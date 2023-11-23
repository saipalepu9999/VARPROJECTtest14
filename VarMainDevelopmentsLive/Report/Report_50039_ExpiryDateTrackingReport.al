report 50039 "Expiry Date Tracking Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\ExpiryDateTracking.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = WHERE("Expiration Date" = filter(<> 0D));
            column(ItemNoCapLbl; ItemNoCapLbl)
            { }
            column(DescriptionCapLbl; DescriptionCapLbl)
            { }
            column(UnitOfMeasureCapLbl; UnitOfMeasureCapLbl)
            { }
            column(ReceiptNoCapLbl; ReceiptNoCapLbl)
            { }
            column(ReceiptDateCapLbl; ReceiptDateCapLbl)
            { }
            column(BatchNoCapLbl; BatchNoCapLbl)
            { }
            column(VendorLotNo_B2B_ItemLedgerEntry; "Vendor Lot No_B2B")
            {
            }
            column(BoeNoCapLbl; BoeNoCapLbl)
            { }
            column(BoeDateCapLbl; BoeDateCapLbl)
            { }
            column(ExpiryDateCapLbl; ExpiryDateCapLbl)
            { }
            column(QtyReceivedCaplbl; QtyReceivedCaplbl)
            { }
            column(QtyIssuedConsumedCapLbl; QtyIssuedConsumedCapLbl)
            { }
            column(QtyAvailableCapLbl; QtyAvailableCapLbl)
            { }
            column(RevalidatedDateCapLbl; RevalidatedDateCapLbl)
            { }
            column(Item_No_; "Item No.")
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }
            column(Description; Description)
            { }
            column(Document_No_; "Document No.")
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Lot_No_; "Lot No.")
            { }
            column(Quantity; Quantity)
            { }
            column(Bill_of_Entry_No_; "Bill of Entry No.")
            { }
            column(Bill_of_Entry_Date; format("Bill of Entry Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Expiration_Date; format("Expiration Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(CompanyInfo_Name; CompanyInfo.Name)
            { }
            column(CompanyInfo_Address; CompanyInfo.Address)
            { }
            column(Location_Address; LocationGRec.Address)//B2BSSD09Jan2023
            { }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            { }
            column(ExpiryCapLbl; ExpiryCapLbl)
            { }
            column(AppliedQtyGvar; AppliedQtyGvar)
            { }
            column(RemainingQuantity_ItemLedgerEntry; "Remaining Quantity")
            { }
            column(ItemDescriptionGvar; ItemDescriptionGvar)
            { }
            trigger OnPreDataItem()
            begin
                if format(DateGvar) <> '' then
                    setrange("Expiration Date", WorkDate, CalcDate(DateGvar, WorkDate()));
            end;

            trigger OnAfterGetRecord()
            var
                TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
            begin
                Clear(AppliedQtyGvar);
                //B2BSSD09Jan2023<<
                Clear(LocationGRec);
                if LocationGRec.Get("Location Code") then;
                //B2BSSD09Jan2023>>
                TempItemLedgerEntry.DeleteAll();
                FindAppliedEntries("Item Ledger Entry", TempItemLedgerEntry);
                if TempItemLedgerEntry.FindSet() then
                    repeat
                        AppliedQtyGvar += Abs(TempItemLedgerEntry.Quantity);
                    until TempItemLedgerEntry.Next() = 0;
                Clear(ItemDescriptionGvar);
                if ItemGrec.Get("Item No.") then
                    ItemDescriptionGvar := ItemGrec.Description;
            end;
        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(DateGvar; DateGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Expiry Date Formula';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.calcfields(Picture);
    end;

    procedure FindAppliedEntries(ItemLedgEntry: Record "Item Ledger Entry"; var TempItemLedgerEntry: Record "Item Ledger Entry" temporary)
    var
        ItemApplnEntry: Record "Item Application Entry";
    begin
        if ItemLedgEntry.Positive then begin
            ItemApplnEntry.Reset();
            ItemApplnEntry.SetCurrentKey("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
            ItemApplnEntry.SetRange("Inbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetFilter("Outbound Item Entry No.", '<>%1', 0);
            ItemApplnEntry.SetRange("Cost Application", true);
            if ItemApplnEntry.Find('-') then
                repeat
                    InsertTempEntry(TempItemLedgerEntry, ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                until ItemApplnEntry.Next() = 0;
        end else begin
            ItemApplnEntry.Reset();
            ItemApplnEntry.SetCurrentKey("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
            ItemApplnEntry.SetRange("Outbound Item Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
            ItemApplnEntry.SetRange("Cost Application", true);
            if ItemApplnEntry.Find('-') then
                repeat
                    InsertTempEntry(TempItemLedgerEntry, ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                until ItemApplnEntry.Next() = 0;
        end;
    end;

    local procedure InsertTempEntry(var TempItemLedgerEntry: Record "Item Ledger Entry" temporary; EntryNo: Integer; AppliedQty: Decimal)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.Get(EntryNo);
        if AppliedQty * ItemLedgEntry.Quantity < 0 then
            exit;

        if not TempItemLedgerEntry.Get(EntryNo) then begin
            TempItemLedgerEntry.Init();
            TempItemLedgerEntry := ItemLedgEntry;
            TempItemLedgerEntry.Quantity := AppliedQty;
            TempItemLedgerEntry.Insert();
        end else begin
            TempItemLedgerEntry.Quantity := TempItemLedgerEntry.Quantity + AppliedQty;
            TempItemLedgerEntry.Modify();
        end;
    end;

    var
        CompanyInfo: Record "Company Information";
        ExpiryCapLbl: Label 'EXPIRY DATE TRACKING';
        ItemNoCapLbl: Label 'Item No.';
        DescriptionCapLbl: Label 'Description';
        UnitOfMeasureCapLbl: Label 'Unit Of Measure';
        ReceiptNoCapLbl: Label 'Receipt No.';
        ReceiptDateCapLbl: Label 'Receipt Date';
        BatchNoCapLbl: Label 'Batch No.';
        BoeNoCapLbl: Label 'BOE No.';
        BoeDateCapLbl: Label 'BOE Date';
        QtyReceivedCaplbl: Label 'Qty Received';
        ExpiryDateCapLbl: Label 'Expiry Date';
        QtyIssuedConsumedCapLbl: Label 'Qty Issued';
        QtyAvailableCapLbl: Label 'Qty Available';
        RevalidatedDateCapLbl: Label 'Revalidated Date';
        ItemLedgerEntries: Record "Item Ledger Entry";
        ItemLedgerPage: Page "Item Ledger Entries";
        AppliedQtyGvar: Decimal;
        ItemDescriptionGvar: Text;
        ItemGrec: Record Item;
        DateGvar: DateFormula;
        LocationGRec: Record Location;//B2BSSD09Jan2023
}
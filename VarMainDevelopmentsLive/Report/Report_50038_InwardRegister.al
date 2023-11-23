report 50038 InwardRegister
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Inward Register';
    //DefaultLayout = RDLC;
    //RDLCLayout = 'Report\Layouts\InwardRegister.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            trigger OnAfterGetRecord()
            begin
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn('Inward Document No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Supplier Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Item No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Item Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Source Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Source No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('DC No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('DC Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn('Bill No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Bill Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn('Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('Rate Per Unit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('Base Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('SGST', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('CGST', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('IGST', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('Total Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ItemLedgEntry.Reset();
                if (StartDateGvar <> 0D) and (EndDateGvar <> 0D) then
                    ItemLedgEntry.SetRange("Posting Date", StartDateGvar, EndDateGvar);
                ItemLedgEntry.SetFilter("Document Type", '%1|%2', ItemLedgEntry."Document Type"::"Purchase Receipt", ItemLedgEntry."Document Type"::"Sales Return Receipt");
                if ItemLedgEntry.FindSet() then
                    repeat
                        Clear(SupplierNameGvar);
                        Clear(ItemDescriptionGvar);
                        Clear(DCNoGvar);
                        Clear(DCDateGvar);
                        Clear(RatePerUnitGvar);
                        ExcelBuffer.NewRow();
                        ExcelBuffer.AddColumn(ItemLedgEntry."Posting Date", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(ItemLedgEntry."Document No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        if ItemLedgEntry."Entry Type" = ItemLedgEntry."Entry Type"::Purchase then begin
                            if VendorGrec.get(ItemLedgEntry."Source No.") then
                                SupplierNameGvar := VendorGrec.Name;
                        end else
                            if ItemLedgEntry."Entry Type" = ItemLedgEntry."Entry Type"::Sale then begin
                                if CustomerGrec.get(ItemLedgEntry."Source No.") then
                                    SupplierNameGvar := CustomerGrec.Name;
                            end;
                        ExcelBuffer.AddColumn(SupplierNameGvar, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(ItemLedgEntry."Item No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        if ItemGrec.Get(ItemLedgEntry."Item No.") then
                            ItemDescriptionGvar := ItemGrec.Description;
                        ExcelBuffer.AddColumn(ItemDescriptionGvar, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(ItemLedgEntry."Document Type", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(ItemLedgEntry."Document No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        if ItemLedgEntry."Document Type" = ItemLedgEntry."Document Type"::"Purchase Receipt" then begin
                            if PostedPurchaseReceiptGvar.Get(ItemLedgEntry."Document No.") then begin
                                DCNoGvar := PostedPurchaseReceiptGvar."Dc No.";
                                DCDateGvar := PostedPurchaseReceiptGvar."Dc Date";
                            end;
                        end;
                        ExcelBuffer.AddColumn(DCNoGvar, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(DCDateGvar, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(ItemLedgEntry."Bill of Entry No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(format(ItemLedgEntry."Bill of Entry Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(ItemLedgEntry.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        if ItemLedgEntry."Document Type" = ItemLedgEntry."Document Type"::"Purchase Receipt" then begin
                            ValueEntryGrec.Reset();
                            ValueEntryGrec.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                            ValueEntryGrec.SetRange("Document Type", ValueEntryGrec."Document Type"::"Purchase Invoice");
                            if ValueEntryGrec.FindFirst() then begin
                                RatePerUnitGvar := ValueEntryGrec."Cost per Unit";
                                PurchInvLineGrec.Reset();
                                PurchInvLineGrec.SetRange("Document No.", ValueEntryGrec."Document No.");
                                PurchInvLineGrec.SetRange("Line No.", ValueEntryGrec."Document Line No.");
                                if PurchInvLineGrec.FindFirst() then begin
                                    PurchaseInvHdrGrec.Reset();
                                    PurchaseInvHdrGrec.SetRange("No.", PurchInvLineGrec."Document No.");
                                    if PurchaseInvHdrGrec.FindFirst() then
                                        GetGSTAmount(PurchaseInvHdrGrec, PurchInvLineGrec);
                                end;
                            end;
                        end else begin
                            ValueEntryGrec.Reset();
                            ValueEntryGrec.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                            ValueEntryGrec.SetRange("Document Type", ValueEntryGrec."Document Type"::"Sales Credit Memo");
                            if ValueEntryGrec.FindFirst() then begin
                                RatePerUnitGvar := ValueEntryGrec."Cost per Unit";
                                SalesCreditMemoLineGrec.Reset();
                                SalesCreditMemoLineGrec.SetRange("Document No.", ValueEntryGrec."Document No.");
                                SalesCreditMemoLineGrec.SetRange("Line No.", ValueEntryGrec."Document Line No.");
                                if SalesCreditMemoLineGrec.FindFirst() then begin
                                    SalesCreditMemoHdrGrec.Reset();
                                    SalesCreditMemoHdrGrec.SetRange("No.", SalesCreditMemoLineGrec."Document No.");
                                    if SalesCreditMemoHdrGrec.FindFirst() then begin
                                        GetSalesCrMemoGSTAmount(SalesCreditMemoHdrGrec, SalesCreditMemoLineGrec);
                                    end;
                                end;
                            end;
                        end;
                        //ExcelBuffer.AddColumn(ItemLedgEntry.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(RatePerUnitGvar, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ItemLedgEntry.CalcFields("Cost Amount (Actual)");
                        ExcelBuffer.AddColumn(ItemLedgEntry."Cost Amount (Actual)", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(SGSTAmt, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(CGSTAmt, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(IGSTAmt, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(ItemLedgEntry."Cost Amount (Actual)" + CGSTAmt + SGSTAmt + IGSTAmt, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    until ItemLedgEntry.Next() = 0;
                DcLedgerEntries.Reset();
                DcLedgerEntries.SetRange("Source Type", DcLedgerEntries."Source Type"::"RGP In");
                if DcLedgerEntries.FindSet() then
                    repeat
                        ExcelBuffer.NewRow();
                        ExcelBuffer.AddColumn(format(DcLedgerEntries."Document Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(DcLedgerEntries."Consignee Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(DcLedgerEntries."No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        if ItemGrec.Get(DcLedgerEntries."No.") then
                            ItemDescriptionGvar := ItemGrec.Description;
                        ExcelBuffer.AddColumn(ItemDescriptionGvar, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(DcLedgerEntries."Source Type", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(DcLedgerEntries."Source No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(DcLedgerEntries.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    until DcLedgerEntries.Next() = 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StartDateGvar; StartDateGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Start Date';
                    }
                    field(EndDateGvar; EndDateGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'End Date';
                    }
                }
            }
        }

        /*actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }*/
    }
    local Procedure CreateBook()
    begin
        ExcelBuffer.CreateBookAndOpenExcel('', 'Inward Register', '', '', USERID);
    end;

    trigger OnPreReport()
    begin
        CLEAR(ExcelBuffer);
        ExcelBuffer.DELETEALL;
    end;

    trigger OnPostReport()
    begin
        CreateBook();
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup.Get() then
            exit;
        GSTSetup.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;

    local procedure GetGSTAmount(PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(IGSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(CessAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", PurchInvLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (PurchInvHeader."Currency Code" <> '') then
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (PurchInvHeader."Currency Code" <> '') then
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (PurchInvHeader."Currency Code" <> '') then
                    IGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then
                        IGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (PurchInvHeader."Currency Code" <> '') then
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then
                        CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
            until DetailedGSTLedgerEntry.Next() = 0;
    end;

    local procedure GetSalesCrMemoGSTAmount(SalesCrMemoHdr: Record "Sales Cr.Memo Header";
        SalesCrMemoLine: Record "Sales Cr.Memo Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(IGSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(CessAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesCrMemoLine."Document No.");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (SalesCrMemoHdr."Currency Code" <> '') then
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCrMemoHdr."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (SalesCrMemoHdr."Currency Code" <> '') then
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCrMemoHdr."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (SalesCrMemoHdr."Currency Code" <> '') then
                    IGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCrMemoHdr."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then
                        IGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (SalesCrMemoHdr."Currency Code" <> '') then
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCrMemoHdr."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then
                        CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
            until DetailedGSTLedgerEntry.Next() = 0;

    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        ItemLedgEntry: Record "Item Ledger Entry";
        SupplierNameGvar: Text;
        VendorGrec: Record Vendor;
        CustomerGrec: Record Customer;
        ItemGrec: Record Item;
        ItemDescriptionGvar: Text;
        pa: Page 1392;
        StartDateGvar: Date;
        EndDateGvar: Date;
        PostedPurchaseReceiptGvar: Record "Purch. Rcpt. Header";
        DCNoGvar: Text;
        DCDateGvar: Date;
        ValueEntryGrec: Record "Value Entry";
        RatePerUnitGvar: Decimal;
        BaseAmountGvar: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        SalesCreditMemoHdrGrec: Record "Sales Cr.Memo Header";
        SalesCreditMemoLineGrec: Record "Sales Cr.Memo Line";
        PurchaseInvHdrGrec: Record "Purch. Inv. Header";
        PurchInvLineGrec: Record "Purch. Inv. Line";
        DcLedgerEntries: Record "GP Ledger Entry";

}
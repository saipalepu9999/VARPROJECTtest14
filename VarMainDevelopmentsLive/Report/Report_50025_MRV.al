report 50025 MaterialReceiptVoucher
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Material Receipt Voucher';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\MRVNew.rdl';

    dataset
    {
        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            DataItemTableView = where(Quantity = filter(<> 0));

            column(Document_No_; "Document No.")
            { }
            column(Line_No_; "Line No.")
            { }
            column(MRVNO; MRVNO)
            { }
            column(MRV_Date; format(MRV_Date, 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            { }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            { }
            column(Vendor_Invoice_No_; Vendor_Invoice_No_)
            { }
            column(Vendor_Invoice_Date; format(Vendor_Invoice_Date, 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Party_Dc_No_; Party_Dc_No_)
            { }
            column(Dc_Date; format(Dc_Date, 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Pc_Date; format(Pc_Date, 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Document_Date; format(Document_Date, 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(NameofPartAddressCapLbl; NameofPartAddressCapLbl)
            { }
            column(PoNoCapLbl; PoNoCapLbl)
            { }
            column(PartyDCCapLbl; PartyDCCapLbl)
            { }

            column(InvCapLbl; InvCapLbl)
            { }
            column(DateCapLbl; DateCapLbl)
            { }
            column(MRVNOCapLbl; MRVNOCapLbl)
            { }
            column(RemarksCaptionLbl; RemarksCaptionLbl)
            { }
            column(CompanyInfoGrec; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrecAddress; CompanyInfoGrec.Address)
            { }
            column(Mrs; Mrs)
            { }
            column(Contact; Contact)
            { }
            column(Address; Address)
            { }
            column(CompanyInfoGrecPic; CompanyInfoGrec.Picture)
            { }
            column(Buy_from_City; Buy_from_City)
            { }
            column(Dc_No_; Dc_No_)
            { }
            column(MaterialRequestVoucherCapLbl; MaterialRequestVoucherCapLbl)
            { }
            column(MRVDateCapLbl; MRVDateCapLbl)
            { }
            column(DivisionCodeCapLbl; DivisionCodeCapLbl)
            { }
            column(ProjectCodeCapLbl; ProjectCodeCapLbl)
            { }
            column(MRVDetailsCapLbl; MRVDetailsCapLbl)
            { }
            column(QCDetailsCapLbl; QCDetailsCapLbl)
            { }
            column(ItemNoCapLbl; ItemNoCapLbl)
            { }
            column(ItemDescriptionCapLbl; ItemDescriptionCapLbl)
            { }
            column(ItemDrawingNoCapLbl; ItemDrawingNoCapLbl)
            { }
            column(UnitOfMeasureCapLbl; UnitOfMeasureCapLbl)
            { }
            column(PoQtyCapLbl; PoQtyCapLbl)
            { }
            column(ReceivedQtyCapLbl; ReceivedQtyCapLbl)
            { }
            column(IRNoCApLbl; IRNoCApLbl)
            { }
            column(IRDateCApLbl; IRDateCApLbl)
            { }
            column(QuantityOfferedCapL; QuantityOfferedCapL)
            { }
            column(AccepetdQtyCapLbl; AccepetdQtyCapLbl)
            { }
            column(RejectedQtyCapLbl; RejectedQtyCapLbl)
            { }
            column(ReworkQtyCapLbl; ReworkQtyCapLbl)
            { }
            column(PoDateCapLbl; PoDateCapLbl)
            { }
            column(InvoiceDateCapLbl; InvoiceDateCapLbl)
            { }
            column(DcDateCapLbl; DcDateCapLbl)
            { }
            column(VendorGrec_Name; VendorGrec.Name)
            { }
            column(VendorGrec_Address; VendorGrec.Address)
            { }
            column(PurchaseHeaderGrec_No; PurchaseHeaderGrec."No.")
            { }
            column(PurchaseHeaderGrec_OrderDate; format(PurchaseHeaderGrec."Order Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(LocationGrec_Name; LocationGrec.Name)
            { }
            column(LocationGrec_Address; LocationGrec.Address)
            { }
            column(LocationGrec_Address2; LocationGrec."Address 2")
            { }
            column(StoresCapLbl; StoresCapLbl)
            { }
            column(QCCapLbl; QCCapLbl)
            { }
            column(FinanceCapLbl; FinanceCapLbl)
            { }
            column(DivNameGvar; DivNameGvar)
            { }
            column(ProjectNameGvar; ProjectNameGvar)
            { }
            column(UnitPriceCapLbl; UnitPriceCapLbl)
            { }
            column(TotalAmtCapLbl; TotalAmtCapLbl)
            { }
            column(RPONo; RPONo)
            { }
            column(RPODate; RPODate)
            { }
            column(ProjectCode; ProjectCode)
            { }
            column(RPONOCapLbl; RPONOCapLbl)
            { }
            column(RPODateCapLbl; RPODateCapLbl)
            { }
            column(ItemNo; "No.")
            { }
            column(QC_Enabled_B2B; "QC Enabled B2B")
            { }
            column(Description; Description)
            { }
            column(Quantity; Quantity)
            { }
            column(QuantityOfferedGvar; QuantityOfferedGvar)
            { }
            column(unit; "Location Code")
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }
            column(Quantity_Accepted_B2B; "Quantity Accepted B2B")
            { }
            column(Quantity_Rejected_B2B; "Quantity Rejected B2B")
            { }
            column(Quantity_Rework_B2B; "Quantity Rework B2B")
            { }
            column(RateUnit; "Direct Unit Cost")
            { }
            column(PoQtyGVar; PoQtyGVar)
            { }
            column(IRNoGvar; IRNoGvar)
            { }
            column(IRDateGvar; IRDateGvar)
            { }
            column(DrawingNoGvar; DrawingNoGvar)
            { }
            column(RemarksGvar; RemarksGvar)
            { }
            column(Unit_Cost; "Unit Cost")
            { }
            column(MRVVisible; MRVVisible)
            { }

            dataitem("MRV Quality Ledger Entry"; "MRV Quality Ledger Entry")
            {
                DataItemLinkReference = "Purch. Rcpt. Line";
                DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No.");
                column(Accepted_Quantity; "Accepted Quantity")
                {

                }
                column(Rejected_Quantity; "Rejected Quantity")

                {

                }
                column(Rework_Quantity; "Rework Quantity")
                {

                }
                column(MRV_Posting_Date; "MRV Posting Date")
                {

                }
                column(No_; "No.")
                {

                }
                trigger OnPreDataItem()
                begin
                    MRVCount := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    MRVCount += 1;
                    if MRVCount > 1 then begin
                        MRVVisible := true;
                        QuantityOfferedGvar := 0

                    end else
                        MRVVisible := false;
                end;

            }
            trigger OnAfterGetRecord()
            begin
                Clear(VendorGrec);
                Clear(PurchaseHeaderGrec);
                Clear(LocationGrec);
                Clear(DivNameGvar);
                Clear(ProjectNameGvar);
                PurchRecptHeaderGrec.Reset();
                PurchRecptHeaderGrec.SetRange("No.", "Purch. Rcpt. Line"."Document No.");
                if PurchRecptHeaderGrec.FindFirst() then begin
                    MRVNO := PurchRecptHeaderGrec."No.";
                    MRV_Date := PurchRecptHeaderGrec."Posting Date";
                    Shortcut_Dimension_1_Code := PurchRecptHeaderGrec."Shortcut Dimension 1 Code";
                    Shortcut_Dimension_2_Code := PurchRecptHeaderGrec."Shortcut Dimension 2 Code";
                    Vendor_Invoice_No_ := PurchRecptHeaderGrec."Vendor Invoice No.";
                    Vendor_Invoice_Date := PurchRecptHeaderGrec."Vendor Invoice Date";
                    Party_Dc_No_ := PurchRecptHeaderGrec."Dc No.";
                    Dc_No_ := PurchRecptHeaderGrec."Dc No.";
                    Dc_Date := PurchRecptHeaderGrec."Dc Date";
                    Pc_Date := PurchRecptHeaderGrec."Pc Date";
                    Document_Date := PurchRecptHeaderGrec."Document Date";
                    Posting_Date := PurchRecptHeaderGrec."Posting Date";
                    Mrs := PurchRecptHeaderGrec."Buy-from Vendor Name";
                    Contact := PurchRecptHeaderGrec."Buy-from Contact";
                    Address := PurchRecptHeaderGrec."Buy-from Address";
                    Buy_from_City := PurchRecptHeaderGrec."Buy-from City";
                end;

                Clear(QuantityOfferedGvar);
                Clear(PoQtyGVar);
                Clear(IRNoGvar);
                Clear(IRDateGvar);
                Clear(RemarksGvar);
                Clear(TotalVar);
                PurChaseLineGrec.Reset();
                PurChaseLineGrec.SetRange("Document Type", PurChaseLineGrec."Document Type"::Order);
                PurChaseLineGrec.SetRange("Document No.", PurchRecptHeaderGrec."Order No.");
                PurChaseLineGrec.SetRange("Line No.", "Purch. Rcpt. Line"."Order Line No.");
                //PurChaseLineGrec.setf(Type, PurChaseLineGrec.Type::Item);
                PurChaseLineGrec.SetRange("No.", "Purch. Rcpt. Line"."No.");
                if PurChaseLineGrec.FindFirst() then begin
                    PoQtyGVar := PurChaseLineGrec.Quantity;
                end;
                if "QC Enabled B2B" = true then begin
                    InspectionReceiptHeader.Reset();
                    InspectionReceiptHeader.SetRange(Status, true);
                    InspectionReceiptHeader.SetRange("Receipt No.", "Purch. Rcpt. Line"."Document No.");
                    InspectionReceiptHeader.SetRange("Item No.", "Purch. Rcpt. Line"."No.");
                    if InspectionReceiptHeader.FindFirst() then begin
                        IRNoGvar := InspectionReceiptHeader."No.";
                        IRDateGvar := InspectionReceiptHeader."Posting Date";
                        RemarksGvar := InspectionReceiptHeader."Quality Remarks";
                    end;
                end;
                Clear(DrawingNoGvar);
                DocumnetAttachMnet.Reset();
                DocumnetAttachMnet.SetRange("Table ID", 27);
                DocumnetAttachMnet.SetRange("No.", "No.");
                DocumnetAttachMnet.SetRange(Type_B2B, DocumnetAttachMnet.Type_B2B::Drawing);
                DocumnetAttachMnet.SetCurrentKey("Attached Date");
                if DocumnetAttachMnet.FindLast() then
                    DrawingNoGvar := DocumnetAttachMnet."Drawing No_B2B";
                QuantityOfferedGvar := Quantity;

                if VendorGrec.get(PurchRecptHeaderGrec."Buy-from Vendor No.") then;
                if PurchaseHeaderGrec.get(PurchaseHeaderGrec."Document Type"::Order, PurchRecptHeaderGrec."Order No.") then;
                if LocationGrec.Get("Location Code") then;
                DimensionValues.Reset();
                DimensionValues.SetRange(Code, PurchRecptHeaderGrec."Shortcut Dimension 1 Code");
                if DimensionValues.FindFirst() then
                    DivNameGvar := DimensionValues.Name;
                DimensionValues.Reset();
                DimensionValues.SetRange(Code, PurchRecptHeaderGrec."Shortcut Dimension 2 Code");
                if DimensionValues.FindFirst() then
                    ProjectNameGvar := DimensionValues.Name;
                //B2BSSD09Jan2023<<
                Clear(LocationGrec);
                if LocationGrec.Get(PurchRecptHeaderGrec."Location Code") then;
                //B2BSSD09Jan2023>>
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Document No.", "Purch. Rcpt. Line"."Document No.");
                ItemLedgerEntry.setrange("Document Line No.", "Purch. Rcpt. Line"."Line No.");
                ItemLedgerEntry.setrange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                ItemLedgerEntry.setrange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
                if ItemLedgerEntry.FindFirst() then
                    PurchageFieldsUpdate(ItemLedgerEntry);
            end;

        }
    }

    trigger OnPreReport()
    begin
        CompanyInfoGrec.Get();
        CompanyInfoGrec.CalcFields(Picture);
    end;

    var
        VendorGrec: Record Vendor;
        PurchaseHeaderGrec: Record "Purchase Header";
        PurchRecptHeaderGrec: Record "Purch. Rcpt. Header";
        InspectionReceiptHeader: Record "Inspection Receipt Header B2B";
        InspectionReceiptLine: Record "Inspection Receipt Line B2B";
        PurChaseLineGrec: Record "Purchase Line";
        PoQtyGVar: Decimal;
        MrvLedgerEntryRec: Record "MRV Quality Ledger Entry";
        MrvLedgerEntryRec2: Record "MRV Quality Ledger Entry";
        MRVNO: Code[20];
        MRV_Date: Date;
        Shortcut_Dimension_1_Code: Code[20];
        Shortcut_Dimension_2_Code: Code[20];
        Vendor_Invoice_No_: Code[20];
        Vendor_Invoice_Date: Date;
        Party_Dc_No_: Code[20];
        Dc_No_: Code[20];
        Dc_Date: Date;
        Pc_Date: Date;
        Document_Date: Date;
        Posting_Date: Date;
        Mrs: Text[100];
        Contact: Text[100];
        Address: Text[100];
        Buy_from_City: Text[30];

        MrvQtyAcceptedVar: Decimal;
        MrvQtyRejectedVar: Decimal;
        MrvQtyReworkvar: Decimal;
        IRNoGvar: Text;
        IRDateGvar: Date;
        RemarksCaptionLbl: Label 'Remarks';
        MaterialRequestVoucherCapLbl: Label 'MATERIAL RECEIPT VOUCHER';
        CompanyInfoGrec: Record "Company Information";
        NameofPartAddressCapLbl: Label 'Name of the Party & Address';
        PoNoCapLbl: Label 'P.O.No';
        PartyDCCapLbl: Label 'Party D.C.No';
        InvCapLbl: Label 'Invoice No.';
        PoDateCapLbl: Label 'PO Date';
        InvoiceDateCapLbl: Label 'Invoice Date';
        DcDateCapLbl: Label 'DC Date';
        DateCapLbl: Label 'Date';
        MRVNOCapLbl: Label 'MRV No.';
        MRVDateCapLbl: Label 'MRV Date';
        DivisionCodeCapLbl: Label 'Division Code';
        ProjectCodeCapLbl: Label 'Project Code';
        MRVDetailsCapLbl: label 'MRV Details';
        QCDetailsCapLbl: Label 'QC Details';
        ItemNoCapLbl: Label 'Item No.';
        ItemDescriptionCapLbl: Label 'Item Description';
        ItemDrawingNoCapLbl: Label 'Item Drawing';
        UnitOfMeasureCapLbl: Label 'Unit Of Measure';
        PoQtyCapLbl: Label 'Po Qty';
        ReceivedQtyCapLbl: Label 'Received Qty.';
        IRNoCApLbl: Label 'IR/QC No.';
        IRDateCApLbl: Label 'IR/QC Date';
        QuantityOfferedCapL: label 'Quantity offered';
        AccepetdQtyCapLbl: Label 'Accepted Quantity';
        RejectedQtyCapLbl: Label 'Rejected Quanity';
        ReworkQtyCapLbl: Label 'Rework Quantity';
        // gen : Record "Gen. Journal Narration";
        saleline: Record "Sales Line";
        DrawingNoGvar: Text;
        ItemGrec: Record Item;
        DocumnetAttachMnet: Record "Document Attachment";
        RemarksGvar: Text;
        LocationGrec: Record Location;
        StoresCapLbl: Label 'Stores Department';
        QCCapLbl: Label 'QC Department';
        FinanceCapLbl: Label 'Finance Department';
        DivNameGvar: Text;
        ProjectNameGvar: Text;
        DimensionValues: Record "Dimension Value";
        Re: Report 18008;
        QuantityOfferedGvar: Decimal;
        pag: Page 99000883;
        TotalVar: Decimal;
        MrvReworkVar: Decimal;
        UnitPriceCapLbl: Label 'Unit Price';
        TotalAmtCapLbl: Label 'Total Amount';
        MRVNoVar: Code[20];
        MRVPostingDate: Date;
        RPONo: Code[20];
        RPODate: Date;
        ProjectCode: Code[20];
        ItemLedgerEntry: Record "Item Ledger Entry";
        RPONOCapLbl: Label 'R.P.O No.';
        RPODateCapLbl: Label 'R.P.O Date';
        MRVCount: Integer;
        MRVVisible: Boolean;

    local procedure PurchageFieldsUpdate(ItemLedgerEntry: Record "Item Ledger Entry"): Decimal
    var
        Item: Record Item;
        ILE: Record "Item Ledger Entry";
        ILE2: Record "Item Ledger Entry";
        Application: Record "Item Application Entry";
        Application2: Record "Item Application Entry";
    begin
        with ItemLedgerEntry do begin
            if Quantity > 0 then begin
                Application.Reset();
                Application.SetRange("Inbound Item Entry No.", "Entry No.");
                Application.SetFilter("Item Ledger Entry No.", '<>%1', "Entry No.");
                if Application.FindFirst() then
                    repeat
                        if ILE.get(Application."Inbound Item Entry No.") then begin
                            if (ILE."Entry Type" = ILE."Entry Type"::Purchase) then begin
                                RPONo := ILE."Document No.";
                                RPODate := ILE."Posting Date";
                                ProjectCode := ILE."Global Dimension 2 Code";
                            end;
                        end;
                    until Application.Next() = 0;
                /* end else begin
                     Application.Reset();
                     Application.SetRange("Outbound Item Entry No.", "Entry No.");
                     Application.SetFilter("Item Ledger Entry No.", '<>%1', "Entry No.");
                     if Application.FindFirst() then
                         repeat
                             if ILE.get(Application."Item Ledger Entry No.") then begin
                                 if (ILE."Entry Type" = ILE."Entry Type"::Purchase) then begin
                                     RPONo := ILE."Document No.";
                                     RPODate := ILE."Posting Date";
                                     ProjectCode := ILE."Global Dimension 2 Code";
                                 end;
                             end;
                         until Application.Next() = 0;*/
            end;
        End;
    end;

}
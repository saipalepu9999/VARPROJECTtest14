report 50036 "Posted Purchase Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Posted Purchse Invoice_50036';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\Posted Purchase Invoice-New.rdl';

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
            { }
            column(No_PurchInvHeader; "No.")
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(NewRemarks_PurchInvHeader; "New Remarks")
            { }
            column(PartyCapLbl; PartyCapLbl)
            { }
            column(Reference_Invoice_No_; "Reference Invoice No.")
            { }
            column(ParticularCapLbl; ParticularCapLbl)
            { }
            column(QunatityCapLbl; QunatityCapLbl)
            { }
            column(RateCapLbl; RateCapLbl)
            { }
            column(perCapLbl; perCapLbl)
            { }
            column(AmountCapLbl; AmountCapLbl)
            { }
            column(TotalCapLbl; TotalCapLbl)
            { }
            column(InvoiceNoCapLbl; InvoiceNoCapLbl)
            { }
            column(RefCapLbl; RefCapLbl)
            { }
            column(DateCapLbl; DateCapLbl)
            { }
            column(AmountChargeableCapLbl; AmountChargeableCapLbl)
            { }
            column(RemarksCapLbl; RemarksCapLbl)
            { }
            column(PurchVochCapLbl; PurchVochCapLbl)
            { }
            column(EOECapLbl; EOECapLbl)
            { }
            column(VarElectroCapLbl; VarElectroCapLbl)
            { }
            column(AuthorisedCapLbl; AuthorisedCapLbl)
            { }
            column(GSTNoCapLbl; GSTNoCapLbl)
            { }
            column(GSTINCapLbl; GSTINCapLbl)
            { }
            column(EmailCapLabl; EmailCapLabl)
            { }
            column(EMailCapLbl1; EMailCapLbl1)
            { }
            column(ContactCapLbl; ContactCapLbl)
            { }
            column(PostingDateCapLbl; PostingDateCapLbl)
            { }
            column(InvoiceDateCaplbl; InvoiceDateCaplbl)
            { }
            column(ForvarElecCapLbl; ForvarElecCapLbl)
            { }
            column(PostingDate_PurchInvHeader; "Posting Date")
            { }
            column(DocumentDate_PurchInvHeader; format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(VendorInvoiceDate_PurchInvHeader; "Vendor Invoice Date")
            { }
            column(BillofEntryDate_PurchInvHeader; "Bill of Entry Date")
            { }
            column(DcDate_PurchInvHeader; "Dc Date")
            { }
            column(DueDate_PurchInvHeader; "Due Date")
            { }
            column(ExpectedReceiptDate_PurchInvHeader; "Expected Receipt Date")
            { }
            column(OrderDate_PurchInvHeader; "Order Date")
            { }
            column(PaymentDate_PurchInvHeader; "Payment Date")
            { }
            column(RemarksGvar; RemarksGvar)
            { }
            column(Name; Name)
            { }
            column(Address; Address)
            { }
            column(Contact; Contact)
            { }
            column(Email; Email)
            { }
            column(City; City)
            { }
            column(LessCapLbl; LessCapLbl)
            { }
            column(TDSPayCapLbl; TDSPayCapLbl)
            { }
            column(TDSPercent; TDSPercent)
            { }
            column(TDS; TDS)
            { }
            column(TDSAmount; TDSAmount)
            { }
            column(CompanyInfo_Name; CompanyInfo.Name)
            { }
            column(CompanyInfo_Address; CompanyInfo.Address)
            { }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            { }
            column(VendorGrec_Name; VendorGrec.Name)
            { }
            column(SNoCapLbl; SNoCapLbl)
            { }
            column(DescOfGoodsCap; DescOfGoodsCap)
            { }
            column(VendorGrec_Address; VendorGrec.Address)
            { }
            column(VendorGrec_Address2; VendorGrec."Address 2")
            { }
            column(VendorGrec_GstNO; VendorGrec."GST Registration No.")
            { }
            column(PurchaseInvoiceCapLbl; PurchaseInvoiceCapLbl)
            { }
            column(VendorGrec_State; VendorGrec."State Code")
            { }
            column(Location_Address; LocationGrec.Address)//B2BSSD09Jan2023
            { }
            column(Location_Address2; LocationGrec."Address 2")//B2BSSD09Jan2023
            { }
            column(LocationGrec_City; LocationGrec.City)
            { }
            column(LocationGrec_State; LocationGrec."State Code")
            { }
            column(LocationGrec_Postcode; LocationGrec."Post Code")
            { }
            column(LocationGrec_Email; LocationGrec."E-Mail")
            { }
            // CHB2B23FEB2023<<
            column(LocationGst; LocationGrec."GST Registration No.")
            { }
            column(StateDescrGvar; StateDescrGvar)
            { }
            column(StateCodeGva; StateCodeGva)
            { }
            // CHB2B23FEB2023>>
            column(StateNamecapLbl; StateNamecapLbl)
            { }
            column(CodeCapLbl; CodeCapLbl)
            { }
            column(CompanyInfo_City; CompanyInfo.City)
            { }
            column(CompanyInfo_GSTNo; CompanyInfo."GST Registration No.")
            { }
            column(CompanyInfo_Country; CompanyInfo."Country/Region Code")
            { }
            column(CompanyInfo_Email; CompanyInfo."E-Mail")
            { }
            column(CompanyInfo_PAnNo; CompanyInfo."P.A.N. No.")
            { }
            column(CGSTLbl; CGSTLbl)
            { }
            column(SGSTLbl; SGSTLbl)
            { }
            column(IGSTLbl; IGSTLbl)
            { }
            column(IGSTCaption; IGSTCaption)
            { }
            column(CGSTCaption; CGSTCaption)
            { }
            column(SGSTCaption; SGSTCaption)
            { }
            column(TotalCGST; TotalCGST)
            { }
            column(TotalSGST; TotalSGST)
            { }
            column(TotalIGST; TotalIGST)
            { }
            column(VenStateDes; VenStateDes)
            { }
            column(VenStateCode; VenStateCode)
            { }
            column(NumberText; NumberText[1])
            { }
            column(VendorName; "Buy-from Vendor Name")
            { }
            column(Address1; "Buy-from Address")
            { }
            column(Address2; "Buy-from Address 2")
            { }
            column(GSTRegNoGvar; GSTRegNoGvar)
            { }
            column(CustomsCapLbl; CustomsCapLbl)
            { }
            column(CustomsDutyCapLbl; CustomsDutyCapLbl)
            { }
            column(GSTVendorType; "GST Vendor Type")
            { }
            column(GLAccName; GLAccName)
            { }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Purch. Inv. Header";
                //DataItemTableView = where(Type = filter(<>''))
                column(Description; Description)
                { }
                column(Amount; Amount)
                { }
                column(IGSTAmt; IGSSTAmt)
                { }
                column(No_PurchInvLine; "No.")
                { }
                column(Type_PurchInvLine; "Type")
                { }
                column(CGSTAmt; CGSTAmt)
                { }
                column(SGSTAmt; SGSTAmt)
                { }
                column(IGSSTAmt; IGSSTAmt)
                { }
                column(TotalAmount; TotalAmount)
                { }
                column(CGSTPercentage; CGSTPercentage)
                { }
                column(SGSTPercentage; SGSTPercentage)
                { }
                column(IGSTPercentage; IGSTPercentage)
                { }
                column(TDSAmt; TDSAmt)
                { }
                column(PercentCapLbl; PercentCapLbl)
                { }
                column(Quantity_PurchInvLine; Quantity)
                { }
                column(RateGvar; RateGvar)
                { }
                column(UnitofMeasureCode_PurchInvLine; "Unit of Measure Code")
                { }
                column(DirectUnitCost_PurchInvLine; "Direct Unit Cost")
                { }
                column(LineAmount_PurchInvLine; "Line Amount")
                { }
                column(LineAmountGvar; LineAmountGvar)
                { }
                column(LineDiscount_PurchInvLine; "Line Discount %")
                { }
                column(SnoGvar; SnoGvar)
                { }
                column(GSTReverseCharge_PurchInvLine; GSTGroupVar)
                { }
                column(AmountVendor1; AmountVendor1)
                { }
                column(CustomDutyAmount; CustomsDutyAmt)
                { }
                column(CustomsDutyAmt; CustomsDutyAmt)
                { }
                column(TotalCustomsDutyAmt; TotalCustomsDutyAmt)
                { }
                trigger OnPreDataItem()
                begin
                    //SetFilter(Type, '<>%1', Type::" ");
                end;

                trigger OnAfterGetRecord()
                begin
                    Clear(CustomsDutyAmt);
                    Clear(TotalCustomsDutyAmt);
                    /*TDSEntry.Reset();
                    TDSEntry.SetRange("Document No.", "Purch. Inv. Header"."No.");
                    if TDSEntry.FindFirst() then begin
                        TDS := TDSEntry.Section;
                        TDSPercent := TDSEntry."TDS %";
                        TDSAmount := TDSEntry."TDS Amount";
                    end;*/
                    /*
                    if "GST Reverse Charge" then
                        GstReverseBoolGvar := true;*/
                    //B2BPROn06Jul2023<<<
                    //B2BPROn30JUN2023<<<
                    if GSTGroupGRec.Get("GST Group Code") and (GSTGroupGRec."Reverse Charge") then
                        GSTGroupVar := true
                    else
                        GSTGroupVar := false;

                    //B2BPROn30JUN2023<<<
                    Clear(RateGvar);
                    Clear(LineAmountGvar);
                    if "Purch. Inv. Header"."Currency Code" <> '' then begin
                        LineAmountGvar := "Line Amount" / "Purch. Inv. Header"."Currency Factor";
                        RateGvar := "Direct Unit Cost" / "Purch. Inv. Header"."Currency Factor";
                    end else begin
                        LineAmountGvar := "Line Amount";
                        RateGvar := "Direct Unit Cost";
                    end;
                    Clear(CGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSSTAmt);
                    //Clear(SGSTPer);
                    //Clear(IGSTPer);
                    //Clear(CGSTPer);
                    //GSTSetup.get();
                    //GetGSTAmounts(TaxTransactionValue, "Purchase Line", GSTSetup);
                    Clear(TDSAmt);
                    GetPurchGSTAmount("Purch. Inv. Header", "Purch. Inv. Line");
                    GetTDSAmt("Purch. Inv. Header", "Purch. Inv. Line");

                    IGSTCaption := IGSTLbl + '@' + format(IGSTPercentage) + '%';
                    CGSTCaption := CGSTLbl + '@' + format(CGSTPercentage) + '%';
                    SGSTCaption := SGSTLbl + '@' + format(SGSTPercentage) + '%';

                    Clear(GstTotal);
                    GstTotal := CGSTAmt + SGSTAmt + IGSSTAmt;
                    GstTotalSum := GstTotalSum + GstTotal;
                    TotalCGST += CGSTAmt;
                    TotalIGST += IGSSTAmt;
                    TotalSGST += SGSTAmt;
                    //Message(Format(TotalSGST));
                    //GSTPerQTY := GstTotal / Quantity;
                    //GSTPertotal := CGSTPer + SGSTPer + IGSTPer;
                    //Message('%1', GstTotal);
                    Clear(AmountVendor1);
                    if "Purch. Inv. Header"."Currency Code" <> '' then
                        AmountVendor += "Line Amount" / "Purch. Inv. Header"."Currency Factor"
                    else
                        AmountVendor += "Line Amount";


                    if ("Purch. Inv. Header"."Currency Factor" <> 0) and ("No." <> '') and (GSTGroupVar = false) then begin
                        CustomsDutyAmt := "Custom Duty Amount" / "Purch. Inv. Header"."Currency Factor";
                        //TotalCustomsDutyAmt := TotalIGST + CustomsDutyAmt;
                    end;

                    TotalCustomsDutyAmt := TotalIGST + CustomsDutyAmt;
                    if GSTGroupVar then
                        AmountVendor1 := Round((AmountVendor - TDSAmt), 1)
                    else
                        if ("Purch. Inv. Header"."GST Vendor Type" <> "Purch. Inv. Header"."GST Vendor Type"::Import) then begin
                            //AmountVendor1 := Round((AmountVendor + GstTotalSum - TDSAmt - TotalIGST), 1)
                            AmountVendor1 := Round((AmountVendor + GstTotalSum + CustomsDutyAmt - TDSAmt), 1);
                        end else
                            AmountVendor1 := Round((AmountVendor + GstTotalSum + CustomsDutyAmt - TDSAmt - TotalCustomsDutyAmt), 1);

                    //CHB2B27FEB2023<<
                    //clear(NumberText);
                    CheckGRec.InitTextVariable;
                    CheckGRec.FormatNoText(NumberText, AmountVendor1, '');

                    if Type <> Type::" " then
                        SnoGvar += 1;
                    //CHB2B27FEB2023<<
                    /* Clear(TotalAmount);
                     GetPurchGSTAmount("Purch. Inv. Header", "Purch. Inv. Line");
                     TotalAmount := CGSTAmt + SGSTAmt + IGSSTAmt + Amount + TDSAmount;
                     Clear(NumberText);
                     CheckGRec.InitTextVariable; 
                     CheckGRec.FormatNoText(NumberText, Round(TotalAmount, 1, '='), GetCurrencyCode());*/

                    //B2BPROn30JUN2023<<<
                    if GSTGroupGRec.Get("GST Group Code") and (GSTGroupGRec."Reverse Charge") then
                        GSTGroupVar := true
                    else
                        GSTGroupVar := false;
                    //B2BPROn30JUN2023<<<
                    if "Purch. Inv. Line".Type = "Purch. Inv. Line".Type::"G/L Account" then begin
                        if GLAccountGvar.Get("No.") then
                            GLAccName := GLAccountGvar.Name;
                    end;

                end;

                trigger OnPostDataItem()
                begin
                    //Message(format(TotalSGST));
                end;


            }
            trigger OnAfterGetRecord()
            begin
                Clear(LocationGrec);
                Clear(VendorGrec);
                clear(StateGre1);
                Clear(GstReverseBoolGvar);
                if LocationGrec.Get("Location Code") then;
                //LocationDescr := LocationGrec.City;
                if StateGre.Get("Location State Code") then begin
                    StateDescrGvar := StateGre.Description;
                    StateCodeGva := StateGre."State Code (GST Reg. No.)";
                end;
                if VendorGrec.Get("Purch. Inv. Header"."Buy-from Vendor No.") then begin
                    StateGre1.Reset();
                    StateGre1.setrange(code, VendorGrec."State Code");
                    if StateGre1.FindFirst() then begin
                        VenStateDes := StateGre.Description;
                        VenStateCode := StateGre."State Code (GST Reg. No.)";
                    end;
                end;

                if "Order Address GST Reg. No." <> '' then
                    GSTRegNoGvar := "Order Address GST Reg. No."
                else
                    GSTRegNoGvar := "Vendor GST Reg. No.";
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.get();
    end;

    local procedure GetPurchGSTAmount(PurchInvHeader: Record "Purch. Inv. Header";
           PurchInvLine: Record "Purch. Inv. Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(IGSSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(CessAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", PurchInvLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", PurchInvLine."Line No.");
        if DetailedGSTLedgerEntry.FindSet() then begin
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then begin
                    CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                    CGSTPercentage := DetailedGSTLedgerEntry."GST %";
                end;

                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then begin
                    SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                    SGSTPercentage := DetailedGSTLedgerEntry."GST %";
                end;

                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then begin
                    IGSSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                    IGSTPercentage := DetailedGSTLedgerEntry."GST %";
                end;
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then
                    CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
            until DetailedGSTLedgerEntry.Next() = 0;
        end;
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

    local procedure GetTDSAmt(PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line")
    var
        TDSEntry: Record "TDS Entry";
    begin
        Clear(TDSAmt);
        TDSEntry.Reset();
        TDSEntry.SetRange("Document No.", PurchInvLine."Document No.");
        if TDSEntry.FindSet() then
            repeat
                // if "Purch. Inv. Header"."Currency Code" <> '' then
                //     TDSAmt += (PurchInvHeader."Currency Factor" * TDSEntry."Total TDS Including SHE CESS")
                //else
                TDSAmt += TDSEntry."Total TDS Including SHE CESS";
            until TDSEntry.Next() = 0;
    end;

    var
        StateGre: record State;
        GLAccountGvar: Record "G/L Account";
        GLAccName: Text[100];
        StateGre1: record State;
        GSTGroupGRec: Record "GST Group";
        GSTGroupVar: Boolean;
        PercentCapLbl: Label '%';
        CheckGRec: Codeunit "Check Codeunit";
        NumberText: array[2] of Text;
        TDSAmt: Decimal;
        CGSTPercentage: Decimal;
        SGSTPercentage: Decimal;
        IGSTPercentage: Decimal;
        TotalAmount: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        ParticularCapLbl: Label 'Particulars';
        PartyCapLbl: Label 'Party ';
        QunatityCapLbl: Label 'Quantity';
        RateCapLbl: Label 'Rate';
        perCapLbl: Label 'Per';
        CompanyPanCapLbl: Label 'Companys Pan';
        DiscPerCapLbl: Label 'Disc. %';
        AmountCapLbl: Label 'Amount';
        TotalCapLbl: Label 'Total';
        DescOfGoodsCap: Label 'Description Of Goods';
        AmountChargeableCapLbl: Label 'Amount Chargeable (in words)';
        InvoiceNoCapLbl: Label 'Invoice No.';
        DateCapLbl: Label 'Dated:';
        RefCapLbl: Label 'Ref. No.';
        RemarksCapLbl: Label 'Remarks:';
        PurchVochCapLbl: Label 'PURCHASE VOUCHER';
        EOECapLbl: Label 'E. & O.E';
        VarElectroCapLbl: Label 'for VAR ELECTROCHEM PRIVATE LIMITED';
        AuthorisedCapLbl: Label 'Authorised Signatory';
        PurchaseInvoiceCapLbl: Label 'PURCHASE INVOICE';
        SNoCapLbl: Label 'Sl No.';
        CompanyInfo: Record "Company Information";
        Name: Text[100];
        Address: Text[100];
        Contact: Text[30];
        Email: Text[80];
        City: Text[30];
        Vendor: Record Vendor;
        TDSEntry: Record "TDS Entry";
        LessCapLbl: Label 'Less';
        TDS: Code[20];
        TDSAmount: Decimal;
        GSTNoCapLbl: Label 'GST No :';
        GSTINCapLbl: Label 'GSTIN/UIN ';
        EmailCapLabl: Label 'E-Mail :';
        EMailCapLbl1: Label 'E-Mail :';
        ContactCapLbl: Label 'Contact :';
        TDSPercent: Decimal;
        TDSPayCapLbl: Label 'TDS Payable on Contracts - ';
        LocationGrec: Record Location;//B2BSSD09Jan2023
        StateNamecapLbl: Label 'State Name:';
        CodeCapLbl: Label 'Code:';
        VendorGrec: Record Vendor;
        PostingDateCapLbl: Label 'Posting Date';
        InvoiceDateCaplbl: Label 'Invoice Date';
        ForvarElecCapLbl: Label 'FOR VAR ELECTROCHEM PRIVATE LIMITED';
        CustomsCapLbl: Label 'Customs duty payable Amount';
        CustomsDutyCapLbl: Label 'Customs duty + Cess';
        rep: Report "Purchase - Invoice GST";
        GstTotal: Decimal;
        GstTotalSum: Decimal;
        AmountVendor: Decimal;
        AmountVendor1: Decimal;
        StateDescrGvar: Text[50];
        StateCodeGva: Code[10];
        IGSTCaption: Text;
        CGSTCaption: Text;
        SGSTCaption: Text;
        TotalCGST: Decimal;
        TotalIGST: Decimal;
        TotalSGST: Decimal;
        VenStateDes: Text[50];
        VenStateCode: code[20];
        RemarksGvar: Text;
        SnoGvar: Integer;
        LineAmountGvar: Decimal;
        CurrencyFactorGvar: Decimal;
        RateGvar: Decimal;
        pag: Page 6510;
        GstReverseBoolGvar: Boolean;
        GSTRegNoGvar: Code[20];
        CustomsDutyAmt: Decimal;
        TotalCustomsDutyAmt: Decimal;
}
report 50094 "Posted Purchase Credit Memo"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Posted Purchase Credit Memo';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\PostedPurchaseCreditMemo.rdl';

    dataset
    {
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            RequestFilterFields = "No.";

            column(No_PurchCrMemoHdr; "No.")
            { }
            column(Vendor_Cr__Memo_No; "Vendor Cr. Memo No.")
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(NewRemarks_PurchInvHeader; "New Remarks")
            {
            }
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
            column(PostingDate_PurchCrMemoHdr; "Posting Date")
            {
            }
            column(DocumentDate_PurchCrMemoHdr; format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(VendorInvoiceDate_PurchInvHeader; "Vendor Invoice Date")
            {
            }
            column(BillofEntryDate_PurchInvHeader; "Bill of Entry Date")
            {
            }
            column(DcDate_PurchInvHeader; "Dc Date")
            {
            }
            column(DueDate_PurchInvHeader; "Due Date")
            {
            }
            column(ExpectedReceiptDate_PurchInvHeader; "Expected Receipt Date")
            {
            }
            column(PaymentDate_PurchInvHeader; "Payment Date")
            {
            }
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
            {

            }
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
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Purch. Cr. Memo Hdr.";
                //DataItemTableView = where(Type = filter(<>''))
                column(Description; Description)
                { }
                column(Amount; Amount)
                { }
                column(IGSTAmt; IGSSTAmt)
                { }
                column(No_PurchCrMemoLine; "No.")
                {
                }
                column(Type_PurchCrMemoLine; "Type")
                {
                }
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
                column(Quantity_PurchCrMemoLine; Quantity)
                { }
                column(RateGvar; RateGvar)
                { }
                column(UnitofMeasureCode_PurchCrMemoLine; "Unit of Measure Code")
                { }
                column(DirectUnitCost_PurchCrMemoLine; "Direct Unit Cost")
                { }
                column(LineAmount_PurchCrMemoLine; "Line Amount")
                { }
                column(LineAmountGvar; LineAmountGvar)
                { }
                column(LineDiscount_PurchCrMemoLine; "Line Discount %")
                { }
                column(SnoGvar; SnoGvar)
                { }
                column(GSTReverseCharge_PurchCrMemoLine; "GST Reverse Charge")
                {
                }
                column(AmountVendor1; AmountVendor1)
                { }
                trigger OnPreDataItem()
                begin
                    //SetFilter(Type, '<>%1', Type::" ");
                end;

                trigger OnAfterGetRecord()
                begin
                    if "GST Reverse Charge" then
                        GstReverseBoolGvar := true;
                    Clear(RateGvar);
                    Clear(LineAmountGvar);
                    if "Purch. Cr. Memo Hdr."."Currency Code" <> '' then begin
                        LineAmountGvar := "Line Amount" / "Purch. Cr. Memo Hdr."."Currency Factor";
                        RateGvar := "Direct Unit Cost" / "Purch. Cr. Memo Hdr."."Currency Factor";
                    end else begin
                        LineAmountGvar := "Line Amount";
                        RateGvar := "Direct Unit Cost";
                    end;
                    Clear(CGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSSTAmt);
                    Clear(TDSAmt);
                    GetPurchGSTAmount("Purch. Cr. Memo Hdr.", "Purch. Cr. Memo Line");
                    GetTDSAmt("Purch. Cr. Memo Hdr.", "Purch. Cr. Memo Line");

                    IGSTCaption := IGSTLbl + '@' + format(IGSTPercentage) + '%';
                    CGSTCaption := CGSTLbl + '@' + format(CGSTPercentage) + '%';
                    SGSTCaption := SGSTLbl + '@' + format(SGSTPercentage) + '%';

                    Clear(GstTotal);
                    GstTotal := CGSTAmt + SGSTAmt + IGSSTAmt;
                    GstTotalSum := GstTotalSum + GstTotal;
                    TotalCGST += CGSTAmt;
                    TotalIGST += IGSSTAmt;
                    TotalSGST += SGSTAmt;
                    Clear(AmountVendor1);
                    if "Purch. Cr. Memo Hdr."."Currency Code" <> '' then
                        AmountVendor += "Line Amount" / "Purch. Cr. Memo Hdr."."Currency Factor"
                    else
                        AmountVendor += "Line Amount";
                    if GstReverseBoolGvar then
                        AmountVendor1 := Round((AmountVendor - TDSAmt), 1)
                    else
                        AmountVendor1 := Round((AmountVendor + GstTotalSum - TDSAmt), 1);

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
                    //B2BSSD09Jan2023<<

                    //B2BSSD09Jan2023>>
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
                if VendorGrec.Get("Purch. Cr. Memo Hdr."."Buy-from Vendor No.") then begin
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

    local procedure GetPurchGSTAmount(PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
           PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(IGSSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(CessAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", PurchCrMemoLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", PurchCrMemoLine."Line No.");
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

    local procedure GetTDSAmt(PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    var
        TDSEntry: Record "TDS Entry";
    begin
        Clear(TDSAmt);
        TDSEntry.Reset();
        TDSEntry.SetRange("Document No.", PurchCrMemoLine."Document No.");
        if TDSEntry.FindSet() then
            repeat
                TDSAmt += TDSEntry."Total TDS Including SHE CESS";
            until TDSEntry.Next() = 0;
    end;



    var
        StateGre: record State;
        StateGre1: record State;
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
        InvoiceNoCapLbl: Label 'Credit Memo No.';
        DateCapLbl: Label 'Dated:';
        RefCapLbl: Label 'Ref. No.';
        RemarksCapLbl: Label 'Remarks:';
        PurchVochCapLbl: Label 'PURCHASE VOUCHER';
        EOECapLbl: Label 'E. & O.E';
        VarElectroCapLbl: Label 'for VAR ELECTROCHEM PRIVATE LIMITED';
        AuthorisedCapLbl: Label 'Authorised Signatory';
        PurchaseInvoiceCapLbl: Label 'PURCHASE CREDIT MEMO';
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
}
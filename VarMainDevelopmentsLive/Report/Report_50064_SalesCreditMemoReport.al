report 50064 "Sales Credit Memo"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sales Credit Memo';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\SalesCreditMemo.rdl';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            //DataItemTableView = where("Document Type" = filter(Invoice));
            RequestFilterFields = "No.";
            column(No_SalesHeader; "No.")
            { }
            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
            { }
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
            { }
            //B2BSSD09Jan2023<<
            column(Location_Addres; LocationGRec.Address)
            { }
            column(Location_Address2; LocationGRec."Address 2")
            { }
            //B2BSSD09Jan2023>>
            column(CompanyInfoGrec_Picture; CompanyInfoGrec.Picture)
            { }
            column(CompanyInfoGrec_city; CompanyInfoGrec.City)
            { }
            column(CompanyStatecode; CompanyStatecode) //B2BSSD14NOV22
            { }
            column(CompanyInfoGrec_PanNo; CompanyInfoGrec."P.A.N. No.")
            { }
            column(CompanyInfoGrec_GstNo; CompanyInfoGrec."GST Registration No.")
            { }
            column(CompanyInfoGrec_Fax; CompanyInfoGrec."Fax No.")
            { }
            column(CompanyInfoGrec_State; CompanyInfoGrec."State Code")
            { }
            column(CompanyInfoGrec_Country; CompanyInfoGrec."Country/Region Code")
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }

            column(InvNoCapLbl; InvNoCapLbl)
            { }
            column(InvDateCapLbl; InvDateCapLbl)
            { }
            column(eWayBillNoCapLbl; eWayBillNoCapLbl)
            { }
            column(GSTINCapLbl; GSTINCapLbl)
            { }
            column(PANCapLbl; PANCapLbl)
            { }
            column(StateandCodeCapLbl; StateandCodeCapLbl)
            { }
            column(SalesCrMemoCapLb1; SalesCrMemoCapLb1)
            { }
            column(NameandaddressofCustCapLbl; NameandaddressofCustCapLbl)
            { }
            column(NameandAddressofConsigneeCapLbl; NameandAddressofConsigneeCapLbl)
            { }
            column(StateCapLbl; StateCapLbl)
            { }
            column(PurchOrdNoCapLbl; PurchOrdNoCapLbl)
            { }
            column(PODateCapLbl; PODateCapLbl)
            { }
            Column(DCNoCapLbl; DCNoCapLbl)
            { }
            column(DCDateCapLbl; DCDateCapLbl)
            { }
            column(TransportModeCapLbl; TransportModeCapLbl)
            { }
            column(VehicleNoCapLbl; VehicleNoCapLbl)
            { }
            column(FreightChargesCapLbl; FreightChargesCapLbl)
            { }
            column(LRNoCapLbl; LRNoCapLbl)
            { }
            column(SNoCapLbl; SNoCapLbl)
            { }
            column(DescCapLbl; DescCapLbl)
            { }
            column(HSNSACCodeCapLbl; HSNSACCodeCapLbl)
            { }
            column(UOMCapLbl; UOMCapLbl)
            { }
            column(QTYCapLbl; QTYCapLbl)
            { }
            column(RateCapLbl; RateCapLbl)
            { }
            column(AmountCapLbl; AmountCapLbl)
            { }
            column(DiscountCapLbl; DiscountCapLbl)
            { }
            column(TaxValueCapLbl; TaxValueCapLbl)
            { }
            column(RemarksCapLbl; RemarksCapLbl)
            { }
            column(TotAmtBefTaxCapLbl; TotAmtBefTaxCapLbl)
            { }
            column(AddCGSTCapLbl; AddCGSTCapLbl)
            { }
            column(AddSGSTCapLbl; AddSGSTCapLbl)
            { }
            column(AddIGSTCapLbl; AddIGSTCapLbl)
            { }
            column(TotTaxAmtCapLbl; TotTaxAmtCapLbl)
            { }
            column(TotalAmtafterTaxCapLbl; TotalAmtafterTaxCapLbl)
            { }
            column(GSTPayCapLbl; GSTPayCapLbl)
            { }
            column(CertifiedthatCapLbl; CertifiedthatCapLbl)
            { }
            column(ForVarCapLbl; ForVarCapLbl)
            { }
            column(AuthSigCapLbl; AuthSigCapLbl)
            { }
            column(TotTaxAmtinWordsCapLbl; TotTaxAmtinWordsCapLbl)
            { }
            column(TotInvoiceAmtinWordsCapLbl; TotInvoiceAmtinWordsCapLbl)
            { }
            column(BankDetailsCapLbl; BankDetailsCapLbl)
            { }
            column(BankACCCapLbl; BankACCCapLbl)
            { }
            column(BankIFSCCapLbl; BankIFSCCapLbl)
            { }
            column(TermsandConditionsCapLbl; TermsandConditionsCapLbl)
            { }
            column(CustomerGrec_Name; CustomerGrec.Name) //B2BSSD14NOV22
            { }
            column(CustomerGrec_Address; CustomerGrec.Address) //B2BSSD14NOV22
            { }
            column(CustomerGrec_Address2; CustomerGrec."Address 2") //B2BSSD14NOV22
            { }
            column(StateDesc; StateDesc) //B2BSSD14NOV22
            { }
            column(CodeLBL; CodeLBL) //B2BSSD14NOV22
            { }
            column(statecode; statecode) //B2BSSD14NOV22
            { }
            //B2BMMOn21Dec2022>>
            column(E_Way_Bill_No_; "E-Way Bill No.")
            { }
            column(Ship_to_Name; "Ship-to Name")
            { }
            column(Ship_to_Address; "Ship-to Address")
            { }
            column(Ship_to_Address_2; "Ship-to Address 2")
            { }
            column(State; State)
            { }
            column(External_Document_No_; "External Document No.")
            { }
            column(External_Document_Date; format("External Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Transport_Method; "Transport Method")
            { }
            column(Vehicle_No_; "Vehicle No.")
            { }
            // column(LR_RR_No_; "LR/RR No.")
            // { }
            column(TotalAmtBeforeTax; TotalAmtBeforeTax)
            { }
            column(TotalTaxAmt; TotalTaxAmt)
            { }
            column(TotalAmtAfterTax; TotalAmtAfterTax)
            { }
            column(BankGRec_Name; BankGRec.Name)
            {
            }
            column(BankGRec_Address; BankGRec.Address)
            {
            }
            column(BankGRec_BankAccNo; BankGRec."Bank Account No.")
            {
            }
            column(BankGRec_IFSC; BankGRec."IFSC Code")
            {
            }
            column(BankGRec_Swift; BankGRec."SWIFT Code")
            {
            }
            column(CGSTRate; CGSTRate)
            { }
            column(SGSTRate; SGSTRate)
            { }
            column(IGSTAmt; IGSTAmt)
            { }
            column(IGSTRate; IGSTRate)
            { }
            column(CGSTAmt; CGSTAmt)
            { }
            column(SGSTAmt; SGSTAmt)
            { }
            column(EnvoiceEntry_Irno; EnvoiceEntry."IRN No.")
            { }
            column(EnvoiceEntry_Qrcode; EnvoiceEntry."QR Code")
            { }



            //B2BMMOn21Dec2022<<
            column(statecode2; Cmpstatecode2)
            { }


            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {

                DataItemLinkReference = "Sales Cr.Memo Header";
                DataItemLink = "Document No." = FIELD("No.");
                column(No_SalesLine; "No.")
                {
                }
                column(HSNSACCode_SalesLine; "HSN/SAC Code")
                {
                }
                column(Description_SalesLine; Description)
                {
                }
                column(UnitPrice_SalesLine; "Unit Price")
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                }
                column(Amount_SalesLine; Amount)
                {

                }
                column(NumberText; NumberText[1])
                {
                }
                column(NumberText1; NumberText1[1])
                {
                }
                column(Line_Discount_Amount; "Line Discount Amount")
                { }
                trigger OnAfterGetRecord()
                begin
                    GetSalesGSTAmount("Sales Cr.Memo Header", "Sales Cr.Memo Line");
                    CheckGRec.InitTextVariable;
                    CheckGRec.FormatNoText(NumberText, Round(TotalTaxAmt, 1, '='), "Sales Cr.Memo Header"."Currency Code");
                    "Sales Cr.Memo Header".CalcFields("Amount Including VAT");
                    CheckGRec.FormatNoText(NumberText1, Round("Sales Cr.Memo Header"."Amount Including VAT" + TotalTaxAmt, 1, '='), "Sales Cr.Memo Header"."Currency Code");
                end;

            }
            trigger OnAfterGetRecord()
            var
                StateLRec: Record State;
            begin
                Clear(CustomerGrec);
                Clear(StateLRec);
                Clear(StateDesc);
                //B2BSSD09Jan2023<<
                Clear(LocationGRec);
                if LocationGRec.Get("Location Code") then;
                //B2BSSD09Jan2023>>
                if CustomerGrec.Get("Sales Cr.Memo Header"."Sell-to Customer No.") then;
                if StateLRec.get("Sales Cr.Memo Header".State) then; //B2BSSD14NOV22
                StateDesc := StateLRec.Description;
                statecode := StateLRec."State Code (GST Reg. No.)";

                if StateLRec.Get(CompanyInfoGrec."State Code") then
                    CompanyStatecode := StateLRec.Description;
                Cmpstatecode2 := StateLRec."State Code (GST Reg. No.)";

                if BankCode <> '' then
                    if not BankGRec.Get(BankCode) then
                        Clear(BankGRec);
                // CHB2B22Dec2022<<
                IRNNoCaptionLVar := '';
                IF EnvoiceEntry.GET(EnvoiceEntry."Document Type"::"Sales Cr. Memo", "Sales Cr.Memo Header"."No.") THEN BEGIN
                    EnvoiceEntry.CALCFIELDS("QR Code");
                    IF EnvoiceEntry."IRN No." <> '' THEN
                        IRNNoCaptionLVar := 'IRN No.';
                END;
                // CHB2B22Dec2022>>



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
                    field(BankCode; BankCode)
                    {
                        Caption = 'Bank Code';
                        TableRelation = "Bank Account"."No.";
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
        CompanyInfoGrec.Get();
        CompanyInfoGrec.CalcFields(Picture);

    end;


    local procedure GetComponentName(SalesLine: Record "Sales Invoice Line";
        GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if SalesLine."GST Jurisdiction Type" = SalesLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
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

    local procedure GetSalesGSTAmount(SalesCreditMemoHeader: Record "Sales Cr.Memo Header";
              SalesCreditMemoLine: Record "Sales Cr.Memo Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        //Clear(IGSSTAmt);
        //Clear(CGSTAmt);
        //Clear(SGSTAmt);
        //Clear(CessAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesCreditMemoLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesCreditMemoLine."Line No.");
        if DetailedGSTLedgerEntry.FindSet() then begin
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (SalesCreditMemoHeader."Currency Code" <> '') then begin
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCreditMemoHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    CGSTRate += DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then begin
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        CGSTRate += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (SalesCreditMemoHeader."Currency Code" <> '') then begin
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCreditMemoHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    SGSTRate += DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then begin
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        SGSTRate += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (SalesCreditMemoHeader."Currency Code" <> '') then begin
                    IGSSTAmt := Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCreditMemoHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    IGSTRate += DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then begin
                        IGSSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
                        IGSTRate += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (SalesCreditMemoHeader."Currency Code" <> '') then begin
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesCreditMemoHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then begin
                        CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                    end;
            // TotalAmtBeforeTax += CGSTAmt + SGSTAmt + IGSSTAmt;
            // TotalTaxAmt += CGSTRate + SGSTRate + IGSTRate;
            // TotalAmtAfterTax += (TotalAmtBeforeTax + TotalTaxAmt);
            until DetailedGSTLedgerEntry.Next() = 0;

            TotalTaxAmt += CGSTAmt + SGSTAmt + IGSSTAmt;
        end;
    end;

    var
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        CGSTRate: Decimal;
        SGSTRate: Decimal;
        IGSTRate: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';

        CompanyInfoGrec: Record "Company Information";
        CustomerGrec: Record Customer;
        PostSalesInvoice: Record "Sales Invoice Header";
        InvNoCapLbl: Label 'Invoice No:';
        InvDateCapLbl: label 'Invoice Date';
        eWayBillNoCapLbl: Label 'e Way Bill No.';
        GSTINCapLbl: Label 'GSTIN';
        PANCapLbl: Label 'PAN';
        StateandCodeCapLbl: Label 'State & Code:';
        SalesCrMemoCapLb1: Label 'Sales Credit Memo';
        NameandaddressofCustCapLbl: Label 'Name and Address of Customer/Bill to Party:';
        NameandAddressofConsigneeCapLbl: Label 'Name and Address of Consignee/Ship to Party:';
        StateCapLbl: Label 'STATE';
        CodeCapLbl: Label 'CODE';
        PurchOrdNoCapLbl: Label 'Purchase Order No.';
        PODateCapLbl: Label 'P.O.Date';
        DCNoCapLbl: Label 'D.C No.';
        DCDateCapLbl: Label 'D.C Date.';
        TransportModeCapLbl: Label 'Transport Mode:';
        VehicleNoCapLbl: Label 'Vehicle Number:';
        FreightChargesCapLbl: Label 'Freight Charges';
        LRNoCapLbl: Label 'L.R.No.';
        SNoCapLbl: Label 'S.No.';
        DescCapLbl: Label 'DESCRIPTION';
        HSNSACCodeCapLbl: Label 'HSN/SAC CODE';
        UOMCapLbl: Label 'UOM';
        QTYCapLbl: Label 'QTY';
        RateCapLbl: Label 'RATE';
        AmountCapLbl: Label 'AMOUNT';
        DiscountCapLbl: Label 'DISCOUNT';
        TaxValueCapLbl: Label 'TAXABLE VALUE';
        RemarksCapLbl: Label 'Remarks';
        TotAmtBefTaxCapLbl: Label 'Total Amount Before Tax';
        AddCGSTCapLbl: Label 'Add:CGST@';
        AddSGSTCapLbl: Label 'Add:SGST@';
        AddIGSTCapLbl: Label 'Add:IGST@';
        TotTaxAmtCapLbl: Label 'Total Tax Amount';
        TotalAmtafterTaxCapLbl: Label 'Total Amount After Tax:';
        GSTPayCapLbl: Label 'GST Payable on Reverse Charge';
        TotTaxAmtinWordsCapLbl: Label 'Total Tax Amount in Words:';
        TotInvoiceAmtinWordsCapLbl: Label 'Total Invoice Amount in Words:';
        BankDetailsCapLbl: Label 'Bank Details';
        BankACCCapLbl: Label 'Bank A/C:';
        BankIFSCCapLbl: Label 'Bank IFSC:';
        TermsandConditionsCapLbl: Label 'Terms & Conditions:';
        CertifiedthatCapLbl: Label 'Certified that the particulars given above are true and correct';
        ForVarCapLbl: Label 'For VAR ELECTROCHEM PRIVATE LIMITED';
        AuthSigCapLbl: Label 'Authorised Signatory';
        CodeLBL: Label 'Post Code';
        StateDesc: Text; //B2BSSD14NOV22
        statecode: Code[10]; //B2BSSD14NOV22
        CompanyStatecode: Code[10]; //B2BSSD14NOV22
        TotalAmtBeforeTax: Decimal;
        TotalTaxAmt: Decimal;
        TotalAmtAfterTax: Decimal;
        NumberText: array[2] of Text;
        NumberText1: array[2] of Text;
        GSTIN: Code[20];
        CheckGRec: Codeunit "Check Codeunit";
        BankCode: Code[20];
        BankGRec: Record "Bank Account";
        Cmpstatecode2: Code[10];
        IRNNoCaptionLVar: Text[50];
        EnvoiceEntry: Record "E-Invoice Entry";
        LocationGRec: Record Location;//B2BSSD09Jan2023


}

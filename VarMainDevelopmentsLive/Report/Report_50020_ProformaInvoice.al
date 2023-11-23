report 50020 "Proforma Invoice New"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Proforma Invoice';
    DefaultLayout = RDLC;
    RDLCLayout = 'New Report Layouts\DomesticInvoice2 - Copy.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            column(No_SalesHeader; "No.")
            { }
            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
            { }
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
            { }
            column(CompanyInfoGrec_Picture; CompanyInfoGrec.Picture)
            { }
            column(CompanyInfoGrec_city; CompanyInfoGrec.City)
            { }
            column(CompanyStatecode; CompanyStatecode) //B2BSSD14NOV22
            { }
            column(CustomerPoNo_SalesInvoiceHeader; "Customer Po No.")
            {
            }
            column(ModeofTransport_SalesInvoiceHeader; "Mode of Transport")
            {
            }
            column(LRRRDate_SalesInvoiceHeader; Format("LR/RR Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(ShipmentDate_SalesInvoiceHeader; format("Shipment Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(FinalDestintion_SalesHeader; "Final Destintion")
            { }
            column(CustomerPoDate_SalesInvoiceHeader; format("Customer Po Date", 0, '<Day,2>-<Month,2>-<Year4>'))
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
            column(TaxInvCapLbl; TaxInvCapLbl)
            { }
            column(NameandaddressofCustCapLbl; NameandaddressofCustCapLbl)
            { }
            column(NameandAddressofConsigneeCapLbl; NameandAddressofConsigneeCapLbl)
            { }
            column(ShipToNameGvar; ShipToNameGvar)
            { }
            column(ShiptoAdressGvar; ShiptoAdressGvar)
            { }
            column(ShipToAddress2Gvar; ShipToAddress2Gvar)
            { }
            column(ShipToStateGvar; ShipToStateGvar)
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
            column(LR_RR_No_; "LR/RR No.")
            { }
            column(TotalAmtBeforeTax; TotalAmtBeforeTax)
            { }
            column(TotalTaxAmt; TotalTaxAmt)
            { }
            column(TotalAmtAfterTax; TotalAmtAfterTax)
            { }
            column(BankGRec_Name; BankGRec.Name)
            { }
            column(BankGRec_Address; BankGRec.Address)
            { }
            column(BankGRec_BankAccNo; BankGRec."Bank Account No.")
            { }
            column(BankGRec_IFSC; BankGRec."IFSC Code")
            { }
            column(BankGRec_Swift; BankGRec."SWIFT Code")
            { }
            column(CGSTRate; CGSTRate)
            { }
            column(SGSTRate; SGSTRate)
            { }
            column(IGSTAmt; IGSSTAmt)
            { }
            column(IGSTRate; IGSTRate)
            { }
            column(CGSTAmt; CGSTAmt)
            { }
            column(SGSTAmt; SGSTAmt)
            { }
            //B2BMMOn21Dec2022<<
            column(statecode2; Cmpstatecode2)
            { }
            column(IRNNoCaption; IRNNoCaptionLVar)
            { }
            column(PrepaymentNo_SalesHeader; "Prepayment No.")
            { }
            column(LastPrepaymentNo_SalesHeader; "Last Prepayment No.")
            { }
            column(EnvoiceEntry_irno; EnvoiceEntry."IRN No.")
            { }
            column(EnvoiceEntry_Qrcode; EnvoiceEntry."QR Code")
            { }
            column(LocationGRec_Name; LocationGRec.Name)
            { }
            column(LocationGRec_Address; LocationGRec.Address)
            { }
            column(LocationGRec_Address2; LocationGRec."Address 2")
            { }
            column(LocationGRec; LocationGRec."GST Registration No.")
            { }
            column(LocationGRec_GstRegistration; LocationGRec."GST Registration No.")
            { }
            column(LocationGRec_City; LocationGRec.City)
            { }
            column(LocationGRec_postCode; LocationGRec."Post Code")
            { }
            column(LocationGRec_FaxNo; LocationGRec."Fax No.")
            { }
            column(TeleFaxNoCapLbl; TeleFaxNoCapLbl)
            { }
            column(CountryGrec_Name; CountryGrec.Name)
            { }
            column(Customer_GST_Reg__No_SIH; "Customer GST Reg. No.")
            { }
            column(Remarks1CapLbl; Remarks1CapLbl)
            { }
            column(Remarks2CapLbl; Remarks2CapLbl)
            { }
            column(PostingNo; "Posting No.")
            { }

            dataitem("Sales Line"; "Sales Line")
            {

                DataItemLinkReference = "Sales Header";
                //DataItemLink = "Document No." = FIELD("No.");
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
                column(PrepaymentAmount_SalesLine; "Prepayment Amount")
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                }
                column(UnitofMeasureCode_SalesInvoiceLine; "Unit of Measure Code")
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
                column(Inv__Discount_Amount; "Inv. Discount Amount")
                { }
                column(CGSTPer; CGSTPer)
                { }
                column(SGSTPer; SGSTPer)
                { }
                column(IGSTPer; IGSTPer)
                { }
                column(SNoGVar; SNoGVar)
                { }
                trigger OnPreDataItem()
                begin
                    //SetFilter(Type, '<>%1', Type::" ");
                end;

                trigger OnAfterGetRecord()
                begin

                    if (Type <> Type::" ") then
                        SNoGVar += 1;
                    //GetSalesGSTAmount("Sales Invoice Header", "Sales Invoice Line");

                    //CheckGRec.InitTextVariable;
                    //CheckGRec.FormatNoText(NumberText, Round(CGSTAmt + SGSTAmt + IGSSTAmt, 1, '='), "Sales Invoice Header"."Currency Code");
                    //"Sales Invoice Header".CalcFields("Amount Including VAT");
                    //CheckGRec.FormatNoText(NumberText1, Round("Sales Invoice Header"."Amount Including VAT" + CGSTAmt + SGSTAmt + IGSSTAmt, 1, '='), "Sales Invoice Header"."Currency Code");
                    //Clear(GstTotal);
                    //GstTotal := CGSTAmt + SGSTAmt + IGSSTAmt;
                    //GstTotalSum := GstTotalSum + GstTotal;

                    //Clear(AmountVendor1);
                    //if "Sales Invoice Header"."Currency Factor" <> 0 then
                    //    AmountVendor += "Line Amount" / "Sales Invoice Header"."Currency Factor"
                    //else
                    //    AmountVendor += "Line Amount";
                    //AmountVendor1 := AmountVendor + GstTotalSum;
                    //CHB2B27FEB2023<<
                    //clear(NumberText);
                    //CheckGRec.InitTextVariable;
                    //CheckGRec.FormatNoText(NumberText, GstTotalSum, "Sales Invoice Header"."Currency Code");
                    //CheckGRec.FormatNoText(NumberText1, AmountVendor1, "Sales Invoice Header"."Currency Code");
                    Clear(CGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSTAmt);
                    Clear(SGSTPer);
                    Clear(IGSTPer);
                    Clear(CGSTPer);
                    GSTSetup.get();
                    GetGSTAmounts(TaxTransactionValue, "Sales Line", GSTSetup);
                    Clear(GstTotal);

                    GstTotal := CGSTAmt + SGSTAmt + IGSTAmt;
                    GstTotalSum := GstTotalSum + GstTotal;
                    //GSTPerQTY := GstTotal / Quantity;
                    //GSTPertotal := CGSTPer + SGSTPer + IGSTPer;
                    //Message('%1', GstTotal);
                    Clear(AmountVendor1);
                    AmountVendor += "Line Amount";
                    AmountVendor1 := AmountVendor + GstTotalSum;
                    CheckGRec.InitTextVariable;
                    CheckGRec.FormatNoText(NumberText, GstTotalSum, '');
                    CheckGRec.FormatNoText(NumberText1, AmountVendor1, '');
                    // GetSalesGSTAmount("Sales Invoice Header", "Sales Invoice Line");
                    //"Sales Invoice Header".CalcFields("Amount Including VAT");
                    // ReportCheck.InitTextVariable;
                end;

            }
            trigger OnAfterGetRecord()
            var
                StateLRec: Record State;
            begin
                Clear(CustomerGrec);
                Clear(StateLRec);
                Clear(StateDesc);
                Clear(ShipToNameGvar);
                Clear(ShiptoAdressGvar);
                Clear(ShipToAddress2Gvar);
                Clear(ShipToStateGvar);
                Clear(SNoGVar);
                if "Ship-to Code" <> '' then begin
                    ShipToNameGvar := "Ship-to Name";
                    ShiptoAdressGvar := "Ship-to Address";
                    ShipToAddress2Gvar := "Ship-to Address 2";
                    ShipToStateGvar := "Ship-to City";
                end else begin
                    ShipToNameGvar := "Bill-to Name";
                    ShiptoAdressGvar := "Bill-to Address";
                    ShipToAddress2Gvar := "Bill-to Address 2";
                    ShipToStateGvar := "Bill-to City";
                end;

                if CustomerGrec.Get("Sell-to Customer No.") then;

                if StateLRec.get(State) then; //B2BSSD14NOV22
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
                IF EnvoiceEntry.GET(EnvoiceEntry."Document Type"::"Sales Invoice", "No.") THEN BEGIN
                    EnvoiceEntry.CALCFIELDS("QR Code");
                    IF EnvoiceEntry."IRN No." <> '' THEN
                        IRNNoCaptionLVar := 'IRN No.';
                END;
                // CHB2B22Dec2022>>
                if not LocationGRec.Get("Location Code") then
                    Clear(LocationGRec);
                Clear(CountryGrec);
                if CountryGrec.Get(LocationGRec."Country/Region Code") then;


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



    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
   SalesLine: Record "Sales Line";
   GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];
    begin

        ComponentName := GetComponentName("Sales Line", GSTSetup);

        if (SalesLine.Type <> SalesLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                SGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                SGSTPer := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                CGSTPer := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                IGSTPer := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;
    end;

    local procedure GetComponentName(SalesLine: Record "Sales Line";
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
        TaxInvCapLbl: Label 'PROFORMA INVOICE';
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
        CodeLBL: Label 'Code';
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
        EnvoiceEntry: Record "E-Invoice Entry";
        IRNNoCaptionLVar: Text[50];
        LocationGRec: Record Location;
        GstTotal: Decimal;
        GstTotalSum: Decimal;
        AmountVendor1: Decimal;
        AmountVendor: Decimal;
        CountryGrec: Record "Country/Region";
        TeleFaxNoCapLbl: Label 'Tel/ Fax No.';
        GSTSetup: Record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
        Remarks1CapLbl: Label '1. All disputes subject to Hyderabad Jurisdiction Only.';
        Remarks2CapLbl: Label '2. No deduction to be made in any case without our consent';
        ShipToNameGvar: Text;
        ShiptoAdressGvar: Text;
        ShipToAddress2Gvar: Text;
        ShipToStateGvar: Text;
        IGSTPer: Decimal;
        SGSTPer: Decimal;
        CGSTPer: Decimal;
        SNoGVar: Integer;
        newlbl: Label '🗹';
        pa: Page 1355;
}

report 50099 "Sales Domestic Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sales Domestic Invoice';
    DefaultLayout = RDLC;
    RDLCLayout = 'New Report Layouts\SalesDomesticInvoice1 - Copy.rdl';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            DataItemTableView = where("Document Type" = const("Document Type"::Invoice));
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
            column(AmendmentNo_SalesInvoiceHeader; "Amendment No.")
            {
            }
            column(AmendmentDate_SalesInvoiceHeader; "Amendment Date")
            {
            }
            column(CustomerPoNo_SalesInvoiceHeader; "Customer Po No.")
            {
            }
            column(ModeofTransport_SalesInvoiceHeader; "Mode of Transport")
            {
            }
            column(LRRRDate_SalesInvoiceHeader; "LR/RR Date")
            {
            }
            column(FinalDestintion_SalesInvoiceHeader; "Final Destintion")
            {
            }
            column(ShipmentDate_SalesInvoiceHeader; "Shipment Date")
            {
            }
            column(CustomerPoDate_SalesInvoiceHeader; "Customer Po Date")
            {
            }
            column(CompanyInfoGrec_PanNo; CompanyInfoGrec."P.A.N. No.")
            { }
            column(CompanyInfoGrec_GstNo; CompanyInfoGrec."GST Registration No.")
            { }
            column(OriginalForReceipt; OriginalForReceipt)
            { }
            column(DuplicateForTransporter; DuplicateForTransporter)
            { }
            column(TriplicateForSupplier; TriplicateForSupplier)
            { }
            column(NumberText; NumberText[1])
            {
            }
            column(NumberText1; NumberText1[1])
            {
            }
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
            column(OriginalCapLbl; OriginalCapLbl)
            { }
            column(DuplicateCapLbl; DuplicateCapLbl)
            {

            }
            column(TriplicateCapLbl; TriplicateCapLbl)
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
            column(CustomerGrec_City; CustomerGrec.City)
            { }
            column(CustomerGrec_PostCode; CustomerGrec."Post Code")
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
            column(Ship_to_City; "Ship-to City")
            { }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            { }
            column(Bill_to_City; "Bill-to City")
            { }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            { }
            column(State; State)
            { }
            column(newlbl; newlbl)
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
            column(IGSTAmt; IGSSTAmt)
            { }
            column(IGSTRate; IGSTRate)
            { }
            column(CGSTAmt; CGSTAmt)
            { }
            column(SGSTAmt; SGSTAmt)
            { }
            column(TCSAmountVar; TCSAmountVar)
            { }
            column(TCSAmountCap; TCSAmountCap)
            { }
            //B2BMMOn21Dec2022<<
            column(statecode2; Cmpstatecode2)
            { }
            column(IRNNoCaption; IRNNoCaptionLVar)
            {
            }
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
            {
            }
            column(TeleFaxNoCapLbl; TeleFaxNoCapLbl)
            { }
            column(CountryGrec_Name; CountryGrec.Name)
            { }
            column(Customer_GST_Reg__No_SIH; "Customer GST Reg. No.")
            {

            }
            column(Remarks1CapLbl; Remarks1CapLbl)
            {

            }
            column(Remarks2CapLbl; Remarks2CapLbl)
            { }

            column(Remarks3CapLbl; Remarks3CapLbl)
            { }
            column(Remarks4CapLbl; Remarks4CapLbl)
            { }
            column(CINNoCap; CINNoCap)
            { }
            column(GSTRegNo; GSTRegNo)
            { }
            column(Acknowledgement_No_; '')
            { }//sao
            column(Acknowledgement_Date; '')
            { }
            /*  column(Acknowledgement_Date; format("Acknowledgement Date", 0, '<Day,2>-<Month,2>-<Year4>'))
              { }*/
            column(AcknowLedNoCap; AcknowLedNoCap)
            { }
            column(AcknowLedDateCap; AcknowLedDateCap)
            { }
            dataitem("Sales Line"; "Sales Line")
            {

                DataItemLinkReference = "Sales Header";
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
                column(UnitofMeasureCode_SalesInvoiceLine; "Unit of Measure Code")
                {
                }
                column(Amount_SalesLine; Amount)
                {

                }
                column(LineAmount_SalesInvoiceLine; "Line Amount")
                {
                }
                column(AmountVendor; AmountVendor)
                { }

                column(Line_Discount_Amount; "Line Discount Amount")
                { }
                column(Inv__Discount_Amount; "Inv. Discount Amount")
                { }
                column(SNoGVar; SNoGVar)
                { }
                trigger OnPreDataItem()
                begin
                    //SetFilter(Type, '<>%1', Type::" ");
                end;

                trigger OnAfterGetRecord()
                var
                    TCSEntryRec: Record "TCS Entry";
                begin
                    if ("Sales Line".Type <> "Sales Line".Type::" ") then
                        SNoGVar += 1;
                    Clear(CGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSTAmt);
                    Clear(TCSAmountVar);

                    GetSalesGSTAmount("Sales Header", "Sales Line");

                    TCSEntryRec.Reset();
                    TCSEntryRec.SetRange("Document No.", "Document No.");
                    if TCSEntryRec.FindSet() then begin
                        TCSAmountVar += TCSEntryRec."TCS Amount";
                    end;
                    //CheckGRec.InitTextVariable;
                    //CheckGRec.FormatNoText(NumberText, Round(CGSTAmt + SGSTAmt + IGSSTAmt, 1, '='), "Sales Invoice Header"."Currency Code");
                    "Sales Header".CalcFields("Amount Including VAT");
                    //CheckGRec.FormatNoText(NumberText1, Round("Sales Invoice Header"."Amount Including VAT" + CGSTAmt + SGSTAmt + IGSSTAmt, 1, '='), "Sales Invoice Header"."Currency Code");
                    Clear(GstTotal);
                    GstTotal := CGSTAmt + SGSTAmt + IGSSTAmt;
                    GstTotalSum := GstTotalSum + GstTotal;

                    Clear(AmountVendor1);
                    if "Sales Header"."Currency Factor" <> 0 then
                        AmountVendor += "Line Amount" / "Sales Header"."Currency Factor" + TCSAmountVar
                    else
                        AmountVendor += "Line Amount";
                    AmountVendor1 := AmountVendor + GstTotalSum + TCSAmountVar;
                    //CHB2B27FEB2023<<
                    //clear(NumberText);
                    CheckGRec.InitTextVariable;
                    CheckGRec.FormatNoText(NumberText, GstTotalSum, "Sales Header"."Currency Code");
                    CheckGRec.FormatNoText(NumberText1, AmountVendor1, "Sales Header"."Currency Code");

                end;

            }
            trigger OnAfterGetRecord()
            var
                StateLRec: Record State;
            begin
                Clear(CustomerGrec);
                Clear(StateLRec);
                Clear(StateDesc);
                Clear(SNoGVar);
                if CustomerGrec.Get("Sales Header"."Sell-to Customer No.") then;

                //  if StateLRec.get("Sales Header".State) then; //B2BSSD14NOV22
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
                IF EnvoiceEntry.GET(EnvoiceEntry."Document Type"::"Sales Invoice", "Sales Header"."No.") THEN BEGIN
                    EnvoiceEntry.CALCFIELDS("QR Code");
                    IF EnvoiceEntry."IRN No." <> '' THEN
                        IRNNoCaptionLVar := 'IRN No.';
                END;
                // CHB2B22Dec2022>>
                if not LocationGRec.Get("Location Code") then
                    Clear(LocationGRec);
                Clear(CountryGrec);
                if CountryGrec.Get(LocationGRec."Country/Region Code") then;

                if LocationGrec1.Get("Location Code") then
                    GSTRegNo := LocationGRec."GST Registration No.";

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
                    field(OriginalForReceipt; OriginalForReceipt)
                    {
                        Caption = 'Original For Receipient';
                        ApplicationArea = all;
                    }
                    field(DuplicateForTransporter; DuplicateForTransporter)
                    {
                        ApplicationArea = all;
                        Caption = 'Duplicate For Transporter';
                    }
                    field(TriplicateForSupplier; TriplicateForSupplier)
                    {
                        ApplicationArea = all;
                        Caption = 'Triplicate For Supplier';
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

    local procedure GetSalesGSTAmount(SalesHeader: Record "Sales Header";
              SalesLine: Record "Sales Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        //Clear(IGSSTAmt);
        //Clear(CGSTAmt);
        //Clear(SGSTAmt);
        //Clear(CessAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesLine."Line No.");
        if DetailedGSTLedgerEntry.FindSet() then begin
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (SalesHeader."Currency Code" <> '') then begin
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    CGSTRate += DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then begin
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        CGSTRate += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (SalesHeader."Currency Code" <> '') then begin
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    SGSTRate += DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then begin
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        SGSTRate += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (SalesHeader."Currency Code" <> '') then begin
                    IGSSTAmt := Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    IGSTRate += DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then begin
                        IGSSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
                        IGSTRate += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (SalesHeader."Currency Code" <> '') then begin
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then begin
                        CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                    end;

            until DetailedGSTLedgerEntry.Next() = 0;

            //TotalTaxAmt += CGSTAmt + SGSTAmt + IGSSTAmt;

        end;
    end;

    var
        LocationGrec1: Record Location;
        GSTRegNo: Code[20];
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
        TaxInvCapLbl: Label 'DRAFT TAX INVOICE';
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
        //TotTaxAmtCapLbl: Label 'Total Tax Amount';
        TotTaxAmtCapLbl: Label 'Total GST Amount';
        TotalAmtafterTaxCapLbl: Label 'Total Amount After Tax:';
        GSTPayCapLbl: Label 'GST Payable on Reverse Charge';
        TotTaxAmtinWordsCapLbl: Label 'Total GST Amount in Words:';
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
        Remarks1CapLbl: Label '1. All disputes subject to Hyderabad Jurisdiction Only.';
        Remarks2CapLbl: Label '2. Goods once sold will not be taken back';
        Remarks3CapLbl: Label '3. No deduction to be made in any case without our consent';
        Remarks4CapLbl: Label '4. Interest @ 24% will be charged on belated payments';
        SNoGVar: Integer;
        OriginalCapLbl: Label 'ORIGINAL FOR RECIPIENT';
        DuplicateCapLbl: Label 'DUPLICATE FOR TRANSPORTER';
        TriplicateCapLbl: Label 'TRIPLICATE FOR SUPPLIER';
        OriginalForReceipt: Boolean;
        DuplicateForTransporter: Boolean;
        TriplicateForSupplier: Boolean;
        //newlbl: Label '🗹';
        newlbl: Label '🗸';
        CINNoCap: Label 'CIN No. U31402TG1997PTC028377';
        TCSAmountVar: Decimal;
        TCSAmountCap: Label 'TCS Amount';
        AcknowLedNoCap: Label 'Ack.No.:';
        AcknowLedDateCap: Label 'Ack.Date:';
}

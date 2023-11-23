report 50003 "Proforma Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Invoice For Advance';
    DefaultLayout = RDLC;
    RDLCLayout = 'New Report Layouts\ProformaInvoice1.rdl';


    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {

            // DataItemTableView = WHERE("Document Type" = FILTER(Invoice));
            RequestFilterFields = "No.";
            column(No_SalesHeader; "No.")
            {
            }
            column(OrderDate_SalesHeader; format("Order Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(PostingDate_SalesHeader; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(FinalDestintion_SalesHeader; "Final Destintion")
            {
            }
            column(ProformaCapLbl; ProformaCapLbl)
            { }
            column(InvoiceForAdvCapLbl; InvoiceForAdvCapLbl)
            { }
            column(ExporterCapLbl; ExporterCapLbl)
            { }
            column(InvoiceNoCapLbl; InvoiceNoCapLbl)
            { }
            column(ExporterRefCapLbl; ExporterRefCapLbl)
            { }
            column(DateCapLbl; DateCapLbl)
            { }
            column(IecCap; IecNoCaPLbl)
            { }
            column(BuyersOrdNoDateCapLbl; BuyersOrdNoDateCapLbl)
            { }
            column(BilltoName_SalesHeader; "Bill-to Name")
            {
            }
            column(BilltoName2_SalesHeader; "Bill-to Name 2")
            {
            }
            column(BilltoAddress_SalesHeader; "Bill-to Address")
            {
            }
            column(Remarks1_SalesHeader; Remarks1)
            {
            }
            column(Remarks2_SalesHeader; Remarks2)
            {
            }
            column(BilltoAddress2_SalesHeader; "Bill-to Address 2")
            {
            }
            column(BilltoPostCode_SalesHeader; "Bill-to Post Code")
            {
            }
            column(BilltoCity_SalesHeader; "Bill-to City")
            {
            }
            column(BilltoCounty_SalesHeader; "Bill-to County")
            {
            }
            column(BilltoContact_SalesHeader; "Bill-to Contact")
            {
            }
            column(BilltoCustomerNo_SalesHeader; "Bill-to Customer No.")
            {
            }
            column(BilltoCountryRegionCode_SalesHeader; "Bill-to Country/Region Code")
            {
            }
            column(BilltoContactNo_SalesHeader; "Bill-to Contact No.")
            {
            }
            column(DtCapLbl; DtCapLbl)
            { }
            column(BuyerIfOtherThanCapLbl; BuyerIfOtherThanCapLbl)
            { }
            column(ConsigneeCapLbl; ConsigneeCapLbl)
            { }
            column(PreCarriageByCapLbl; PreCarriageByCapLbl)
            { }
            column(PlaceOfreceiptByCapLbl; PlaceOfreceiptByCapLbl)
            { }
            column(CountryOfOriginCapLbl; CountryOfOriginCapLbl)
            { }
            column(CountryOfFinalDestination; CountryOfFinalDestination)
            { }
            column(VesslFlightNoCapLbl; VesslFlightNoCapLbl)
            { }
            column(PortOfLoading; PortOfLoading)
            { }
            column(TermsOfDeliveryAndPaymentCapLbl; TermsOfDeliveryAndPaymentCapLbl)
            { }
            column(ShipmentTermsCapLbl; ShipmentTermsCapLbl)
            { }
            column(PortOfDischargeCapLbl; PortOfDischargeCapLbl)
            { }
            column(FinalDestinationCapLbl; FinalDestinationCapLbl)
            { }
            column(PaymentTermsCapLbl; PaymentTermsCapLbl)
            { }
            column(MarksnosCapLbl; MarksnosCapLbl)
            { }
            column(NoAndKindOfPackingsCapLbl; NoAndKindOfPackingsCapLbl)
            { }
            column(DescriptionOfMaterialCapLbl; DescriptionOfMaterialCapLbl)
            { }
            column(QuantityCapLbl; QuantityCapLbl)
            { }
            column(UnitPriceCapLbl; UnitPriceCapLbl)
            { }
            column(TotalAmountInDollarsCapLl; TotalAmountInDollarsCapLl)
            { }
            column(CartonBoxesCapLbl; CartonBoxesCapLbl)
            { }
            column(GrossWeightCapLbl; GrossWeightCapLbl)
            { }
            column(NetWeightCapLbl; NetWeightCapLbl)
            { }
            column(DeclarationCapLbl; DeclarationCapLbl)
            { }
            column(DeclarationMatterLbl; DeclarationMatterLbl)
            { }
            /*column(OurBankDetailsCapLbl; OurBankDetailsCapLbl)
            { }
            column(InterMediatelyBankCapLbl; InterMediatelyBankCapLbl)
            { }
            column(SwiftCodeCapLbl; SwiftCodeCapLbl)
            { }*/
            column(FedwireAbaNoCapLbl; FedwireAbaNoCapLbl)
            { }
            column(ChipsAbaNoCapLbl; ChipsAbaNoCapLbl)
            { }
            column(ChipsUidNoCapLbl; ChipsUidNoCapLbl)
            { }
            column(FavouringBenificiaryBankCapLbl; FavouringBenificiaryBankCapLbl)
            { }
            column(BenificiaryNameCapLbl; BenificiaryNameCapLbl)
            { }
            column(BenificiaryAccountNoCapLbl; BenificiaryAccountNoCapLbl)
            { }
            column(BankIfscCode; BankIfscCode)
            { }
            column(WeHereByCertifyThatCapLbl; WeHereByCertifyThatCapLbl)
            { }
            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Picture; CompanyInfoGrec.Picture)
            { }
            column(UnitPriceText; UnitPriceText)
            { }
            column(TotalAmountText; TotalAmountText)
            { }
            column(TransportMethodGrec_desc; TransportMethodGrec.Description)
            { }
            column(ContryGrec2_Name; ContryGrec2.Name)
            { }
            column(ForVarCapLbl; ForVarCapLbl)
            { }
            column(VehicleNo_SalesHeader; "Vehicle No.")
            {
            }
            column(AuthorisedSignatoryCapLbl; AuthorisedSignatoryCapLbl)
            { }
            column(ShipToNameGvar; ShipToNameGvar)
            { }
            column(ShiptoAddr1Gvar; ShiptoAddr1Gvar)
            { }
            column(ShipToAddr2Gvar; ShipToAddr2Gvar)
            { }
            column(Address; Address)
            { }
            column(Gst; Gst)
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(External_Document_No_; "External Document No.")
            { }
            column(External_Document_Date; format("External Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Exit_Point; "Exit Point")
            { }
            column(Country; Country)
            { }
            column(Port_Of_Discharge; "Port Of Discharge")
            { }
            column(Description; Description)
            { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(Sell_to_Address; "Sell-to Address")
            { }
            column(countryGrec_name; countryGrec.Name)
            { }
            column(ShipmentMethodCode_SalesHeader; "Shipment Method Code")
            {
            }
            column(No_; "No.")
            { }
            column(CustCountry; CustCountry)
            { }
            column(BankDetailsCapLbl; BankDetailsCapLbl)
            { }
            column(BankAddressCapLbl; BankAddressCapLbl)
            { }
            column(BankACCapLbl; BankACCapLbl)
            { }
            column(BankIFSCCapLbl; BankIFSCCapLbl)
            { }
            column(BankSwiftCodeCapLbl; BankSwiftCodeCapLbl)
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
            column(Ship_to_Name; "Ship-to Name")
            { }
            column(Ship_to_Address; "Ship-to Address")
            { }
            column(Ship_to_Address_2; "Ship-to Address 2")
            { }
            column(Location_Name; Location.Name)
            { }
            column(Location_Address; Location.Address)
            { }
            column(Location_address2; Location."Address 2")
            { }
            column(Location_City; Location.City)
            { }
            column(PrepaymentoGvar; PrepaymentoGvar)
            { }
            column(Location_postcode; Location."Post Code")
            { }
            column(Location_FaxNo; Location."Fax No.")
            { }
            column(Location_State; Location."State Code")
            { }
            column(CountryRegion_Name; CountryRegion.Name)
            { }
            column(CustomerPoNo_SalesHeader; "Customer Po No.")
            {
            }
            column(CustomerPoDate_SalesHeader; "Customer Po Date")
            {
            }
            column(NoText_1; NoText[1])
            { }
            column(CommentsText_1; CommentsText[1])
            { }
            column(CommentsText_2; CommentsText[2])
            { }
            column(CommentsText_3; CommentsText[3])
            { }
            column(CommentsText_4; CommentsText[4])
            { }
            column(CommentsText_5; CommentsText[5])
            { }
            column(CommentsText_6; CommentsText[6])
            { }
            column(CommentsText_7; CommentsText[7])
            { }
            column(CommentsText_8; CommentsText[8])
            { }
            column(CommentsCode_1; CommentsCode[1])
            { }
            column(CommentsCode_2; CommentsCode[2])
            { }
            column(CommentsCode_3; CommentsCode[3])
            { }
            column(CommentsCode_4; CommentsCode[4])
            { }
            column(CommentsCode_5; CommentsCode[5])
            { }
            column(CommentsCode_6; CommentsCode[6])
            { }
            column(CommentsCode_7; CommentsCode[7])
            { }
            column(CommentsCode_8; CommentsCode[8])
            { }
            dataitem("Sales Line"; "Sales Line")
            {

                DataItemLinkReference = "Sales Header";
                //DataItemLink = "Document No." = FIELD("No.");
                DataItemLink = "Document No." = FIELD("No.");
                column(No_SalesLine; "No.")
                {
                }
                column(Description_SalesLine; Description)
                {
                }
                column(PrepaymentAmount_SalesLine; "Prepayment Amount")
                {
                }

                /* column(DocumentType_SalesLine; "Document Type")
                 {
                 }*/
                column(DocumentNo_SalesLine; "Document No.")
                {
                }
                column(LineNo_SalesLine; "Line No.")
                {
                }
                column(LineAmount_SalesLine; "Line Amount")
                {
                }
                column(Quantity_SalesLine; Quantity)
                {
                }
                column(UnitPrice_SalesLine; "Unit Price")
                {
                }

                column(SNoGVar; SNoGVar)
                { }
                trigger OnPreDataItem()
                begin
                    //SetFilter(Type, '<>%1', Type::" ");
                end;

                trigger OnAfterGetRecord()
                begin
                    Clear(CGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSTAmt);
                    //Clear(SGSTPer);
                    //Clear(IGSTPer);
                    //Clear(CGSTPer);
                    if (Type <> Type::" ") then begin
                        SNoGvar2 += 1;
                        SNoGVar := SNoGvar2;
                    end else begin
                        SNoGVar := 0;
                    end;
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
                    ReportCheck.InitTextVariable;
                    ReportCheck.FormatNoText(NoText, AmountVendor1, "Sales Header"."Currency Code");
                    // GetSalesGSTAmount("Sales Invoice Header", "Sales Invoice Line");
                    //"Sales Invoice Header".CalcFields("Amount Including VAT");
                    // ReportCheck.InitTextVariable;
                    //ReportCheck.FormatNoText(NoText, "Sales Invoice Header"."Amount Including VAT", "Sales Invoice Header"."Currency Code");
                end;
            }
            trigger OnAfterGetRecord()
            begin
                /* Location.Reset();
                 Location.SetRange(Code, "Location Code");
                 if Location.FindFirst() then begin
                     Address := Location.Address;
                     Gst := Location."GST Registration No.";
                     //Country := Location."Country/Region Code";
                     if CountryRegion.Get(Location."Country/Region Code") then
                         Country := CountryRegion.Name;
                 end;*/
                Clear(SNoGVar);
                Clear(Location);
                Clear(CountryRegion);
                Clear(ShipToNameGvar);
                Clear(ShiptoAddr1Gvar);
                Clear(ShipToAddr2Gvar);
                Clear(countryGrec);
                Clear(PrepaymentoGvar);
                Clear(UnitPriceText);
                Clear(TotalAmountText);
                if "Currency Code" <> '' then begin
                    UnitPriceText := StrSubstNo(UnitPriceCapLbl, "Currency Code");
                    TotalAmountText := StrSubstNo(TotalAmountInDollarsCapLl, "Currency Code");
                end;
                if "Last Prepayment No." <> '' then
                    PrepaymentoGvar := "Last Prepayment No."
                else
                    PrepaymentoGvar := "No.";
                Clear(TransportMethodGrec);
                if TransportMethodGrec.Get("Transport Method") then;
                if countryGrec.Get("Bill-to Country/Region Code") then;
                Clear(ContryGrec2);
                if "Ship-to Name" <> '' then begin
                    ShipToNameGvar := "Ship-to Name";
                    ShiptoAddr1Gvar := "Ship-to Address";
                    ShipToAddr2Gvar := "Ship-to Address 2";
                    if ContryGrec2.Get("Ship-to Country/Region Code") then;
                end else begin
                    ShipToNameGvar := "Bill-to Name";
                    ShiptoAddr1Gvar := "Bill-to Address";
                    ShipToAddr2Gvar := "Bill-to Address 2";
                    if ContryGrec2.get("Bill-to County") then;
                end;
                if Location.Get("Location Code") then;
                if CountryRegion.Get(Location."Country/Region Code") then;
                PaymentTerms.Reset();
                PaymentTerms.SetRange(Code, "Payment Terms Code");
                if PaymentTerms.FindFirst() then
                    Description := PaymentTerms.Description;

                if Customer.Get("Sell-to Customer No.") then
                    //CustCountry := Customer."Country/Region Code";
                    if CountryRegion.Get(Customer."Country/Region Code") then
                        CustCountry := CountryRegion.Name;

                if BankCode <> '' then
                    if not BankGRec.Get(BankCode) then
                        Clear(BankGRec);
                Clear(I);
                i := 1;
                Clear(CommentsText);
                Clear(CommentsCode);
                SalesCommentLineGrec.Reset();
                SalesCommentLineGrec.SetRange("Document Type", SalesCommentLineGrec."Document Type"::Order);
                SalesCommentLineGrec.SetRange("No.", "No.");
                SalesCommentLineGrec.SetRange("Document Line No.", 0);
                SalesCommentLineGrec.SetCurrentKey("Line No.");
                if SalesCommentLineGrec.FindSet() then
                    repeat
                        CommentsCode[I] := SalesCommentLineGrec."Code New";
                        CommentsText[I] := SalesCommentLineGrec.Comment;
                        i += 1;
                    until SalesCommentLineGrec.Next() = 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(optional)
                {
                    ShowCaption = false;
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
        CompanyInfoGrec.get;
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
                                //SGSTPer := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                //CGSTPer := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                //IGSTPer := TaxTransactionValue.Percent;
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
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        ProformaCapLbl: Label 'PROFORMA';
        InvoiceForAdvCapLbl: Label 'INVOICE FOR ADVANCE';
        ExporterCapLbl: Label 'Exporter:';
        InvoiceNoCapLbl: Label 'Inv.No. :';
        ExporterRefCapLbl: Label 'Exporters Ref:';
        DateCapLbl: Label 'Date';
        IecNoCaPLbl: Label 'IEC -';
        BuyersOrdNoDateCapLbl: Label 'Buyers Order No. & Date:';
        DtCapLbl: Label 'Dt.';
        BuyerIfOtherThanCapLbl: Label 'Buyer (If other than Consignee)';
        ConsigneeCapLbl: Label 'Consignee:';
        PreCarriageByCapLbl: Label 'Pre-carriage by';
        PlaceOfreceiptByCapLbl: Label 'Place of Receipt by Pre-Carrier';
        CountryOfOriginCapLbl: Label 'Country of Origin';
        CountryOfFinalDestination: Label 'Country of final Destination:';
        VesslFlightNoCapLbl: Label 'Vessel/Fliqht No.';
        PortOfLoading: Label 'Port of loading';
        TermsOfDeliveryAndPaymentCapLbl: Label 'Terms of Delivery & Payment';
        ShipmentTermsCapLbl: Label 'SHIPMENT TERMS';
        PortOfDischargeCapLbl: Label 'Port of discharge';
        FinalDestinationCapLbl: Label 'Final destination';
        PaymentTermsCapLbl: Label 'PAYMENT TERMS:';
        MarksnosCapLbl: Label 'Marks & Nos.';
        NoAndKindOfPackingsCapLbl: Label 'No.& kind of Packings';
        DescriptionOfMaterialCapLbl: Label 'DESCRIPTION OF MATERIAL';
        QuantityCapLbl: Label 'QTY.';
        UnitPriceCapLbl: Label 'Unit Price %1';
        TotalAmountInDollarsCapLl: Label 'Total Amount in %1';
        UnitPriceText: Text;
        TotalAmountText: Text;
        CartonBoxesCapLbl: Label 'CARTON BOXES';
        GrossWeightCapLbl: Label 'Gross Weight';
        NetWeightCapLbl: Label 'Net Weight';
        DeclarationCapLbl: Label 'Declaration';
        DeclarationMatterLbl: Label 'We declare that this lnvoice shows the actual price of the goods described and that all particulars are true and correct.';
        /*OurBankDetailsCapLbl: Label 'Our Bank Detalls';
        InterMediatelyBankCapLbl: Label 'Intermediately bank :';
        SwiftCodeCapLbl: Label 'swift code';*/
        FedwireAbaNoCapLbl: Label 'FEDWIRE ABA NO:';
        ChipsAbaNoCapLbl: Label 'CHIPS ABA NO.';
        ChipsUidNoCapLbl: Label 'CHIPS UID NO:';
        FavouringBenificiaryBankCapLbl: Label 'Favorlng Beneficlary Bank :';
        BenificiaryNameCapLbl: Label 'Benificiary Name :';
        BenificiaryAccountNoCapLbl: Label 'Benificiary Acccount No :';
        BankIfscCode: Label 'Bank IFS Code';
        WeHereByCertifyThatCapLbl: Label 'WE HERE BY CERTIFY THAT MERCHANDISE ARE OF INDIAN ORIGIN';
        AuthorisedSignatoryCapLbl: Label 'AUTHORISED SIGNATORY';
        ForVarCapLbl: Label 'For VAR ELECTROCHEM PRIVATE LIMITED';
        CompanyInfoGrec: Record "Company Information";
        Location: Record Location;
        Address: Text;
        Gst: Code[20];
        Country: Code[10];
        PaymentTerms: Record "Payment Terms";
        Description: Text;
        Customer: Record Customer;
        CustCountry: Code[10];
        BankDetailsCapLbl: Label 'Bank Details:';
        BankAddressCapLbl: Label 'Bank Address:';
        BankACCapLbl: Label 'Bank A/C:';
        BankIFSCCapLbl: Label 'Bank IFSC:';
        BankSwiftCodeCapLbl: Label 'Bank Swift Code:';
        BankGRec: Record "Bank Account";
        BankCode: Code[20];
        CountryRegion: Record "Country/Region";
        ReportCheck: Codeunit "Check Codeunit";
        NoText: array[2] of text;
        GSTSetup: Record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
        GstTotal: Decimal;
        GstTotalSum: Decimal;
        AmountVendor: Decimal;
        AmountVendor1: Decimal;
        ShipToNameGvar: Text;
        ShiptoAddr1Gvar: Text;
        ShipToAddr2Gvar: Text;
        countryGrec: Record "Country/Region";
        TransportMethodGrec: Record "Transport Method";
        PrepaymentoGvar: Text;
        ContryGrec2: Record "Country/Region";
        SalesCommentLineGrec: Record "Sales Comment Line";
        CommentsText: array[10] of Text;
        CommentsCode: array[10] of Text;
        I: Integer;
        SNoGVar: Integer;
        SNoGvar2: Integer;
        cu22: Codeunit 22;

}
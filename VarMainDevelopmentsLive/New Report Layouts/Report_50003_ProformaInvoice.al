// report 50003 "Proforma Invoice"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     Caption = 'Proforma Invoice';
//     DefaultLayout = RDLC;
//     RDLCLayout = 'New Report Layouts\ProformaInvoice1.rdl';


//     dataset
//     {
//         dataitem("Sales Invoice Header"; "Sales Invoice Header")
//         {

//             // DataItemTableView = WHERE("Document Type" = FILTER(Invoice));
//             RequestFilterFields = "No.";
//             column(No_SalesHeader; "No.")
//             {
//             }
//             column(OrderDate_SalesHeader; format("Order Date", 0, '<Day,2>-<Month,2>-<Year4>'))
//             {
//             }
//             column(PostingDate_SalesHeader; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
//             {
//             }
//             column(ProformaCapLbl; ProformaCapLbl)
//             { }
//             column(InvoiceForAdvCapLbl; InvoiceForAdvCapLbl)
//             { }
//             column(ExporterCapLbl; ExporterCapLbl)
//             { }
//             column(InvoiceNoCapLbl; InvoiceNoCapLbl)
//             { }
//             column(ExporterRefCapLbl; ExporterRefCapLbl)
//             { }
//             column(DateCapLbl; DateCapLbl)
//             { }
//             column(IecNoCaPLbl; IecNoCaPLbl)
//             { }
//             column(BuyersOrdNoDateCapLbl; BuyersOrdNoDateCapLbl)
//             { }
//             column(DtCapLbl; DtCapLbl)
//             { }
//             column(BuyerIfOtherThanCapLbl; BuyerIfOtherThanCapLbl)
//             { }
//             column(ConsigneeCapLbl; ConsigneeCapLbl)
//             { }
//             column(PreCarriageByCapLbl; PreCarriageByCapLbl)
//             { }
//             column(PlaceOfreceiptByCapLbl; PlaceOfreceiptByCapLbl)
//             { }
//             column(CountryOfOriginCapLbl; CountryOfOriginCapLbl)
//             { }
//             column(CountryOfFinalDestination; CountryOfFinalDestination)
//             { }
//             column(VesslFlightNoCapLbl; VesslFlightNoCapLbl)
//             { }
//             column(PortOfLoading; PortOfLoading)
//             { }
//             column(TermsOfDeliveryAndPaymentCapLbl; TermsOfDeliveryAndPaymentCapLbl)
//             { }
//             column(ShipmentTermsCapLbl; ShipmentTermsCapLbl)
//             { }
//             column(PortOfDischargeCapLbl; PortOfDischargeCapLbl)
//             { }
//             column(FinalDestinationCapLbl; FinalDestinationCapLbl)
//             { }
//             column(PaymentTermsCapLbl; PaymentTermsCapLbl)
//             { }
//             column(MarksnosCapLbl; MarksnosCapLbl)
//             { }
//             column(NoAndKindOfPackingsCapLbl; NoAndKindOfPackingsCapLbl)
//             { }
//             column(DescriptionOfMaterialCapLbl; DescriptionOfMaterialCapLbl)
//             { }
//             column(QuantityCapLbl; QuantityCapLbl)
//             { }
//             column(UnitPriceCapLbl; UnitPriceCapLbl)
//             { }
//             column(TotalAmountInDollarsCapLl; TotalAmountInDollarsCapLl)
//             { }
//             column(CartonBoxesCapLbl; CartonBoxesCapLbl)
//             { }
//             column(GrossWeightCapLbl; GrossWeightCapLbl)
//             { }
//             column(NetWeightCapLbl; NetWeightCapLbl)
//             { }
//             column(DeclarationCapLbl; DeclarationCapLbl)
//             { }
//             column(DeclarationMatterLbl; DeclarationMatterLbl)
//             { }
//             /*column(OurBankDetailsCapLbl; OurBankDetailsCapLbl)
//             { }
//             column(InterMediatelyBankCapLbl; InterMediatelyBankCapLbl)
//             { }
//             column(SwiftCodeCapLbl; SwiftCodeCapLbl)
//             { }*/
//             column(FedwireAbaNoCapLbl; FedwireAbaNoCapLbl)
//             { }
//             column(ChipsAbaNoCapLbl; ChipsAbaNoCapLbl)
//             { }
//             column(ChipsUidNoCapLbl; ChipsUidNoCapLbl)
//             { }
//             column(FavouringBenificiaryBankCapLbl; FavouringBenificiaryBankCapLbl)
//             { }
//             column(BenificiaryNameCapLbl; BenificiaryNameCapLbl)
//             { }
//             column(BenificiaryAccountNoCapLbl; BenificiaryAccountNoCapLbl)
//             { }
//             column(BankIfscCode; BankIfscCode)
//             { }
//             column(WeHereByCertifyThatCapLbl; WeHereByCertifyThatCapLbl)
//             { }
//             column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
//             { }
//             column(CompanyInfoGrec_Picture; CompanyInfoGrec.Picture)
//             { }
//             column(ForVarCapLbl; ForVarCapLbl)
//             { }
//             column(AuthorisedSignatoryCapLbl; AuthorisedSignatoryCapLbl)
//             { }
//             column(Address; Address)
//             { }
//             column(Gst; Gst)
//             { }
//             column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
//             { }
//             column(External_Document_No_; "External Document No.")
//             { }
//             column(External_Document_Date; format("External Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
//             { }
//             column(Exit_Point; "Exit Point")
//             { }
//             column(Country; Country)
//             { }
//             column(Port_Of_Discharge; "Port Of Discharge")
//             { }
//             column(Description; Description)
//             { }
//             column(Sell_to_Customer_Name; "Sell-to Customer Name")
//             { }
//             column(Sell_to_Address; "Sell-to Address")
//             { }
//             column(No_; "No.")
//             { }
//             column(CustCountry; CustCountry)
//             { }
//             column(BankDetailsCapLbl; BankDetailsCapLbl)
//             { }
//             column(BankAddressCapLbl; BankAddressCapLbl)
//             { }
//             column(BankACCapLbl; BankACCapLbl)
//             { }
//             column(BankIFSCCapLbl; BankIFSCCapLbl)
//             { }
//             column(BankSwiftCodeCapLbl; BankSwiftCodeCapLbl)
//             { }
//             column(BankGRec_Name; BankGRec.Name)
//             { }
//             column(BankGRec_Address; BankGRec.Address)
//             { }
//             column(BankGRec_BankAccNo; BankGRec."Bank Account No.")
//             { }
//             column(BankGRec_IFSC; BankGRec."IFSC Code")
//             { }
//             column(BankGRec_Swift; BankGRec."SWIFT Code")
//             { }
//             column(Ship_to_Name; "Ship-to Name")
//             { }
//             column(Ship_to_Address; "Ship-to Address")
//             { }
//             column(Ship_to_Address_2; "Ship-to Address 2")
//             { }
//             dataitem("Sales Invoice Line"; "Sales Invoice Line")
//             {

//                 DataItemLinkReference = "Sales Invoice Header";
//                 DataItemLink = "Document No." = FIELD("No.");
//                 column(No_SalesLine; "No.")
//                 {
//                 }
//                 column(Description_SalesLine; Description)
//                 {
//                 }

//                 /* column(DocumentType_SalesLine; "Document Type")
//                  {
//                  }*/
//                 column(DocumentNo_SalesLine; "Document No.")
//                 {
//                 }
//                 column(LineNo_SalesLine; "Line No.")
//                 {
//                 }
//                 column(LineAmount_SalesLine; "Line Amount")
//                 {
//                 }
//                 column(Quantity_SalesLine; Quantity)
//                 {
//                 }
//                 column(UnitPrice_SalesLine; "Unit Price")
//                 {
//                 }
//                 column(NoText_1; NoText[1])
//                 { }
//                 trigger OnPreDataItem()
//                 begin
//                     SetFilter(Type, '<>%1', Type::" ");
//                 end;

//                 trigger OnAfterGetRecord()
//                 begin
//                     GetSalesGSTAmount("Sales Invoice Header", "Sales Invoice Line");
//                     "Sales Invoice Header".CalcFields("Amount Including VAT");
//                     ReportCheck.InitTextVariable;
//                     ReportCheck.FormatNoText(NoText, "Sales Invoice Header"."Amount Including VAT", "Sales Invoice Header"."Currency Code");
//                 end;
//             }
//             trigger OnAfterGetRecord()
//             begin
//                 Location.Reset();
//                 Location.SetRange(Code, "Sales Invoice Header"."Location Code");
//                 if Location.FindFirst() then begin
//                     Address := Location.Address;
//                     Gst := Location."GST Registration No.";
//                     //Country := Location."Country/Region Code";
//                     if CountryRegion.Get(Location."Country/Region Code") then
//                         Country := CountryRegion.Name;
//                 end;
//                 PaymentTerms.Reset();
//                 PaymentTerms.SetRange(Code, "Sales Invoice Header"."Payment Terms Code");
//                 if PaymentTerms.FindFirst() then
//                     Description := PaymentTerms.Description;

//                 if Customer.Get("Sell-to Customer No.") then
//                     //CustCountry := Customer."Country/Region Code";
//                     if CountryRegion.Get(Customer."Country/Region Code") then
//                         CustCountry := CountryRegion.Name;

//                 if BankCode <> '' then
//                     if not BankGRec.Get(BankCode) then
//                         Clear(BankGRec);
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(optional)
//                 {
//                     ShowCaption = false;
//                     field(BankCode; BankCode)
//                     {
//                         Caption = 'Bank Code';
//                         TableRelation = "Bank Account"."No.";
//                     }

//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }
//     }
//     trigger OnPreReport()
//     begin
//         CompanyInfoGrec.get;
//         CompanyInfoGrec.CalcFields(Picture);
//     end;

//     local procedure GetComponentName(SalesLine: Record "Sales Invoice Line";
//        GSTSetup: Record "GST Setup"): Code[30]
//     var
//         ComponentName: Code[30];
//     begin
//         if GSTSetup."GST Tax Type" = GSTLbl then
//             if SalesLine."GST Jurisdiction Type" = SalesLine."GST Jurisdiction Type"::Interstate then
//                 ComponentName := IGSTLbl
//             else
//                 ComponentName := CGSTLbl
//         else
//             if GSTSetup."Cess Tax Type" = GSTCESSLbl then
//                 ComponentName := CESSLbl;
//         exit(ComponentName)
//     end;

//     procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
//     var
//         TaxComponent: Record "Tax Component";
//         GSTSetup: Record "GST Setup";
//         GSTRoundingPrecision: Decimal;
//     begin
//         if not GSTSetup.Get() then
//             exit;
//         GSTSetup.TestField("GST Tax Type");

//         TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
//         TaxComponent.SetRange(Name, ComponentName);
//         TaxComponent.FindFirst();
//         if TaxComponent."Rounding Precision" <> 0 then
//             GSTRoundingPrecision := TaxComponent."Rounding Precision"
//         else
//             GSTRoundingPrecision := 1;
//         exit(GSTRoundingPrecision);
//     end;

//     local procedure GetSalesGSTAmount(SalesInvoiceHeader: Record "Sales Invoice Header";
//             SalesInvoiceLine: Record "Sales Invoice Line")
//     var
//         DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
//     begin
//         Clear(IGSSTAmt);
//         Clear(CGSTAmt);
//         Clear(SGSTAmt);
//         Clear(CessAmt);
//         DetailedGSTLedgerEntry.Reset();
//         DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
//         DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
//         DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
//         if DetailedGSTLedgerEntry.FindSet() then begin
//             // repeat
//             if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then
//                 CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
//             else
//                 if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then
//                     CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

//             if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then
//                 SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
//             else
//                 if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then
//                     SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

//             if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then
//                 IGSSTAmt := Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
//             else
//                 if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then
//                     IGSSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
//             if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (SalesInvoiceHeader."Currency Code" <> '') then
//                 CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
//             else
//                 if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then
//                     CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
//             // until DetailedGSTLedgerEntry.Next() = 0;

//         end;
//     end;


//     var
//         CGSTAmt: Decimal;
//         SGSTAmt: Decimal;
//         IGSSTAmt: Decimal;
//         IGSTAmt: Decimal;
//         CessAmt: Decimal;
//         IGSTLbl: Label 'IGST';
//         SGSTLbl: Label 'SGST';
//         CGSTLbl: Label 'CGST';
//         CESSLbl: Label 'CESS';
//         GSTLbl: Label 'GST';
//         GSTCESSLbl: Label 'GST CESS';
//         ProformaCapLbl: Label 'PROFORMA';
//         InvoiceForAdvCapLbl: Label 'INVOICE FOR ADVANCE';
//         ExporterCapLbl: Label 'Exporter:';
//         InvoiceNoCapLbl: Label 'Inv.No. :';
//         ExporterRefCapLbl: Label 'Exporters Ref:';
//         DateCapLbl: Label 'Date';
//         IecNoCaPLbl: Label 'IEC -';
//         BuyersOrdNoDateCapLbl: Label 'Buyers Order No. & Date:';
//         DtCapLbl: Label 'Dt.';
//         BuyerIfOtherThanCapLbl: Label 'Buyer (If other than Consignee)';
//         ConsigneeCapLbl: Label 'Consignee:';
//         PreCarriageByCapLbl: Label 'Pre-carriage by';
//         PlaceOfreceiptByCapLbl: Label 'Place of Receipt by Pre-Carrier';
//         CountryOfOriginCapLbl: Label 'Country of Origin';
//         CountryOfFinalDestination: Label 'Country of final Destination:';
//         VesslFlightNoCapLbl: Label 'Vessel/Fliqht No.';
//         PortOfLoading: Label 'Port of loading';
//         TermsOfDeliveryAndPaymentCapLbl: Label 'Terms of Delivery & Payment';
//         ShipmentTermsCapLbl: Label 'SHIPMENT TERMS';
//         PortOfDischargeCapLbl: Label 'Port of discharge';
//         FinalDestinationCapLbl: Label 'Final destination';
//         PaymentTermsCapLbl: Label 'PAYMENT TERMS:';
//         MarksnosCapLbl: Label 'Marks & Nos.';
//         NoAndKindOfPackingsCapLbl: Label 'No.& kind of Packings';
//         DescriptionOfMaterialCapLbl: Label 'DESCRIPTION OF MATERIAL';
//         QuantityCapLbl: Label 'QTY.';
//         UnitPriceCapLbl: Label 'Unit Price ($)';
//         TotalAmountInDollarsCapLl: Label 'Total Amount in DOLLAR ($)';
//         CartonBoxesCapLbl: Label 'CARTON BOXES';
//         GrossWeightCapLbl: Label 'Gross Weight';
//         NetWeightCapLbl: Label 'Net Weight';
//         DeclarationCapLbl: Label 'Declaration';
//         DeclarationMatterLbl: Label 'We declare that this lnvoice shows the actual price of the goods described and that all particulars are true and correct.';
//         /*OurBankDetailsCapLbl: Label 'Our Bank Detalls';
//         InterMediatelyBankCapLbl: Label 'Intermediately bank :';
//         SwiftCodeCapLbl: Label 'swift code';*/
//         FedwireAbaNoCapLbl: Label 'FEDWIRE ABA NO:';
//         ChipsAbaNoCapLbl: Label 'CHIPS ABA NO.';
//         ChipsUidNoCapLbl: Label 'CHIPS UID NO:';
//         FavouringBenificiaryBankCapLbl: Label 'Favorlng Beneficlary Bank :';
//         BenificiaryNameCapLbl: Label 'Benificiary Name :';
//         BenificiaryAccountNoCapLbl: Label 'Benificiary Acccount No :';
//         BankIfscCode: Label 'Bank IFS Code';
//         WeHereByCertifyThatCapLbl: Label 'WE HERE BY CERTIFY THAT MERCHANDISE ARE OF INDIAN ORIGIN';
//         AuthorisedSignatoryCapLbl: Label 'AUTHORISED SIGNATORY';
//         ForVarCapLbl: Label 'For VAR ELECTROCHEM PRIVATE LIMITED';
//         CompanyInfoGrec: Record "Company Information";
//         Location: Record Location;
//         Address: Text;
//         Gst: Code[20];
//         Country: Code[10];
//         PaymentTerms: Record "Payment Terms";
//         Description: Text;
//         Customer: Record Customer;
//         CustCountry: Code[10];
//         BankDetailsCapLbl: Label 'Bank Details:';
//         BankAddressCapLbl: Label 'Bank Address:';
//         BankACCapLbl: Label 'Bank A/C:';
//         BankIFSCCapLbl: Label 'Bank IFSC:';
//         BankSwiftCodeCapLbl: Label 'Bank Swift Code:';
//         BankGRec: Record "Bank Account";
//         BankCode: Code[20];
//         CountryRegion: Record "Country/Region";
//         ReportCheck: Codeunit "Check Codeunit";
//         NoText: array[2] of text;


// }
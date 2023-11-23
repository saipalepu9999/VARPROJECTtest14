report 50008 "Export Tax Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Export Tax Invoice';
    DefaultLayout = RDLC;
    RDLCLayout = 'New Report Layouts\ExportTaxInvoice1.rdl';


    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {

            //DataItemTableView = WHERE("Document Type" = FILTER(Invoice));
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
            column(ExportTaxInvCapLbl; ExportTaxInvCapLbl)
            { }
            column(SupplyMeantCapLbl; SupplyMeantCapLbl)
            { }
            Column(InvNoCapLbl; InvNoCapLbl)
            { }
            column(InvoiceDateCapLbl; InvoiceDateCapLbl)
            { }
            column(NoText_1; NoText[1])
            { }

            column(ShiptoContact_SalesInvoiceHeader; "Ship-to Contact")
            {
            }
            column(Bill_to_County; "Bill-to Country/Region Code")
            { }
            column(Ship_to_County; "Ship-to Country/Region Code")
            { }
            column(TeleFaxNoCapLbl; TeleFaxNoCapLbl)
            { }
            column(ReverseChargeCapLbl; ReverseChargeCapLbl)
            { }
            column(TransportMethodGrec_desc; TransportMethodGrec.Description)
            { }
            column(CustomerPoNo_SIH; "Customer Po No.")
            {
            }
            column(CustomerPoDate_SIH; format("Customer Po Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(PurchOrdNoCapLbl; PurchOrdNoCapLbl)
            { }
            column(PurchOrdDateCapLbl; PurchOrdDateCapLbl)
            { }
            column(GstinNoCapLbl; GstinNoCapLbl)
            { }
            column(TransportModeCapLbl; TransportModeCapLbl)
            { }
            column(ShipmentTermsCapLbl; ShipmentTermsCapLbl)
            { }
            column(PortofLoadingCapLbl; PortofLoadingCapLbl)
            { }
            column(PortofDischargeCapLbl; PortofDischargeCapLbl)
            { }
            column(FinalDestinationCapLbl; FinalDestinationCapLbl)
            { }
            column(CountryofOriginCapLbl; CountryofOriginCapLbl)
            { }
            column(CountryofFinalDestinationCapLbl; CountryofFinalDestinationCapLbl)
            { }
            column(ConsigneeNameandAddressCapLbl; ConsigneeNameandAddressCapLbl)
            { }
            column(BuyerNameandAddressCapLbl; BuyerNameandAddressCapLbl)
            { }
            column(TelCapLbl; TelCapLbl)
            { }
            column(TelNoCapLbl; TelNoCapLbl)
            { }
            column(SNoCapLbl; SNoCapLbl)
            { }
            column(ProdDescCapLbl; ProdDescCapLbl)
            { }
            column(HSNCodeCapLbl; HSNCodeCapLbl)
            { }
            column(QtyCapLbl; QtyCapLbl)
            { }
            column(UnitPriceCapLbl; UnitPriceCapLbl)
            { }
            column(TotalUSDCapLbl; TotalUSDCapLbl)
            { }
            column(UnitRateCapLbl; UnitRateCapLbl)
            { }
            column(TaxValueCapLbl; TaxValueCapLbl)
            { }
            column(TotalCratesCapLbl; TotalCratesCapLbl)
            { }
            column(GrossWtCapLbl; GrossWtCapLbl)
            { }
            column(NetWtCapLbl; NetWtCapLbl)
            { }
            column(DimensionCapLbl; DimensionCapLbl)
            { }
            column(TotalGRWTCapLbl; TotalGRWTCapLbl)
            { }
            column(TotalNTWTCapLbl; TotalNTWTCapLbl)
            { }
            column(TotalCapLbl; TotalCapLbl)
            { }
            column(TotalInvCapLbl; TotalInvCapLbl)
            { }
            column(TotalAmtAfterTaxCapLbl; TotalAmtAfterTaxCapLbl)
            { }
            column(TotalAmtBeforeTaxCapLbl; TotalAmtBeforeTaxCapLbl)
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
            column(CertfiedthatCapLbl; CertfiedthatCapLbl)
            { }
            column(FinalDestintion_SalesInvoiceHeader; "Final Destintion")
            {
            }
            column(AuthSigCapLbl; AuthSigCapLbl)
            { }
            column(WeherebyDeclareCapLbl; WeherebyDeclareCapLbl)
            { }
            column(CINNoCapLbl; CINNoCapLbl)
            { }
            column(IGSTCapLbl; IGSTCapLbl)
            { }
            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
            { }
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
            { }
            column(CompanyInfoGrec_Picture; CompanyInfoGrec.Picture)
            { }
            column(CompanyInfoGrec_GSTRegNo; CompanyInfoGrec."GST Registration No.")
            { }
            column(CustomerGrec_City; CustomerGrec.City)
            { }
            column(CustomerGrec_PostCode; CustomerGrec."Post Code")
            { }
            column(CustomerGrec_Name; CustomerGrec.Name)
            { }
            column(CustomerGrec_Address; CustomerGrec.Address)
            { }
            column(CustomerGrec_Address2; CustomerGrec."Address 2")
            { }
            column(CustomerGrec_MobileNo; CustomerGrec."Mobile Phone No.")
            { }
            column(ExternalDocumentNo_SIH; "External Document No.")
            {
            }
            column(ExitPoint_SIH; "Exit Point")
            {
            }
            column(TransportMethod_SIH; "Transport Method")
            {
            }
            column(ShipmentMethodCode_SIH; "Shipment Method Code")
            {
            }
            column(CustomerGrec_Country; CustomerGrec."Country/Region Code")
            {
            }
            column(Loc_Country; LocationGRec."Country/Region Code")
            {
            }
            column(CustomerGSTRegNo_SIH; "Customer GST Reg. No.")
            {
            }
            column(ExternalDocumentDate_SIH; format("External Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(PortOfDischarge_SIH; "Port Of Discharge")
            {
            }
            column(CINNo; CINNoGvar)
            {
            }
            column(ShiptoName_SIH; "Ship-to Name")
            {
            }
            column(ShiptoAddress_SIH; "Ship-to Address")
            {
            }
            column(ShiptoAddress2_SIH; "Ship-to Address 2")
            {
            }
            column(Ship_to_City; "Ship-to City")
            { }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            { }
            column(Bill_to_City; "Bill-to City")
            { }
            column(Bill_to_Post_Code; "Bill-to Post Code")
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
            column(External_Document_Date; format("External Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(ReverseCharge; ReverseCharge)
            {
            }
            column(EnvoiceEntry_Irno; EnvoiceEntry."IRN No.")
            {

            }
            column(EnvoiceEntry_QrCode; EnvoiceEntry."QR Code")
            {

            }
            column(LocationGRec_Name; LocationGRec.Name)
            { }
            column(LocationGRec_Address; LocationGRec.Address)
            { }
            column(LocationGRec_Address2; LocationGRec."Address 2")
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
            column(CountryGrec_Name; CountryGrec.Name)
            { }
            column(CountryGrec2_Name; CountryGrec2.Name)
            { }
            column(Currency_Factor; "Currency Factor")
            { }
            column(UnitPriceTextCap; UnitPriceTextCap)
            { }
            column(TotalUsdTextCap; TotalUsdTextCap)
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


            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {

                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = FIELD("No.");
                column(No_SalesLine; "No.")
                {
                }
                column(Description_SalesLine; Description)
                {
                }

                /*column(DocumentType_SalesLine; "Document Type")
                {
                }*/
                column(HSNSACCode_SalesLine; "HSN/SAC Code")
                {
                }
                column(UnitofMeasureCode_SalesLine; "Unit of Measure Code")
                {
                }
                column(DocumentNo_SalesLine; "Document No.")
                {
                }
                column(LineNo_SalesLine; "Line No.")
                {
                }
                column(LineAmount_SalesLine; "Line Amount")
                {
                }
                column(SNoGVar; SNoGVar)
                { }
                column(Quantity_SalesLine; Quantity)
                {
                }
                column(UnitPrice_SalesLine; "Unit Price")
                {
                }
                column(ForVARCapLbl; ForVARCapLbl)
                { }
                column(CGSTAmt; CGSTAmt)
                { }
                column(IGSSTAmt; IGSSTAmt)
                { }
                column(SGSTAmt; SGSTAmt)
                { }

                column(IRNNoCaption; IRNNoCaptionLVar)
                {
                }
                column(SupplyMeantText; SupplyMeantText)
                { }
                column(CGSTRate; CGSTRate)
                { }
                column(SGSTRate; SGSTRate)
                { }
                column(IGSTRate; IGSTRate)
                { }
                trigger OnPreDataItem()
                begin
                    //SetFilter(Type, '<>%1', Type::" ");
                end;

                //column(cgs)
                trigger OnAfterGetRecord()
                var
                    SalesInvoiceLine: Record "Sales Invoice Line";
                    DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
                    AmountTotal: Decimal;

                begin
                    Clear(CGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSTAmt);

                    /*SalesInvoiceLine.Reset();
                    SalesInvoiceLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                    if SalesInvoiceLine.FindSet() then
                        repeat
                            if "Sales Invoice Header"."Currency Factor" <> 0 then
                                AmountTotal += (SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price") / "Sales Invoice Header"."Currency Factor"
                            else
                                AmountTotal += (SalesInvoiceLine.Quantity * SalesInvoiceLine."Unit Price");


                            DetailedGSTLedgerEntry.Reset();
                            DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
                            DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
                            DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
                            if DetailedGSTLedgerEntry.FindSet() then begin
                                repeat
                                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And ("Sales Invoice Header"."Currency Code" <> '') then begin
                                        AmountTotal += AmountTotal + Round((Abs(DetailedGSTLedgerEntry."GST Amount") * "Sales Invoice Header"."Currency Factor"),
                                                                        GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                                    end;
                                until DetailedGSTLedgerEntry.Next() = 0;
                            end;
                        until SalesInvoiceLine.Next() = 0;*/
                    if ("Sales Invoice Line".Type <> "Sales Invoice Line".Type::" ") then begin
                        //SNoGVar += 1;
                        SNoGvar2 += 1;
                        SNoGVar := SNoGvar2;
                    end else begin
                        SNoGVar := 0;
                    end;
                    GetSalesGSTAmount("Sales Invoice Header", "Sales Invoice Line");
                    //CHB2B28MAR2023<<
                    if IGSTRate > 0 then
                        SupplyMeantText := StrSubstNo(SupplyMeantCapLbl, 'WITH')
                    else
                        SupplyMeantText := StrSubstNo(SupplyMeantCapLbl, 'WITHOUT');
                    //CHB2B28MAR2023<<
                    "Sales Invoice Header".CalcFields("Amount Including VAT");
                    //ReportCheck.InitTextVariable;

                    //ReportCheck.FormatNoText(NoText, AmountTotal, "Sales Invoice Header"."Currency Code");
                    Clear(GstTotal);
                    GstTotal := CGSTAmt + SGSTAmt + IGSSTAmt;
                    GstTotalSum := GstTotalSum + GstTotal;

                    Clear(AmountVendor1);
                    if "Sales Invoice Header"."Currency Factor" <> 0 then
                        AmountVendor += "Line Amount" / "Sales Invoice Header"."Currency Factor"
                    else
                        AmountVendor += "Line Amount";
                    AmountVendor1 := AmountVendor + GstTotalSum;
                    //CHB2B27FEB2023<<
                    //clear(NumberText);
                    ReportCheck.InitTextVariable;
                    ReportCheck.FormatNoText(NoText, AmountVendor1, ' ');
                    //ReportCheck.FormatNoText(NoText, AmountVendor1, "Sales Invoice Header"."Currency Code");

                end;
            }
            trigger OnAfterGetRecord()
            var
                SalesInvLine: Record "Sales Invoice Line";
                GstGroupCode: Record "GST Group";

            begin
                Clear(CustomerGrec);
                Clear(CountryGrec);
                Clear(TransportMethodGrec);
                Clear(SNoGVar);
                if TransportMethodGrec.Get("Transport Method") then;
                if CustomerGrec.get("Sales Invoice Header"."Sell-to Customer No.") then;

                if not LocationGRec.Get("Location Code") then
                    Clear(LocationGRec);
                if CountryGrec.Get(LocationGRec."Country/Region Code") then;
                if BankCode <> '' then
                    if not BankGRec.Get(BankCode) then
                        Clear(BankGRec);
                // CHB2B22Dec2022<<

                IRNNoCaptionLVar := '';
                IF EnvoiceEntry.GET(EnvoiceEntry."Document Type"::"Sales Invoice", "Sales Invoice Header"."No.") THEN BEGIN
                    EnvoiceEntry.CALCFIELDS("QR Code");
                    IF EnvoiceEntry."IRN No." <> '' THEN
                        IRNNoCaptionLVar := 'IRN No.';
                END;
                // CHB2B22Dec2022>>
                UnitPriceTextCap := StrSubstNo(UnitPriceCapLbl, "Currency Code");
                TotalUsdTextCap := StrSubstNo(TotalUSDCapLbl, "Currency Code");
                Clear(CountryGrec2);
                if "Ship-to Code" <> '' then begin
                    if CountryGrec2.Get("Ship-to Country/Region Code") then;
                end else begin
                    if CountryGrec2.Get("Bill-to Country/Region Code") then;
                end;
                SalesInvLine.Reset();
                SalesInvLine.SetCurrentKey("GST Group Code");
                SalesInvLine.SetFilter("GST Group Code", '<>%1', '');
                if SalesInvLine.FindSet() then
                    repeat
                        if not GstGroupCode.Get(SalesInvLine."GST Group Code") then
                            Clear(GstGroupCode);
                        if GstGroupCode."Reverse Charge" then
                            ReverseCharge := 'Y';
                    until (SalesInvLine.Next() = 0) or (ReverseCharge = 'Y');
                if ReverseCharge <> 'Y' then
                    ReverseCharge := 'N';
                Clear(I);
                i := 1;
                Clear(CommentsText);
                Clear(CommentsCode);
                SalesCommentLineGrec.Reset();
                SalesCommentLineGrec.SetRange("Document Type", SalesCommentLineGrec."Document Type"::"Posted Invoice");
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
                group(Optional)
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
    }

    trigger OnPreReport()
    begin
        CompanyInfoGrec.Get();
        CompanyInfoGrec.CalcFields(Picture);
        CINNoGvar := 'U31402TG1997PTC028377';
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

    local procedure GetSalesGSTAmount(SalesInvoiceHeader: Record "Sales Invoice Header"; SalesInvoiceLine: Record "Sales Invoice Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        //Clear(IGSSTAmt);
        //Clear(CGSTAmt);
        //Clear(SGSTAmt);
        //Clear(CessAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
        if DetailedGSTLedgerEntry.FindSet() then begin
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then begin
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    CGSTRate := DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then begin
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        CGSTRate := DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then begin
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    SGSTRate := DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then begin
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        SGSTRate := DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then begin
                    IGSSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    IGSTRate := DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then begin
                        IGSSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        IGSTRate := DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (SalesInvoiceHeader."Currency Code" <> '') then begin
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then begin
                        CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        // 
                    end;
            until DetailedGSTLedgerEntry.Next() = 0;
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
        CESSRate: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';

        ExportTaxInvCapLbl: Label 'EXPORT INVOICE';
        SupplyMeantCapLbl: Label '(SUPPLY MEANT FOR EXPORT LETTER OF UNDERTAKING %1 PAYMENT OF IGST)';
        SupplyMeantText: Text;

        InvNoCapLbl: Label 'Invoice No:';
        InvoiceDateCapLbl: Label 'Invoice Date:';
        ReverseChargeCapLbl: Label 'Reverse Charge (Y/N):';
        PurchOrdNoCapLbl: Label 'Purchase Order No.:';
        PurchOrdDateCapLbl: Label 'Purchase Order Date:';
        GstinNoCapLbl: Label 'GSTIN No.:';
        TransportModeCapLbl: Label 'Transport Mode:';
        ShipmentTermsCapLbl: Label 'SHIPMENT TERMS:';
        PortofLoadingCapLbl: Label 'Port of Loading:';
        PortofDischargeCapLbl: Label 'Port of Discharge:';
        FinalDestinationCapLbl: Label 'Final Destination:';
        CountryofOriginCapLbl: Label 'Country of Origin:';
        CountryofFinalDestinationCapLbl: Label 'Country of Final Destination:';
        ConsigneeNameandAddressCapLbl: Label 'Consignee Name & Address';
        BuyerNameandAddressCapLbl: Label 'Buyer Name & Address if Other than Consignee';
        TelCapLbl: Label 'Tel.:';
        TelNoCapLbl: Label 'Tele Number:';
        SNoCapLbl: Label 'S.No.';
        ProdDescCapLbl: Label 'Product Description';
        HSNCodeCapLbl: Label 'HSN Code';
        QtyCapLbl: Label 'Qty(NOS)';
        UnitPriceCapLbl: Label 'Unit Price in %1';
        TotalUSDCapLbl: Label 'Total %1';
        UnitPriceTextCap: Text;
        TotalUsdTextCap: Text;
        UnitRateCapLbl: Label 'Unit Rate(INR)';
        TaxValueCapLbl: Label 'Taxable Value (INR)';
        TotalCratesCapLbl: Label 'TOTAL CRATES:';
        GrossWtCapLbl: Label 'GROSS WEIGHT:';
        NetWtCapLbl: Label 'NET WEIGHT:';
        DimensionCapLbl: Label 'DIMENSION IN MM:';
        TotalGRWTCapLbl: Label 'TOTAL GR.WT:';
        TotalNTWTCapLbl: Label 'TOTAL NT.WT:';
        TotalCapLbl: Label 'TOTAL';
        TotalInvCapLbl: Label 'Total lnvoice amount in INR';
        TotalAmtBeforeTaxCapLbl: Label 'Total Amount before Tax';
        TotalAmtAfterTaxCapLbl: Label 'Total Amount after Tax';
        BankDetailsCapLbl: Label 'Bank Details:';
        BankAddressCapLbl: Label 'Bank Address:';
        BankACCapLbl: Label 'Bank A/C:';
        BankIFSCCapLbl: Label 'Bank IFSC:';
        BankSwiftCodeCapLbl: Label 'Bank Swift Code';
        CertfiedthatCapLbl: Label 'Certified that particulars given above are true & correct';
        AuthSigCapLbl: Label 'Authorised Signatory';
        WeherebyDeclareCapLbl: Label '"We hereby declare that the goods mentioned in this invoice are of Indian Origin and manufacture."';
        CINNoCapLbl: Label 'CIN No.';
        IGSTCapLbl: Label 'IGST';
        CompanyInfoGrec: Record "Company Information";
        ForVARCapLbl: Label 'For VAR ELECTROCHEM PRIVATE LIMITED';
        CustomerGrec: Record Customer;
        LocationGRec: Record Location;
        ShippingCust: Record Customer;
        BankCode: Code[20];
        BankGRec: Record "Bank Account";
        AmountInWords: Decimal;
        ReverseCharge: Text[10];
        ReportCheck: Codeunit "Check Codeunit";
        EnvoiceEntry: Record "E-Invoice Entry";
        NoText: array[2] of text;
        IRNNoCaptionLVar: Text[50];
        CINNoGvar: Text;
        CountryGrec: Record "Country/Region";
        TeleFaxNoCapLbl: Label 'Tel/ Fax No.';
        GstTotal: Decimal;
        GstTotalSum: Decimal;
        AmountVendor1: Decimal;
        AmountVendor: Decimal;
        TransportMethodGrec: Record "Transport Method";
        SalesCommentLineGrec: Record "Sales Comment Line";
        CommentsCode: array[10] of Text;
        CommentsText: array[10] of Text;
        I: Integer;
        CountryGrec2: Record "Country/Region";
        SNoGVar: Integer;
        SNoGvar2: Integer;


}
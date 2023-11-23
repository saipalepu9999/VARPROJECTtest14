report 50029 "Customs VSVG Report Quartly"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Customs VSEZ Report Quartly';
    RDLCLayout = 'Report\Layouts\CustomsVSVGReport.rdl';

    dataset

    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            // RequestFilterFields = "Posting Date";
            //DataItemTableView = WHERE("Gst Customer Type" = const(Export));
            column(FormatCap; FormatCap)
            { }
            column(AnnextureCap; AnnextureCap)
            { }
            column(PeriodCap; PeriodCap)
            { }
            column(NameCap; NameCap)
            { }
            column(PermanentCap; PermanentCap)
            { }
            column(WebsiCap; WebsiCap)
            { }
            column(WebSiteCap; WebSiteCap)
            { }
            column(DateCap; DateCap)
            { }
            column(DatecCap; DatecCap)
            { }
            column(DetailCap; DetailCap)
            { }
            column(QuantiCap; QuantiCap)
            { }
            column(ValueCap; ValueCap)
            { }
            column(ExportCap; ExportCap)
            { }
            column(QuantityinCap; QuantityinCap)
            { }
            column(ValueinusCap; ValueinusCap)
            { }
            column(FOBCap; FOBCap)
            { }
            column(GcaCap; GcaCap)
            { }
            column(RpaCap; RpaCap)
            { }
            column(TotalCap; TotalCap)
            { }
            column(DeemedCap; DeemedCap)
            { }
            column(CumulaCap; CumulaCap)
            { }
            column(ImpoCap; ImpoCap)
            { }
            column(CumulativeimpoCap; CumulativeimpoCap)
            { }
            column(CumulatCap; CumulatCap)
            { }
            column(CumulatCap1; CumulatCap1)
            { }
            column(NetFoCap; NetFoCap)
            { }
            column(DTACap; DTACap)
            { }
            column(DTASCap; DTASCap)
            { }
            column(QuanCap; QuanCap)
            { }
            column(valCap; valCap)
            { }
            column(CaseCap; CaseCap)
            { }
            column(CaseesCap; CaseesCap)
            { }
            column(DateoCap; DateoCap)
            { }
            column(AddressCap; AddressCap)
            { }
            column(AmouCap; AmouCap)
            { }
            column(SignCap; SignCap)
            { }
            column(WithCap; WithCap)
            { }
            column(NotCap; NotCap)
            { }
            column(TheAboveCap; TheAboveCap)
            { }
            column(QprsCap; QprsCap)
            { }
            column(ThesiCap; ThesiCap)
            { }
            column(NosCap; NosCap)
            { }
            column(InrCap; InrCap)
            { }

            column(TotalQuantity; TotalQuantity)
            { }
            column(TotalAmount; TotalAmount)
            { }
            column(ExportForCap; ExportForCap)
            { }
            COLUMN(StartingDateG; StartingDateG)
            { }
            column(EndingDateG; EndingDateG)
            { }
            column(TotalAmount1; TotalAmount1)
            { }
            column(TotalAmount2; TotalAmount2)
            { }
            column(StartingDate1; StartingDate1)
            {

            }
            column(StartingDate2; StartingDate2)
            { }
            column(EndingDate1; EndingDate1)
            { }
            column(StartingDate3; StartingDate3)
            { }
            Column(EndingDate2; EndingDate2)
            { }
            column(EndingDate3; EndingDate3)
            { }
            column(TotalAmount3; TotalAmount3)
            { }
            column(GrandTotal; GrandTotal)
            { }
            column(PTotalAmount; PTotalAmount)
            { }
            column(PTotalAmount1; PTotalAmount1)
            { }
            column(PTotalAmount2; PTotalAmount2)
            { }
            column(PTotalAmount3; PTotalAmount3)
            { }
            column(PfGrandTotal; PfGrandTotal)
            { }
            column(CTotalAmount; CTotalAmount)
            { }
            column(CTotalAmount1; CTotalAmount1)
            { }
            column(CTotalAmount2; CTotalAmount2)
            { }
            column(CTotalAmount3; CTotalAmount3)
            { }
            column(CRGrandTotal; CRGrandTotal)
            { }
            column(CompanyInformationGvar; CompanyInformationGvar.Name)
            { }
            column(CompanyInformationGvarEmail; CompanyInformationGvar."E-Mail")
            { }
            column(TotalQuantity2; TotalQuantity2)
            { }
            column(TotalAmtRPA; TotalAmtRPA)
            { }
            column(PeriodQty; PeriodQty)
            { }
            column(PeriodAmount; PeriodAmount)
            { }
            trigger OnAfterGetRecord()
            begin
                CompanyInformationGvar.Get();
                //GCA Exports
                Psalesinvoiceheader.Reset();
                Psalesinvoiceheader.SetRange("GST Customer Type", Psalesinvoiceheader."GST Customer Type"::Export);
              //  Psalesinvoiceheader.SetRange("GCA Exports", true); sai
                Psalesinvoiceheader.setrange("Posting Date", StartingDateG, EndingDateG);
                if Psalesinvoiceheader.FindSet() then
                    repeat
                        PSalesline.Reset();
                        PSalesline.SetRange("Document No.", Psalesinvoiceheader."No.");
                        if PSalesline.FindSet() then begin
                            PSalesline.CalcSums(Quantity);
                            TotalQuantity += PSalesline.Quantity;
                        end;
                    until Psalesinvoiceheader.Next = 0;

                Psalesinvoiceheader.Reset();
                Psalesinvoiceheader.SetRange("GST Customer Type", Psalesinvoiceheader."GST Customer Type"::Export);
             //   Psalesinvoiceheader.SetRange("GCA Exports", true); sai
                Psalesinvoiceheader.SetRange("Posting Date", StartingDateG, EndingDateG);
                if Psalesinvoiceheader.FindSet() then
                    repeat
                        CustomerLedgerEntrier.Reset();
                        CustomerLedgerEntrier.SetRange("Document No.", Psalesinvoiceheader."No.");
                        if CustomerLedgerEntrier.FindSet() then begin
                            CustomerLedgerEntrier.CalcSums("Sales (LCY)");
                            TotalAmount += Abs(CustomerLedgerEntrier."Sales (LCY)");
                        end;
                    until Psalesinvoiceheader.Next = 0;
                //RPA Exports
                Psalesinvoiceheader.Reset();
                Psalesinvoiceheader.SetRange("GST Customer Type", Psalesinvoiceheader."GST Customer Type"::Export);
              //  Psalesinvoiceheader.SetRange("GCA Exports", true); sai
                Psalesinvoiceheader.setrange("Posting Date", StartingDateG, EndingDateG);
                if Psalesinvoiceheader.FindSet() then
                    repeat
                        PSalesline.Reset();
                        PSalesline.SetRange("Document No.", Psalesinvoiceheader."No.");
                        if PSalesline.FindSet() then begin
                            PSalesline.CalcSums(Quantity);
                            TotalQuantity2 += PSalesline.Quantity;
                        end;
                    until Psalesinvoiceheader.Next = 0;

                Psalesinvoiceheader.Reset();
                Psalesinvoiceheader.SetRange("GST Customer Type", Psalesinvoiceheader."GST Customer Type"::Export);
               // Psalesinvoiceheader.SetRange("GCA Exports", true); sai
                Psalesinvoiceheader.SetRange("Posting Date", StartingDateG, EndingDateG);
                if Psalesinvoiceheader.FindSet() then
                    repeat
                        CustomerLedgerEntrier.Reset();
                        CustomerLedgerEntrier.SetRange("Document No.", Psalesinvoiceheader."No.");
                        if CustomerLedgerEntrier.FindSet() then begin
                            CustomerLedgerEntrier.CalcSums("Sales (LCY)");
                            TotalAmtRPA += Abs(CustomerLedgerEntrier."Sales (LCY)");
                        end;
                    until Psalesinvoiceheader.Next = 0;
                //Period<<<
                Psalesinvoiceheader.Reset();
                Psalesinvoiceheader.SetRange("GST Customer Type", Psalesinvoiceheader."GST Customer Type"::Export);
                Psalesinvoiceheader.setrange("Posting Date", StartingDateG, EndingDateG);
                if Psalesinvoiceheader.FindSet() then
                    repeat
                        PSalesline.Reset();
                        PSalesline.SetRange("Document No.", Psalesinvoiceheader."No.");
                        if PSalesline.FindSet() then begin
                            PSalesline.CalcSums(Quantity);
                            PeriodQty += PSalesline.Quantity;
                        end;
                    until Psalesinvoiceheader.Next = 0;

                Psalesinvoiceheader.Reset();
                Psalesinvoiceheader.SetRange("GST Customer Type", Psalesinvoiceheader."GST Customer Type"::Export);
                Psalesinvoiceheader.SetRange("Posting Date", StartingDateG, EndingDateG);
                if Psalesinvoiceheader.FindSet() then
                    repeat
                        CustomerLedgerEntrier.Reset();
                        CustomerLedgerEntrier.SetRange("Document No.", Psalesinvoiceheader."No.");
                        if CustomerLedgerEntrier.FindSet() then begin
                            CustomerLedgerEntrier.CalcSums("Sales (LCY)");
                            PeriodAmount += Abs(CustomerLedgerEntrier."Sales (LCY)");
                        end;
                    until Psalesinvoiceheader.Next = 0;
                //B2BPROn26Jun2023>>>

                StartingDate1 := CalcDate('-1Y', StartingDateG);
                EndingDate1 := CalcDate('-1Y', EndingDateG);

                Psalesinvoiceheader.Reset();
                Psalesinvoiceheader.SetRange("GST Customer Type", Psalesinvoiceheader."GST Customer Type"::Export);
                Psalesinvoiceheader.SetRange("Posting Date", StartingDate1, EndingDate1);
                if Psalesinvoiceheader.FindSet() then
                    repeat
                        CustomerLedgerEntrier.Reset();
                        CustomerLedgerEntrier.SetRange("Document No.", Psalesinvoiceheader."No.");
                        if CustomerLedgerEntrier.FindSet() then begin

                            CustomerLedgerEntrier.CalcSums("Sales (LCY)");
                            TotalAmount1 += Abs(CustomerLedgerEntrier."Sales (LCY)");
                        end;
                    until Psalesinvoiceheader.Next = 0;

                StartingDate2 := CalcDate('-2Y', StartingDateG);
                EndingDate2 := CalcDate('-2Y', EndingDateG);
                Psalesinvoiceheader.Reset();
                Psalesinvoiceheader.SetRange("GST Customer Type", Psalesinvoiceheader."GST Customer Type"::Export);
                Psalesinvoiceheader.SetRange("Posting Date", StartingDate2, EndingDate2);
                if Psalesinvoiceheader.FindSet() then
                    repeat
                        CustomerLedgerEntrier.Reset();
                        CustomerLedgerEntrier.SetRange("Document No.", Psalesinvoiceheader."No.");
                        if CustomerLedgerEntrier.FindSet() then begin
                            CustomerLedgerEntrier.CalcSums("Sales (LCY)");
                            TotalAmount2 += Abs(CustomerLedgerEntrier."Sales (LCY)");
                        end;
                    until Psalesinvoiceheader.Next = 0;

                StartingDate3 := CalcDate('-3Y', StartingDateG);
                EndingDate3 := CalcDate('-3Y', EndingDateG);
                Psalesinvoiceheader.Reset();
                Psalesinvoiceheader.SetRange("GST Customer Type", Psalesinvoiceheader."GST Customer Type"::Export);
                Psalesinvoiceheader.SetRange("Posting Date", StartingDate3, EndingDate3);
                if Psalesinvoiceheader.FindSet() then
                    repeat
                        CustomerLedgerEntrier.Reset();
                        CustomerLedgerEntrier.SetRange("Document No.", Psalesinvoiceheader."No.");
                        if CustomerLedgerEntrier.FindSet() then begin
                            CustomerLedgerEntrier.CalcSums("Sales (LCY)");
                            TotalAmount3 += Abs(CustomerLedgerEntrier."Sales (LCY)");
                        end;
                    until Psalesinvoiceheader.Next = 0;

                GrandTotal := PeriodAmount + TotalAmount1 + TotalAmount2 + TotalAmount3;


                Ppurchaseinvoiceheader.Reset();
                Ppurchaseinvoiceheader.setrange("GST Vendor Type", Ppurchaseinvoiceheader."GST Vendor Type"::Import);
                Ppurchaseinvoiceheader.SetRange("Posting Date", StartingDateG, EndingDateG);
                if Ppurchaseinvoiceheader.FindSet() then
                    repeat
                        Ppurchaseinvoiceline.Reset();
                        Ppurchaseinvoiceline.SetRange("Document No.", Ppurchaseinvoiceheader."No.");
                        Ppurchaseinvoiceline.SetFilter("Gen. Prod. Posting Group", 'RM-DOM|RM-EOU|SC');
                        if Ppurchaseinvoiceline.FindSet() then begin
                            Ppurchaseinvoiceline.CalcSums(Amount);
                            PTotalAmount += Ppurchaseinvoiceline.Amount;
                            /*
                            repeat
                                VendorLedgerEntries.Reset();
                                VendorLedgerEntries.SetRange("Document No.", Ppurchaseinvoiceline."Document No.");
                                if VendorLedgerEntries.FindSet() then begin
                                    VendorLedgerEntries.CalcSums("Purchase (LCY)");
                                    PTotalAmount += Abs(VendorLedgerEntries."Purchase (LCY)");
                                end;
                            until Ppurchaseinvoiceline.Next() = 0;*/
                        end;
                    UNTIL Ppurchaseinvoiceheader.Next = 0;


                StartingDate1 := CalcDate('-1Y', StartingDateG);
                EndingDate1 := CalcDate('-1Y', EndingDateG);

                Ppurchaseinvoiceheader.Reset();
                Ppurchaseinvoiceheader.setrange("GST Vendor Type", Ppurchaseinvoiceheader."GST Vendor Type"::Import);
                Ppurchaseinvoiceheader.SetRange("Posting Date", StartingDate1, EndingDate1);
                if Ppurchaseinvoiceheader.FindSet() then
                    repeat
                        Ppurchaseinvoiceline.Reset();
                        Ppurchaseinvoiceline.SetRange("Document No.", Ppurchaseinvoiceheader."No.");
                        Ppurchaseinvoiceline.SetFilter("Gen. Prod. Posting Group", 'RM-DOM|RM-EOU|SC');
                        if Ppurchaseinvoiceline.FindSet() then begin
                            Ppurchaseinvoiceline.CalcSums(Amount);
                            PTotalAmount1 += Ppurchaseinvoiceline.Amount;
                        end;
                    UNTIL Ppurchaseinvoiceheader.Next = 0;

                StartingDate2 := CalcDate('-2Y', StartingDateG);
                EndingDate2 := CalcDate('-2Y', EndingDateG);
                Ppurchaseinvoiceheader.Reset();
                Ppurchaseinvoiceheader.setrange("GST Vendor Type", Ppurchaseinvoiceheader."GST Vendor Type"::Import);
                Ppurchaseinvoiceheader.SetRange("Posting Date", StartingDate2, EndingDate2);
                if Ppurchaseinvoiceheader.FindSet() then
                    repeat
                        Ppurchaseinvoiceline.Reset();
                        Ppurchaseinvoiceline.SetRange("Document No.", Ppurchaseinvoiceheader."No.");
                        Ppurchaseinvoiceline.SetFilter("Gen. Prod. Posting Group", 'RM-DOM|RM-EOU|SC');
                        if Ppurchaseinvoiceline.FindSet() then begin
                            Ppurchaseinvoiceline.CalcSums(Amount);
                            PTotalAmount2 += Ppurchaseinvoiceline.Amount;
                        end;
                    UNTIL Ppurchaseinvoiceheader.Next = 0;

                StartingDate3 := CalcDate('-3Y', StartingDateG);
                EndingDate3 := CalcDate('-3Y', EndingDateG);
                Ppurchaseinvoiceheader.Reset();
                Ppurchaseinvoiceheader.setrange("GST Vendor Type", Ppurchaseinvoiceheader."GST Vendor Type"::Import);
                Ppurchaseinvoiceheader.SetRange("Posting Date", StartingDate3, EndingDate3);
                if Ppurchaseinvoiceheader.FindSet() then
                    repeat
                        Ppurchaseinvoiceline.Reset();
                        Ppurchaseinvoiceline.SetRange("Document No.", Ppurchaseinvoiceheader."No.");
                        Ppurchaseinvoiceline.SetFilter("Gen. Prod. Posting Group", 'RM-DOM|RM-EOU|SC');
                        if Ppurchaseinvoiceline.FindSet() then begin
                            Ppurchaseinvoiceline.CalcSums(Amount);
                            PTotalAmount3 += Ppurchaseinvoiceline.Amount;
                        end;
                    UNTIL Ppurchaseinvoiceheader.Next = 0;
                PfGrandTotal := PTotalAmount + PTotalAmount1 + PTotalAmount2 + PTotalAmount3;

                //B2BPROn29JUN2023<<<
                Ppurchaseinvoiceheader.Reset();
                Ppurchaseinvoiceheader.setrange("GST Vendor Type", Ppurchaseinvoiceheader."GST Vendor Type"::Import);
                Ppurchaseinvoiceheader.SetRange("Posting Date", StartingDateG, EndingDateG);
                if Ppurchaseinvoiceheader.FindSet() then
                    repeat
                        Ppurchaseinvoiceline.Reset();
                        Ppurchaseinvoiceline.SetRange("Document No.", Ppurchaseinvoiceheader."No.");
                        Ppurchaseinvoiceline.SetFilter("Gen. Prod. Posting Group", 'FA|SER');
                        if Ppurchaseinvoiceline.FindSet() then begin
                            Ppurchaseinvoiceline.CalcSums(Amount);
                            CTotalAmount += Ppurchaseinvoiceline.Amount;
                        end;
                    UNTIL Ppurchaseinvoiceheader.Next = 0;

                Ppurchaseinvoiceheader.Reset();
                Ppurchaseinvoiceheader.setrange("GST Vendor Type", Ppurchaseinvoiceheader."GST Vendor Type"::Import);
                Ppurchaseinvoiceheader.SetRange("Posting Date", StartingDate1, EndingDate1);
                if Ppurchaseinvoiceheader.FindSet() then
                    repeat
                        Ppurchaseinvoiceline.Reset();
                        Ppurchaseinvoiceline.SetRange("Document No.", Ppurchaseinvoiceheader."No.");
                        Ppurchaseinvoiceline.SetFilter("Gen. Prod. Posting Group", 'FA|SER');
                        if Ppurchaseinvoiceline.FindSet() then begin
                            Ppurchaseinvoiceline.CalcSums(Amount);
                            CTotalAmount1 += Ppurchaseinvoiceline.Amount;
                        end;
                    UNTIL Ppurchaseinvoiceheader.Next = 0;
                Ppurchaseinvoiceheader.Reset();
                Ppurchaseinvoiceheader.setrange("GST Vendor Type", Ppurchaseinvoiceheader."GST Vendor Type"::Import);
                Ppurchaseinvoiceheader.SetRange("Posting Date", StartingDate2, EndingDate2);
                if Ppurchaseinvoiceheader.FindSet() then
                    repeat
                        Ppurchaseinvoiceline.Reset();
                        Ppurchaseinvoiceline.SetRange("Document No.", Ppurchaseinvoiceheader."No.");
                        Ppurchaseinvoiceline.SetFilter("Gen. Prod. Posting Group", 'FA|SER');
                        if Ppurchaseinvoiceline.FindSet() then begin
                            Ppurchaseinvoiceline.CalcSums(Amount);
                            CTotalAmount2 += Ppurchaseinvoiceline.Amount;
                        end;
                    UNTIL Ppurchaseinvoiceheader.Next = 0;
                Ppurchaseinvoiceheader.Reset();
                Ppurchaseinvoiceheader.setrange("GST Vendor Type", Ppurchaseinvoiceheader."GST Vendor Type"::Import);
                Ppurchaseinvoiceheader.SetRange("Posting Date", StartingDate3, EndingDate3);
                if Ppurchaseinvoiceheader.FindSet() then
                    repeat
                        Ppurchaseinvoiceline.Reset();
                        Ppurchaseinvoiceline.SetRange("Document No.", Ppurchaseinvoiceheader."No.");
                        Ppurchaseinvoiceline.SetFilter("Gen. Prod. Posting Group", 'FA|SER');
                        if Ppurchaseinvoiceline.FindSet() then begin
                            Ppurchaseinvoiceline.CalcSums(Amount);
                            CTotalAmount3 += Ppurchaseinvoiceline.Amount;
                        end;
                    UNTIL Ppurchaseinvoiceheader.Next = 0;
                CRGrandTotal := CTotalAmount + CTotalAmount1 + CTotalAmount2 + CTotalAmount3;
            end;

        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(StartingDateG; StartingDateG)
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the value of the Starting Date field.';
                    }
                    field(EndingDateG; EndingDateG)
                    {
                        ApplicationArea = All;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the value of the Ending Date field.';
                    }
                }
            }
        }
    }
    var
        IleQuantityQuarter: Decimal;
        ItemUnitPriceQuarter: decimal;
        CompanyInformationGvar: Record "Company Information";
        Psalesinvoiceheader: Record "Sales Invoice Header";
        Salesinvoiceheader1: Record "Sales Invoice Header";
        CustomerLedgerEntrier: Record "Cust. Ledger Entry";
        Ppurchaseinvoiceheader: Record "Purch. Inv. Header";
        Ppurchaseinvoiceline: Record "Purch. Inv. Line";
        VendorLedgerEntries: Record "Vendor Ledger Entry";
        GrandTotal: Decimal;
        StartingDateG: Date;
        EndingDateG: Date;
        StartingDate1: Date;
        EndingDate1: Date;
        TotalAmount1: Decimal;
        TotalAmount2: Decimal;
        TotalAmount3: Decimal;
        StartingDate2: Date;
        EndingDate2: Date;
        StartingDate3: Date;
        EndingDate3: Date;
        PTotalAmount: Decimal;
        PTotalAmount1: Decimal;
        PTotalAmount2: Decimal;
        PTotalAmount3: Decimal;
        PfGrandTotal: Decimal;
        CTotalAmount: Decimal;
        CTotalAmount1: Decimal;
        CTotalAmount2: Decimal;
        CTotalAmount3: Decimal;
        CRGrandTotal: Decimal;
        AnnextureCap: Label 'ANNEXURE-III';
        FormatCap: Label 'FORMAT FOR QUARTERLY REPORT FOR THE WORKING UNITS';
        PeriodCap: Label 'Period-PERIOD REPORTING:QUARTERLY';
        NameCap: Label 'Name of the Unit & location';
        PermanentCap: Label '(a)Permanent E-mail Address(Compulosry)';
        WebsiCap: label '(b)Web Site';
        WebSiteCap: Label 'WWW.VARELECTROCHEM.IN';
        DateCap: Label 'Date of commencement of production';
        DatecCap: Label '15 th February 2020';
        DetailCap: Label 'Details of Production figures';
        QuantiCap: Label 'Quantity(MT/pieces)';
        ValueCap: Label 'Value in INR in Lakhs';
        ExportCap: Label 'EXPORT(INFLOW)';
        FOBCap: Label 'FOB value of exports for the Quarter';
        GcaCap: Label 'GCA exports';
        RpaCap: Label 'RPA exports';
        TotalCap: Label 'Total in INR';
        QuantityinCap: Label 'Quantity in Nos';
        ValueinusCap: Label 'Value in USD/INR In Lakhs';
        NosCap: Label 'Nos';
        InrCap: Label 'INR';
        DeemedCap: Label 'Deemed export for other categories during the quarter';
        CumulaCap: Label 'Cumulative exports/deemed export up to the current Quarter';
        ImpoCap: Label 'IMPORT(OUTFLOW)';
        CumulativeimpoCap: Label 'Cumulative import of RM/consumable etc during the quarter';
        CumulatCap: Label 'Cumulative import of RM/Consumables etc.,Consumed up to the Quarter';
        CumulatCap1: Label 'Cumulative import of Capital goods/Services including spares up to the Quarter';
        NetFoCap: Label 'Net foregin exchange earning Achieved(NFE)(Column4-Column5{ii}+Column 5{ii})';
        DTACap: Label 'DTA SALE';
        DTASCap: Label 'DTA sale';
        QuanCap: label 'Quantity';
        valCap: Label 'Value';
        CaseCap: Label 'Cases of pending Foreign Exchange';
        CaseesCap: Label 'Cases of Pending Foreign Exchange realisation outstanding for more than 360 days at the end of last quarter/financial year';
        DateoCap: Label 'Date of export : Name of Importer';
        AddressCap: Label 'Address:';
        AmouCap: Label 'Amount';
        SignCap: Label '(SIGNATURE)';
        WithCap: Label 'With a stamp';
        NotCap: Label 'Notes:-';
        TheAboveCap: Label 'The above information should be given separately for each Letter of Permission';
        QprsCap: Label 'QPRs must be submitted electronically only if the zones have provided online facilities';
        ThesiCap: Label 'The signature of the authorised signatory of the unit must be sent to the zone electronically';
        StaringDate: Date;
        EndingDate: Date;
        TotalQuantity: Decimal;
        TotalQuantity2: Decimal;
        PeriodQty: Decimal;
        PeriodAmount: Decimal;
        TotalAmtRPA: Decimal;
        TotalAmount: Decimal;
        PSalesline: Record "Sales Invoice Line";
        ExportForCap: Label 'Export for';
        ItemLedgerEntryGrec: Record "Item Ledger Entry";

    //psalesheader: Record "Sales Invoice Header";
}
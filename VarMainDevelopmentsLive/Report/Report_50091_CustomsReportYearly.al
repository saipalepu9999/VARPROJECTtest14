report 50091 "Customs VSEZ-Report Yearly"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\CustomsVSEZReportYearly.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            column(Number; Number)
            { }
            column(CompanyName; CompanyInfo.Name)
            { }
            column(AmountUSDGvar; AmountUSDGvar)
            { }
            column(AmountEUROGvar; AmountEUROGvar)
            { }
            column(AmountInVatUSDVar; AmountInVatUSDVar)
            { }
            column(AmountInVatEUROVar; AmountInVatEUROVar)
            { }
            column(CummulAvgGVar; CummulAvgGVar)
            { }
            column(OpeningBalVar; OpeningBalVar)
            { }
            column(RMImpGvar; RMImpGvar)
            { }
            column(RMTransGvar; RMTransGvar)
            { }
            column(ImpRMConGvar; ImpRMConGvar)
            { }
            column(PostingDateVar; PostingDateVar)
            { }
            column(PostingDateVar1; PostingDateVar1)
            { }
            column(OpeningBal29Col; OpeningBal29Col)
            { }
            column(PurchaseBal30Col; PurchaseBal30Col)
            { }
            column(PurchAmt21Col; PurchAmt21Col)
            { }
            column(OtherFEOutflowVar; OtherFEOutflowVar)
            { }
            column(NoOfMenGvar; NoOfMenGvar)
            { }
            column(NoOfWomenGvar; NoOfWomenGvar)
            { }
            column(AuthCapValVar; AuthCapValVar)
            { }
            column(PaidUpCapValVar; PaidUpCapValVar)
            { }
            column(TitleCapLbl; TitleCapLbl)
            { }
            column(PeriodCapLbl; PeriodCapLbl)
            { }
            column(ExportCapLbl; ExportCapLbl)
            { }
            column(TotalCapLbl; TotalCapLbl)
            { }
            column(ImportCapLbl; ImportCapLbl)
            { }
            column(ImportRMConCap; ImportRMConCap)
            { }
            column(SubTotalCapLbl; SubTotalCapLbl)
            { }
            column(TotalOutflowCap; TotalOutflowCap)
            { }
            column(ValueCapLbl; ValueCapLbl)
            { }
            column(EuroCapLbl; EuroCapLbl)
            { }
            column(EuroUsdCapLbl; EuroUsdCapLbl)
            { }
            column(RupeesInCap; RupeesInCap)
            { }
            column(QuantityCapLbl; QuantityCapLbl)
            { }
            column(DetailsCap1; DetailsCap1)
            { }
            column(NameCap2; NameCap2)
            { }
            column(IECNoCap3; IECNoCap3)
            { }
            column(PeriodReportCap4; PeriodReportCap4)
            { }
            column(ApprovalCap5; ApprovalCap5)
            { }
            column(ItemofManfCap6; ItemofManfCap6)
            { }
            column(DetailsofAllItemCap7; DetailsofAllItemCap7)
            { }
            column(FactoryLocCap8; FactoryLocCap8)
            { }
            column(RegdOfficeCap9; RegdOfficeCap9)
            { }
            column(PermanentCap10; PermanentCap10)
            { }
            column(WebSiteCap11; WebSiteCap11)
            { }
            column(DateofCommenCap12; DateofCommenCap12)
            { }
            column(DetailsOfProdCap13; DetailsOfProdCap13)
            { }
            column(DetailsOfForeignCap14; DetailsOfForeignCap14)
            { }
            column(FOBValueCap15; FOBValueCap15)
            { }
            column(GCAExportCap16; GCAExportCap16)
            { }
            column(CurrencyInUSDCap17; CurrencyInUSDCap17)
            { }
            column(CurrencyInEuroCap18; CurrencyInEuroCap18)
            { }
            column(RPAExportCap19; RPAExportCap19)
            { }
            column(GoodsSoldCap20; GoodsSoldCap20)
            { }
            column(ChapterCap21; ChapterCap21)
            { }
            column(DeemedExportCap22; DeemedExportCap22)
            { }
            column(CumExportCurrCap23; CumExportCurrCap23)
            { }
            column(CumExpPreCap24; CumExpPreCap24)
            { }
            column(CountryWiseCap25; CountryWiseCap25)
            { }
            column(OpeningBalCap26; OpeningBalCap26)
            { }
            column(RawMaterialCap27; RawMaterialCap27)
            { }
            column(RMConsumTransferCap28; RMConsumTransferCap28)
            { }
            column(RMConsumReceivCap29; RMConsumReceivCap29)
            { }
            column(CumImportCap30; CumImportCap30)
            { }
            column(RMImportCap31; RMImportCap31)
            { }
            column(ClosingBalImpCap32; ClosingBalImpCap32)
            { }
            column(OpeningBalImpCap33; OpeningBalImpCap33)
            { }
            column(ImpCapitalCap34; ImpCapitalCap34)
            { }
            column(CapitalGoodsReceivCap35; CapitalGoodsReceivCap35)
            { }
            column(CapitalGoodsTransCap36; CapitalGoodsTransCap36)
            { }
            column(CumImpCapGoodsCap37; CumImpCapGoodsCap37)
            { }
            column(OtherFEOutfloeCap38; OtherFEOutfloeCap38)
            { }
            column(DividedPayCap39; DividedPayCap39)
            { }
            column(NetForeiExChCap40; NetForeiExChCap40)
            { }
            column(OpeningBalIndiCap41; OpeningBalIndiCap41)
            { }
            column(PurIndigeCap42; PurIndigeCap42)
            { }
            column(CumIndigeCap43; CumIndigeCap43)
            { }
            column(CumIndigeCap44; CumIndigeCap44)
            { }
            column(OpeningBalIndiRMCap45; OpeningBalIndiRMCap45)
            { }
            column(PurIndigeRMCap46; PurIndigeRMCap46)
            { }
            column(CumIndigeRMCap47; CumIndigeRMCap47)
            { }
            column(DTASaleCap48; DTASaleCap48)
            { }
            column(SalesOfGoodsCap49; SalesOfGoodsCap49)
            { }
            column(SalesofRejCap50; SalesofRejCap50)
            { }
            column(SalesofWasteCap51; SalesofWasteCap51)
            { }
            column(SalesofByProdCap52; SalesofByProdCap52)
            { }
            column(DTASaleOnCap53; DTASaleOnCap53)
            { }
            column(ItemsManSerCap54; ItemsManSerCap54)
            { }
            column(AnnualCapacityCap55; AnnualCapacityCap55)
            { }
            column(ForeNRIIndCap56; ForeNRIIndCap56)
            { }
            column(AuthCapitalCap57; AuthCapitalCap57)
            { }
            column(PaidupCap58; PaidupCap58)
            { }
            column(ForeDirectInstCap59; ForeDirectInstCap59)
            { }
            column(QuantityCap60; QuantityCap60)
            { }
            column(ForeignNRICap61; ForeignNRICap61)
            { }
            column(ValueCap62; ValueCap62)
            { }
            column(IndianCap63; IndianCap63)
            { }
            column(ApprovedCap64; ApprovedCap64)
            { }
            column(ActualInflowCap65; ActualInflowCap65)
            { }
            column(CumBalYearCap66; CumBalYearCap66)
            { }
            column(FDICumCap67; FDICumCap67)
            { }
            column(NRICapitalCap68; NRICapitalCap68)
            { }
            column(EmpCapLbl69; EmpCapLbl69)
            { }
            column(NoOfMenWorkerCap70; NoOfMenWorkerCap70)
            { }
            column(ManagirialCap71; ManagirialCap71)
            { }
            column(NoOfWoMenWorkerCap72; NoOfWoMenWorkerCap72)
            { }
            column(SkilledCap73; SkilledCap73)
            { }
            column(UnSkilledCap74; UnSkilledCap74)
            { }
            column(TotalABCap75; TotalABCap75)
            { }
            column(OtherInfoCap76; OtherInfoCap76)
            { }
            column(OverSeasCap77; OverSeasCap77)
            { }
            column(OverSeasInvtCap78; OverSeasInvtCap78)
            { }
            column(LessThanCap79; LessThanCap79)
            { }
            column(AmountInCap80; AmountInCap80)
            { }
            column(CasesOfPendCap81; CasesOfPendCap81)
            { }
            column(CasesOfPendrealiCap82; CasesOfPendrealiCap82)
            { }
            column(ForMorethanCap83; ForMorethanCap83)
            { }
            column(DateofExportCap84; DateofExportCap84)
            { }
            column(NameofImporterCap85; NameofImporterCap85)
            { }
            column(AddressCap86; AddressCap86)
            { }
            column(AmountCap87; AmountCap87)
            { }
            column(EOSSpCap88; EOSSpCap88)
            { }
            column(ExternalComCap89; ExternalComCap89)
            { }
            column(ExternalComPedCap90; ExternalComPedCap90)
            { }
            column(Morethan3yearsCap91; Morethan3yearsCap91)
            { }
            column(Lessthan3YearsCap92; Lessthan3YearsCap92)
            { }
            column(RevenContriCap93; RevenContriCap93)
            { }
            column(RevenContUnitCap94; RevenContUnitCap94)
            { }
            column(ExciseDutyCap95; ExciseDutyCap95)
            { }
            column(IncomeTaxCap96; IncomeTaxCap96)
            { }
            column(StateTaxCap97; StateTaxCap97)
            { }
            column(StateTaxCap98; StateTaxCap98)
            { }
            column(TaxDeductCap99; TaxDeductCap99)
            { }
            column(SigNatureCap100; SigNatureCap100)
            { }
            column(WithSealCap101; WithSealCap101)
            { }
            column(NoteCap102; NoteCap102)
            { }
            column(Note1CapLbl103; Note1CapLbl103)
            { }
            column(Note2CapLbl104; Note2CapLbl104)
            { }
            column(Note3CapLbl105; Note3CapLbl105)
            { }
            column(Note4CapLbl106; Note4CapLbl106)
            { }
            trigger OnPreDataItem()
            begin
                MinDateGvar := Date2DMY(StartDate, 3);
                MaxDateGvar := Date2DMY(EndDate, 3);
            end;

            trigger OnAfterGetRecord()
            var
                PSalesLine: Record "Sales Invoice Line";
            begin
                PostedSalesInv.Reset();
                PostedSalesInv.SetRange("GST Customer Type", PostedSalesInv."GST Customer Type"::Export);
                PostedSalesInv.SetFilter("Currency Code", 'USD|EURO');
                PostedSalesInv.SetRange("Posting Date", StartDate, EndDate);
                PostedSalesInv.SetAutoCalcFields(Amount, "Amount Including VAT");
                if PostedSalesInv.FindSet() then
                    repeat
                        PSalesLine.Reset();
                        PSalesLine.SetRange("Document No.", PostedSalesInv."No.");
                        PSalesLine.SetRange(Type, PSalesLine.Type::Item);
                        if PSalesLine.FindFirst() then
                            case PostedSalesInv."Currency Code" of
                                'USD':
                                    begin
                                        AmountUSDGvar += PostedSalesInv.Amount;
                                        AmountInVatUSDVar += PostedSalesInv."Amount Including VAT";
                                    end;
                                'EURO':
                                    begin
                                        AmountEUROGvar += PostedSalesInv.Amount;
                                        AmountInVatEUROVar += PostedSalesInv."Amount Including VAT";
                                    end;
                            end;
                    until PostedSalesInv.Next() = 0;

                ItemGRec.Reset();
                ItemGRec.SetFilter("Inventory Posting Group", 'RAW MAT|RESALE');
                if ItemGRec.FindSet() then begin
                    repeat
                        ItemLedgEntryRec.Reset();
                        ItemLedgEntryRec.SetRange("Item No.", ItemGRec."No.");
                        ItemLedgEntryRec.SetFilter("Posting Date", '<%1', StartDate);
                        if ItemLedgEntryRec.FindSet() then
                            repeat
                                ItemLedgEntryRec.CalcFields("Cost Amount (Actual)");
                                OpeningBalVar += ItemLedgEntryRec."Cost Amount (Actual)";
                            until ItemLedgEntryRec.Next() = 0;
                    until ItemGRec.Next() = 0;
                end;

                ItemLedgEntryRec.Reset();
                ItemLedgEntryRec.SetRange("Posting Date", StartDate, EndDate);
                ItemLedgEntryRec.SetRange("Entry Type", ItemLedgEntryRec."Entry Type"::Purchase);
                ItemLedgEntryRec.SetRange("Document Type", ItemLedgEntryRec."Document Type"::"Purchase Receipt");
                if ItemLedgEntryRec.FindSet() then
                    repeat
                        ItemLedgEntryRec.CalcFields("Cost Amount (Actual)");
                        RMImpGvar += ItemLedgEntryRec."Cost Amount (Actual)";
                    until ItemLedgEntryRec.Next() = 0;


                ItemGRec.Reset();
                ItemGRec.SetFilter("Inventory Posting Group", 'RAW MAT|RESALE');
                if ItemGRec.FindSet() then begin
                    repeat
                        ItemLedgEntryRec.Reset();
                        ItemLedgEntryRec.SetRange("Item No.", ItemGRec."No.");
                        ItemLedgEntryRec.SetRange("Entry Type", ItemLedgEntryRec."Entry Type"::Transfer);
                        ItemLedgEntryRec.SetRange("Document Type", ItemLedgEntryRec."Document Type"::"Transfer Shipment");
                        ItemLedgEntryRec.SetRange(Positive, true);
                        ItemLedgEntryRec.SetRange("Posting Date", StartDate, EndDate);
                        if ItemLedgEntryRec.FindSet() then
                            repeat
                                ItemLedgEntryRec.CalcFields("Cost Amount (Actual)");
                                RMTransGvar += ItemLedgEntryRec."Cost Amount (Actual)";
                            until ItemLedgEntryRec.Next() = 0;
                    until ItemGRec.Next() = 0;
                end;

                ItemGRec.Reset();
                ItemGRec.SetFilter("Inventory Posting Group", 'RAW MAT|RESALE');
                if ItemGRec.FindSet() then begin
                    repeat
                        ItemLedgEntryRec.Reset();
                        ItemLedgEntryRec.SetRange("Item No.", ItemGRec."No.");
                        ItemLedgEntryRec.SetRange("Entry Type", ItemLedgEntryRec."Entry Type"::Consumption);
                        ItemLedgEntryRec.SetRange("Posting Date", StartDate, EndDate);
                        if ItemLedgEntryRec.FindSet() then
                            repeat
                                ItemLedgEntryRec.CalcFields("Cost Amount (Actual)");
                                ImpRMConGvar += Abs(ItemLedgEntryRec."Cost Amount (Actual)");
                            until ItemLedgEntryRec.Next() = 0;
                    until ItemGRec.Next() = 0
                end;

                //Column 21 
                PostedRecHeader.Reset();
                PostedRecHeader.SetRange("GST Vendor Type", PostedRecHeader."GST Vendor Type"::Import);
                PostedRecHeader.SetRange("Posting Date", StartDate, EndDate);
                if PostedRecHeader.FindSet() then begin
                    repeat
                        PostedRecLine.Reset();
                        PostedRecLine.SetRange("Document No.", PostedRecHeader."No.");
                        PostedRecLine.SetRange(Type, PostedRecLine.Type::Item);
                        if PostedRecLine.FindSet() then begin
                            repeat
                                ItemGrec2.Reset();
                                ItemGrec2.SetRange("No.", PostedRecLine."No.");
                                ItemGrec2.SetFilter("Inventory Posting Group", 'RAW MAT|RESALE');
                                repeat
                                    if ItemGrec2.FindSet() then begin
                                        ItemLedgEntry2.Reset();
                                        ItemLedgEntry2.SetRange("Item No.", ItemGrec2."No.");
                                        //ItemLedgEntry2.SetRange();
                                        if ItemLedgEntry2.FindSet() then begin
                                            ItemLedgEntry2.CalcFields("Cost Amount (Actual)");
                                            repeat
                                                PurchAmt21Col += ItemLedgEntry2."Cost Amount (Actual)";
                                            until ItemLedgEntry2.Next() = 0;
                                        end;
                                    end;
                                until ItemGrec2.Next() = 0;
                            until PostedRecLine.Next() = 0;
                        end;
                    until PostedRecHeader.Next() = 0;
                end;

                FALdgEntryGRec.Reset();
                FALdgEntryGRec.SetRange("FA Posting Type", FALdgEntryGRec."FA Posting Type"::"Acquisition Cost");
                FALdgEntryGRec.SetFilter("Posting Date", '<=%1', StartDate);
                if FALdgEntryGRec.FindSet() then begin
                    FALdgEntryGRec.CalcSums(Amount);
                    OpeningBal29Col := FALdgEntryGRec.Amount;
                end;

                FALdgEntryGRec.Reset();
                FALdgEntryGRec.SetRange("FA Posting Type", FALdgEntryGRec."FA Posting Type"::"Acquisition Cost");
                FALdgEntryGRec.SetRange("Posting Date", StartDate, EndDate);
                if FALdgEntryGRec.FindSet() then begin
                    FALdgEntryGRec.CalcSums(Amount);
                    PurchaseBal30Col := FALdgEntryGRec.Amount;
                end;

                PostingDateVar := StrSubstNo(PostingDateLbl, MinDateGvar, MaxDateGvar);
                PostingDateVar1 := StrSubstNo(PeriodCapLbl, MinDateGvar, MaxDateGvar)
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
                    ShowCaption = false;
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field(CummulAvgGVar; CummulAvgGVar)
                    {
                        ApplicationArea = All;
                        Caption = 'Cumulalive exports up to the previous year';

                    }
                    field(OtherFEOutflowVar; OtherFEOutflowVar)
                    {
                        ApplicationArea = All;
                        Caption = 'Other FE Oufloow/Royally/ technoiogical know-how/investment';
                    }
                    field(AuthCapValVar; AuthCapValVar)
                    {
                        ApplicationArea = All;
                        Caption = 'Authorized Capital';
                    }
                    field(PaidUpCapValVar; PaidUpCapValVar)
                    {
                        ApplicationArea = All;
                        Caption = 'Paid up capital';
                    }
                    field(NoOfMenGvar; NoOfMenGvar)
                    {
                        ApplicationArea = All;
                        Caption = 'No.of Men Workers employed in the unit';
                    }
                    field(NoOfWomenGvar; NoOfWomenGvar)
                    {
                        ApplicationArea = All;
                        Caption = 'No.of WoMen Workers employed in the unit';
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
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        PostedSalesInv: Record "Sales Invoice Header";
        ItemLedgEntryRec: Record "Item Ledger Entry";
        ItemGRec: Record Item;
        FixedAssetRec: Record "Fixed Asset";
        FALdgEntryGRec: Record "FA Ledger Entry";
        PostedRecHeader: Record "Purch. Rcpt. Header";
        PostedRecLine: Record "Purch. Rcpt. Line";
        ItemGrec2: Record Item;
        ItemLedgEntry2: Record "Item Ledger Entry";
        PurchAmt21Col: Decimal;
        AmountUSDGvar: Decimal;
        AmountEUROGvar: Decimal;
        AmountInVatUSDVar: Decimal;
        AmountInVatEUROVar: Decimal;
        CummulAvgGVar: Decimal;
        PostingDateGvar: Date;
        PostingDateVar: Text;
        PostingDateVar1: Text;
        MinDateGvar: Integer;
        MaxDateGvar: Integer;
        StartDate: Date;
        EndDate: Date;
        OpeningBalVar: Decimal;
        RMImpGvar: Decimal;
        RMTransGvar: Decimal;
        ImpRMConGvar: Decimal;
        OtherFEOutflowVar: Decimal;
        AuthCapValVar: Decimal;
        PaidUpCapValVar: Decimal;
        NoOfMenGvar: Decimal;
        NoOfWomenGvar: Decimal;
        PostingDateLbl: Label '(%1-%2)';
        TitleCapLbl: Label 'FORMAT FOR ANNUAL PROGRESS REPORT FOR THE WORKING UNITS';
        PeriodCapLbl: Label 'Period -- PERIOD OF REPORTING ANNUAL(APRIL %1-MARCH %2)';
        ExportCapLbl: Label 'EXPORT(INFLOW)';
        TotalCapLbl: Label 'Total';
        ImportCapLbl: Label 'IMPORT(OUTFLOW)';
        ImportRMConCap: Label 'Imported RM/consumable etc. not utilised beyond five years';
        SubTotalCapLbl: Label 'Sub-Total[Column No.20 + Column 26]';
        TotalOutflowCap: Label 'TOTAL OUTFLOW[Column No. 20+26+27]';
        QuantityCapLbl: Label 'Quantity(MT/pieces)';
        ValueCapLbl: Label 'Value(Rs. in  lakhs)';
        EuroCapLbl: Label 'EURO in Million';
        EuroUsdCapLbl: Label 'EURO/USD in Million';
        RupeesInCap: Label '(Rs. in Lakhs)';
        DetailsCap1: Label 'Details of the Unit:';
        NameCap2: Label 'Name of the Unit:';
        IECNoCap3: Label 'IEC. No.';
        PeriodReportCap4: Label 'PERIOD OF REPORTING';
        ApprovalCap5: Label 'Approval No. & Date';
        ItemofManfCap6: Label 'Item of manufacture/servica - Annual Capacity';
        DetailsofAllItemCap7: Label '(Details or all items to be provided)';
        FactoryLocCap8: Label 'Factory Location/Address/Teiephone No';
        RegdOfficeCap9: Label 'Regd. Office Address/Tel/Fax No';
        PermanentCap10: Label '(a) Permanen I E-mail Address (Compuisory):';
        WebSiteCap11: Label '(d) Web Site';
        DateofCommenCap12: Label 'Date of commencement of production';
        DetailsOfProdCap13: Label 'Details of production figures';
        DetailsOfForeignCap14: Label 'Details of Foreign Exchange Inflow/Outflow';
        FOBValueCap15: Label 'FOB value of exports for the Year';
        GCAExportCap16: Label 'GCA exports';
        CurrencyInUSDCap17: Label 'Currency in USD';
        CurrencyInEuroCap18: Label 'Currency in EURO';
        RPAExportCap19: Label 'RPA Exports';
        GoodsSoldCap20: Label '(a)Goods sold in DTA in tarms of Para 6.9(b) of the';
        ChapterCap21: Label 'Chapter 6 of the foreign Trade Policy for year';
        DeemedExportCap22: Label '(b)Deemed export for other categories during the year';
        CumExportCurrCap23: Label 'Cumulative exports up to the current year';//
        CumExpPreCap24: Label 'Cumulative exports up to the previous year';
        CountryWiseCap25: Label 'Country-wise details of exports';
        OpeningBalCap26: Label 'Opening balance of Imported RM, Consumables etc., during the year';
        RawMaterialCap27: Label 'Raw Materials/consumables/components etc. imported during the year';
        RMConsumTransferCap28: Label 'RM/consumables etc, transferred to other units during the year';
        RMConsumReceivCap29: Label 'RM/consumables etc, received under the inter-units transfer during the year';
        CumImportCap30: Label 'Cumulative import of RM/consumable etc. during the year';
        RMImportCap31: Label 'Imported RM/Consumables/ etc., consumed during the year';
        ClosingBalImpCap32: Label 'Closing balance of imported RM/Consumables etc, at the end of year';
        OpeningBalImpCap33: Label 'Opening balance of imported capital goods including spares';
        ImpCapitalCap34: Label 'Import of capital goods including spares dunng the year';
        CapitalGoodsReceivCap35: Label 'Capital goods including spares received under inter—unit transfer';
        CapitalGoodsTransCap36: Label 'Capital goods including spares transferred under inter-unit transfer';
        CumImpCapGoodsCap37: Label 'Cumulative imports of capital goods including spares dunng year.(Column No.22+23+24+25)';
        OtherFEOutfloeCap38: Label 'Other FE Outflow(Royalty/Technological know-how/investment';
        DividedPayCap39: Label '/Dividend payment/Travel/Commission/Hire Charges/Hypothecation etc.)during the year';
        NetForeiExChCap40: Label 'Net foreign exchange earning (Column No. 9 - Column No. 27';
        OpeningBalIndiCap41: Label 'Opening balance of indigenous capital goods Including spares during the year';
        PurIndigeCap42: Label 'Purchase of indigenous capital goods dunng the year';
        CumIndigeCap43: Label 'Cumulative balance of indigenous capital goods purchased during the year';
        CumIndigeCap44: Label 'Cumulative balance of indigenous capital goods purchased up to the year';
        OpeningBalIndiRMCap45: Label 'Opening balance of indigenous RM/Consumables etc., during the year';
        PurIndigeRMCap46: Label 'Purchase of indigenous RM/Consumables etc., during the year';
        CumIndigeRMCap47: Label 'Cumulative balance of indigenous RM/Consumables Purchased during the year';
        DTASaleCap48: Label 'DTA SALE';
        SalesOfGoodsCap49: Label 'Sales of goods effected in DTA if';
        SalesofRejCap50: Label 'Sales of rejects in DTA if any:';
        SalesofWasteCap51: Label 'Sale of Waste/Scrap/Remnent';
        SalesofByProdCap52: Label 'Sale of by product';
        DTASaleOnCap53: Label 'DTA sale on full duty';
        ItemsManSerCap54: Label 'Items of manufacture/service';
        AnnualCapacityCap55: Label 'Annual capacity (at the end of financial year)';
        ForeNRIIndCap56: Label 'Foreign/NRl/indian investment';
        AuthCapitalCap57: Label 'i) Authorised capital';
        PaidupCap58: Label 'ii) Paid up Capital';
        ForeDirectInstCap59: Label 'iii) Foreign Direct Investment';
        QuantityCap60: Label 'Quantity';
        ForeignNRICap61: Label 'Foreign NRI';
        ValueCap62: Label 'Value';
        IndianCap63: Label 'Indian (to be submitted annually)';
        ApprovedCap64: Label 'i) Approved';
        ActualInflowCap65: Label 'ii) Actual Inflow during the year';
        CumBalYearCap66: Label 'II)Cumulative balance for the year';
        FDICumCap67: Label '(FDI Cumulative up to the Year INR. 16,04,330=00)';
        NRICapitalCap68: Label 'iv) NRI capital';
        EmpCapLbl69: Label 'Employment:';
        NoOfMenWorkerCap70: Label 'No. of Men Workers employed in the unit';
        ManagirialCap71: Label 'Managerial';
        NoOfWoMenWorkerCap72: Label 'No. of Women Workers employed in the unit';
        SkilledCap73: Label 'Skilled';
        UnSkilledCap74: Label 'Unskilled';
        TotalABCap75: Label 'Total:(a+b)';
        OtherInfoCap76: Label 'OTHER INFORMATION';
        OverSeasCap77: Label 'OverSeas Investment';
        OverSeasInvtCap78: Label 'Overseas investment made by the unit at the end of last year';
        LessThanCap79: Label 'Less than one year';
        AmountInCap80: Label 'Amount in';
        CasesOfPendCap81: Label 'Cases of pending Foreign Exchange';
        CasesOfPendrealiCap82: Label 'Cases of pending Foreign Exchange realization outstanding';
        ForMorethanCap83: Label 'for more than 180/360 days at the end of financial year';
        DateofExportCap84: Label 'Deta of Export:';
        NameofImporterCap85: Label 'Name of importer:';
        AddressCap86: Label 'Address:';
        AmountCap87: Label 'Amount:';
        EOSSpCap88: Label '(180 days for EOUs)';
        ExternalComCap89: Label 'External commercial borrowing';
        ExternalComPedCap90: Label 'External commercial borrowing pending at the  last years';
        Morethan3yearsCap91: Label 'More than three years';
        Lessthan3YearsCap92: Label 'Less than three years';
        RevenContriCap93: Label 'Revenue Contributions';
        RevenContUnitCap94: Label 'Revenue Contributions by units';
        ExciseDutyCap95: Label 'a) Excise duty on DTA sale during the financial year';
        IncomeTaxCap96: Label 'b) Income tax paid, if any, during the financial year';
        StateTaxCap97: Label 'c) State Taxes, cess duties & levies (including GST';
        StateTaxCap98: Label 'paid on domestic procurement).';
        TaxDeductCap99: Label 'd) Tax deducted at source in respect of employees.';
        SigNatureCap100: Label '(S I G N A T U R E)';
        WithSealCap101: Label 'Wilh Seal of Co.';
        NoteCap102: Label 'Notes :-';
        Note1CapLbl103: Label '1) The above information should be given separately for each Letter of Pemission.';
        Note2CapLbl104: Label '2) The infomation given in the formats for APRS should be authenticated by the authorized signatory of the unit and should be certified for its correctness by a chartered Accountant with reference to the account records and registers maintained by the unit.';
        Note3CapLbl105: Label '3) APRs must be submitted electronically only if the zones have provided online faclities.';
        Note4CapLbl106: Label '4) The signature of the authorised signalory of the unit must be sent to the zone electronically.';
        OpeningBal29Col: Decimal;
        PurchaseBal30Col: Decimal;

}
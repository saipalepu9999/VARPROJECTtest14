//B2BPROn15May2023<<<
report 50089 "Depreciation As Per Comp.Act"
{
    ApplicationArea = All;
    Caption = 'Depreciation As Per Comp.Act';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            trigger OnPreDataItem()
            begin
                CreateCaptions();
            end;

            trigger OnAfterGetRecord()
            begin
                //Tangible Assets
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('(a) Property, plant and equipment *', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                FixedAssetGRec.Reset();
                FixedAssetGRec.SetFilter("FA Class Code", '%1', 'TANGIBLE');
                if FixedAssetGRec.FindSet() then begin
                    repeat
                        NormalValues(FixedAssetGRec);
                    until FixedAssetGRec.Next() = 0;
                    CaptionVal := 'Total Property, plant and equipment (A)';
                    TotalValues(CaptionVal);
                    GrandTotalAsAtValue += TotalGrossAsAtValue;
                    GrandTotalAddValue += TotalGrossAddValue;
                    GrandTotalDelValue += TotalGrossDelValue;
                    GrandTotalGrossValue += TotalGBSumValue;
                    GrandTotalAccAsAtValue += TotalDepreAsAtValue;
                    GrandTotalAccAddValue += TotalDepreAddValue;
                    GrandTotalAccDelValue += TotalDepreDelValue;
                    GrandTotalAccValue += TotalADSumValue;
                    GrandTotalNetValue += TotalNBSumValue;
                    GrandTotalValue += TotalNetValue;
                end;
                Clear(TotalGrossAsAtValue);
                Clear(TotalGrossAddValue);
                Clear(TotalGrossDelValue);
                Clear(TotalGrossBlockVal);
                Clear(TotalDepreAsAtValue);
                Clear(TotalDepreAddValue);
                Clear(TotalDepreDelValue);
                Clear(TotalAccDepBlockVal);
                Clear(TotalNetBlockValue);
                Clear(TotalNetValue);
                Clear(TotalGBSumValue);
                Clear(TotalADSumValue);
                Clear(TotalNBSumValue);
                Clear(TotalNBValue);
                //In Tangible Assets
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('(b) Intangible assets', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                FixedAssetGRec.Reset();
                FixedAssetGRec.SetFilter("FA Class Code", '%1', 'INTANGIBLE');
                if FixedAssetGRec.FindSet() then begin
                    repeat
                        NormalValues(FixedAssetGRec);
                    until FixedAssetGRec.Next() = 0;
                    CaptionVal := 'Total intangibles assets (B)';
                    TotalValues(CaptionVal);
                    GrandTotalAsAtValue += TotalGrossAsAtValue;
                    GrandTotalAddValue += TotalGrossAddValue;
                    GrandTotalDelValue += TotalGrossDelValue;
                    GrandTotalGrossValue += TotalGBSumValue;
                    GrandTotalAccAsAtValue += TotalDepreAsAtValue;
                    GrandTotalAccAddValue += TotalDepreAddValue;
                    GrandTotalAccDelValue += TotalDepreDelValue;
                    GrandTotalAccValue += TotalADSumValue;
                    GrandTotalNetValue += TotalNBSumValue;
                    GrandTotalValue += TotalNetValue;
                end;
                Clear(TotalGrossAsAtValue);
                Clear(TotalGrossAddValue);
                Clear(TotalGrossDelValue);
                Clear(TotalGrossBlockVal);
                Clear(TotalDepreAsAtValue);
                Clear(TotalDepreAddValue);
                Clear(TotalDepreDelValue);
                Clear(TotalAccDepBlockVal);
                Clear(TotalNetBlockValue);
                Clear(TotalNetValue);
                //Clear(TotalNetValue);
                Clear(TotalGBSumValue);
                Clear(TotalADSumValue);
                Clear(TotalNBSumValue);
                Clear(TotalNBValue);
                //(c) Capital Work in Progress
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('(c) Capital Work in Progress', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                WorkInPro();
                CaptionVal := 'Total Capital Work in Progress (C)';
                TotalValues(CaptionVal);
                GrandTotalAsAtValue += TotalGrossAsAtValue;
                GrandTotalAddValue += TotalGrossAddValue;
                GrandTotalDelValue += TotalGrossDelValue;
                GrandTotalGrossValue += TotalGBSumValue;
                GrandTotalAccAsAtValue += TotalDepreAsAtValue;
                GrandTotalAccAddValue += TotalDepreAddValue;
                GrandTotalAccDelValue += TotalDepreDelValue;
                GrandTotalAccValue += TotalADSumValue;
                GrandTotalNetValue += TotalNBSumValue;
                GrandTotalValue += TotalNetValue;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Total (A+B+C)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(GrandTotalAsAtValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(GrandTotalAddValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(GrandTotalDelValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(GrandTotalGrossValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(GrandTotalAccAsAtValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(GrandTotalAccAddValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(GrandTotalAccDelValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(GrandTotalAccValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(GrandTotalNetValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(GrandTotalValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
            end;

            trigger OnPostDataItem()
            begin
                CreateBook();
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                    ShowCaption = false;
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    local Procedure CreateBook()
    begin
        ExcelBuffer.CreateBookAndOpenExcel('', 'Depreciation As Per CompAct.', '', '', USERID);
    end;

    procedure CreateCaptions()
    companyInfo: Record "Company Information";
    begin
        companyInfo.get();

        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(companyInfo.Name, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Notes to the financial statements', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('(All amounts in Indian Rupees (Rs.), except share data and where otherwise stated)', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('2.6 Property, plant and equipment and intangible assets', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Gross block', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Accumulated depreciation / amortisation', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Net block', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('As at 1 April ' + Format(Date2DMY(StartDate, 3)), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Additions', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Deletions', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('As at 1 April ' + Format(Date2DMY(StartDate, 3)), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Charge for the year', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Deletions', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('As at 31 March ' + Format(Date2DMY(StartDate, 3)), false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
    end;

    procedure NormalValues(FixedAssetPar: Record "Fixed Asset")
    begin
        Clear(DescriptionGvar);
        Clear(AsAtValueGross);
        Clear(AdditionsValue);
        Clear(DeletionsValue);
        Clear(AsAtValueAccDepre);
        Clear(ChargeForTheYearVal);
        Clear(DeletionAtAccValue);
        Clear(NetBlockValue);
        DescriptionGvar := FixedAssetGRec.Description;
        //Gross Block As At Value
        FALederEntryGrec.Reset();
        FALederEntryGrec.SetRange("FA No.", FixedAssetPar."No.");
        FALederEntryGrec.SetRange("FA Posting Type", FALederEntryGrec."FA Posting Type"::"Acquisition Cost");
        FALederEntryGrec.SetRange("FA Posting Category", FALederEntryGrec."FA Posting Category"::" ");
        FALederEntryGrec.SetFilter("Posting Date", '%1..%2', DMY2Date(31, 03, Date2DMY(StartDate, 3) - 1), DMY2Date(01, 04, Date2DMY(StartDate, 3)));
        if FALederEntryGrec.FindSet() then begin
            FALederEntryGrec.CalcSums(Amount);
            AsAtValueGross := Round(FALederEntryGrec.Amount, 1);
        end;
        //Gross Block Additions
        FALederEntryGrec.Reset();
        FALederEntryGrec.SetRange("FA No.", FixedAssetPar."No.");
        FALederEntryGrec.SetRange("FA Posting Type", FALederEntryGrec."FA Posting Type"::"Acquisition Cost");
        FALederEntryGrec.SetRange("FA Posting Category", FALederEntryGrec."FA Posting Category"::" ");
        FALederEntryGrec.SetFilter("Posting Date", '%1..%2', DMY2Date(01, 04, Date2DMY(StartDate, 3)), DMY2Date(31, 03, Date2DMY(StartDate, 3) + 1));
        if FALederEntryGrec.FindSet() then begin
            FALederEntryGrec.CalcSums(Amount);
            AdditionsValue := Round(FALederEntryGrec.Amount, 1);
        end;
        //Gross Block Deletions
        FALederEntryGrec.Reset();
        FALederEntryGrec.SetRange("FA No.", FixedAssetPar."No.");
        FALederEntryGrec.SetRange("FA Posting Type", FALederEntryGrec."FA Posting Type"::"Proceeds on Disposal");
        FALederEntryGrec.SetFilter("Posting Date", '%1..%2', DMY2Date(31, 03, Date2DMY(StartDate, 3) - 1), DMY2Date(01, 04, Date2DMY(StartDate, 3)));
        if FALederEntryGrec.FindSet() then begin
            FALederEntryGrec.CalcSums(Amount);
            DeletionsValue := abs(FALederEntryGrec.Amount);
        end;
        //Acc Dept. As At Value
        FALederEntryGrec.Reset();
        FALederEntryGrec.SetRange("FA No.", FixedAssetPar."No.");
        FALederEntryGrec.SetRange("FA Posting Type", FALederEntryGrec."FA Posting Type"::Depreciation);
        FALederEntryGrec.SetFilter("Posting Date", '%1..%2', DMY2Date(31, 03, Date2DMY(StartDate, 3) - 1), DMY2Date(01, 04, Date2DMY(StartDate, 3)));
        if FALederEntryGrec.FindSet() then begin
            FALederEntryGrec.CalcSums(Amount);
            AsAtValueAccDepre := Abs(FALederEntryGrec.Amount);
        end;
        //Acc Dept. Additions
        FALederEntryGrec.Reset();
        FALederEntryGrec.SetRange("FA No.", FixedAssetPar."No.");
        FALederEntryGrec.SetRange("FA Posting Type", FALederEntryGrec."FA Posting Type"::Depreciation);
        FALederEntryGrec.SetFilter("Posting Date", '%1..%2', DMY2Date(01, 04, Date2DMY(StartDate, 3)), DMY2Date(31, 03, Date2DMY(StartDate, 3) + 1));
        if FALederEntryGrec.FindSet() then begin
            FALederEntryGrec.CalcSums(Amount);
            ChargeForTheYearVal := Round(Abs(FALederEntryGrec.Amount), 1);
        end;
        //Acc Dept. Deletions
        FALederEntryGrec.Reset();
        FALederEntryGrec.SetRange("FA No.", FixedAssetPar."No.");
        FALederEntryGrec.SetRange("FA Posting Category", FALederEntryGrec."FA Posting Category"::Disposal);
        FALederEntryGrec.SetRange("FA Posting Type", FALederEntryGrec."FA Posting Type"::Depreciation);
        FALederEntryGrec.SetFilter("Posting Date", '%1..%2', DMY2Date(31, 03, Date2DMY(StartDate, 3) - 1), DMY2Date(01, 04, Date2DMY(StartDate, 3)));
        if FALederEntryGrec.FindSet() then begin
            FALederEntryGrec.CalcSums(Amount);
            DeletionAtAccValue := Abs(FALederEntryGrec.Amount);
        end;
        //Net Block
        FALederEntryGrec.Reset();
        FALederEntryGrec.SetRange("FA No.", FixedAssetPar."No.");
        FALederEntryGrec.SetRange("FA Posting Type", FALederEntryGrec."FA Posting Type"::"Acquisition Cost");
        FALederEntryGrec.SetFilter("Posting Date", '%1..%2', DMY2Date(31, 03, Date2DMY(StartDate, 3) - 1), DMY2Date(31, 03, Date2DMY(StartDate, 3)));
        if FALederEntryGrec.FindSet() then begin
            FALederEntryGrec.CalcSums(Amount);
            NetBlockValue := Round(Abs(FALederEntryGrec.Amount), 1);
        end;
        TotalGrossBlockVal := Abs(AsAtValueGross + AdditionsValue - DeletionsValue);
        TotalAccDepBlockVal := Abs(AsAtValueAccDepre + ChargeForTheYearVal - DeletionAtAccValue);
        TotalGrossAsAtValue += AsAtValueGross;
        TotalGrossAddValue += AdditionsValue;
        TotalGrossDelValue += DeletionsValue;
        TotalDepreAsAtValue += AsAtValueAccDepre;
        TotalDepreAddValue += ChargeForTheYearVal;
        TotalDepreDelValue += DeletionAtAccValue;
        TotalNetBlockValue := Abs(TotalGrossBlockVal - TotalAccDepBlockVal);
        TotalNetValue += NetBlockValue;
        TotalGBSumValue += TotalGrossBlockVal;
        TotalADSumValue += TotalAccDepBlockVal;
        TotalNBSumValue += TotalNetBlockValue;
        //TotalNBValue += TotalNetValue;
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(DescriptionGvar, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(AsAtValueGross, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(AdditionsValue, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DeletionsValue, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalGrossBlockVal, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(AsAtValueAccDepre, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ChargeForTheYearVal, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DeletionAtAccValue, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalAccDepBlockVal, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalNetBlockValue, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(NetBlockValue, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
    end;

    procedure TotalValues(CaptionPar: text)
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CaptionPar, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalGrossAsAtValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalGrossAddValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalGrossDelValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalGBSumValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalDepreAsAtValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalDepreAddValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalDepreDelValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalADSumValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalNBSumValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalNetValue, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Number);
    end;

    procedure WorkInPro()
    begin
        Clear(DescriptionGvar);
        Clear(AsAtValueGross);
        Clear(AdditionsValue);
        Clear(DeletionsValue);
        Clear(AsAtValueAccDepre);
        Clear(ChargeForTheYearVal);
        Clear(DeletionAtAccValue);
        Clear(NetBlockValue);
        GLAccountGrec.Reset();
        GLAccountGrec.SetRange("No.", '110110');
        if GLAccountGrec.FindFirst() then begin
            GLEntryGrec.Reset();
            GLEntryGrec.SetRange("G/L Account No.", GLAccountGrec."No.");
            GLEntryGrec.SetFilter("Posting Date", '%1..%2', DMY2Date(31, 03, Date2DMY(StartDate, 3) - 1), DMY2Date(01, 04, Date2DMY(StartDate, 3)));
            if GLEntryGrec.FindSet() then begin
                DescriptionGvar := GLEntryGrec.Description;
                GLEntryGrec.CalcSums(Amount);
                AsAtValueGross := Abs(GLEntryGrec.Amount);
            end;

            GLEntryGrec.Reset();
            GLEntryGrec.SetRange("G/L Account No.", GLAccountGrec."No.");
            GLEntryGrec.SetFilter("Posting Date", '%1..%2', DMY2Date(01, 04, Date2DMY(StartDate, 3)), DMY2Date(31, 03, Date2DMY(StartDate, 3) + 1));
            if GLEntryGrec.FindSet() then begin
                GLEntryGrec.CalcSums(Amount);
                AdditionsValue := Abs(GLEntryGrec.Amount);
            end;
        end;
        TotalWorkInDelValue := AsAtValueGross + AdditionsValue - 0;
        TotalWorkInNetVal := TotalWorkInDelValue;
        TotalGrossAsAtValue += AsAtValueGross;
        TotalGrossAddValue += AdditionsValue;
        TotalGrossDelValue += DeletionsValue;
        TotalDepreAsAtValue += AsAtValueAccDepre;
        TotalDepreAddValue += ChargeForTheYearVal;
        TotalDepreDelValue += DeletionAtAccValue;
        TotalNetBlockValue := TotalGrossBlockVal - TotalAccDepBlockVal;
        TotalNetValue += NetBlockValue;
        TotalGBSumValue += TotalWorkInDelValue;
        TotalADSumValue += TotalAccDepBlockVal;
        TotalNBSumValue += TotalWorkInNetVal;
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(DescriptionGvar, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(AsAtValueGross, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(AdditionsValue, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DeletionsValue, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalWorkInDelValue, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(AsAtValueAccDepre, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(ChargeForTheYearVal, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DeletionAtAccValue, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalAccDepBlockVal, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(TotalWorkInNetVal, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(NetBlockValue, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        AsAtValueGross: Decimal;
        AdditionsValue: Decimal;
        DeletionsValue: Decimal;
        AsAtValueAccDepre: Decimal;
        ChargeForTheYearVal: Decimal;
        DeletionAtAccValue: Decimal;
        TotalGrossBlockVal: Decimal;
        TotalAccDepBlockVal: Decimal;
        TotalProperValue: Decimal;
        TotalIntangibleVal: Decimal;
        TotalTangibleVal: Decimal;
        GrandTotalValue: Decimal;
        FixedAssetGRec: Record "Fixed Asset";
        DescriptionGvar: Code[100];
        StartDate: Date;
        FinancialYrStart: Date;
        FinancialYrEnd: Date;
        TotalGrossAsAtValue: Decimal;
        TotalGrossAddValue: Decimal;
        TotalGrossDelValue: Decimal;
        TotalDepreAsAtValue: Decimal;
        TotalDepreAddValue: Decimal;
        TotalDepreDelValue: Decimal;
        TotalNetBlockValue: Decimal;
        NetBlockValue: Decimal;
        TotalNetValue: Decimal;
        FALederEntryGrec: Record "FA Ledger Entry";
        CaptionVal: Text;
        GLEntryGrec: Record "G/L Entry";
        GLAccountGrec: Record "G/L Account";
        WorkInAsAtVal: Decimal;
        WorkInAddVal: Decimal;
        TotalWorkInDelValue: Decimal;
        TotalWorkInAddVal: Decimal;
        TotalWorkInGrossVal: Decimal;
        WorkInAccDelVal: Decimal;
        TotalWorkInNetVal: Decimal;
        WorkInNetTolVal: Decimal;
        GrandTotalAsAtValue: Decimal;
        GrandTotalAddValue: Decimal;
        GrandTotalDelValue: Decimal;
        GrandTotalAccAsAtValue: Decimal;
        GrandTotalAccAddValue: Decimal;
        GrandTotalAccDelValue: Decimal;
        GrandTotalGrossValue: Decimal;
        GrandTotalAccValue: Decimal;
        GrandTotalNetBlockVal: Decimal;
        GrandTotalNetValue: Decimal;
        TotalGBSumValue: Decimal;
        TotalADSumValue: Decimal;
        TotalNBSumValue: Decimal;
        TotalNBValue: Decimal;
}

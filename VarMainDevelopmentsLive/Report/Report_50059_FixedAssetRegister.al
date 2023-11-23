report 50059 "FA Register"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            trigger OnPreDataItem()
            begin
                CreateCaptions();
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(AcquisitionDateGvar);
                Clear(UsefulLifeInYearsGvar);
                Clear(OriginalCostGvar);
                Clear(SalvageValueGvar);
                Clear(DepreciationValueGvar);
                FixedAssetLedgEntries.Reset();
                FixedAssetLedgEntries.SetRange("FA No.", "Fixed Asset"."No.");
                FixedAssetLedgEntries.SetRange("FA Posting Type", FixedAssetLedgEntries."FA Posting Type"::"Acquisition Cost");
                if FixedAssetLedgEntries.FindLast() then begin
                    AcquisitionDateGvar := FixedAssetLedgEntries."Posting Date";
                end;
                FixedAssetLedgEntries.Reset();
                FixedAssetLedgEntries.SetRange("FA No.", "Fixed Asset"."No.");
                FixedAssetLedgEntries.SetRange("FA Posting Type", FixedAssetLedgEntries."FA Posting Type"::"Acquisition Cost");
                if FixedAssetLedgEntries.FindSet() then begin
                    repeat
                        OriginalCostGvar += abs(FixedAssetLedgEntries.Amount);
                    until FixedAssetLedgEntries.Next() = 0;
                end;
                FixedAssetLedgEntries.Reset();
                FixedAssetLedgEntries.SetRange("FA No.", "Fixed Asset"."No.");
                FixedAssetLedgEntries.SetRange("FA Posting Type", FixedAssetLedgEntries."FA Posting Type"::"Salvage Value");
                if FixedAssetLedgEntries.FindSet() then begin
                    repeat
                        SalvageValueGvar += abs(FixedAssetLedgEntries.Amount);
                    until FixedAssetLedgEntries.Next() = 0;
                end;
                FixedAssetDepBook.Reset();
                FixedAssetDepBook.SetRange("FA No.", "Fixed Asset"."No.");
                if FixedAssetDepBook.FindFirst() then begin
                    UsefulLifeInYearsGvar := FixedAssetDepBook."No. of Depreciation Years";
                end;
                FixedAssetLedgEntries.Reset();
                FixedAssetLedgEntries.SetRange("FA No.", "Fixed Asset"."No.");
                FixedAssetLedgEntries.SetRange("FA Posting Type", FixedAssetLedgEntries."FA Posting Type"::Depreciation);
                FixedAssetLedgEntries.SetFilter("Posting Date", '<%1', StartDateGvar);
                if FixedAssetLedgEntries.FindSet() then begin
                    repeat
                        DepreciationValueGvar += abs(FixedAssetLedgEntries.Amount);
                    until FixedAssetLedgEntries.Next() = 0;
                end;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn("Fixed Asset".Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(AcquisitionDateGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn(OriginalCostGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(UsefulLifeInYearsGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(UsefulLifeInYearsGvar * 365, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(SalvageValueGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(DepreciationValueGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                for I := 1 to ResultMonthGvar do begin
                    if i = 1 then
                        DateVar := StartDateGvar
                    else
                        DateVar := CalcDate('1M', DateVar);
                    ExcelBuffer.AddColumn('Dep as on' + Format(DateVar, 0, '<Month Text>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(StartDateGvar; StartDateGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Start Date';
                        trigger OnValidate()
                        begin
                            CalcResults();
                        end;
                    }
                    field(EndDateGvar; EndDateGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'End Date';
                        trigger OnValidate()
                        begin
                            CalcResults();
                        end;
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
        CLEAR(ExcelBuffer);
        ExcelBuffer.DELETEALL;
        CompanyInfo.Get();

    end;

    trigger OnPostReport()
    begin
        CreateBook();
    end;

    local Procedure CreateBook()
    begin
        ExcelBuffer.CreateBookAndOpenExcel('', 'FA Register', '', '', USERID);

    end;

    local procedure CalcResults()
    begin
        if (StartDateGvar <> 0D) and (EndDateGvar <> 0D) then begin
            DateGrec.Reset();
            DateGrec.SetRange("Period Type", DateGrec."Period Type"::Month);
            DateGrec.Setfilter("Period Start", '>=%1&<=%2', StartDateGvar, EndDateGvar);
            if DateGrec.FindSet() then begin
                ResultMonthGvar := DateGrec.Count;
            end;
        end;
    end;

    local procedure CreateCaptions()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('M/s.' + CompanyInfo.Name, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Fixed Asset Register updated till' + Format(EndDateGvar), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('FOR ASSETS EXISTING AS ON' + Format(EndDateGvar), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Description of Asset', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date of purchase of exsiting asset', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Original Cost', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('useful life in years', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('useful life in days ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('salvage value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Dep charged till date' + Format(StartDateGvar), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        for I := 1 to ResultMonthGvar do begin
            if i = 1 then
                DateVar := StartDateGvar
            else
                DateVar := CalcDate('1M', DateVar);
            ExcelBuffer.AddColumn('Dep charged till date' + Format(DateVar, 0, '<Month Text>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        end;

    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        StartDateGvar: Date;
        EndDateGvar: Date;
        ResultMonthGvar: Integer;
        DateGrec: Record Date;
        FixedAssetLedgEntries: Record "FA Ledger Entry";
        AcquisitionDateGvar: Date;
        OriginalCostGvar: Decimal;
        CompanyInfo: Record "Company Information";
        DateVar: Date;
        I: Integer;
        FixedAssetDepBook: Record "FA Depreciation Book";
        UsefulLifeInYearsGvar: Decimal;
        SalvageValueGvar: Decimal;
        DepreciationValueGvar: Decimal;
}
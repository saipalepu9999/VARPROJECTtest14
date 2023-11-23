//B2BMMOn12May2023 >>
report 50083 "Dept IT Act 1961"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Depreciation As per IT Act 1961';

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            trigger OnPreDataItem()
            begin
                makeexcelheader();
            end;

            trigger OnAfterGetRecord()
            var
            begin
                //0% Assets
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('0%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                FixedAssetGRec.Reset();
                FixedAssetGRec.SetFilter("FA Subclass Code", 'LAND');
                if FixedAssetGRec.FindSet() then begin
                    repeat
                        ExcelBody();
                    until FixedAssetGRec.Next() = 0;
                end;

                //10% Block-1 Assets
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('10.00%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('BLOCK 1', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                FixedAssetGRec.Reset();
                FixedAssetGRec.SetFilter("FA Subclass Code", 'BUILDING|FUN-FIX');
                if FixedAssetGRec.FindSet() then begin
                    repeat
                        ExcelBody();
                    until FixedAssetGRec.Next() = 0;
                end;

                //15% Block-2 Assets
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('15.00%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('BLOCK 2', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                FixedAssetGRec.Reset();
                FixedAssetGRec.SetFilter("FA Subclass Code", 'PLA-MAC|ELE-FIT');
                if FixedAssetGRec.FindSet() then begin
                    repeat
                        ExcelBody();
                    until FixedAssetGRec.Next() = 0;
                end;

                //40% Block-3 Assets
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('40.00%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('BLOCK 3', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                FixedAssetGRec.Reset();
                FixedAssetGRec.SetFilter("FA Subclass Code", 'COMPUTERS|VEHICLE');
                if FixedAssetGRec.FindSet() then begin
                    repeat
                        ExcelBody();
                    until FixedAssetGRec.Next() = 0;
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
                group(GroupName)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                        Caption = 'End Date';
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


    procedure makeexcelheader()
      CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get();


        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CompanyInfo.Name, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        IF (StartDate <> 0D) or (EndDate <> 0D) THEN
            ExcelBuffer.AddColumn('' + Format(StartDate, 5, '<year4>') + '-' + Format(EndDate, 5, '<year4>'), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('STATEMENT SHOWING COMPUTATION OF DEPRECIATION AS PER INCOME TAX ACT 1961', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Written Down', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Depreciation for the year ' + Format(StartDate, 5, '<year4>') + '-' + Format(EndDate, 5, '<year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Rate', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Particular', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Value as on ' + Format(StartDate, 10, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        IF (StartDate <> 0D) or (EndDate <> 0D) THEN
            ExcelBuffer.AddColumn('Additions during the year upto ' + Format(StartDate, 10, '<Day,2>/<Month,2>/<Year4>'), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        IF (StartDate <> 0D) or (EndDate <> 0D) THEN
            ExcelBuffer.AddColumn('Additions during the year from ' + Format(EndDate, 10, '<Day,2>/<Month,2>/<Year4>'), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Capitalization', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date put to use', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sale Price of assets sold', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Regular', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('On Additions', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Written down Value as on  ' + Format(EndDate, 10, '<Day,2>/<Month,2>/<Year4>'), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        /*ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('0%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('10.00%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('BLOCK 1', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('15.00%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('BLOCK 2', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('40.00%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('BLOCK 3', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Computers', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('GRAND TOTAL', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        */
    end;

    procedure ExcelBody()
    begin
        Clear(DescriptionGvar);
        Clear(DuringPeriodGvar);
        Clear(Start6MonthsGvar);
        Clear(After6MonthsGvar);
        DescriptionGvar := FixedAssetGRec.Description;
        FALedgEntryGRec.Reset();
        FALedgEntryGRec.SetRange("FA No.", FixedAssetGRec."No.");
        FALedgEntryGRec.SetFilter("Posting Date", '<%1', StartDate);
        if FALedgEntryGRec.FindSet() then begin
            FALedgEntryGRec.CalcSums(Amount);
            DuringPeriodGvar := FALedgEntryGRec.Amount;
        end;

        FALedgEntryGRec.Reset();
        FALedgEntryGRec.SetRange("FA No.", FixedAssetGRec."No.");
        FALedgEntryGRec.SetRange("Posting Date", StartDate, CalcDate('<6M>', StartDate));
        if FALedgEntryGRec.FindSet() then begin
            FALedgEntryGRec.CalcSums(Amount);
            Start6MonthsGvar := FALedgEntryGRec.Amount;
        end;

        FALedgEntryGRec.Reset();
        FALedgEntryGRec.SetRange("FA No.", FixedAssetGRec."No.");
        FALedgEntryGRec.SetRange("Posting Date", CalcDate('<+6M+1D>', StartDate), EndDate);
        if FALedgEntryGRec.FindSet() then begin
            FALedgEntryGRec.CalcSums(Amount);
            After6MonthsGvar := FALedgEntryGRec.Amount;
        end;
        TotalColGvar := Abs(DuringPeriodGvar + Start6MonthsGvar + After6MonthsGvar);
        TotalGvar3 += DuringPeriodGvar;
        TotalGvar4 += Start6MonthsGvar;
        TotalGvar5 += After6MonthsGvar;
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(DescriptionGvar, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(DuringPeriodGvar, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Start6MonthsGvar, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(After6MonthsGvar, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalColGvar, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure PrintTotals()
    begin

    end;

    LOCAL PROCEDURE CreateBook();
    BEGIN
        ExcelBuffer.CreateBookAndOpenExcel('', '2.6V', '', '', USERID);
    END;

    trigger OnPostReport()
    begin
        CreateBook();
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        StartDate: Date;
        EndDate: Date;
        FixedAssetGRec: Record "Fixed Asset";
        FALedgEntryGRec: Record "FA Ledger Entry";
        DescriptionGvar: Code[100];
        DuringPeriodGvar: Decimal;
        Start6MonthsGvar: Decimal;
        After6MonthsGvar: Decimal;
        TotalColGvar: Decimal;
        TotalGvar3: Decimal;
        TotalGvar4: Decimal;
        TotalGvar5: Decimal;
        TotalGvar6: Decimal;
        TotalGvar7: Decimal;
        TotalGvar8: Decimal;
        TotalGvar9: Decimal;
        TotalGvar10: Decimal;
        TotalGvar11: Decimal;
        TotalGvar12: Decimal;
        TotalGvar13: Decimal;
}
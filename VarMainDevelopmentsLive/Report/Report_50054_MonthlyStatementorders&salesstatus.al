
report 50054 "MonthlyStatement Orders Status"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Monthly Statement Orders & Sales Status';
    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            DataItemTableView = sorting(Number);
            trigger OnAfterGetRecord()
            begin
                SalesHeader.Reset();
                SalesHeader.SetFilter("Posting Date", '<=%1', StartDate);
                SalesHeader.SetRange("Shortcut Dimension 1 Code", 'DOM');
                if SalesHeader.FindSet() then begin
                    repeat
                        MakeDomesticExcelHeader();
                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetFilter("No.", '<>%1', '');
                        SalesLine.SetRange("Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 1 Code");
                        if SalesLine.FindSet() then
                            repeat
                                SubTotal += SalesLine."Line Amount";
                                PrintDomesticLines();
                            until SalesLine.Next() = 0;
                    until SalesHeader.Next() = 0;
                end;
                SalesHeader.Reset();
                SalesHeader.SetFilter("Posting Date", '<=%1', StartDate);
                SalesHeader.SetRange("Shortcut Dimension 1 Code", 'EOU');
                if SalesHeader.FindSet() then begin
                    repeat
                        MakeExportExcelHeaders();
                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetFilter("No.", '<>%1', '');
                        SalesLine.SetRange("Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 1 Code");
                        if SalesLine.FindSet() then
                            repeat
                                PrintExportLines();
                            until SalesLine.Next() = 0;
                    until SalesHeader.Next() = 0;
                end;
            end;

            trigger OnPreDataItem()
            begin

                if StartDate = 0D then
                    Error('Start Date must have a value.');
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Date Filters")
                {
                    field(StartDate; StartDate)
                    {
                        Caption = 'Date';
                        ApplicationArea = all;
                    }
                }
            }
        }
    }
    trigger OnPostReport()
    begin
        CreateBook();
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;

    procedure MakeDomesticExcelHeader()

    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        IF (StartDate <> 0D) THEN
            ExcelBuffer.AddColumn('DOMESTIC ORDERS AS ON   ' + Format(StartDate), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('P.O. No & Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Model', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Cost / Bty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Order Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TOTAL PROJECT VALUE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

    end;

    procedure MakeExportExcelHeaders()

    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        IF (StartDate <> 0D) THEN
            ExcelBuffer.AddColumn('EXPORT ORDERS AS ON   ' + Format(StartDate), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('P.O. No & Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Model', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Cost / Bty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Order Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TOTAL PROJECT VALUE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

    end;

    PROCEDURE CreateBook();
    BEGIN
        ExcelBuffer.CreateBookAndOpenExcel('', 'Monthly Statement Orders & Sales Status', '', '', USERID);
    END;

    local procedure PrintDomesticLines()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(SalesHeader."External Document No." + format(SalesHeader."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SalesHeader."Sell-to Customer Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SalesHeader."Shortcut Dimension 1 Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SalesLine.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SalesLine."Unit Price", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SalesLine."Line Amount", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SubTotal, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
    end;

    local procedure PrintExportLines()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(SalesHeader."External Document No." + format(SalesHeader."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SalesHeader."Sell-to Customer Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SalesHeader."Shortcut Dimension 1 Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SalesLine.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SalesLine."Unit Price", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SalesLine."Line Amount", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(SubTotal, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
    end;

    var
        myInt: Integer;

        Date1: Date;
        Date2: Date;
        StartDate: Date;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SubTotal: Decimal;

}


report 50058 SalesOrderStatusReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    Caption = 'Sales Order Status Report';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            trigger OnAfterGetRecord()
            begin
                //DOMESTIC ORDERS AS ON 01-01-2022-START
                MakeExcelDomesticCaption();
                SalesHeader.Reset();
                SalesHeader.SetCurrentKey("Posting Date");
                SalesHeader.SetRange("Posting Date", StartDate, EndDate);
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SetRange("Shortcut Dimension 1 Code", 'DOMESTIC');
                if SalesHeader.FindSet() then
                    repeat
                        SalesLine.Reset();
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetFilter("No.", '<>%1', '');
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        if SalesLine.FindSet() then
                            repeat
                                Clear(CGSTAmt);
                                Clear(IGSTAmt);
                                Clear(SGSTAmt);
                                GSTSetup.get();
                                GetGSTAmounts(TaxTransactionValue, SalesLine, GSTSetup);
                                ExcelBuffer.NewRow();
                                ExcelBuffer.AddColumn(SalesHeader."No." + format(SalesHeader."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(SalesHeader."Sell-to Customer Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(SalesHeader."Shortcut Dimension 1 Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(SalesLine.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(SalesLine."Unit Price", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(SalesLine."Line Amount", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(SalesLine."Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.NewRow();
                                ExcelBuffer.NewRow();
                            until SalesLine.Next() = 0;
                    until SalesHeader.Next() = 0;
                DemoSticTotalGvar += SalesLine."Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt;
                ExcelBuffer.NewRow();
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('Total', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(DemoSticTotalGvar, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                Clear(DemoSticTotalGvar);
                //DOMESTIC ORDERS AS ON 01-01-2022-END

                //EXPORT ORDERS AS ON 01-01-2022-START
                MakeExcelEXPORTCaption();
                SalesHeader.Reset();
                SalesHeader.SetCurrentKey("Posting Date");
                SalesHeader.SetRange("Posting Date", StartDate, EndDate);
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                SalesHeader.SetRange("Shortcut Dimension 1 Code", 'EOU');
                if SalesHeader.FindSet() then
                    SalesLine.Reset();
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange("No.", '<>%1', '');
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                repeat
                    Clear(CGSTAmt);
                    Clear(IGSTAmt);
                    Clear(SGSTAmt);
                    GSTSetup.get();
                    GetGSTAmounts(TaxTransactionValue, SalesLine, GSTSetup);
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn(SalesHeader."No." + format(SalesHeader."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesHeader."Sell-to Customer Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesHeader."Shortcut Dimension 1 Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine."Unit Price", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine."Line Amount", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine."Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.NewRow();
                until SalesHeader.Next() = 0;
                EouTotalGvar += SalesLine."Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt;
                ExcelBuffer.NewRow();
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('Total', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(EouTotalGvar, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.DeleteAll();
                //EXPORT ORDERS AS ON 01-01-2022_END

                //NEW  ORDER RECEIVED - DOMESTIC-START
                MakeCaptionNewOrderReceivedDemostic();
                SalesHeader.Reset();
                SalesHeader.SetCurrentKey("Order Date");
                SalesHeader.SetRange("Order Date", StartDate, EndDate);
                SalesHeader.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesHeader.SetRange("Shortcut Dimension 1 Code", 'DOMESTIC');
                if SalesHeader.FindSet() then
                    SalesLine.Reset();
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange("No.", '<>%1', '');
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                repeat
                    Clear(CGSTAmt);
                    Clear(IGSTAmt);
                    Clear(SGSTAmt);
                    GSTSetup.get();
                    GetGSTAmounts(TaxTransactionValue, SalesLine, GSTSetup);
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn(Format(SalesHeader."Order Date", 0, '<Month>-<Day>'), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn(SalesHeader."No." + format(SalesHeader."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesHeader."Sell-to Customer Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesHeader."Shortcut Dimension 1 Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine."Unit Price", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine."Line Amount", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine."Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.NewRow();
                until SalesHeader.Next() = 0;
                DemoSticTotalGvar += SalesLine."Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt;
                ExcelBuffer.NewRow();
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('Total', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(DemoSticTotalGvar, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                //NEW  ORDER RECEIVED - DOMESTIC-END

                //EXPORT SALES FOR 2021-22-START
                MakeExcelEXPORTCaption();
                SalesHeader.Reset();
                SalesHeader.SetCurrentKey("Order Date");
                SalesHeader.SetRange("Order Date", StartDate, EndDate);
                SalesHeader.SetRange("Document Type", SalesLine."Document Type"::Order);
                SalesHeader.SetRange("Shortcut Dimension 1 Code", 'EOU');
                if SalesHeader.FindSet() then
                    SalesLine.Reset();
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                SalesLine.SetRange("No.", '<>%1', '');
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                repeat
                    Clear(CGSTAmt);
                    Clear(IGSTAmt);
                    Clear(SGSTAmt);
                    GSTSetup.get();
                    GetGSTAmounts(TaxTransactionValue, SalesLine, GSTSetup);
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn(Format(SalesHeader."Order Date", 0, '<Month>-<Day>'), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn(SalesHeader."No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesHeader."Posting Date", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesHeader."Shortcut Dimension 1 Code", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine."Unit Price", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine."Line Amount", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(SalesLine."Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.NewRow();
                until SalesHeader.Next() = 0;
                EouTotalGvar += SalesLine."Line Amount" + IGSTAmt + CGSTAmt + SGSTAmt;
                ExcelBuffer.NewRow();
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(EouTotalGvar, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                //EXPORT SALES FOR 2021-22-END

                //SALES DETAILS FOR THE YEAR 2022'-STRAT
                SalesDetailsForTheYear();
                DateRec.Reset();
                DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
                DateRec.SetRange("Period Start", DMY2Date(1, 1, YearFilter), DMY2Date(01, 12, YearFilter));
                if DateRec.FindSet() then
                    repeat
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Order Date", StartDate, EndDate);
                        SalesHeader.SetRange("Document Type", SalesLine."Document Type"::Order);
                        SalesHeader.SetRange("Shortcut Dimension 1 Code", 'EOU');
                        if SalesHeader.FindSet() then
                            SalesLine.Reset();
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetRange("No.", '<>%1', '');
                        SalesLine.SetRange(Type, SalesLine.Type::Item);

                        ExcelBuffer.AddColumn(StrSubstNo('SALES AT THE END OF %1 %2', DateRec."Period Name", YearFilter), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(SalesLine.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(SalesLine.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(SalesLine."Unit Cost", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    until DateRec.Next() = 0;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(SalesLine.CalcSums(Quantity), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(SalesLine.CalcSums("Unit Cost"), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                //SALES DETAILS FOR THE YEAR 2022'-END

                //ORDER BOOK DETAILS FOR THE YEAR 2022 - START
                OrderBookDetailsForTheYear();
                DateRec.Reset();
                DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
                DateRec.SetRange("Period Start", DMY2Date(1, 1, YearFilter), DMY2Date(01, 12, YearFilter));
                if DateRec.FindSet() then
                    repeat
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Order Date", StartDate, EndDate);
                        SalesHeader.SetRange("Document Type", SalesLine."Document Type"::Order);
                        SalesHeader.SetRange("Shortcut Dimension 1 Code", 'EOU');
                        if SalesHeader.FindSet() then
                            SalesLine.Reset();
                        SalesLine.SetRange("Document No.", SalesHeader."No.");
                        SalesLine.SetRange("No.", '<>%1', '');
                        SalesLine.SetRange(Type, SalesLine.Type::Item);

                        ExcelBuffer.AddColumn(StrSubstNo('ORDERS AT THE END OF %1 %2', DateRec."Period Name", YearFilter), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(SalesLine.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(SalesLine.Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(SalesLine."Unit Cost", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    until DateRec.Next() = 0;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn('TOTAL ORDER BOOK DURING THE YEAR UPTO THE MONTH', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn('', FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                //ORDER BOOK DETAILS FOR THE YEAR 2022 - END
            end;

            trigger OnPreDataItem()
            begin
                if StartDate = 0D then
                    Error('Start Date must have a value.')
                else
                    if EndDate = 0D then
                        Error('End Date Must Have a Value');
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
                        Caption = 'Start Date';
                        ApplicationArea = All;
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
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
        ExcelBuffer.DELETEALL;
    end;

    procedure MakeExcelDomesticCaption()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('DOMESTIC ORDERS AS ON' + Format(EndDate), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('P.O. No & Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Model', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Cost / Bty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Order Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TOTAL PROJECT VALUE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeExcelEXPORTCaption()
    Begin
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('EXPORT ORDERS AS ON' + Format(EndDate), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('P.O. No & Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Model', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Cost / Bty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Order Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TOTAL PROJECT VALUE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    End;

    procedure MakeCaptionNewOrderReceivedDemostic()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('NEW  ORDER RECEIVED - DOMESTIC', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('P.O. No & Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customer', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Model', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Cost / Bty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total  Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TOTAL Order VALUE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeCaptionNewOrderReceivedFromASB()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('NEW  ORDER RECEIVED FROM ASB', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeCaptionEXPORTSalses()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('EXPORT SALES FOR 2021-22', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('INVOICE NO.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('INVOICE DATE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MODEL', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('RATE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('VALUE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Month Wise Sales', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure MakeCaptionDemosticSales()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('DOMESTIC SALES FOR 2021-22', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('INVOICE NO.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('INVOICE DATE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MODEL', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('RATE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('VALUE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TAX', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TOTAL VALUE', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Month Wise Sales', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure SalesDetailsForTheYear()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('SALES DETAILS FOR THE YEAR 2022', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('SALES', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('DOMESTIC', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PROJECT', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('EXPORT', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PROJECT', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TOTAL SALES', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('CUMULATIVE SALES', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    procedure OrderBookDetailsForTheYear()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('ORDER BOOK DETAILS FOR THE YEAR 2022', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(FORMAT(''), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('ORDERS', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TOTAL ORDERS', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TOTAL ORDERS', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('ASB ORDER BOOK', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('OTHERS ORDER BOOK', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('ORDER BOOK', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('ABS', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('OTHERS', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
   SalesLine: Record "Sales Line";
   GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];
    begin
        ComponentName := GetComponentName(SalesLine, GSTSetup);

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
                                SGSTPer := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                CGSTPer := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                IGSTPer := TaxTransactionValue.Percent;
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
        ExcelBuffer: Record "Excel Buffer" temporary;
        StartDate: Date;
        EndDate: Date;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        CGSTPer: Decimal;
        GstTotal: decimal;
        GstTotalSum: Decimal;
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        DemoSticTotalGvar: Decimal;
        EouTotalGvar: Decimal;
        SalesMonth: Integer;
        YearFilter: Integer;
        DateRec: Record Date;
}
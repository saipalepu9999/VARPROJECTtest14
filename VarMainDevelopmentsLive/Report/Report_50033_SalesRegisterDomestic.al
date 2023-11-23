report 50033 "Sales Register Domestic"

{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Sales Register (Domestic)';

    dataset
    {


        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            RequestFilterFields = "Posting Date";


            trigger OnPreDataItem()
            begin
                makeexcelheader();
                SetFilter("No.", '<>%1', '');
            end;

            trigger OnAfterGetRecord()
            var
                SalesShipLine: Record "Sales Shipment Line";
                OrderNo: Code[20];
                OrderDate: Date;
                SalesHdr: Record "Sales Header";
            begin
                if not SaleInvHdr.Get("Document No.") then
                    Clear(SaleInvHdr);

                if SaleInvHdr."GST Customer Type" = SaleInvHdr."GST Customer Type"::Export then
                    CurrReport.Skip();

                GetSalesGSTAmount("Sales Invoice Line");

                if not SalesShipLine.Get("Shipment No.", "Shipment Line No.") then
                    Clear(SalesShipLine);
                if (SalesHdr.Get(SalesHdr."Document Type", SalesShipLine."Order No.")) or
                   (SalesHdr.Get(SalesHdr."Document Type", "Order No.")) or
                   (SalesHdr.Get(SalesHdr."Document Type", SaleInvHdr."Order No."))
               then begin
                    OrderNo := SalesHdr."No.";
                    OrderDate := SalesHdr."Document Date";
                end else begin
                    OrderNo := SalesShipLine."Order No.";
                    OrderDate := SalesShipLine."Posting Date";
                end;


                SNo += 1;
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(SNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn(OrderNo, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(format(OrderDate, 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn("Document No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::text);
                ExcelBuffer.AddColumn(format(SaleInvHdr."Document Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn(SaleInvHdr."Sell-to Customer Name", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(SaleInvHdr."Sell-to Address", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(SaleInvHdr."Customer GST Reg. No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Description, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Quantity, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn("Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Quantity * "Unit Cost", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(CGSTPer, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(CGSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(SGSTPer, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(SGSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(IGSTPer, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(IGSSTAmt, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(TotalAmtTax, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Quantity * "Unit Cost" + TotalAmtTax, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
            end;


        }

    }

    local procedure GetSalesGSTAmount(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(CGSTPer);
        Clear(SGSTPer);
        Clear(IGSTPer);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(IGSSTAmt);
        Clear(CessAmt);
        Clear(TotalAmtTax);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
        if DetailedGSTLedgerEntry.FindSet() then begin
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = 'CGST') then begin
                    CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                    CGSTPer += DetailedGSTLedgerEntry."GST %";
                end;
                if (DetailedGSTLedgerEntry."GST Component Code" = 'SGST') then begin
                    SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                    SGSTPer += DetailedGSTLedgerEntry."GST %";
                end;
                if (DetailedGSTLedgerEntry."GST Component Code" = 'IGST') then begin
                    IGSSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                    IGSTPer += DetailedGSTLedgerEntry."GST %";
                end;
                if (DetailedGSTLedgerEntry."GST Component Code" = 'Cess') then
                    CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

            until DetailedGSTLedgerEntry.Next() = 0;
            TotalAmtTax += CGSTAmt + SGSTAmt + IGSSTAmt;
        end;
    end;






    procedure makeexcelheader()
    var
        CompanyInfo: Record "Company Information";
    begin
        CompanyInfo.Get();
        InitialzeAccountingPeriodDates();

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(CompanyInfo.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(StrSubstNo('SALES REGISTER FOR THE YEAR %1-%2 (Domestic)', Date2DMY(Date1, 3), Date2DMY(Date2, 3)), FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('S No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('SDC No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('SDC Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice. No ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Name of the Purchasing Dealer', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Address of the Purchasing Dealer', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('GSTIN', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Description of the Material', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty in Nos', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Gross Sales', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('CGST %', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('CGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('SGST %', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('SGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('IGST %', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('IGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Amount of Tax', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Invoice Amount in INR', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    LOCAL PROCEDURE CreateBook();
    BEGIN
        ExcelBuffer.CreateBookAndOpenExcel('', 'Sales Register Domestic', '', '', USERID);
    END;

    trigger OnPostReport()
    begin
        CreateBook();
    end;

    local procedure InitialzeAccountingPeriodDates()
    var
        AccountingPeriod: Record "Accounting Period";

    begin
        AccountingPeriod.RESET;
        AccountingPeriod.SETRANGE("New Fiscal Year", true);
        AccountingPeriod."Starting Date" := WorkDate();
        AccountingPeriod.FIND('=<');
        Date1 := AccountingPeriod."Starting Date";
        IF AccountingPeriod.NEXT = 0 THEN
            Date2 := 99991231D
        ELSE
            Date2 := AccountingPeriod."Starting Date" - 1;
    end;

    var
        SNo: Integer;
        GSTIN: Code[20];

        CustomerGRec: Record Customer;
        ExcelBuffer: Record "Excel Buffer" temporary;
        CompanyInfo: Record "Company Information";
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        CGSTAmt9: Decimal;
        SGSTAmt9: Decimal;
        IGSSTAmt9: Decimal;
        CessAmt: Decimal;
        CGSTAmt2: Decimal;
        SGSTAmt2: Decimal;
        IGSSTAmt2: Decimal;
        IGSSTAmt: Decimal;
        CGSTPer: Decimal;
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        TotalAmtTax: Decimal;
        AmtInclTax: Decimal;
        SaleInvHdr: Record "Sales Invoice Header";
        Date1: Date;
        Date2: Date;

}


report 50061 "SalesReport- Location Wise"
{
    ApplicationArea = All;
    Caption = 'SalesReport- Location Wise Domestic_50061';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\salesreport.rdl';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            // RequestFilterFields = "Posting Date";//B2BPROn19May2023<<<
            DataItemTableView = WHERE("Gst Customer Type" = filter(<> Export));//B2BPROn18May2023<<<
            column(Shipment_Date; format("Shipment Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(No_; "No.")
            { }
            column(CustomerAddress; CustomerGRec.Address)
            { }
            column(CustomerName; CustomerGRec.Name)
            { }
            column(CompanyInfoPic; CompanyInfo.Picture)
            { }
            column(LocationGSTRegNo; "Location GST Reg. No.")
            { }//B2BPROn18May2023<<<
            column(Title1CapLbl; Title1CapLbl)
            { }
            column(Title2CapLbl; Title2CapLbl)
            { }
            column(SlNoCapLbl; SlNoCapLbl)
            { }
            column(DateCapLbl; DateCapLbl)
            { }
            column(SdcNodatCapLbl; SdcNodatCapLbl)
            { }
            column(IncNodtCapLbl; IncNodtCapLbl)
            { }
            column(NameAddPurchDealerCapLbl; NameAddPurchDealerCapLbl)
            { }
            column(GSTINCapLbl; GSTINCapLbl)
            { }
            column(DescriptionMatrilCapLbl; DescriptionMatrilCapLbl)
            { }
            column(QtyNoCapLbl; QtyNoCapLbl)
            { }
            column(AmtCapLbl; AmtCapLbl)
            { }
            column(GrossSalesCapLbl; GrossSalesCapLbl)
            { }
            column(CGST9CapLbl; CGST9CapLbl)
            { }
            column(SGST9CapLbl; SGST9CapLbl)
            { }
            column(IGSST9CapLbl; IGSST9CapLbl)
            { }
            column(IGSSTCapLbl; IGSSTCapLbl)
            { }
            column(CGSTCapLbl; CGSTCapLbl)
            { }
            column(SGSTCapLbl; SGSTCapLbl)
            { }
            column(TotAmtTAxCaplbl; TotAmtTAxCaplbl)
            { }
            column(TotInvAmtINRCapLbl; TotInvAmtINRCapLbl)
            { }
            column(SalesRegForExText; SalesRegForExText)
            { }
            column(GSTRateLbl; GSTRateLbl)
            { }
            column(PerSysLbl; PerSysLbl)
            { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = FIELD("No.");
                column(Document_No_; "Document No.")
                { }
                column(Line_No_; "Line No.")
                { }
                column(Shipment_No_; "Shipment No.")
                { }
                column(Description; Description)
                { }
                column(Quantity; Quantity)
                { }
                column(UnitPrice; "Unit Price")
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(TotInvoAmnt; TotInvoAmnt)
                { }
                column(TotAmountTax; TotAmountTax)
                { }
                column(IGSTLbl; IGSTLbl)
                { }
                column(CGSTAmt9; CGSTAmt9)
                { }
                column(SGSTAmt9; SGSTAmt9)
                { }
                column(CGSTAmt2; CGSTAmt2)
                { }
                column(SGSTAmt2; SGSTAmt2)
                { }
                column(IGSSTAmt2; IGSSTAmt2)
                { }
                column(IGSSTAmt9; IGSSTAmt9)
                { }
                column(IGSSTAmt; IGSSTAmt)
                { }
                column(Totalsales; Totalsales)
                { }
                column(Unit_Price; "Unit Price")
                { }
                column(GrossSales; GrossSales)
                { }
                column(GSTIN; GSTIN)
                { }
                column(CustomerGRecReg; CustomerGRec."GST Registration No.")
                { }
                column(CGSTAmt; CGSTAmt)
                { }
                column(SGSTAmt; SGSTAmt)
                { }
                column(CGSTPer; CGSTPer)
                { }
                column(SGSTPer; SGSTPer)
                { }
                column(IGSTPer; IGSTPer)
                { }
                trigger OnAfterGetRecord()
                begin

                    Clear(TotInvoAmnt);
                    Clear(CustomerGrec);
                    Clear(TotGrossSales);
                    Clear(TotCGSTAmt2);
                    Clear(TotSGSTAmt2);
                    Clear(TotCGSTAMT9);
                    Clear(TotSGSTAMT9);
                    Clear(TotAmountTax);
                    if CustomerGrec.Get("Sales Invoice Header"."Sell-to Customer No.") then
                        GetSalesGSTAmount("Sales Invoice Header", "Sales Invoice Line");
                    //TotAmountTax := CGSTAmt9 + SGSTAmt9 + CGSTAmt2 + SGSTAmt2;
                    TotAmountTax := CGSTAmt + SGSTAmt + IGSSTAmt;
                    TotInvoAmnt := GrossSales + TotAmountTax;
                    Totalsales := "Sales Invoice Line".Quantity;
                    GrossSales := "Sales Invoice Line"."Unit Price" * "Sales Invoice Line".Quantity;

                    CustomerGRec.Reset();
                    CustomerGRec.SetRange("No.", "No.");
                    If CustomerGRec.FindSet() then
                        GSTIN := CustomerGRec."GST Registration No.";
                end;
            }

            trigger OnPreDataItem()
            begin
                SetFilter("Currency Code", '%1', '');
                SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                //PostDateMax := GetRangeMax("Posting Date");
                //PostDateMin := GetRangeMin("Posting Date");
                SetCurrentKey("Posting Date");
                MinDateGvar := Date2DMY(StartDate, 3);
                MaxDateGvar := Date2DMY(EndDate, 3)
            end;

            trigger OnAfterGetRecord()
            begin

                //SalesRegForExText := StrSubstNo(Title2CapLbl, Format(PostDateMin, 0, '<Year4>-<Month Text>'), Format(PostDateMax, 0, '<Year4>-<Month Text>'));
                SalesRegForExText := StrSubstNo(Title2CapLbl, MinDateGvar, MaxDateGvar)
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
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;


    local procedure GetSalesGSTAmount(SalesInvoiceHeader: Record "Sales Invoice Header";
           SalesInvoiceLine: Record "Sales Invoice Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin

        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(IGSSTAmt);
        Clear(CessAmt);
        clear(CGSTPer);
        Clear(SGSTPer);
        Clear(IGSTPer);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
        if DetailedGSTLedgerEntry.FindSet() then begin
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then begin
                    CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                    CGSTPer := DetailedGSTLedgerEntry."GST %";

                end;
                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then begin
                    SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                    SGSTPer := DetailedGSTLedgerEntry."GST %";

                end;

                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then begin
                    IGSSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                    IGSTPer := DetailedGSTLedgerEntry."GST %";

                end;

                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then
                    CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

            until DetailedGSTLedgerEntry.Next() = 0;

        end;
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
        MinDateGvar: Integer;
        MaxDateGvar: Integer;
        StartDate: Date;
        EndDate: Date;
        Totalsales: Integer;
        salesshpthdr: Record "Sales Shipment Header";
        salsshptLine: Record "Sales Shipment Line";
        CustomerGRec: Record Customer;
        CompanyInfo: Record "Company Information";
        customer: Record Customer;
        TotInvoAmnt: Decimal;
        TotGrossSales: Decimal;
        TotCGSTAmt2: Decimal;
        TotSGSTAmt2: Decimal;
        TotCGSTAMT9: Decimal;
        TotSGSTAMT9: Decimal;
        TotAmountTax: Decimal;
        CGSTAmt9: Decimal;
        SGSTAmt9: Decimal;
        CGSTAmt2: Decimal;
        SGSTAmt2: Decimal;
        IGSSTAmt2: Decimal;
        IGSSTAmt9: Decimal;
        GrossSales: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        Title1CapLbl: Label 'VAR ELECTROCHEM PRIVATE LIMITED';
        Title2CapLbl: Label 'SALES REGISTER FOR THE YEAR %1-%2 (DOMESTIC)';
        SalesRegForExText: Text;
        SlNoCapLbl: Label 'SI No.';
        DateCapLbl: Label 'Date';
        SdcNodatCapLbl: Label 'SDC No. & Dt';
        IncNodtCapLbl: Label 'Invoice.No & Dt';
        NameAddPurchDealerCapLbl: Label 'Name and address of the Purchasing Dealer';
        GSTINCapLbl: Label 'GSTIN';
        DescriptionMatrilCapLbl: Label 'Description of the Material';
        QtyNoCapLbl: Label 'Qty in Nos';
        AmtCapLbl: Label 'Amount';
        GrossSalesCapLbl: Label 'Gross Sales';
        CGST9CapLbl: Label 'CGST';
        SGST9CapLbl: Label 'SGST';
        IGSST9CapLbl: Label 'IGST';
        CGSTCapLbl: Label 'CGST 2.5%';
        SGSTCapLbl: Label 'SGST 2.5%';
        IGSSTCapLbl: Label 'IGSST 2.5%';
        TotAmtTAxCaplbl: Label 'Total Amount of Tax';
        TotInvAmtINRCapLbl: Label 'Total Invoice Amount in INR';
        GSTIN: Code[20];
        IGSTLbl: Label 'IGST';
        IGSSTAmt: Decimal;
        CESSLbl: Label 'CESS';
        CessAmt: Decimal;
        CGSTPer: Decimal;
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        PostDateMax: Date;
        PostDateMin: Date;
        GSTRateLbl: Label 'GST Rate';
        PerSysLbl: Label '%';
}

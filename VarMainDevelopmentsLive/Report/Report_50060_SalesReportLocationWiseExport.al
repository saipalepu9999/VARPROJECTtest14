report 50060 "Sales Report Loc Wise Export"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sales Report Location Wise Export';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\SalesLocWiseExport.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "Location GST Reg. No.";
            DataItemTableView = WHERE("Gst Customer Type" = const(Export));
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(External_Document_No_; "External Document No.")
            { }
            column(No_; "No.")
            { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            { }
            column(CustomerAddress; CustomerGRec.Address)
            { }
            column(CustomerName; CustomerGRec.Name)
            { }
            column(CompanyInfoName; CompanyInfo.Name)
            { }
            column(CompanyInfoAdd; CompanyInfo.Address)
            { }
            column(Locatio_Address; LocationGRec.Address)//B2BSSD09Jan2023
            { }
            column(CompanyInfoPic; CompanyInfo.Picture)
            { }
            column(SalesRegisterForYearCapLbl; SalesRegisterForYearCapLbl)
            { }
            column(SNLCapLbl; SNLCapLbl)
            { }
            column(DateCapLbl; DateCapLbl)
            { }
            column(SdcCapLbl; SdcCapLbl)
            { }
            column(InvoiceCapLbl; InvoiceCapLbl)
            { }
            column(NameAddCapLbl; NameAddCapLbl)
            { }
            column(DescofMatCapLbl; DescofMatCapLbl)
            { }
            column(QtyCapLbl; QtyCapLbl)
            { }
            column(AmountCapLbl; AmountCapLbl)
            { }
            column(GrossSalCapLbl; GrossSalCapLbl)
            { }
            column(CgstCapLbl; CgstCapLbl)
            { }
            column(SgstCapLbl; SgstCapLbl)
            { }
            column(IgstCapLbl; IgstCapLbl)
            { }
            column(TotalAmuntTaxCapLbl; TotalAmuntTaxCapLbl)
            { }
            column(TotalInvoAmntInrCapLbl; TotalInvoAmntInrCapLbl)
            { }
            column(Currency_Code; "Currency Code")
            { }
            column(SalesRegForExText; SalesRegForExText)
            { }
            column(GSTRateLbl; GSTRateLbl)
            { }
            column(PerSysLbl; PerSysLbl)
            { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                // RequestFilterFields = "Document No.";//B2BSSD10MAY2023
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = field("No.");

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
                column(Amount; Amount)
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(CGSTAmt; CGSTAmt)
                { }
                column(IGSTAmt; IGSSTAmt)
                { }
                column(SGSTAmt; SGSTAmt)
                { }
                column(TotalGst; TotalGst)
                { }
                column(TotInvoAmnt; TotInvoAmnt)
                { }
                column(Unit_Price; "Unit Price")
                { }
                column(InrAmount; InrAmount)
                { }
                column(InrGrossSales; InrGrossSales)
                { }
                column(CGSTAmtInr; CGSTAmtInr)
                { }
                column(SGSTAmtInr; SGSTAmtInr)
                { }
                column(IGSSTAmtInr; IGSSTAmtInr)
                { }
                column(TotalGstInrAmount; TotalGstInrAmount)
                { }
                column(TotInvoAmntInrAmount; TotInvoAmntInrAmount)
                { }
                column(ShipmentDate_SalesInvoiceLine; "Shipment Date")
                {
                }
                column(CGSTPer; CGSTPer)
                { }
                column(SGSTPer; SGSTPer)
                { }
                column(IGSTPer; IGSTPer)
                { }

                trigger OnAfterGetRecord()
                begin
                    Clear(TotalGst);
                    Clear(TotInvoAmnt);
                    Clear(CustomerGrec);
                    Clear(InrAmount);
                    Clear(InrGrossSales);
                    Clear(CGSTAmtInr);
                    Clear(SGSTAmtInr);
                    Clear(IGSSTAmtInr);
                    Clear(TotalGstInrAmount);
                    Clear(TotInvoAmntInrAmount);
                    //B2BSSD09Jan2023<<
                    Clear(LocationGRec);
                    if LocationGRec.get("Location Code") then;
                    //B2BSSD09Jan2023>>
                    if CustomerGrec.Get("Sales Invoice Header"."Sell-to Customer No.") then;
                    GetSalesGSTAmount("Sales Invoice Header", "Sales Invoice Line");
                    TotalGst := CGSTAmt + IGSSTAmt + SGSTAmt;
                    TotInvoAmnt := TotalGst + "Line Amount";
                    if "Sales Invoice Header"."Currency Factor" <> 0 then begin
                        InrAmount := (("Unit Price") / "Sales Invoice Header"."Currency Factor");
                        InrGrossSales := (("Line Amount") / "Sales Invoice Header"."Currency Factor");
                        CGSTAmtInr := ((CGSTAmt) / "Sales Invoice Header"."Currency Factor");
                        SGSTAmtInr := ((SGSTAmt) / "Sales Invoice Header"."Currency Factor");
                        IGSSTAmtInr := ((IGSSTAmt) / "Sales Invoice Header"."Currency Factor");
                        TotalGstInrAmount := (CGSTAmtInr + IGSSTAmtInr + SGSTAmtInr);
                        TotInvoAmntInrAmount := (TotalGstInrAmount + InrGrossSales);
                    end
                end;
            }
            trigger OnPreDataItem()
            begin

                SetFilter("Currency Code", '<>%1', '');
                SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                //PostDateMax := GetRangeMax("Posting Date");
                //PostDateMin := GetRangeMin("Posting Date");
                SetCurrentKey("Posting Date");
                MinDateGvar := Date2DMY(StartDate, 3);
                MaxDateGvar := Date2DMY(EndDate, 3)

            end;

            trigger OnAfterGetRecord()
            begin
                //SalesRegForExText := StrSubstNo(SalesRegisterForYearCapLbl, Format(PostDateMin, 0, '<Year4>-<Month Text>'), Format(PostDateMax, 0, '<Year4>-<Month Text>'));
                SalesRegForExText := StrSubstNo(SalesRegisterForYearCapLbl, MinDateGvar, MaxDateGvar);
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
                    ToolTip = 'Executes the ActionName action.';

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
        Clear(IGSSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(CessAmt);
        Clear(SGSTPer);
        Clear(CGSTPer);
        Clear(IGSTPer);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", SalesInvoiceLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
        if DetailedGSTLedgerEntry.FindSet() then begin
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then begin
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    CGSTPer := DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then begin
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        CGSTPer := DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then begin
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    SGSTPer := DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then begin
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        SGSTPer := DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (SalesInvoiceHeader."Currency Code" <> '') then begin
                    IGSSTAmt := Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    IGSTPer := DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then begin
                        IGSSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
                        IGSTPer := DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (SalesInvoiceHeader."Currency Code" <> '') then
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * SalesInvoiceHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
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
        InrAmount: Decimal;
        InrGrossSales: Decimal;
        CGSTAmtInr: Decimal;
        IGSSTAmtInr: Decimal;
        SGSTAmtInr: Decimal;
        TotInvoAmnt: Decimal;
        TotalGst: Decimal;
        TotalGstInrAmount: Decimal;
        TotInvoAmntInrAmount: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        CGSTPer: Decimal;
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';

        SalesShpmnthdr: Record "Sales Shipment Header";
        SalesShpmntline: Record "Sales Shipment Line";
        CustomerGRec: Record Customer;
        CompanyInfo: Record "Company Information";
        SalesRegisterForYearCapLbl: Label 'SALES REGISTER FOR THE YEAR %1-%2(EXPORT)';
        SalesRegForExText: Text;
        SNLCapLbl: Label 'SI.NO';
        DateCapLbl: Label 'Date';
        SdcCapLbl: Label 'SDC NO. & Dt';
        InvoiceCapLbl: Label 'Invoice No.';
        NameAddCapLbl: Label 'Name & address of the Purchasing Dealer';
        DescofMatCapLbl: Label 'Description of the Material';
        QtyCapLbl: Label 'Qty in Nos';
        AmountCapLbl: Label 'Amount';
        GrossSalCapLbl: Label 'Gross Sales';
        CgstCapLbl: Label 'CGST';
        SgstCapLbl: Label 'SGST';
        IgstCapLbl: Label 'IGST';
        TotalAmuntTaxCapLbl: Label 'Total Amount of Tax';
        TotalInvoAmntInrCapLbl: Label 'Total Invoice Amount in INR';
        LocationGRec: Record Location;//B2BSSD09Jan2023
        PostingDate1Cap: Text;
        PostDateMax: Date;
        PostDateMin: Date;
        GSTRateLbl: Label 'GST Rate';
        PerSysLbl: Label '%';
}
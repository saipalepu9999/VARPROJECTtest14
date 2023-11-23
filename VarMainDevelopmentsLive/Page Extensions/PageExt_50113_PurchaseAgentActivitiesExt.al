pageextension 50113 PurchaseAgentActivitiesExt extends "Purchase Agent Activities"
{
    layout
    {
        modify("Upcoming Orders")
        {
            Visible = false;
        }
        addlast("Purchase Orders - Authorize for Payment")
        {
            field(IndentsPendingForPo; IndentsPendingForPo)
            {
                ApplicationArea = all;
                //Visible = false;
                Caption = 'Indents Pending For Purchase Orders';
                ToolTip = 'Specifies the value of the Indents Pending For Purchase Orders field.';
                trigger OnDrillDown()
                var
                    PurchaseHedaer: Record "Purchase Header";
                    IndentHedaer: Record "Indent Header";
                    Indentlist: Page "Indent List";
                begin
                    IndentHedaer.Reset();
                    if IndentHedaer.FindSet() then
                        repeat
                            PurchaseHedaer.Reset();
                            PurchaseHedaer.SetRange("Document Type", PurchaseHedaer."Document Type"::Order);
                            PurchaseHedaer.SetRange("Indent No.", IndentHedaer."No.");
                            if not PurchaseHedaer.FindFirst() then
                                IndentHedaer.Mark(true);
                        until IndentHedaer.Next() = 0;
                    IndentHedaer.MarkedOnly(true);
                    if IndentHedaer.FindSet() then
                        Indentlist.SetTableView(IndentHedaer);
                    Indentlist.RunModal();
                end;
            }
            field(QuoteCompPendingForPo; QuoteCompPendingForPo)
            {
                ApplicationArea = all;
                Caption = 'Quotation Comparisio Pending For Po';
                trigger OnDrillDown()
                var
                    QuotationComparision: Record QuotCompHdr;
                    QuoteCompList: Page "Quotation Comparisions";
                begin
                    QuotationComparision.Reset();
                    QuotationComparision.SetRange("Orders Created", false);
                    if QuotationComparision.FindSet() then;
                    QuoteCompList.SetTableView(QuotationComparision);
                    QuoteCompList.RunModal();
                end;
            }
            field(VendorCertificateWarrenty; VendorCertificateWarrenty)
            {
                ApplicationArea = all;
                Caption = 'Vendor Test Report/Warranty Certificates - Pending from Vendor';
                trigger OnDrillDown()
                var
                    InspectionReceipt: Record "Inspection Receipt Header B2B";
                    InspectionReceiptList: page "Inspection Receipt List B2B";
                begin
                    InspectionReceipt.Reset();
                    InspectionReceipt.SetRange(Status, false);
                    InspectionReceipt.SetFilter("QC Certificate(s) Status", '<>%1|<>%2', InspectionReceipt."QC Certificate(s) Status"::"Not Required", InspectionReceipt."QC Certificate(s) Status"::Available);
                    if InspectionReceipt.FindSet() then;
                    InspectionReceiptList.SetTableView(InspectionReceipt);
                    InspectionReceiptList.RunModal();
                end;
            }
            field(PurchaseReceiptNotInvoiced; PurchaseReceiptNotInvoiced)
            {
                Caption = 'Purchase Receipts Posted But Not Invoiced';
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Purchase Receipts Posted But Not Invoiced field.';
                trigger OnDrillDown()
                var
                    PurchReceiptLines: Record "Purch. Rcpt. Line";
                    PurchReceiptHeader: Record "Purch. Rcpt. Header";
                    PostedPurchaseReceiptList: Page "Posted Purchase Receipts";
                begin
                    PurchReceiptLines.Reset();
                    if PurchReceiptLines.FindSet() then
                        repeat
                            if PurchReceiptLines."Quantity Invoiced" <> PurchReceiptLines.Quantity then begin
                                if PurchReceiptHeader.Get(PurchReceiptLines."Document No.") then
                                    PurchReceiptHeader.mark(true);
                            end;
                        until PurchReceiptLines.Next() = 0;
                    PurchReceiptHeader.MarkedOnly(true);
                    if PurchReceiptHeader.FindSet() then;
                    PostedPurchaseReceiptList.SetTableView(PurchReceiptHeader);
                    PostedPurchaseReceiptList.RunModal();
                end;
            }
            field(ExcessQtyDeliveredPos; ExcessQtyDeliveredPos)
            {
                ApplicationArea = all;
                Caption = 'Excess Quantity Delivered Pos';
                trigger OnDrillDown()
                var
                    PurchaseHeaderLrec: Record "Purchase Header";
                    PurchaseLineLrec: Record "Purchase Line";
                    DocumentNoLvar: Text;
                    PurchaseOrderList: Page "Purchase Order List";
                begin
                    PurchaseLineLrec.Reset();
                    PurchaseLineLrec.SetRange("Document Type", PurchaseLineLrec."Document Type"::Order);
                    PurchaseLineLrec.SetFilter("No.", '<>%1', '');
                    PurchaseLineLrec.SetFilter("Over-Receipt Quantity", '<>%1', 0);
                    PurchaseLineLrec.SetCurrentKey("Document No.");
                    if PurchaseLineLrec.FindSet() then
                        repeat
                            if DocumentNoLvar <> PurchaseLineLrec."Document No." then begin
                                DocumentNoLvar := PurchaseLineLrec."Document No.";
                                if PurchaseHeaderLrec.get(PurchaseLineLrec."Document Type", PurchaseLineLrec."Document No.") then
                                    PurchaseHeaderLrec.Mark(true);
                            end;
                        until PurchaseLineLrec.Next() = 0;
                    PurchaseHeaderLrec.MarkedOnly(true);
                    if PurchaseHeaderLrec.FindSet() then;
                    PurchaseOrderList.SetTableView(PurchaseHeaderLrec);
                    PurchaseOrderList.RunModal();
                end;
            }
        }
        addafter("Purchase Orders - Authorize for Payment")
        {
            cuegroup(Indents)
            {
                Caption = 'Indents';
                field(OpenIndentGvar; OpenIndentGvar)
                {
                    Caption = 'Open Indents';
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        IndentHeader: Record "Indent Header";
                    begin
                        IndentHeader.Reset();
                        IndentHeader.SetRange("Indent Status", IndentHeader."Indent Status"::Indent);
                        if IndentHeader.FindSet() then begin
                            Page.RunModal(Page::"Indent List", IndentHeader);
                        end;
                    end;
                }
                field(CloseIndentGvar; CloseIndentGvar)
                {
                    Caption = 'Close Indents';
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        IndentHeader: Record "Indent Header";
                    begin
                        IndentHeader.Reset();
                        IndentHeader.SetRange("Indent Status", IndentHeader."Indent Status"::Close);
                        if IndentHeader.FindSet() then begin
                            Page.RunModal(Page::"Indent List", IndentHeader);
                        end;
                    end;
                }
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }
    procedure IndentsPendingPos()
    var
        IndentHedaer: Record "Indent Header";
        PurchaseHedaer: Record "Purchase Header";
    begin
        IndentHedaer.Reset();
        if IndentHedaer.FindSet() then
            repeat
                PurchaseHedaer.Reset();
                PurchaseHedaer.SetRange("Document Type", PurchaseHedaer."Document Type"::Order);
                PurchaseHedaer.SetRange("Indent No.", IndentHedaer."No.");
                if not PurchaseHedaer.FindFirst() then
                    IndentHedaer.Mark(true);
            until IndentHedaer.Next() = 0;
        IndentHedaer.MarkedOnly(true);
        if IndentHedaer.FindSet() then
            IndentsPendingForPo := IndentHedaer.Count;
    end;

    procedure QuotationComparisionListPendingForPo()
    var
        QuotationComparision: Record QuotCompHdr;
        QuoteCompList: Page "Quotation Comparisions";
    begin
        QuotationComparision.Reset();
        QuotationComparision.SetRange("Orders Created", false);
        if QuotationComparision.FindSet() then
            QuoteCompPendingForPo := QuotationComparision.Count;

    end;

    procedure VendortestCertificate()
    var
        InspectionReceipt: Record "Inspection Receipt Header B2B";
        InspectionReceiptList: page "Inspection Receipt List B2B";
    begin
        InspectionReceipt.Reset();
        InspectionReceipt.SetRange(Status, false);
        InspectionReceipt.SetFilter("QC Certificate(s) Status", '<>%1|<>%2', InspectionReceipt."QC Certificate(s) Status"::"Not Required", InspectionReceipt."QC Certificate(s) Status"::Available);
        if InspectionReceipt.FindSet() then
            VendorCertificateWarrenty := InspectionReceipt.Count;

    end;

    procedure PurchaseReceiptsPostedNotInvoiced()
    var
        PurchReceiptLines: Record "Purch. Rcpt. Line";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        PostedPurchaseReceiptList: Page "Posted Purchase Receipts";
    begin
        PurchReceiptLines.Reset();
        if PurchReceiptLines.FindSet() then
            repeat
                if PurchReceiptLines."Quantity Invoiced" <> PurchReceiptLines.Quantity then begin
                    if PurchReceiptHeader.Get(PurchReceiptLines."Document No.") then
                        PurchReceiptHeader.mark(true);
                end;
            until PurchReceiptLines.Next() = 0;
        PurchReceiptHeader.MarkedOnly(true);
        if PurchReceiptHeader.FindSet() then
            PurchaseReceiptNotInvoiced := PurchReceiptHeader.Count;
    end;

    procedure ExcessQuantitiesDeliverdPos()
    var
        PurchaseHeaderLrec: Record "Purchase Header";
        PurchaseLineLrec: Record "Purchase Line";
        DocumentNoLvar: Text;
        PurchaseOrderList: Page "Purchase Order List";
    begin
        PurchaseLineLrec.Reset();
        PurchaseLineLrec.SetRange("Document Type", PurchaseLineLrec."Document Type"::Order);
        PurchaseLineLrec.SetFilter("No.", '<>%1', '');
        //PurchaseLineLrec.SetFilter("Over-Receipt Quanity", '<>%1', 0);
        PurchaseLineLrec.SetFilter("Over-Receipt Quantity", '<>%1', 0);
        PurchaseLineLrec.SetCurrentKey("Document No.");
        if PurchaseLineLrec.FindSet() then
            repeat
                if DocumentNoLvar <> PurchaseLineLrec."Document No." then begin
                    DocumentNoLvar := PurchaseLineLrec."Document No.";
                    if PurchaseHeaderLrec.get(PurchaseLineLrec."Document Type", PurchaseLineLrec."Document No.") then
                        PurchaseHeaderLrec.Mark(true);
                end;
            until PurchaseLineLrec.Next() = 0;
        PurchaseHeaderLrec.MarkedOnly(true);
        if PurchaseHeaderLrec.FindSet() then
            ExcessQtyDeliveredPos := PurchaseHeaderLrec.Count;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        IndentsPendingPos();
        QuotationComparisionListPendingForPo();
        VendortestCertificate();
        PurchaseReceiptsPostedNotInvoiced();
        ExcessQuantitiesDeliverdPos();
    end;

    trigger OnAfterGetRecord()
    var
        IndentHeader: Record "Indent Header";
    begin
        Clear(OpenIndentGvar);
        Clear(CloseIndentGvar);
        IndentHeader.Reset();
        IndentHeader.SetRange("Indent Status", IndentHeader."Indent Status"::Indent);
        if IndentHeader.FindSet() then begin
            OpenIndentGvar := IndentHeader.Count;
        end;

        IndentHeader.Reset();
        IndentHeader.SetRange("Indent Status", IndentHeader."Indent Status"::Close);
        if IndentHeader.FindSet() then begin
            CloseIndentGvar := IndentHeader.Count;
        end;
    end;


    var
        IndentsPendingForPo: Integer;
        //string : DotNet str
        QuoteCompPendingForPo: Integer;
        VendorCertificateWarrenty: Integer;
        PurchaseReceiptNotInvoiced: Integer;
        ExcessQtyDeliveredPos: Integer;
        OpenIndentGvar: Integer;
        CloseIndentGvar: Integer;
}
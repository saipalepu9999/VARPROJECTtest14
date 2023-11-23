pageextension 50109 AccountantActivities extends "Accountant Activities"
{
    layout
    {
        addafter("Purchase Documents Due Today")
        {
            field(OverDueBy45Days; OverDueBy45Days)
            {
                Caption = 'MSME Purchase OverDue By 45 Days';
                Editable = false;
                ApplicationArea = all;

                trigger OnDrillDown()
                var
                    Vendor: Record Vendor;
                    VendorLedger: Record "Vendor Ledger Entry";

                begin
                    Vendor.Reset();
                    Vendor.SetRange("MSME Applicable", true);
                    if Vendor.FindSet() then begin
                        repeat
                            VendorLedger.Reset();
                            VendorLedger.SetRange("Vendor No.", Vendor."No.");
                            VendorLedger.SetFilter("Remaining Amount", '<>%1', 0);
                            VendorLedger.SetFilter("Due Date", '>%1', CalcDate('45D', WorkDate()));
                            if VendorLedger.FindSet() then
                                VendorLedger.Mark(true);
                        until Vendor.Next() = 0;
                    end;
                    VendorLedger.MarkedOnly(true);
                    Page.RunModal(0, VendorLedger);
                end;
            }
            field("BG Expiry Today"; "BG Expiry Today")
            {
                ApplicationArea = all;
                Editable = false;

            }
            field("FDR Maturity Today"; "FDR Maturity Today")
            {
                ApplicationArea = all;
                Editable = false;

            }
            field("TDS Liability for the Month"; "TDS Liability for the Month")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(IRList; IRList)
            {
                ApplicationArea = all;
                Caption = 'Posted IR List';
                trigger OnDrillDown()
                var
                    InspectionReceipt: Record "Inspection Receipt Header B2B";
                begin
                    InspectionReceipt.Reset();
                    InspectionReceipt.SetRange(Status, true);
                    if InspectionReceipt.FindSet() then;
                    Page.RunModal(Page::"Posted Ins Receipt List B2B", InspectionReceipt);
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
                                if PurchReceiptHeader.Get(PurchReceiptLines."Document No.") and (PurchReceiptHeader."Service MRV" = false) then
                                    PurchReceiptHeader.mark(true);
                            end;
                        until PurchReceiptLines.Next() = 0;
                    PurchReceiptHeader.MarkedOnly(true);
                    if PurchReceiptHeader.FindSet() then;
                    PostedPurchaseReceiptList.SetTableView(PurchReceiptHeader);
                    PostedPurchaseReceiptList.RunModal();
                end;
            }
            //B2BPROn28JUN2023<<<
            field(ServiceReceiptNotInvoiced; ServiceReceiptNotInvoiced)
            {
                Caption = 'Service MRV Posted But Not Invoiced';
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Service Receipts Posted But Not Invoiced field.';
                trigger OnDrillDown()
                var
                    PurchReceiptLines: Record "Purch. Rcpt. Line";
                    PurchReceiptHeader: Record "Purch. Rcpt. Header";
                    PostedMRVServiceList: Page "Posted MRV Service List";
                begin
                    PurchReceiptLines.Reset();
                    if PurchReceiptLines.FindSet() then
                        repeat
                            if PurchReceiptLines."Quantity Invoiced" <> PurchReceiptLines.Quantity then begin
                                if PurchReceiptHeader.Get(PurchReceiptLines."Document No.") and (PurchReceiptHeader."Service MRV") then
                                    PurchReceiptHeader.mark(true);
                            end;
                        until PurchReceiptLines.Next() = 0;
                    PurchReceiptHeader.MarkedOnly(true);
                    if PurchReceiptHeader.FindSet() then;
                    PostedMRVServiceList.SetTableView(PurchReceiptHeader);
                    PostedMRVServiceList.RunModal();
                end;
            }
            //B2BPROn28JUN2023<<<
            field(SalesShipmentNotInvoiced; SalesShipmentNotInvoiced)
            {
                ApplicationArea = all;
                Caption = 'Sales Shipments Posted But Not Invoiced';
                trigger OnDrillDown()
                var
                    SalesShipmentLines: Record "Sales Shipment Line";
                    SalesShipmentHdr: Record "Sales Shipment Header";
                    PosSalesShipmentList: Page "Posted Sales Shipments";
                begin
                    SalesShipmentLines.Reset();
                    if SalesShipmentLines.FindSet() then
                        repeat
                            if SalesShipmentLines."Quantity Invoiced" <> SalesShipmentLines.Quantity then begin
                                if SalesShipmentHdr.Get(SalesShipmentLines."Document No.") then
                                    SalesShipmentHdr.mark(true);
                            end;
                        until SalesShipmentLines.Next() = 0;
                    SalesShipmentHdr.MarkedOnly(true);
                    if SalesShipmentHdr.FindSet() then;
                    PosSalesShipmentList.SetTableView(SalesShipmentHdr);
                    PosSalesShipmentList.RunModal();
                end;
            }
            field(PurChaseOrderPrepPending; PurChaseOrderPrepPending)
            {
                ApplicationArea = all;
                Caption = 'Purchase Orders Pending For Prepayment';
                trigger OnDrillDown()
                var
                    PurchaseOrder: Record "Purchase Header";
                    PurchaseOrderList: Page "Purchase Order List";
                begin
                    PurchaseOrder.Reset();
                    PurchaseOrder.SetRange("Document Type", PurchaseOrder."Document Type"::Order);
                    PurchaseOrder.SetRange(Status, PurchaseOrder.Status::"Pending Prepayment");
                    if PurchaseOrder.FindSet() then;
                    PurchaseOrderList.SetTableView(PurchaseOrder);
                    PurchaseOrderList.RunModal();
                end;
            }
        }
    }

    actions
    {

    }

    var
        OverDueBy45Days: Decimal;
        IRList: Integer;
        PurchaseReceiptNotInvoiced: Integer;
        SalesShipmentNotInvoiced: Integer;
        PurChaseOrderPrepPending: Integer;
        ServiceReceiptNotInvoiced: Integer;

    trigger OnOpenPage()
    var
        Vendor: Record Vendor;
        VendorLedger: Record "Vendor Ledger Entry";
    begin
        Vendor.Reset();
        Vendor.SetRange("MSME Applicable", true);
        if Vendor.FindSet() then begin
            repeat
                VendorLedger.Reset();
                VendorLedger.SetRange("Vendor No.", Vendor."No.");
                VendorLedger.SetFilter("Remaining Amount", '<>%1', 0);
                VendorLedger.SetFilter("Due Date", '>%1', CalcDate('45D', WorkDate()));
                if VendorLedger.FindSet() then
                    OverDueBy45Days += VendorLedger.Count;
            until Vendor.Next() = 0;
        end;
        Rec.SetFilter("BG Expiry Date Filter", '<=%1', WorkDate());
    end;

    trigger OnAfterGetCurrRecord()
    var
        InspectionReceipt: Record "Inspection Receipt Header B2B";
    begin
        InspectionReceipt.Reset();
        InspectionReceipt.SetRange(Status, true);
        if InspectionReceipt.FindSet() then
            IRList := InspectionReceipt.Count;
        PurchaseReceiptsPostedNotInvoiced();
        ServiceReceiptsPostedNotInvoiced();//B2BPROn28JUN2023<<<
        SalesShipmentsPostedNotInvoicedList();
        PendingPurchaseOrderPrepList();
        //Page.RunModal(Page::"Posted Ins Receipt List B2B", InspectionReceipt);
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
                    if PurchReceiptHeader.Get(PurchReceiptLines."Document No.") and (PurchReceiptHeader."Service MRV" = false) then
                        PurchReceiptHeader.mark(true);
                end;
            until PurchReceiptLines.Next() = 0;
        PurchReceiptHeader.MarkedOnly(true);
        if PurchReceiptHeader.FindSet() then
            PurchaseReceiptNotInvoiced := PurchReceiptHeader.Count;
    end;
    //B2BPROn28JUN2023<<<
    procedure ServiceReceiptsPostedNotInvoiced()
    var
        PurchReceiptLines: Record "Purch. Rcpt. Line";
        PurchReceiptHeader: Record "Purch. Rcpt. Header";
        PostedMRVServiceList: Page "Posted MRV Service List";
    begin
        PurchReceiptLines.Reset();
        if PurchReceiptLines.FindSet() then
            repeat
                if PurchReceiptLines."Quantity Invoiced" <> PurchReceiptLines.Quantity then begin
                    if PurchReceiptHeader.Get(PurchReceiptLines."Document No.") and (PurchReceiptHeader."Service MRV") then
                        PurchReceiptHeader.mark(true);
                end;
            until PurchReceiptLines.Next() = 0;
        PurchReceiptHeader.MarkedOnly(true);
        if PurchReceiptHeader.FindSet() then
            ServiceReceiptNotInvoiced := PurchReceiptHeader.Count;
    end;
    //B2BPROn28JUN2023<<<

    procedure SalesShipmentsPostedNotInvoicedList()
    var

        SalesShipmentLines: Record "Sales Shipment Line";
        SalesShipmentHdr: Record "Sales Shipment Header";
        PosSalesShipmentList: Page "Posted Sales Shipments";
    begin
        SalesShipmentLines.Reset();
        if SalesShipmentLines.FindSet() then
            repeat
                if SalesShipmentLines."Quantity Invoiced" <> SalesShipmentLines.Quantity then begin
                    if SalesShipmentHdr.Get(SalesShipmentLines."Document No.") then
                        SalesShipmentHdr.mark(true);
                end;
            until SalesShipmentLines.Next() = 0;
        SalesShipmentHdr.MarkedOnly(true);
        if SalesShipmentHdr.FindSet() then
            SalesShipmentNotInvoiced := SalesShipmentHdr.Count;
    end;

    procedure PendingPurchaseOrderPrepList()
    var
        PurchaseOrder: Record "Purchase Header";
        PurchaseOrderList: Page "Purchase Order List";
    begin
        PurchaseOrder.Reset();
        PurchaseOrder.SetRange("Document Type", PurchaseOrder."Document Type"::Order);
        PurchaseOrder.SetRange(Status, PurchaseOrder.Status::"Pending Prepayment");
        if PurchaseOrder.FindSet() then
            PurChaseOrderPrepPending := PurchaseOrder.Count;

    end;

}
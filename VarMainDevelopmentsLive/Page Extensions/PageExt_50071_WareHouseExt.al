pageextension 50071 Warehouse_Ext extends "Whse Ship & Receive Activities"
{
    layout
    {
        // Add changes to page layout here
        addafter("Open Phys. Invt. Orders")
        {
            field("Item Ledger Entry"; ILE_ExpiryCount)
            {
                ApplicationArea = all;
                Caption = 'Item Ledger Entries';
                ToolTip = 'Specifies the value of the Item Ledger Entries field.';
                trigger OnDrillDown()
                var
                    ILE_ExpiryDate: Integer;
                    ExpiryDate: Date;
                    ItemLedgerEntryGRec: Record "Item Ledger Entry";
                    ItemLedgerGpage: Page "Item Ledger Entries";
                begin
                    ExpiryDate := CALCDATE('<2W>', WorkDate());
                    ItemLedgerEntryGRec.Reset();
                    ItemLedgerEntryGRec.SetRange("Expiration Date", 0D, ExpiryDate);
                    if ItemLedgerEntryGRec.FindSet() then;
                    ItemLedgerGpage.SetTableView(ItemLedgerEntryGRec);
                    ItemLedgerGpage.Run();

                end;

            }
            field(LotExpiryBefore6Weeks; LotExpiryBefore6Weeks)
            {
                ApplicationArea = all;
                Caption = 'Lot/Batch No expiration is due in next 6 to 8 weeks';
                ToolTip = 'Specifies the value of the Lot/Batch No expiration is due in next 6 to 8 weeks field.';
                trigger OnDrillDown()
                var
                    Items: Record Item;
                    ItemLedgerEntries: Record "Item Ledger Entry";
                    ItemList: Page "Item List";
                begin
                    Items.Reset();
                    if Items.FindSet() then
                        repeat
                            ItemLedgerEntries.Reset();
                            ItemLedgerEntries.SetRange("Item No.", Items."No.");

                            ItemLedgerEntries.SetFilter("Expiration Date", '<>%1', 0D);
                            ItemLedgerEntries.FilterGroup(-1);
                            ItemLedgerEntries.SetFilter("Expiration Date", '<%1', WorkDate() - 42);
                            if ItemLedgerEntries.FindFirst() then begin
                                Items.Mark(true);
                            end;
                        until Items.Next() = 0;
                    Items.MarkedOnly(true);
                    if Items.FindSet() then;
                    ItemList.SetTableView(Items);
                    ItemList.RunModal();
                end;
            }
            field(RewoekRejQtyNotSentToVendor; RewoekRejQtyNotSentToVendor)
            {
                ApplicationArea = all;
                Caption = 'Rework/Rejected quantities not yet sent to Vendor';
                ToolTip = 'Specifies the value of the Rework/Rejected quantities not yet sent to Vendor field.';
                trigger OnDrillDown()
                var
                    InsReceiptHdr: Record "Inspection Receipt Header B2B";
                    PostedInspectionReceiptList: Page "Posted Ins Receipt List B2B";
                begin
                    InsReceiptHdr.Reset();
                    InsReceiptHdr.SetRange(Status, true);
                    if InsReceiptHdr.FindSet() then
                        repeat
                            if InsReceiptHdr."Qty. to Vendor(Rework)" < InsReceiptHdr."Qty. Rework" then
                                InsReceiptHdr.Mark(true);
                        until InsReceiptHdr.Next() = 0;
                    InsReceiptHdr.MarkedOnly(true);
                    if InsReceiptHdr.FindSet() then;
                    PostedInspectionReceiptList.SetTableView(InsReceiptHdr);
                    PostedInspectionReceiptList.RunModal();
                end;
            }
            field(MyMrs; MyMrs)
            {
                ApplicationArea = all;
                Caption = 'My MRS';
                ToolTip = 'Specifies the value of the My MRS field.';
                trigger OnDrillDown()
                var
                    TransferHeader: Record "Transfer Header";
                    MrsList: Page "Transfer Orders MRS";
                begin
                    //TransferHeader.Reset();
                    TransferHeader.SetRange("Created From MRS", true);
                    //if TransferHeader.FindSet() then begin
                    //   MyMrs := TransferHeader.Count;
                    MrsList.SetTableView(TransferHeader);
                    MrsList.RunModal();

                end;
            }
            field(MyMrsIndents; MyMrsIndents)
            {
                ApplicationArea = all;
                Caption = 'My MRS/Indents';
                ToolTip = 'Specifies the value of the My MRS/Indents field.';
                trigger OnDrillDown()
                var
                    TransferHeader: Record "Transfer Header";
                    MrsList: Page "Transfer Orders MRS";
                begin
                    //TransferHeader.Reset();
                    TransferHeader.SetRange("Created From MRS", true);
                    TransferHeader.SetRange("Indents Craeted", true);
                    //if TransferHeader.FindSet() then begin
                    //   MyMrs := TransferHeader.Count;
                    MrsList.SetTableView(TransferHeader);
                    MrsList.RunModal();

                end;
            }
            field(MyMrsIndentsPos; MyMrsIndentsPos)
            {
                ApplicationArea = all;
                Caption = 'My MRS/Indents/Pos';
                ToolTip = 'Specifies the value of the My MRS/Indents/Pos field.';
                trigger OnDrillDown()
                var
                    TransferHeader: Record "Transfer Header";
                    PoList: Page "Purchase Orders";
                begin
                    //TransferHeader.Reset();
                    //TransferHeader.SetRange("Created From MRS", true);
                    //TransferHeader.SetRange("Indents Craeted", true);
                    //if TransferHeader.FindSet() then begin
                    //   MyMrs := TransferHeader.Count;
                    //PoList.SetTableView(TransferHeader);
                    PoList.RunModal();

                end;
            }
            field(IndentsPendingForPo; IndentsPendingForPo)
            {
                ApplicationArea = all;
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
            field(MrsIndentsShortfall; MrsIndentsShortfall)
            {
                ApplicationArea = all;
                Caption = 'Mrs Indents ShortFall';
                ToolTip = 'Specifies the value of the Mrs Indents ShortFall field.';
                trigger OnDrillDown()
                var
                    IndentHeader: Record "Indent Header";
                    IndentList: Page "Indent List";
                begin
                    IndentHeader.Reset();
                    IndentHeader.SetFilter("Transfer Order No.", '<>%1', '');
                    if IndentHeader.FindSet() then
                        IndentList.SetTableView(IndentHeader);
                    IndentList.RunModal();
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
                ToolTip = 'Specifies the value of the Excess Quantity Delivered Pos field.';
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
            field(VendorCertificateWarrenty; VendorCertificateWarrenty)
            {
                ApplicationArea = all;
                Caption = 'Vendor Test Report/Warranty Certificates - Pending from Vendor';
                ToolTip = 'Specifies the value of the Vendor Test Report/Warranty Certificates - Pending from Vendor field.';
                trigger OnDrillDown()
                var
                    InspectionReceipt: Record "Inspection Receipt Header B2B";
                    InspectionReceiptList: page "Inspection Receipt List B2B";
                begin
                    InspectionReceipt.Reset();
                    InspectionReceipt.SetFilter("QC Certificate(s) Status", '<>%1|<>%2', InspectionReceipt."QC Certificate(s) Status"::"Not Required", InspectionReceipt."QC Certificate(s) Status"::Available);
                    if InspectionReceipt.FindSet() then;
                    InspectionReceiptList.SetTableView(InspectionReceipt);
                    InspectionReceiptList.RunModal();
                end;
            }
            field(MRVSPendingFromQC; MRVSPendingFromQC)
            {
                ApplicationArea = all;
                Caption = 'MRVS Pending From QC';
                ToolTip = 'Specifies the value of the MRVS Pending From QC field.';
                trigger OnDrillDown()
                var
                    PurchRcptHdr: Record "Purch. Rcpt. Header";
                    PurchRcptLine: Record "Purch. Rcpt. Line";
                    PostedPurchRcptList: Page "Posted Purchase Receipts";
                begin
                    PurchRcptLine.Reset();
                    PurchRcptLine.SetRange("QC Enabled B2B", true);
                    if PurchRcptLine.FindSet() then
                        repeat
                            if PurchRcptLine.Quantity <> PurchRcptLine."Quantity Accepted B2B" + PurchRcptLine."Quantity Rejected B2B" + PurchRcptLine."Quantity Rework B2B" then begin
                                if PurchRcptHdr.Get(PurchRcptLine."Document No.") then
                                    PurchRcptHdr.Mark(true);
                            end;

                        until PurchRcptLine.Next() = 0;
                    PurchRcptHdr.MarkedOnly(true);
                    if PurchRcptHdr.FindSet() then;
                    PostedPurchRcptList.SetTableView(PurchRcptHdr);
                    PostedPurchRcptList.RunModal();
                end;
            }
            field(MRVSCompletedFromQC; MRVSCompletedFromQC)
            {
                ApplicationArea = all;
                Caption = 'MRVS Completed From QC';
                ToolTip = 'Specifies the value of the MRVSCompletedFromQC field.';
                trigger OnDrillDown()
                var
                    PurchRcptHdr: Record "Purch. Rcpt. Header";
                    PurchRcptLine: Record "Purch. Rcpt. Line";
                    PostedPurchRcptList: Page "Posted Purchase Receipts";
                begin
                    PurchRcptLine.Reset();
                    PurchRcptLine.SetRange("QC Enabled B2B", true);
                    if PurchRcptLine.FindSet() then
                        repeat
                            if PurchRcptLine.Quantity = PurchRcptLine."Quantity Accepted B2B" + PurchRcptLine."Quantity Rejected B2B" + PurchRcptLine."Quantity Rework B2B" then begin
                                if PurchRcptHdr.Get(PurchRcptLine."Document No.") then
                                    PurchRcptHdr.Mark(true);
                            end;
                        until PurchRcptLine.Next() = 0;
                    PurchRcptHdr.MarkedOnly(true);
                    if PurchRcptHdr.FindSet() then;
                    PostedPurchRcptList.SetTableView(PurchRcptHdr);
                    PostedPurchRcptList.RunModal();
                end;
            }
            field(RPOFinished; RPOFinished)
            {
                ApplicationArea = all;
                Caption = 'RPO Finished But Not Transfered';
                trigger OnDrillDown()
                var
                    IleLrec: Record "Item Ledger Entry";
                    IlePage: page "Item Ledger Entries";
                begin
                    IleLrec.Reset();
                    IleLrec.SetRange("Item Category Code", 'FG');
                    IleLrec.SetFilter("Location Code", '%1|%2', 'DOMPROD', 'EOUPROD');
                    if IleLrec.FindSet() then;
                    IlePage.SetTableView(IleLrec);
                    IlePage.RunModal();
                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetCurrRecord()
    var
        TransferOrders: Record "Transfer Header";
    begin
        ILEExpiryFun();
        LotExpiryList();
        ReworkRejectQtySentToVendor();
        TransferOrders.SetRange("Created From MRS", true);
        MyMrs := TransferOrders.Count();
        TransferOrders.SetRange("Indents Craeted", true);
        MyMrsIndents := TransferOrders.Count();
        MyMrsIndentsPos := 0;
        IndentsPendingPos();
        MrsIndentsForShortfall();
        PurchaseReceiptsPostedNotInvoiced();
        ExcessQuantitiesDeliverdPos();
        VendortestCertificate();
        MRVSPendingQc();
        MRVSCompletedQc();
        ShowFinishedRPOILE()
    end;

    var
        ILE_ExpiryCount: Integer;
        LotExpiryBefore6Weeks: Integer;
        RewoekRejQtyNotSentToVendor: Integer;
        MyMrs: Integer;
        MyMrsIndents: Integer;
        MyMrsIndentsPos: Integer;
        IndentsPendingForPo: Integer;
        MrsIndentsShortfall: Integer;
        PurchaseReceiptNotInvoiced: Integer;
        ExcessQtyDeliveredPos: Integer;
        VendorCertificateWarrenty: Integer;
        MRVSPendingFromQC: Integer;
        MRVSCompletedFromQC: Integer;
        RPOFinished: Integer;

    local procedure ILEExpiryFun()
    var
        ILE_ExpiryDate: Integer;
        ExpiryDate: Date;
        ItemLedgerEntryGRec: Record "Item Ledger Entry";
        ItemLedgerGpage: Page "Item Ledger Entries";
    begin
        ExpiryDate := CALCDATE('<2W>', WorkDate());
        ItemLedgerEntryGRec.Reset();
        ItemLedgerEntryGRec.SetRange("Expiration Date", 0D, ExpiryDate);
        if ItemLedgerEntryGRec.FindSet() then
            ILE_ExpiryCount := ItemLedgerEntryGRec.Count;

    end;

    procedure LotExpiryList()
    var
        Items: Record Item;
        ItemLedgerEntries: Record "Item Ledger Entry";
        ItemList: Page "Item List";
    begin
        Items.Reset();
        if Items.FindSet() then
            repeat
                ItemLedgerEntries.Reset();
                ItemLedgerEntries.SetRange("Item No.", Items."No.");

                ItemLedgerEntries.SetFilter("Expiration Date", '<>%1', 0D);
                ItemLedgerEntries.FilterGroup(-1);
                ItemLedgerEntries.SetFilter("Expiration Date", '<%1', WorkDate() - 42);
                if ItemLedgerEntries.FindFirst() then begin
                    Items.Mark(true);
                end;
            until Items.Next() = 0;
        Items.MarkedOnly(true);
        if Items.FindSet() then
            LotExpiryBefore6Weeks := Items.Count;

    end;

    procedure ReworkRejectQtySentToVendor()
    var
        InsReceiptHdr: Record "Inspection Receipt Header B2B";
        PostedInspectionReceiptList: Page "Posted Ins Receipt List B2B";
    begin
        InsReceiptHdr.Reset();
        InsReceiptHdr.SetRange(Status, true);
        if InsReceiptHdr.FindSet() then
            repeat
                if InsReceiptHdr."Qty. to Vendor(Rework)" < InsReceiptHdr."Qty. Rework" then
                    InsReceiptHdr.Mark(true);
            until InsReceiptHdr.Next() = 0;
        InsReceiptHdr.MarkedOnly(true);
        if InsReceiptHdr.FindSet() then
            RewoekRejQtyNotSentToVendor := InsReceiptHdr.Count;

    end;

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

    procedure MrsIndentsForShortfall()
    var
        IndentHeader: Record "Indent Header";
        IndentList: Page "Indent List";
    begin
        IndentHeader.Reset();
        IndentHeader.SetFilter("Transfer Order No.", '<>%1', '');
        if IndentHeader.FindSet() then
            MrsIndentsShortfall := IndentHeader.Count;
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

    procedure VendortestCertificate()
    var
        InspectionReceipt: Record "Inspection Receipt Header B2B";
        InspectionReceiptList: page "Inspection Receipt List B2B";
    begin
        InspectionReceipt.Reset();
        InspectionReceipt.SetFilter("QC Certificate(s) Status", '<>%1|<>%2', InspectionReceipt."QC Certificate(s) Status"::"Not Required", InspectionReceipt."QC Certificate(s) Status"::Available);
        if InspectionReceipt.FindSet() then
            VendorCertificateWarrenty := InspectionReceipt.Count;

    end;

    procedure MRVSPendingQc()
    var
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PostedPurchRcptList: Page "Posted Purchase Receipts";
    begin
        PurchRcptLine.Reset();
        PurchRcptLine.SetRange("QC Enabled B2B", true);
        if PurchRcptLine.FindSet() then
            repeat
                if PurchRcptLine.Quantity <> PurchRcptLine."Quantity Accepted B2B" + PurchRcptLine."Quantity Rejected B2B" + PurchRcptLine."Quantity Rework B2B" then begin
                    if PurchRcptHdr.Get(PurchRcptLine."Document No.") then
                        PurchRcptHdr.Mark(true);
                end;
            until PurchRcptLine.Next() = 0;
        PurchRcptHdr.MarkedOnly(true);
        if PurchRcptHdr.FindSet() then
            MRVSPendingFromQC := PurchRcptHdr.Count;

    end;

    procedure MRVSCompletedQc()
    var
        PurchRcptHdr: Record "Purch. Rcpt. Header";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        PostedPurchRcptList: Page "Posted Purchase Receipts";
    begin
        PurchRcptLine.Reset();
        PurchRcptLine.SetRange("QC Enabled B2B", true);
        if PurchRcptLine.FindSet() then
            repeat
                if PurchRcptLine.Quantity = PurchRcptLine."Quantity Accepted B2B" + PurchRcptLine."Quantity Rejected B2B" + PurchRcptLine."Quantity Rework B2B" then begin
                    if PurchRcptHdr.Get(PurchRcptLine."Document No.") then
                        PurchRcptHdr.Mark(true);
                end;
            until PurchRcptLine.Next() = 0;
        PurchRcptHdr.MarkedOnly(true);
        if PurchRcptHdr.FindSet() then
            MRVSPendingFromQC := PurchRcptHdr.Count;

    end;

    procedure ShowFinishedRPOILE()
    var
        IleLrec: Record "Item Ledger Entry";
        IlePage: page "Item Ledger Entries";
    begin
        IleLrec.Reset();
        IleLrec.SetRange("Item Category Code", 'FG');
        IleLrec.SetFilter("Location Code", '%1|%2', 'DOMPROD', 'EOUPROD');
        if IleLrec.FindSet() then
            RPOFinished := IleLrec.Count;

    end;
}
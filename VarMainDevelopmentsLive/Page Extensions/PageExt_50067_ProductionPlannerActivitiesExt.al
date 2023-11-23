pageextension 50067 ProPlannerActivities_Ext extends "Production Planner Activities"
{
    layout
    {
        // Add changes to page layout here
        addafter("Released Prod. Orders - All")
        {
            field("Released Production Orders"; MyRP0)
            {
                ApplicationArea = Manufacturing;
                Caption = 'RPO''s with No action';
                ToolTip = 'Specifies the number of released production orders that are displayed in the Manufacturing  on the Role Center. The documents are filtered by today''s date.';
                trigger OnDrillDown()
                var

                begin
                    ProductionOrder.Reset();
                    ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
                    if ProductionOrder.FindSet() then
                        repeat
                            ItemLedgerEntry.Reset();
                            ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."Order Type"::Production);
                            ItemLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
                            if not ItemLedgerEntry.FindFirst() then
                                ILE := true
                            else
                                ILE := false;
                            CapacityLedgerEntry.Reset();
                            CapacityLedgerEntry.SetRange("Order Type", CapacityLedgerEntry."Order Type"::Production);
                            CapacityLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
                            if not CapacityLedgerEntry.FindFirst() then
                                CLE := true
                            else
                                CLE := false;
                            if ILE and CLE then
                                ProductionOrder.Mark(true);

                        until ProductionOrder.Next() = 0;
                    ProductionOrder.MarkedOnly(true);
                    // Message('%1', ProductionOrder.Count);
                    ReleasedProductionOrder.SetTableView(ProductionOrder);
                    ReleasedProductionOrder.run;

                end;
            }
            field("Released Production Orders New"; MyRP0New)
            {
                ApplicationArea = Manufacturing;
                Caption = 'RPO''s with No action & delayed more than 2 days';
                StyleExpr = 'UnFavorable';
                ToolTip = 'Specifies the number of released production orders that are displayed in the Manufacturing  on the Role Center. The documents are filtered by today''s date.';
                trigger OnDrillDown()
                var
                    ItemLedgerEntry: Record "Item Ledger Entry";
                    ILE: Boolean;
                    CLE: Boolean;


                    CapacityLedgerEntry: Record "Capacity Ledger Entry";
                    ProductionOrder: record "Production Order";
                    ReleasedProductionOrder: Page "Released Production Orders";

                begin
                    StartDate := WorkDate - 2;
                    ProductionOrder.Reset();
                    ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
                    ProductionOrder.SetRange("Creation Date", 0D, StartDate);
                    if ProductionOrder.FindSet() then
                        repeat
                            ItemLedgerEntry.Reset();
                            ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."Order Type"::Production);
                            ItemLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
                            if not ItemLedgerEntry.FindFirst() then
                                ILE := true
                            else
                                ILE := false;
                            CapacityLedgerEntry.Reset();
                            CapacityLedgerEntry.SetRange("Order Type", CapacityLedgerEntry."Order Type"::Production);
                            CapacityLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
                            if not CapacityLedgerEntry.FindFirst() then
                                CLE := true
                            else
                                CLE := false;
                            if ILE and CLE then
                                ProductionOrder.Mark(true);

                        until ProductionOrder.Next() = 0;
                    ProductionOrder.MarkedOnly(true);
                    ReleasedProductionOrder.SetTableView(ProductionOrder);
                    ReleasedProductionOrder.run;

                end;
            }
            field("RPO Subcontracting list"; MyRPOItem)
            {
                ApplicationArea = all;
                Caption = 'RPO Subcontracting list';
                ToolTip = 'Specifies the value of the RPO Subcontracting list field.';
                trigger OnDrillDown()
                var
                    ProductionOrderGRec: Record "Production Order";
                    ReleasedProductionOrderGPage: Page "Released Production Orders";
                    ProductionOrderLineGRec: Record "Prod. Order Line";
                    ProductionOrderHeader: Record "Production Order";
                begin
                    ProductionOrderGRec.Reset();
                    ProductionOrderGRec.SetRange("Source Type", ProductionOrderGRec."Source Type"::Item);
                    ProductionOrderGRec.SetRange(Status, ProductionOrderGRec.Status::Released);
                    if ProductionOrderGRec.FindSet() then
                        repeat
                            if ItemGRec.Get(ProductionOrderGRec."Source No.") and ItemGRec.Subcontracting then
                                ProductionOrderGRec.Mark(true);
                        until ProductionOrderGRec.Next() = 0;
                    ProductionOrderGRec.MarkedOnly(true);
                    ReleasedProductionOrderGPage.SetTableView(ProductionOrderGRec);
                    ReleasedProductionOrderGPage.Run();

                end;
            }
            field("RPO Consumption List"; RPOConsumption)
            {
                ApplicationArea = All;
                Caption = 'RPO Consumption List';
                ToolTip = 'Specifies the value of the RPO Consumption List field.';
                trigger OnDrillDown()
                begin
                    Clear(ILE);
                    ProductionOrder.Reset();
                    ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
                    if ProductionOrder.FindSet() then
                        repeat
                            ItemLedgerEntry.Reset();
                            ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."Order Type"::Production);
                            ItemLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
                            ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                            if ItemLedgerEntry.FindFirst() then
                                ILE := true
                            else
                                ILE := false;

                            if ILE then
                                ProductionOrder.Mark(true);

                        until ProductionOrder.Next() = 0;
                    ProductionOrder.MarkedOnly(true);
                    ReleasedProductionOrder.SetTableView(ProductionOrder);
                    ReleasedProductionOrder.Run();
                end;
            }
            field("RPOComponet List"; RPOComponent)
            {
                ApplicationArea = all;
                Caption = 'RPO Component List';
                ToolTip = 'Specifies the value of the RPO Component List field.';
                trigger OnDrillDown()
                var
                    ProductionOrderGRec: Record "Production Order";
                    ReleasedProductionOrderGPage: Page "Released Production Orders";
                    ProductionOrderLineGRec: Record "Prod. Order Line";
                    ProductionOrderHeader: Record "Production Order";
                begin
                    ProductionOrderHeader.Reset();
                    ProductionOrderHeader.SetRange(Status, ProductionOrderHeader.Status::Released);
                    if ProductionOrderHeader.FindSet() then
                        repeat
                            Clear(ProdComponetQty);
                            Clear(ILEQuantityLVar);
                            ProductionOrderLineGRec.Reset();
                            ProductionOrderLineGRec.SetRange("Prod. Order No.", ProductionOrderHeader."No.");
                            if ProductionOrderLineGRec.FindSet() then
                                repeat

                                    ProductionComponentGRec.Reset();
                                    ProductionComponentGRec.SetRange("Prod. Order No.", ProductionOrderLineGRec."Prod. Order No.");
                                    ProductionComponentGRec.SetRange("Prod. Order Line No.", ProductionOrderLineGRec."Line No.");
                                    if ProductionComponentGRec.FindSet() then
                                        repeat
                                            ItemLedgerEntry.Reset();
                                            ItemLedgerEntry.SetRange("Document No.", ProductionOrderLineGRec."Prod. Order No.");
                                            ItemLedgerEntry.SetRange("Item No.", ProductionComponentGRec."Item No.");
                                            if ItemLedgerEntry.FindSet() then begin
                                                ItemLedgerEntry.CalcSums(Quantity);
                                                ILEQuantityLVar += ItemLedgerEntry.Quantity;
                                            end;
                                            ProdComponetQty += ProductionComponentGRec."Expected Quantity";
                                        until ProductionComponentGRec.Next() = 0;
                                until ProductionOrderLineGRec.Next() = 0;
                            if ProdComponetQty = ILEQuantityLVar then
                                ILEQTy := true
                            else
                                ILEQTy := false;
                            if ILEQTy then
                                ProductionOrderHeader.Mark(true);

                        until ProductionOrderHeader.Next() = 0;
                    ProductionOrderHeader.MarkedOnly(true);
                    // RPOComponent := ProductionOrderHeader.Count;
                    ReleasedProductionOrderGPage.SetTableView(ProductionOrderHeader);
                    ReleasedProductionOrderGPage.Run();
                end;
            }
        }
        addlast("Planning - Operations")
        {
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
            field(FGQCPending; FGQCPending)
            {
                ApplicationArea = all;
                Caption = 'FG QC Pending';
                trigger OnDrillDown()
                var
                    ProductionOrderLvar: Record "Production Order";
                    ProductionOrderLineLvar: Record "Prod. Order Line";
                    ReleasedProdOrders: Page "Released Production Orders";
                begin
                    ProductionOrderLineLvar.Reset();
                    ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
                    ProductionOrderLineLvar.SetRange("WIP QC Enabled B2B", true);
                    ProductionOrderLineLvar.SetFilter("Quantity Sent to Quality B2B", '<>%1', 0);
                    if ProductionOrderLineLvar.FindSet() then
                        repeat
                            ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                            if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" <> ProductionOrderLineLvar."Quantity Sent to Quality B2B" then begin
                                if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                                    ProductionOrderLvar.Mark(true);
                            end;
                        until ProductionOrderLineLvar.Next() = 0;
                    ProductionOrderLvar.MarkedOnly(true);
                    if ProductionOrderLvar.FindSet() then;
                    ReleasedProdOrders.SetTableView(ProductionOrderLvar);
                    ReleasedProdOrders.RunModal();
                end;
            }
            field(FGQCCompleted; FGQCCompleted)
            {
                ApplicationArea = all;
                Caption = 'FG QC Completed';
                trigger OnDrillDown()
                var
                    ProductionOrderLvar: Record "Production Order";
                    ProductionOrderLineLvar: Record "Prod. Order Line";
                    ReleasedProdOrders: Page "Released Production Orders";
                begin
                    ProductionOrderLineLvar.Reset();
                    ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
                    ProductionOrderLineLvar.SetRange("WIP QC Enabled B2B", true);
                    ProductionOrderLineLvar.SetFilter("Quantity Sent to Quality B2B", '<>%1', 0);
                    if ProductionOrderLineLvar.FindSet() then
                        repeat
                            ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                            if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" = ProductionOrderLineLvar."Quantity Sent to Quality B2B" then begin
                                if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                                    ProductionOrderLvar.Mark(true);
                            end;
                        until ProductionOrderLineLvar.Next() = 0;
                    ProductionOrderLvar.MarkedOnly(true);
                    if ProductionOrderLvar.FindSet() then;
                    ReleasedProdOrders.SetTableView(ProductionOrderLvar);
                    ReleasedProdOrders.RunModal();
                end;
            }
            field(InProcessQCSFG; InProcessQCSFG)
            {
                ApplicationArea = all;
                Caption = 'In Process QC SFG Status';
                trigger OnDrillDown()
                var
                    InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
                    InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
                    ProductionOrderLrec: Record "Production Order";
                    ReleasedProdOrders: Page "Released Production Orders";
                begin
                    ProductionOrderLrec.Reset();
                    ProductionOrderLrec.SetRange(Status, ProductionOrderLrec.Status::Released);
                    if ProductionOrderLrec.FindSet() then
                        repeat
                            InspectionDataHdrLrec.Reset();
                            InspectionDataHdrLrec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                            if InspectionDataHdrLrec.FindSet() then
                                ProductionOrderLrec.Mark(true);
                            InsReceiptHdrLRec.Reset();
                            InsReceiptHdrLRec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                            if InsReceiptHdrLRec.FindSet() then
                                ProductionOrderLrec.Mark(true);
                        until ProductionOrderLrec.Next() = 0;
                    ProductionOrderLrec.MarkedOnly(true);
                    if ProductionOrderLrec.FindSet() then;
                    ReleasedProdOrders.SetTableView(ProductionOrderLrec);
                    ReleasedProdOrders.RunModal();
                end;
            }
            field(IDSPostingPendingPurchase; IDSPostingPendingPurchase)
            {
                ApplicationArea = all;
                Caption = 'In-Process related IDS posting pending-Purchase';
                trigger OnDrillDown()
                var
                    InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
                    InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
                    ProductionOrderLrec: Record "Production Order";
                    PurchaseHeaderLrec: Record "Purchase Header";
                    PurchaseOrders: Page "Purchase Order List";
                    ReleasedProdOrders: Page "Released Production Orders";
                begin
                    PurchaseHeaderLrec.Reset();
                    PurchaseHeaderLrec.SetRange("Document Type", PurchaseHeaderLrec."Document Type"::Order);
                    if PurchaseHeaderLrec.FindSet() then
                        repeat
                            InspectionDataHdrLrec.Reset();
                            InspectionDataHdrLrec.SetRange("Order No.", PurchaseHeaderLrec."No.");
                            if InspectionDataHdrLrec.FindSet() then
                                PurchaseHeaderLrec.Mark(true);
                        until PurchaseHeaderLrec.Next() = 0;
                    PurchaseHeaderLrec.MarkedOnly(true);
                    if PurchaseHeaderLrec.FindSet() then;
                    PurchaseOrders.SetTableView(PurchaseHeaderLrec);
                    PurchaseOrders.RunModal();
                end;
            }
            field(IDSPostingPendingProduction; IDSPostingPendingProduction)
            {
                ApplicationArea = all;
                Caption = 'In-Process related IDS posting pending-Production';
                trigger OnDrillDown()
                var
                    InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
                    InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
                    ProductionOrderLrec: Record "Production Order";
                    ReleasedProdOrders: Page "Released Production Orders";
                begin
                    ProductionOrderLrec.Reset();
                    ProductionOrderLrec.SetRange(Status, ProductionOrderLrec.Status::Released);
                    if ProductionOrderLrec.FindSet() then
                        repeat
                            InspectionDataHdrLrec.Reset();
                            InspectionDataHdrLrec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                            if InspectionDataHdrLrec.FindSet() then
                                ProductionOrderLrec.Mark(true);

                        until ProductionOrderLrec.Next() = 0;
                    ProductionOrderLrec.MarkedOnly(true);
                    if ProductionOrderLrec.FindSet() then;
                    ReleasedProdOrders.SetTableView(ProductionOrderLrec);
                    ReleasedProdOrders.RunModal();
                end;
            }
            field(MRVS; MRVS)
            {
                ApplicationArea = all;
                Caption = 'Material Receipt Vouchers';
                trigger OnDrillDown()
                var
                    PurchaseReceiptHdr: Record "Purch. Rcpt. Header";
                    PostedMrvs: Page "Posted Purchase Receipts";
                begin
                    PurchaseReceiptHdr.Reset();
                    if PurchaseReceiptHdr.FindSet() then begin
                        PostedMrvs.SetTableView(PurchaseReceiptHdr);
                        PostedMrvs.RunModal();
                    end;
                end;
            }
            field(CertifiedBOMS; CertifiedBOMS)
            {
                ApplicationArea = all;
                Caption = 'Production BOMS Certified';
                trigger OnDrillDown()
                var
                    ProductionBOMHdrLrec: Record "Production BOM Header";
                    ProductionBomsList: Page "Production BOM List";
                begin
                    ProductionBOMHdrLrec.Reset();
                    ProductionBOMHdrLrec.SetRange(Status, ProductionBOMHdrLrec.Status::Certified);
                    if ProductionBOMHdrLrec.FindSet() then;
                    ProductionBomsList.SetTableView(ProductionBOMHdrLrec);
                    ProductionBomsList.RunModal();
                end;
            }
            field(QAPProgress; QAPProgress)
            {
                ApplicationArea = all;
                Caption = 'QAP Documentation Progress';
                trigger OnDrillDown()
                var
                    SalesCheckList: Record SalesCheckList;
                    salesHeader: Record "Sales Header";
                    SalesOrderList: Page "Sales Order List";
                begin
                    salesHeader.Reset();
                    salesHeader.SetRange("Document Type", salesHeader."Document Type"::Order);
                    if salesHeader.FindSet() then
                        repeat
                            SalesCheckList.Reset();
                            SalesCheckList.SetRange("Document Type", SalesCheckList."Document Type"::Order);
                            SalesCheckList.SetRange("No.", salesHeader."No.");
                            SalesCheckList.SetFilter(Check, '<>%1', SalesCheckList.Check::Yes);
                            if SalesCheckList.FindFirst() then
                                salesHeader.Mark(true);
                        until salesHeader.Next() = 0;
                    salesHeader.MarkedOnly(true);
                    if salesHeader.FindSet() then;
                    SalesOrderList.SetTableView(salesHeader);
                    SalesOrderList.RunModal();
                end;
            }
            field(RewoekRejQtyNotSentToVendor; RewoekRejQtyNotSentToVendor)
            {
                ApplicationArea = all;
                Caption = 'Rework/Rejected quantities not yet sent to Vendor';
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
            field(IDSList; IDSList)
            {
                ApplicationArea = all;
                Caption = 'IDS List';
                trigger OnDrillDown()
                var
                    InspectonDataSheet: Record "Ins Datasheet Header B2B";
                    PostedInsDataSeetList: Page "Inspection Data Sheet List B2B";
                begin
                    InspectonDataSheet.Reset();
                    if InspectonDataSheet.FindSet() then;
                    PostedInsDataSeetList.SetTableView(InspectonDataSheet);
                    PostedInsDataSeetList.RunModal();
                end;
            }
            field(IRList; IRList)
            {
                ApplicationArea = all;
                Caption = 'IR List';
                trigger OnDrillDown()
                var
                    InspectionReceipt: Record "Inspection Receipt Header B2B";
                    InspectionReceiptList: Page "Inspection Receipt List B2B";
                begin
                    InspectionReceipt.Reset();
                    InspectionReceipt.SetRange(Status, false);
                    if InspectionReceipt.FindSet() then;
                    InspectionReceiptList.SetTableView(InspectionReceipt);
                    InspectionReceiptList.RunModal();
                end;
            }
            field(IDSListPendingForMrv; IDSListPendingForMrv)
            {
                ApplicationArea = all;
                Caption = 'IDS Pending Beyond 2 Days For MRV';
                trigger OnDrillDown()
                var
                    InspectionDataSheet: Record "Ins Datasheet Header B2B";
                    PurchaseReceipt: Record "Purch. Rcpt. Header";
                    inspectiondatasheetlist: Page "Inspection Data Sheet List B2B";
                begin
                    InspectionDataSheet.Reset();
                    if InspectionDataSheet.FindSet() then
                        repeat
                            PurchaseReceipt.Reset();
                            PurchaseReceipt.SetRange("No.", InspectionDataSheet."Receipt No.");
                            if PurchaseReceipt.FindFirst() then begin
                                if PurchaseReceipt."Posting Date" < WorkDate() - 2 then
                                    InspectionDataSheet.Mark(true)
                            end;
                        until InspectionDataSheet.Next() = 0;
                    InspectionDataSheet.MarkedOnly(true);
                    if InspectionDataSheet.FindSet() then;
                    inspectiondatasheetlist.SetTableView(InspectionDataSheet);
                    inspectiondatasheetlist.RunModal();
                end;
            }
            field(IRListPeningForMrv; IRListPeningForMrv)
            {
                ApplicationArea = all;
                Caption = 'IR Pending Beyond 2 Days For MRV';
                trigger OnDrillDown()
                var
                    InspectionDataSheet: Record "Inspection Receipt Header B2B";
                    PurchaseReceipt: Record "Purch. Rcpt. Header";
                    inspectiondatasheetlist: Page "Inspection Receipt List B2B";
                begin
                    InspectionDataSheet.Reset();
                    InspectionDataSheet.SetRange(Status, false);
                    if InspectionDataSheet.FindSet() then
                        repeat
                            PurchaseReceipt.Reset();
                            PurchaseReceipt.SetRange("No.", InspectionDataSheet."Receipt No.");
                            if PurchaseReceipt.FindFirst() then begin
                                if PurchaseReceipt."Posting Date" < WorkDate() - 2 then
                                    InspectionDataSheet.Mark(true)
                            end;
                        until InspectionDataSheet.Next() = 0;
                    InspectionDataSheet.MarkedOnly(true);
                    if InspectionDataSheet.FindSet() then;
                    inspectiondatasheetlist.SetTableView(InspectionDataSheet);
                    inspectiondatasheetlist.RunModal();
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
            field(JobWorkPendingForSubconVen; JobWorkPendingForSubconVen)
            {
                ApplicationArea = all;
                Caption = 'Raw Material lying at Job Work Subcon Vendor';
                trigger OnDrillDown()
                var
                    TransferHdr: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    TransferOrderList: page "Transfer Orders";
                    ItemLedgerEntries: Record "Item Ledger Entry";
                    TransferShipment: Record "Transfer Shipment Header";
                    TransferReceipt: Record "Transfer Receipt Header";
                begin
                    TransferHdr.Reset();
                    TransferHdr.SetRange("Created From MRS", false);
                    TransferHdr.SetFilter("Subcon Order No.", '<>%1', '');
                    if TransferHdr.FindSet() then
                        repeat
                            TransferShipment.Reset();
                            TransferShipment.SetRange("Transfer Order No.", TransferHdr."No.");
                            if TransferShipment.FindSet() then
                                repeat
                                    ItemLedgerEntries.Reset();
                                    ItemLedgerEntries.SetRange("Entry Type", ItemLedgerEntries."Entry Type"::Transfer);
                                    ItemLedgerEntries.SetRange("Document Type", ItemLedgerEntries."Document Type"::"Transfer Shipment");
                                    ItemLedgerEntries.SetRange("Document No.", TransferShipment."No.");
                                    if ItemLedgerEntries.FindSet() then
                                        repeat
                                            if ItemLedgerEntries."Posting Date" < WorkDate() - 180 then
                                                TransferHdr.Mark(true);
                                        until ItemLedgerEntries.Next() = 0;
                                until TransferShipment.Next() = 0;
                            TransferReceipt.Reset();
                            TransferReceipt.SetRange("Transfer Order No.", TransferHdr."No.");
                            if TransferReceipt.FindSet() then
                                repeat
                                    ItemLedgerEntries.Reset();
                                    ItemLedgerEntries.SetRange("Entry Type", ItemLedgerEntries."Entry Type"::Transfer);
                                    ItemLedgerEntries.SetRange("Document Type", ItemLedgerEntries."Document Type"::"Transfer Receipt");
                                    ItemLedgerEntries.SetRange("Document No.", TransferReceipt."No.");
                                    if ItemLedgerEntries.FindSet() then
                                        repeat
                                            if ItemLedgerEntries."Posting Date" < WorkDate() - 180 then
                                                TransferHdr.Mark(true);
                                        until ItemLedgerEntries.Next() = 0;
                                until TransferReceipt.Next() = 0;
                        until TransferHdr.Next() = 0;
                    TransferHdr.MarkedOnly(true);
                    if TransferHdr.FindSet() then;
                    TransferOrderList.SetTableView(TransferHdr);
                    TransferOrderList.RunModal();
                end;
            }
            field(RPOsOutputPending; RPOsOutputPending)
            {
                ApplicationArea = all;
                Caption = 'RpOs Output Pending';
                trigger OnDrillDown()
                var
                    ProductionOrder: Record "Production Order";
                    ProdOrderLine: Record "Prod. Order Line";
                    ReleasedProductionOrderList: Page "Released Production Orders";
                begin
                    ProductionOrder.Reset();
                    ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
                    ProductionOrder.SetRange("Subcontracting Order", false);
                    if ProductionOrder.FindSet() then
                        repeat
                            ProdOrderLine.Reset();
                            ProdOrderLine.SetRange(Status, ProductionOrder.Status);
                            ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                            if ProdOrderLine.FindSet() then
                                repeat
                                    if (ProdOrderLine."Finished Quantity" > 0) and (ProdOrderLine."Finished Quantity" < ProdOrderLine.Quantity) then
                                        ProductionOrder.Mark(true);
                                until ProdOrderLine.Next() = 0;
                        until ProductionOrder.Next() = 0;
                    ProductionOrder.MarkedOnly(true);
                    if ProductionOrder.FindSet() then;
                    ReleasedProductionOrderList.SetTableView(ProductionOrder);
                    ReleasedProductionOrderList.RunModal();
                end;
            }
            field(RPOsPendingForJobWorkPo; RPOsPendingForJobWorkPo)
            {
                ApplicationArea = all;
                Caption = 'RPOs Pending For JobWork Po';
                trigger OnDrillDown()
                var
                    ProductionOrder: Record "Production Order";
                    ProdOrderLine: Record "Prod. Order Line";
                    ReleasedProductionOrderList: Page "Released Production Orders";
                begin
                    ProductionOrder.Reset();
                    ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
                    ProductionOrder.SetRange("Subcontracting Order", true);
                    if ProductionOrder.FindSet() then
                        repeat
                            ProdOrderLine.Reset();
                            ProdOrderLine.SetRange(Status, ProductionOrder.Status);
                            ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                            if ProdOrderLine.FindSet() then
                                repeat
                                    if (ProdOrderLine."Finished Quantity" > 0) and (ProdOrderLine."Finished Quantity" < ProdOrderLine.Quantity) then
                                        ProductionOrder.Mark(true);
                                until ProdOrderLine.Next() = 0;
                        until ProductionOrder.Next() = 0;
                    ProductionOrder.MarkedOnly(true);
                    if ProductionOrder.FindSet() then;
                    ReleasedProductionOrderList.SetTableView(ProductionOrder);
                    ReleasedProductionOrderList.RunModal();
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
                    InspectionReceipt.SetFilter("QC Certificate(s) Status", '<>%1|<>%2', InspectionReceipt."QC Certificate(s) Status"::"Not Required", InspectionReceipt."QC Certificate(s) Status"::Available);
                    if InspectionReceipt.FindSet() then;
                    InspectionReceiptList.SetTableView(InspectionReceipt);
                    InspectionReceiptList.RunModal();
                end;
            }
            field(LotExpiryBefore6Weeks; LotExpiryBefore6Weeks)
            {
                ApplicationArea = all;
                Caption = 'Lot/Batch No expiration is due in next 6 to 8 weeks';
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
            field(TransferOrdersCreated; TransferOrdersCreated)
            {
                ApplicationArea = all;
                Caption = 'Transfer Orders Created';
                trigger OnDrillDown()
                var
                    TransferHedaer: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    TransferOrderList: page "Transfer Orders";
                begin
                    TransferHedaer.Reset();
                    TransferHedaer.SetRange("Created From MRS", false);
                    if TransferHedaer.FindSet() then
                        repeat
                            TransferLine.Reset();
                            TransferLine.SetRange("Document No.", TransferHedaer."No.");
                            TransferLine.SetRange("Derived From Line No.", 0);
                            TransferLine.SetFilter("Item No.", '<>%1', '');
                            if TransferLine.FindSet() then
                                repeat
                                    if (TransferLine.Quantity > 0) and (TransferLine."Quantity Shipped" = 0) then
                                        TransferHedaer.Mark(true);
                                until TransferLine.Next() = 0;
                        until TransferHedaer.Next() = 0;
                    if TransferHedaer.FindSet() then;
                    TransferOrderList.SetTableView(TransferHedaer);
                    TransferOrderList.RunModal();
                end;
            }
            field(ShippedNotReceived; ShippedNotReceived)
            {
                ApplicationArea = all;
                Caption = 'Transfer Orders Completely Shipped Not Yet Received';
                trigger OnDrillDown()
                var
                    TransferHedaer: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    TransferOrderList: page "Transfer Orders";
                begin
                    TransferHedaer.Reset();
                    TransferHedaer.SetRange("Created From MRS", false);
                    if TransferHedaer.FindSet() then begin
                        repeat
                            TransferLine.Reset();
                            TransferLine.SetRange("Derived From Line No.", 0);
                            TransferLine.SetRange("Document No.", TransferHedaer."No.");
                            if TransferLine.FindSet() then begin
                                repeat
                                    if (TransferLine.Quantity = TransferLine."Quantity Shipped") and (TransferLine.Quantity <> TransferLine."Quantity Received") then
                                        TransferHedaer.Mark(true);
                                until TransferLine.Next() = 0;
                            end;
                        until TransferHedaer.Next() = 0;
                    end;
                    TransferHedaer.MarkedOnly(true);
                    if TransferHedaer.FindSet() then;
                    TransferOrderList.SetTableView(TransferHedaer);
                    TransferOrderList.RunModal();
                end;
            }
            field(PartiallyShippedReceived; PartiallyShippedReceived)
            {
                ApplicationArea = all;
                Caption = 'Transfer Orders Patially Shipped And Received';
                trigger OnDrillDown()
                var
                    TransferHedaer: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    TransferOrderList: page "Transfer Orders";
                begin
                    TransferHedaer.Reset();
                    TransferHedaer.SetRange("Created From MRS", false);
                    if TransferHedaer.FindSet() then begin
                        repeat
                            TransferLine.Reset();
                            TransferLine.SetRange("Derived From Line No.", 0);
                            TransferLine.SetRange("Document No.", TransferHedaer."No.");
                            if TransferLine.FindSet() then begin
                                repeat
                                    if ((TransferLine.Quantity <> TransferLine."Quantity Shipped") and (TransferLine."Quantity Shipped" > 0)) or ((TransferLine.Quantity <> TransferLine."Quantity Received") and (TransferLine."Quantity Received" > 0)) then
                                        TransferHedaer.Mark(true);
                                until TransferLine.Next() = 0;
                            end;
                        until TransferHedaer.Next() = 0;
                    end;
                    TransferHedaer.MarkedOnly(true);
                    if TransferHedaer.FindSet() then;
                    TransferOrderList.SetTableView(TransferHedaer);
                    TransferOrderList.RunModal();
                end;
            }
            field(ShippedReceived; ShippedReceived)
            {
                ApplicationArea = all;
                Caption = 'Transfer Orders Completely Shipped & Received';
                trigger OnDrillDown()
                var
                    TransferHedaer: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    TransferOrderList: page "Transfer Orders";
                begin
                    TransferHedaer.Reset();
                    TransferHedaer.SetRange("Created From MRS", false);
                    if TransferHedaer.FindSet() then begin
                        repeat
                            TransferLine.Reset();
                            TransferLine.SetRange("Derived From Line No.", 0);
                            TransferLine.SetRange("Document No.", TransferHedaer."No.");
                            if TransferLine.FindSet() then begin
                                repeat
                                    if (TransferLine.Quantity = TransferLine."Quantity Shipped") and (TransferLine.Quantity = TransferLine."Quantity Received") then
                                        TransferHedaer.Mark(true);
                                until TransferLine.Next() = 0;
                            end;
                        until TransferHedaer.Next() = 0;
                    end;
                    TransferHedaer.MarkedOnly(true);
                    if TransferHedaer.FindSet() then;
                    TransferOrderList.SetTableView(TransferHedaer);
                    TransferOrderList.RunModal();
                end;
            }
            field(MRSTransferOrdersCreated; MRSTransferOrdersCreated)
            {
                ApplicationArea = all;
                Caption = 'MRS Created';
                trigger OnDrillDown()
                var
                    TransferHedaer: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    TransferOrderList: page "Transfer Orders MRS";
                begin
                    TransferHedaer.Reset();
                    TransferHedaer.SetRange("Created From MRS", true);
                    if TransferHedaer.FindSet() then
                        repeat
                            TransferLine.Reset();
                            TransferLine.SetRange("Document No.", TransferHedaer."No.");
                            TransferLine.SetRange("Derived From Line No.", 0);
                            TransferLine.SetFilter("Item No.", '<>%1', '');
                            if TransferLine.FindSet() then
                                repeat
                                    if (TransferLine.Quantity > 0) and (TransferLine."Quantity Shipped" = 0) then
                                        TransferHedaer.Mark(true);
                                until TransferLine.Next() = 0;
                        until TransferHedaer.Next() = 0;
                    if TransferHedaer.FindSet() then;
                    TransferOrderList.SetTableView(TransferHedaer);
                    TransferOrderList.RunModal();
                end;
            }
            field(MRSShippedNotReceived; MRSShippedNotReceived)
            {
                ApplicationArea = all;
                Caption = 'MRS Completely Shipped Not Yet Received';
                trigger OnDrillDown()
                var
                    TransferHedaer: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    TransferOrderList: page "Transfer Orders MRS";
                begin
                    TransferHedaer.Reset();
                    TransferHedaer.SetRange("Created From MRS", true);
                    if TransferHedaer.FindSet() then begin
                        repeat
                            TransferLine.Reset();
                            TransferLine.SetRange("Derived From Line No.", 0);
                            TransferLine.SetRange("Document No.", TransferHedaer."No.");
                            if TransferLine.FindSet() then begin
                                repeat
                                    if (TransferLine.Quantity = TransferLine."Quantity Shipped") and (TransferLine.Quantity <> TransferLine."Quantity Received") then
                                        TransferHedaer.Mark(true);
                                until TransferLine.Next() = 0;
                            end;
                        until TransferHedaer.Next() = 0;
                    end;
                    TransferHedaer.MarkedOnly(true);
                    if TransferHedaer.FindSet() then;
                    TransferOrderList.SetTableView(TransferHedaer);
                    TransferOrderList.RunModal();
                end;
            }
            field(MRSPartiallyShippedReceived; MRSPartiallyShippedReceived)
            {
                ApplicationArea = all;
                Caption = 'MRS Patially Shipped And Received';
                trigger OnDrillDown()
                var
                    TransferHedaer: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    TransferOrderList: page "Transfer Orders MRS";
                begin
                    TransferHedaer.Reset();
                    TransferHedaer.SetRange("Created From MRS", true);
                    if TransferHedaer.FindSet() then begin
                        repeat
                            TransferLine.Reset();
                            TransferLine.SetRange("Derived From Line No.", 0);
                            TransferLine.SetRange("Document No.", TransferHedaer."No.");
                            if TransferLine.FindSet() then begin
                                repeat
                                    if ((TransferLine.Quantity <> TransferLine."Quantity Shipped") and (TransferLine."Quantity Shipped" > 0)) or ((TransferLine.Quantity <> TransferLine."Quantity Received") and (TransferLine."Quantity Received" > 0)) then
                                        TransferHedaer.Mark(true);
                                until TransferLine.Next() = 0;
                            end;
                        until TransferHedaer.Next() = 0;
                    end;
                    TransferHedaer.MarkedOnly(true);
                    if TransferHedaer.FindSet() then;
                    TransferOrderList.SetTableView(TransferHedaer);
                    TransferOrderList.RunModal();
                end;
            }
            field(MRSShippedReceived; MRSShippedReceived)
            {
                ApplicationArea = all;
                Caption = 'MRS Completely Shipped & Received';
                trigger OnDrillDown()
                var
                    TransferHedaer: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    TransferOrderList: page "Transfer Orders MRS";
                begin
                    TransferHedaer.Reset();
                    TransferHedaer.SetRange("Created From MRS", true);
                    if TransferHedaer.FindSet() then begin
                        repeat
                            TransferLine.Reset();
                            TransferLine.SetRange("Derived From Line No.", 0);
                            TransferLine.SetRange("Document No.", TransferHedaer."No.");
                            if TransferLine.FindSet() then begin
                                repeat
                                    if (TransferLine.Quantity = TransferLine."Quantity Shipped") and (TransferLine.Quantity = TransferLine."Quantity Received") then
                                        TransferHedaer.Mark(true);
                                until TransferLine.Next() = 0;
                            end;
                        until TransferHedaer.Next() = 0;
                    end;
                    TransferHedaer.MarkedOnly(true);
                    if TransferHedaer.FindSet() then;
                    TransferOrderList.SetTableView(TransferHedaer);
                    TransferOrderList.RunModal();
                end;//4
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
                    IleLrec.setfilter("Remaining Quantity", '>%1', 0);
                    IleLrec.SetRange("Entry Type", IleLrec."Entry Type"::Output);
                    IleLrec.SetFilter("Location Code", '%1|%2', 'DOMPROD', 'EOUPROD');
                    if IleLrec.FindSet() then;
                    IlePage.SetTableView(IleLrec);
                    IlePage.RunModal();
                end;
            }
            field(SalesOrdersRpoNotCreated; SalesOrdersRpoNotCreated)
            {
                Caption = 'Sales Orders For Which RPO Not Created';
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    SalesHeader: Record "Sales Header";
                    ProductionHdr: Record "Production Order";
                    salesOrderList: Page "Sales Order List";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    if SalesHeader.FindSet() then
                        repeat
                            ProductionHdr.Reset();
                            ProductionHdr.SetFilter(ProductionHdr.Status, '%1|%2', ProductionHdr.Status::Released, ProductionHdr.Status::Finished);
                            ProductionHdr.SetRange("Sales Order No", SalesHeader."No.");
                            if not ProductionHdr.FindFirst() then
                                SalesHeader.Mark(true);
                        until SalesHeader.Next() = 0;
                    SalesHeader.MarkedOnly(true);
                    if SalesHeader.FindSet() then;
                    salesOrderList.SetTableView(SalesHeader);
                    salesOrderList.RunModal();
                end;
            }
            field(InBoundIRList; InBoundIRList)
            {
                ApplicationArea = all;
                Caption = 'In Bound IR List';
                trigger OnDrillDown()
                var
                    InspectionReceipt: Record "Inspection Receipt Header B2B";
                    InspectionReceiptList: Page "Inspection Receipt List B2B";
                begin
                    InspectionReceipt.Reset();
                    InspectionReceipt.SetRange(Status, false);
                    InspectionReceipt.SetFilter("Prod. Order No.", '<>%1', '');
                    if InspectionReceipt.FindSet() then;
                    InspectionReceiptList.SetTableView(InspectionReceipt);
                    InspectionReceiptList.RunModal();
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
        TransferOrders.SetRange("Created From MRS", true);
        MyMrs := TransferOrders.Count();
        TransferOrders.SetRange("Indents Craeted", true);
        MyMrsIndents := TransferOrders.Count();
        MyMrsIndentsPos := 0;
        RPOFUN;
        RPOFUN_2();
        RPOItemFun;
        RPOConsumptionFun();
        RPOComponentsFun();
        IndentsPendingPos();
        MrsIndentsForShortfall();
        PurchaseReceiptsPostedNotInvoiced();
        ExcessQuantitiesDeliverdPos();
        InProcessrelatedIDSpostingpendingproduction();
        InProcessrelatedIDSpostingpendingpurchase();
        FgqcCompletdProcedure();
        FgqcpendingProcedure();
        InProcessQCSFGStatus();
        MRVSCount();
        ProductionBomCertifiedCount();
        QAPCheckList();
        ReworkRejectQtySentToVendor();
        InspectionDataSheetList();
        InspectionReceiptList();
        IDSListPendingFor2Days();
        IRListPendingfor2days();
        QuotationComparisionListPendingForPo();
        JobWorkPendingForSunconVendorList();
        Rpospendingforjobworklist();
        Rpospendingoutputslist();
        VendortestCertificate();
        LotExpiryList();
        TransferOrdersCreatedList();
        TransferOrdersCompletelyShippedButNotReceived();
        TransferOrdersPartiallyShippedAndReceived();
        TransferOrdersCompletelyShippedAndReceived();
        MRSTransferOrdersCreatedList();
        MRSTransferOrdersCompletelyShippedButNotReceived();
        MRSTransferOrdersPartiallyShippedAndReceived();
        MRSTransferOrdersCompletelyShippedAndReceived();
        ShowFinishedRPOILE();
        SalesOrdersForWhichRpoNotCreated();
        InBoundInspectionReceiptList();
    end;

    var
        MyMrs: Integer;
        MyMrsIndents: Integer;
        MyMrsIndentsPos: Integer;
        MyRP0: Integer;
        MyRP0New: Integer;
        CertifiedBOMS: Integer;
        ExcessQtyDeliveredPos: Integer;

        MyRPOItem: Integer;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ILE: Boolean;
        CLE: Boolean;
        CapacityLedgerEntry: Record "Capacity Ledger Entry";
        ProductionOrder: record "Production Order";
        ReleasedProductionOrder: Page "Released Production Orders";
        StartDate: Date;
        Pa: Page "Item Ledger Entries";
        ItemGRec: Record Item;
        RPOConsumption: Integer;
        ILEQuantityLVar: Decimal;
        ILEQTy: Boolean;
        ProdComponetQty: Decimal;
        RPOComponent: Integer;

        ProductionComponentGRec: Record "Prod. Order Component";
        IndentsPendingForPo: Integer;
        MrsIndentsShortfall: Integer;
        PurchaseReceiptNotInvoiced: Integer;
        FGQCCompleted: Integer;
        FGQCPending: Integer;
        InProcessQCSFG: Integer;
        IDSPostingPendingPurchase: Integer;
        IDSPostingPendingProduction: Integer;
        MRVS: Integer;
        QAPProgress: Integer;
        RewoekRejQtyNotSentToVendor: Integer;
        IDSList: Integer;
        IRList: Integer;
        InBoundIRList: Integer;
        IDSListPendingForMrv: Integer;
        IRListPeningForMrv: Integer;
        QuoteCompPendingForPo: Integer;
        JobWorkPendingForSubconVen: Integer;
        RPOsPendingForJobWorkPo: Integer;
        RPOsOutputPending: Integer;
        VendorCertificateWarrenty: Integer;
        LotExpiryBefore6Weeks: Integer;
        ShippedNotReceived: Integer;
        ShippedReceived: integer;
        TransferOrdersCreated: Integer;
        PartiallyShippedReceived: Integer;
        MRSShippedNotReceived: Integer;
        MRSShippedReceived: integer;
        MRSTransferOrdersCreated: Integer;
        MRSPartiallyShippedReceived: Integer;
        RPOFinished: Integer;
        SalesOrdersRpoNotCreated: Integer;



    local procedure RPOFUN()
    begin
        ProductionOrder.Reset();
        ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
        if ProductionOrder.FindSet() then
            repeat
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."Order Type"::Production);
                ItemLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
                if not ItemLedgerEntry.FindFirst() then
                    ILE := true
                else
                    ILE := false;
                CapacityLedgerEntry.Reset();
                CapacityLedgerEntry.SetRange("Order Type", CapacityLedgerEntry."Order Type"::Production);
                CapacityLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
                if not CapacityLedgerEntry.FindFirst() then
                    CLE := true
                else
                    CLE := false;
                if ILE and CLE then
                    ProductionOrder.Mark(true);

            until ProductionOrder.Next() = 0;
        ProductionOrder.MarkedOnly(true);
        MyRP0 := ProductionOrder.Count;
        // Message('%1', MyRP0);
    end;

    local procedure RPOFUN_2()
    begin
        StartDate := Today - 2;
        ProductionOrder.Reset();
        ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
        ProductionOrder.SetFilter("Creation Date", '<%1', StartDate);
        if ProductionOrder.FindSet() then
            repeat
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."Order Type"::Production);
                ItemLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
                if not ItemLedgerEntry.FindFirst() then
                    ILE := true
                else
                    ILE := false;
                CapacityLedgerEntry.Reset();
                CapacityLedgerEntry.SetRange("Order Type", CapacityLedgerEntry."Order Type"::Production);
                CapacityLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
                if not CapacityLedgerEntry.FindFirst() then
                    CLE := true
                else
                    CLE := false;
                if ILE and CLE then
                    ProductionOrder.Mark(true);

            until ProductionOrder.Next() = 0;
        ProductionOrder.MarkedOnly(true);
        MyRP0New := ProductionOrder.Count;
        //Message('%1', MyRP0New);
    end;

    local procedure RPOItemFun()
    var
        ProductionOrderGRec: Record "Production Order";
        ReleasedProductionOrderGPage: Page "Released Production Orders";
        ProductionOrderLineGRec: Record "Prod. Order Line";
        ProductionOrderHeader: Record "Production Order";
    begin
        ProductionOrderGRec.Reset();
        ProductionOrderGRec.SetRange("Source Type", ProductionOrderGRec."Source Type"::Item);
        ProductionOrderGRec.SetRange(Status, ProductionOrderGRec.Status::Released);
        if ProductionOrderGRec.FindSet() then
            repeat
                if ItemGRec.Get(ProductionOrderGRec."Source No.") and ItemGRec.Subcontracting then
                    ProductionOrderGRec.Mark(true);
            until ProductionOrderGRec.Next() = 0;
        ProductionOrderGRec.MarkedOnly(true);
        MyRPOItem := ProductionOrderGRec.Count;
    end;

    local procedure RPOConsumptionFun()
    begin
        ProductionOrder.Reset();
        ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
        if ProductionOrder.FindSet() then
            repeat
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."Order Type"::Production);
                ItemLedgerEntry.SetRange("Order No.", ProductionOrder."No.");
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                if ItemLedgerEntry.FindFirst() then
                    ILE := true
                else
                    ILE := false;

                if ILE then
                    ProductionOrder.Mark(true);

            until ProductionOrder.Next() = 0;
        ProductionOrder.MarkedOnly(true);
        RPOConsumption := ProductionOrder.Count;

    end;

    local procedure RPOComponentsFun()
    var
        ProductionOrderGRec: Record "Production Order";
        ReleasedProductionOrderGPage: Page "Released Production Orders";
        ProductionOrderLineGRec: Record "Prod. Order Line";
        ProductionOrderHeader: Record "Production Order";
    begin
        ProductionOrderHeader.Reset();
        ProductionOrderHeader.SetRange(Status, ProductionOrderHeader.Status::Released);
        if ProductionOrderHeader.FindSet() then
            repeat
                Clear(ProdComponetQty);
                Clear(ILEQuantityLVar);
                ProductionOrderLineGRec.Reset();
                ProductionOrderLineGRec.SetRange("Prod. Order No.", ProductionOrderHeader."No.");
                if ProductionOrderLineGRec.FindSet() then
                    repeat

                        ProductionComponentGRec.Reset();
                        ProductionComponentGRec.SetRange("Prod. Order No.", ProductionOrderLineGRec."Prod. Order No.");
                        ProductionComponentGRec.SetRange("Prod. Order Line No.", ProductionOrderLineGRec."Line No.");
                        if ProductionComponentGRec.FindSet() then
                            repeat
                                ItemLedgerEntry.Reset();
                                ItemLedgerEntry.SetRange("Document No.", ProductionOrderLineGRec."Prod. Order No.");
                                ItemLedgerEntry.SetRange("Item No.", ProductionComponentGRec."Item No.");
                                if ItemLedgerEntry.FindSet() then begin
                                    ItemLedgerEntry.CalcSums(Quantity);
                                    ILEQuantityLVar += ItemLedgerEntry.Quantity;
                                end;
                                ProdComponetQty += ProductionComponentGRec."Expected Quantity";
                            until ProductionComponentGRec.Next() = 0;
                    until ProductionOrderLineGRec.Next() = 0;
                if ProdComponetQty = ILEQuantityLVar then
                    ILEQTy := true
                else
                    ILEQTy := false;
                if ILEQTy then
                    ProductionOrderHeader.Mark(true);

            until ProductionOrderHeader.Next() = 0;
        ProductionOrderHeader.MarkedOnly(true);
        RPOComponent := ProductionOrderHeader.Count;

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

    procedure FgqcpendingProcedure()
    var
        ProductionOrderLvar: Record "Production Order";
        ProductionOrderLineLvar: Record "Prod. Order Line";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        ProductionOrderLineLvar.Reset();
        ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
        ProductionOrderLineLvar.SetRange("WIP QC Enabled B2B", true);
        ProductionOrderLineLvar.SetFilter("Quantity Sent to Quality B2B", '<>%1', 0);
        if ProductionOrderLineLvar.FindSet() then
            repeat
                ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" <> ProductionOrderLineLvar."Quantity Sent to Quality B2B" then begin
                    if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                        ProductionOrderLvar.Mark(true);
                end;
            until ProductionOrderLineLvar.Next() = 0;
        ProductionOrderLvar.MarkedOnly(true);
        if ProductionOrderLvar.FindSet() then
            FGQCPending := ProductionOrderLvar.Count;


    end;

    procedure FgqcCompletdProcedure()
    var
        ProductionOrderLvar: Record "Production Order";
        ProductionOrderLineLvar: Record "Prod. Order Line";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        ProductionOrderLineLvar.Reset();
        ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
        ProductionOrderLineLvar.SetRange("WIP QC Enabled B2B", true);
        ProductionOrderLineLvar.SetFilter("Quantity Sent to Quality B2B", '<>%1', 0);
        if ProductionOrderLineLvar.FindSet() then
            repeat
                ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" = ProductionOrderLineLvar."Quantity Sent to Quality B2B" then begin
                    if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                        ProductionOrderLvar.Mark(true);
                end;
            until ProductionOrderLineLvar.Next() = 0;
        ProductionOrderLvar.MarkedOnly(true);
        if ProductionOrderLvar.FindSet() then
            FGQCCompleted := ProductionOrderLvar.Count;


    end;

    procedure InProcessQCSFGStatus()
    var
        InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
        InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
        ProductionOrderLrec: Record "Production Order";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        ProductionOrderLrec.Reset();
        ProductionOrderLrec.SetRange(Status, ProductionOrderLrec.Status::Released);
        if ProductionOrderLrec.FindSet() then
            repeat
                InspectionDataHdrLrec.Reset();
                InspectionDataHdrLrec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                if InspectionDataHdrLrec.FindSet() then
                    ProductionOrderLrec.Mark(true);
                InsReceiptHdrLRec.Reset();
                InsReceiptHdrLRec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                if InsReceiptHdrLRec.FindSet() then
                    ProductionOrderLrec.Mark(true);
            until ProductionOrderLrec.Next() = 0;
        ProductionOrderLrec.MarkedOnly(true);
        if ProductionOrderLrec.FindSet() then
            InProcessQCSFG := ProductionOrderLrec.Count;
    end;

    procedure InProcessrelatedIDSpostingpendingpurchase()
    var
        InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
        InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
        ProductionOrderLrec: Record "Production Order";
        PurchaseHeaderLrec: Record "Purchase Header";
        PurchaseOrders: Page "Purchase Order List";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        PurchaseHeaderLrec.Reset();
        PurchaseHeaderLrec.SetRange("Document Type", PurchaseHeaderLrec."Document Type"::Order);
        if PurchaseHeaderLrec.FindSet() then
            repeat
                InspectionDataHdrLrec.Reset();
                InspectionDataHdrLrec.SetRange("Order No.", PurchaseHeaderLrec."No.");
                if InspectionDataHdrLrec.FindSet() then
                    PurchaseHeaderLrec.Mark(true);

            until PurchaseHeaderLrec.Next() = 0;
        PurchaseHeaderLrec.MarkedOnly(true);
        if PurchaseHeaderLrec.FindSet() then
            IDSPostingPendingPurchase := PurchaseHeaderLrec.Count;

    end;

    procedure InProcessrelatedIDSpostingpendingproduction()
    var
        InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
        InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
        ProductionOrderLrec: Record "Production Order";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        ProductionOrderLrec.Reset();
        ProductionOrderLrec.SetRange(Status, ProductionOrderLrec.Status::Released);
        if ProductionOrderLrec.FindSet() then
            repeat
                InspectionDataHdrLrec.Reset();
                InspectionDataHdrLrec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                if InspectionDataHdrLrec.FindSet() then
                    ProductionOrderLrec.Mark(true);
            until ProductionOrderLrec.Next() = 0;
        ProductionOrderLrec.MarkedOnly(true);
        if ProductionOrderLrec.FindSet() then
            IDSPostingPendingProduction := ProductionOrderLrec.count;
    end;

    procedure MRVSCount()
    var
        PurchaseRcptHdr: Record "Purch. Rcpt. Header";
    begin
        PurchaseRcptHdr.Reset();
        if PurchaseRcptHdr.FindSet() then
            MRVS := PurchaseRcptHdr.Count;
    end;

    procedure ProductionBomCertifiedCount()
    var
        ProductionBOMHdrLrec: Record "Production BOM Header";
        ProductionBomsList: Page "Production BOM List";
    begin
        ProductionBOMHdrLrec.Reset();
        ProductionBOMHdrLrec.SetRange(Status, ProductionBOMHdrLrec.Status::Certified);
        if ProductionBOMHdrLrec.FindSet() then
            CertifiedBOMS := ProductionBOMHdrLrec.Count;
    end;

    procedure QAPCheckList()
    var
        SalesCheckList: Record SalesCheckList;
        salesHeader: Record "Sales Header";
        SalesOrderList: Page "Sales Order List";
    begin
        salesHeader.Reset();
        salesHeader.SetRange("Document Type", salesHeader."Document Type"::Order);
        if salesHeader.FindSet() then
            repeat
                SalesCheckList.Reset();
                SalesCheckList.SetRange("Document Type", SalesCheckList."Document Type"::Order);
                SalesCheckList.SetRange("No.", salesHeader."No.");
                SalesCheckList.SetFilter(Check, '<>%1', SalesCheckList.Check::Yes);
                if SalesCheckList.FindFirst() then
                    salesHeader.Mark(true);
            until salesHeader.Next() = 0;
        salesHeader.MarkedOnly(true);
        if salesHeader.FindSet() then
            QAPProgress := salesHeader.Count;
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

    procedure InspectionDataSheetList()
    var
        InspectonDataSheet: Record "Ins Datasheet Header B2B";
        PostedInsDataSeetList: Page "Inspection Data Sheet List B2B";
    begin
        InspectonDataSheet.Reset();
        if InspectonDataSheet.FindSet() then
            IDSList := InspectonDataSheet.Count;

    end;

    procedure InspectionReceiptList()
    var
        InspectionReceipt: Record "Inspection Receipt Header B2B";
        InspectionReceiptList: Page "Inspection Receipt List B2B";
    begin
        InspectionReceipt.Reset();
        InspectionReceipt.SetRange(Status, false);
        if InspectionReceipt.FindSet() then
            IRList := InspectionReceipt.Count;

    end;

    procedure IDSListPendingFor2Days()
    var
        InspectionDataSheet: Record "Ins Datasheet Header B2B";
        PurchaseReceipt: Record "Purch. Rcpt. Header";
        inspectiondatasheetlist: Page "Inspection Data Sheet List B2B";
    begin
        InspectionDataSheet.Reset();
        if InspectionDataSheet.FindSet() then
            repeat
                PurchaseReceipt.Reset();
                PurchaseReceipt.SetRange("No.", InspectionDataSheet."Receipt No.");
                if PurchaseReceipt.FindFirst() then begin
                    if PurchaseReceipt."Posting Date" < WorkDate() - 2 then
                        InspectionDataSheet.Mark(true);
                end;
            until InspectionDataSheet.Next() = 0;
        InspectionDataSheet.MarkedOnly(true);
        if InspectionDataSheet.FindSet() then
            IDSListPendingForMrv := InspectionDataSheet.Count;

    end;

    procedure IRListPendingfor2days()
    var
        InspectionDataSheet: Record "Inspection Receipt Header B2B";
        PurchaseReceipt: Record "Purch. Rcpt. Header";
        inspectiondatasheetlist: Page "Inspection Receipt List B2B";
    begin
        InspectionDataSheet.Reset();
        InspectionDataSheet.SetRange(Status, false);
        if InspectionDataSheet.FindSet() then
            repeat
                PurchaseReceipt.Reset();
                PurchaseReceipt.SetRange("No.", InspectionDataSheet."Receipt No.");
                if PurchaseReceipt.FindFirst() then begin
                    if PurchaseReceipt."Posting Date" < WorkDate() - 2 then
                        InspectionDataSheet.Mark(true)
                end;
            until InspectionDataSheet.Next() = 0;
        InspectionDataSheet.MarkedOnly(true);
        if InspectionDataSheet.FindSet() then
            IRListPeningForMrv := InspectionDataSheet.Count;
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

    procedure JobWorkPendingForSunconVendorList()
    var
        TransferHdr: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferOrderList: page "Transfer Orders";
        ItemLedgerEntries: Record "Item Ledger Entry";
        TransferShipment: Record "Transfer Shipment Header";
        TransferReceipt: Record "Transfer Receipt Header";
    begin
        TransferHdr.Reset();
        TransferHdr.SetRange("Created From MRS", false);
        TransferHdr.SetFilter("Subcon Order No.", '<>%1', '');
        if TransferHdr.FindSet() then
            repeat
                TransferShipment.Reset();
                TransferShipment.SetRange("Transfer Order No.", TransferHdr."No.");
                if TransferShipment.FindSet() then
                    repeat
                        ItemLedgerEntries.Reset();
                        ItemLedgerEntries.SetRange("Entry Type", ItemLedgerEntries."Entry Type"::Transfer);
                        ItemLedgerEntries.SetRange("Document Type", ItemLedgerEntries."Document Type"::"Transfer Shipment");
                        ItemLedgerEntries.SetRange("Document No.", TransferShipment."No.");
                        if ItemLedgerEntries.FindSet() then
                            repeat
                                if ItemLedgerEntries."Posting Date" < WorkDate() - 180 then
                                    TransferHdr.Mark(true);
                            until ItemLedgerEntries.Next() = 0;
                    until TransferShipment.Next() = 0;
                TransferReceipt.Reset();
                TransferReceipt.SetRange("Transfer Order No.", TransferHdr."No.");
                if TransferReceipt.FindSet() then
                    repeat
                        ItemLedgerEntries.Reset();
                        ItemLedgerEntries.SetRange("Entry Type", ItemLedgerEntries."Entry Type"::Transfer);
                        ItemLedgerEntries.SetRange("Document Type", ItemLedgerEntries."Document Type"::"Transfer Receipt");
                        ItemLedgerEntries.SetRange("Document No.", TransferReceipt."No.");
                        if ItemLedgerEntries.FindSet() then
                            repeat
                                if ItemLedgerEntries."Posting Date" < WorkDate() - 180 then
                                    TransferHdr.Mark(true);
                            until ItemLedgerEntries.Next() = 0;
                    until TransferReceipt.Next() = 0;
            until TransferHdr.Next() = 0;
        TransferHdr.MarkedOnly(true);
        if TransferHdr.FindSet() then
            RPOsOutputPending := TransferHdr.Count;
    end;

    procedure Rpospendingforjobworklist()
    var
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ReleasedProductionOrderList: Page "Released Production Orders";
    begin
        ProductionOrder.Reset();
        ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
        ProductionOrder.SetRange("Subcontracting Order", true);
        if ProductionOrder.FindSet() then
            repeat
                ProdOrderLine.Reset();
                ProdOrderLine.SetRange(Status, ProductionOrder.Status);
                ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                if ProdOrderLine.FindSet() then
                    repeat
                        if (ProdOrderLine."Finished Quantity" > 0) and (ProdOrderLine."Finished Quantity" < ProdOrderLine.Quantity) then
                            ProductionOrder.Mark(true);
                    until ProdOrderLine.Next() = 0;
            until ProductionOrder.Next() = 0;
        ProductionOrder.MarkedOnly(true);
        if ProductionOrder.FindSet() then
            RPOsPendingForJobWorkPo := ProductionOrder.Count;
    end;

    procedure Rpospendingoutputslist()
    var
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ReleasedProductionOrderList: Page "Released Production Orders";
    begin
        ProductionOrder.Reset();
        ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
        ProductionOrder.SetRange("Subcontracting Order", false);
        if ProductionOrder.FindSet() then
            repeat
                ProdOrderLine.Reset();
                ProdOrderLine.SetRange(Status, ProductionOrder.Status);
                ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
                if ProdOrderLine.FindSet() then
                    repeat
                        if (ProdOrderLine."Finished Quantity" > 0) and (ProdOrderLine."Finished Quantity" < ProdOrderLine.Quantity) then
                            ProductionOrder.Mark(true);
                    until ProdOrderLine.Next() = 0;
            until ProductionOrder.Next() = 0;
        ProductionOrder.MarkedOnly(true);
        if ProductionOrder.FindSet() then
            RPOsOutputPending := ProductionOrder.Count;

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

    procedure TransferOrdersCreatedList()
    var
        TransferHedaer: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferOrderList: page "Transfer Orders";
    begin
        TransferHedaer.Reset();
        TransferHedaer.SetRange("Created From MRS", false);
        if TransferHedaer.FindSet() then
            repeat
                TransferLine.Reset();
                TransferLine.SetRange("Document No.", TransferHedaer."No.");
                TransferLine.SetRange("Derived From Line No.", 0);
                TransferLine.SetFilter("Item No.", '<>%1', '');
                if TransferLine.FindSet() then
                    repeat
                        if (TransferLine.Quantity > 0) and (TransferLine."Quantity Shipped" = 0) then
                            TransferHedaer.Mark(true);
                    until TransferLine.Next() = 0;
            until TransferHedaer.Next() = 0;
        if TransferHedaer.FindSet() then
            TransferOrdersCreated := TransferHedaer.Count;
    end;

    procedure TransferOrdersCompletelyShippedButNotReceived()
    var
        TransferHedaer: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferOrderList: page "Transfer Orders";
    begin
        TransferHedaer.Reset();
        TransferHedaer.SetRange("Created From MRS", false);
        if TransferHedaer.FindSet() then begin
            repeat
                TransferLine.Reset();
                TransferLine.SetRange("Derived From Line No.", 0);
                TransferLine.SetRange("Document No.", TransferHedaer."No.");
                if TransferLine.FindSet() then begin
                    repeat
                        if (TransferLine.Quantity = TransferLine."Quantity Shipped") and (TransferLine.Quantity <> TransferLine."Quantity Received") then
                            TransferHedaer.Mark(true);
                    until TransferLine.Next() = 0;
                end;
            until TransferHedaer.Next() = 0;
        end;
        TransferHedaer.MarkedOnly(true);
        if TransferHedaer.FindSet() then
            ShippedNotReceived := TransferHedaer.Count;

    end;

    procedure TransferOrdersPartiallyShippedAndReceived()
    var
        TransferHedaer: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferOrderList: page "Transfer Orders";
    begin
        TransferHedaer.Reset();
        TransferHedaer.SetRange("Created From MRS", false);
        if TransferHedaer.FindSet() then begin
            repeat
                TransferLine.Reset();
                TransferLine.SetRange("Derived From Line No.", 0);
                TransferLine.SetRange("Document No.", TransferHedaer."No.");
                if TransferLine.FindSet() then begin
                    repeat
                        if ((TransferLine.Quantity <> TransferLine."Quantity Shipped") and (TransferLine."Quantity Shipped" > 0)) or ((TransferLine.Quantity <> TransferLine."Quantity Received") and (TransferLine."Quantity Received" > 0)) then
                            TransferHedaer.Mark(true);
                    until TransferLine.Next() = 0;
                end;
            until TransferHedaer.Next() = 0;
        end;
        TransferHedaer.MarkedOnly(true);
        if TransferHedaer.FindSet() then
            PartiallyShippedReceived := TransferHedaer.Count;
    end;

    procedure TransferOrdersCompletelyShippedAndReceived()
    var
        TransferHedaer: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferOrderList: page "Transfer Orders";
    begin
        TransferHedaer.Reset();
        TransferHedaer.SetRange("Created From MRS", false);
        if TransferHedaer.FindSet() then begin
            repeat
                TransferLine.Reset();
                TransferLine.SetRange("Derived From Line No.", 0);
                TransferLine.SetRange("Document No.", TransferHedaer."No.");
                if TransferLine.FindSet() then begin
                    repeat
                        if (TransferLine.Quantity = TransferLine."Quantity Shipped") and (TransferLine.Quantity = TransferLine."Quantity Received") then
                            TransferHedaer.Mark(true);
                    until TransferLine.Next() = 0;
                end;
            until TransferHedaer.Next() = 0;
        end;
        TransferHedaer.MarkedOnly(true);
        if TransferHedaer.FindSet() then
            ShippedReceived := TransferHedaer.Count;
    end;

    procedure MRSTransferOrdersCreatedList()
    var
        TransferHedaer: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferOrderList: page "Transfer Orders MRS";
    begin
        TransferHedaer.Reset();
        TransferHedaer.SetRange("Created From MRS", true);
        if TransferHedaer.FindSet() then
            repeat
                TransferLine.Reset();
                TransferLine.SetRange("Document No.", TransferHedaer."No.");
                TransferLine.SetFilter("Item No.", '<>%1', '');
                TransferLine.SetRange("Derived From Line No.", 0);
                if TransferLine.FindSet() then
                    repeat
                        if (TransferLine.Quantity > 0) and (TransferLine."Quantity Shipped" = 0) then
                            TransferHedaer.Mark(true);
                    until TransferLine.Next() = 0;
            until TransferHedaer.Next() = 0;
        if TransferHedaer.FindSet() then
            MRSTransferOrdersCreated := TransferHedaer.Count;

    end;

    procedure MRSTransferOrdersCompletelyShippedButNotReceived()
    var
        TransferHedaer: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferOrderList: page "Transfer Orders MRS";
    begin
        TransferHedaer.Reset();
        TransferHedaer.SetRange("Created From MRS", true);
        if TransferHedaer.FindSet() then begin
            repeat
                TransferLine.Reset();
                TransferLine.SetRange("Derived From Line No.", 0);
                TransferLine.SetRange("Document No.", TransferHedaer."No.");
                if TransferLine.FindSet() then begin
                    repeat
                        if (TransferLine.Quantity = TransferLine."Quantity Shipped") and (TransferLine.Quantity <> TransferLine."Quantity Received") then
                            TransferHedaer.Mark(true);
                    until TransferLine.Next() = 0;
                end;
            until TransferHedaer.Next() = 0;
        end;
        TransferHedaer.MarkedOnly(true);
        if TransferHedaer.FindSet() then
            MRSShippedNotReceived := TransferHedaer.Count;

    end;

    procedure MRSTransferOrdersPartiallyShippedAndReceived()
    var
        TransferHedaer: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferOrderList: page "Transfer Orders MRS";
    begin
        TransferHedaer.Reset();
        TransferHedaer.SetRange("Created From MRS", true);
        if TransferHedaer.FindSet() then begin
            repeat
                TransferLine.Reset();
                TransferLine.SetRange("Derived From Line No.", 0);
                TransferLine.SetRange("Document No.", TransferHedaer."No.");
                if TransferLine.FindSet() then begin
                    repeat
                        if ((TransferLine.Quantity <> TransferLine."Quantity Shipped") and (TransferLine."Quantity Shipped" > 0)) or ((TransferLine.Quantity <> TransferLine."Quantity Received") and (TransferLine."Quantity Received" > 0)) then
                            TransferHedaer.Mark(true);
                    until TransferLine.Next() = 0;
                end;
            until TransferHedaer.Next() = 0;
        end;
        TransferHedaer.MarkedOnly(true);
        if TransferHedaer.FindSet() then
            MRSPartiallyShippedReceived := TransferHedaer.Count;
    end;

    procedure MRSTransferOrdersCompletelyShippedAndReceived()
    var
        TransferHedaer: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferOrderList: page "Transfer Orders MRS";
    begin
        TransferHedaer.Reset();
        TransferHedaer.SetRange("Created From MRS", true);
        if TransferHedaer.FindSet() then begin
            repeat
                TransferLine.Reset();
                TransferLine.SetRange("Derived From Line No.", 0);
                TransferLine.SetRange("Document No.", TransferHedaer."No.");
                if TransferLine.FindSet() then begin
                    repeat
                        if (TransferLine.Quantity = TransferLine."Quantity Shipped") and (TransferLine.Quantity = TransferLine."Quantity Received") then
                            TransferHedaer.Mark(true);
                    until TransferLine.Next() = 0;
                end;
            until TransferHedaer.Next() = 0;
        end;
        TransferHedaer.MarkedOnly(true);
        if TransferHedaer.FindSet() then
            MRSShippedReceived := TransferHedaer.Count;
    end;

    procedure ShowFinishedRPOILE()
    var
        IleLrec: Record "Item Ledger Entry";
        IlePage: page "Item Ledger Entries";
    begin
        IleLrec.Reset();
        IleLrec.SetRange("Item Category Code", 'FG');
        IleLrec.setfilter("Remaining Quantity", '>%1', 0);
        IleLrec.SetRange("Entry Type", IleLrec."Entry Type"::Output);
        IleLrec.SetFilter("Location Code", '%1|%2', 'DOMPROD', 'EOUPROD');
        if IleLrec.FindSet() then
            RPOFinished := IleLrec.Count;

    end;

    procedure SalesOrdersForWhichRpoNotCreated()
    var
        SalesHeader: Record "Sales Header";
        ProductionHdr: Record "Production Order";
        salesOrderList: Page "Sales Order List";
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then
            repeat
                ProductionHdr.Reset();
                ProductionHdr.SetFilter(ProductionHdr.Status, '%1|%2', ProductionHdr.Status::Released, ProductionHdr.Status::Finished);
                ProductionHdr.SetRange("Sales Order No", SalesHeader."No.");
                if not ProductionHdr.FindFirst() then
                    SalesHeader.Mark(true);
            until SalesHeader.Next() = 0;
        SalesHeader.MarkedOnly(true);
        if SalesHeader.FindSet() then
            SalesOrdersRpoNotCreated := SalesHeader.Count;

    end;

    procedure InBoundInspectionReceiptList()
    var
        InspectionReceipt: Record "Inspection Receipt Header B2B";
        InspectionReceiptList: Page "Inspection Receipt List B2B";
    begin
        InspectionReceipt.Reset();
        InspectionReceipt.SetRange(Status, false);
        InspectionReceipt.SetFilter("Prod. Order No.", '<>%1', '');
        if InspectionReceipt.FindSet() then
            InBoundIRList := InspectionReceipt.Count;
    end;

}
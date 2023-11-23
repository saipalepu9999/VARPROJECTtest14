pageextension 50112 SOProcessorActivitiesExt extends "SO Processor Activities"
{
    layout
    {
        addlast(content)
        {
            cuegroup("New Rolls")
            {
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
                        ProductionOrderLvar.Reset();
                        ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
                        if ProductionOrderLvar.FindSet() then
                            repeat
                                ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                                if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" <> ProductionOrderLineLvar.Quantity then begin
                                    if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                                        ProductionOrderLvar.Mark(true);
                                end;
                            until ProductionOrderLineLvar.Next() = 0;
                        ProductionOrderLvar.MarkedOnly(true);
                        if ProductionOrderLineLvar.FindSet() then;
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
                        ProductionOrderLvar.Reset();
                        ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
                        if ProductionOrderLvar.FindSet() then
                            repeat
                                ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                                if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" = ProductionOrderLineLvar.Quantity then begin
                                    if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                                        ProductionOrderLvar.Mark(true);
                                end;
                            until ProductionOrderLineLvar.Next() = 0;
                        ProductionOrderLvar.MarkedOnly(true);
                        if ProductionOrderLineLvar.FindSet() then;
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
                field(SalesOrdersBomNotCreated; SalesOrdersBomNotCreated)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Orders For Which Bom Has Not Been Created';
                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                        SalesLine: Record "Sales Line";
                        Item: Record Item;
                        SalesOrderList: Page "Sales Order List";
                    begin
                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        if SalesLine.FindSet() then
                            repeat
                                if item.Get(SalesLine."No.") and (Item."Production BOM No." = '') then begin
                                    if SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") then
                                        SalesHeader.Mark(true);
                                end;

                            until SalesLine.Next() = 0;
                        SalesHeader.MarkedOnly(true);
                        if SalesHeader.FindSet() then;
                        SalesOrderList.SetTableView(SalesHeader);
                        SalesOrderList.RunModal();
                    end;
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetCurrRecord()
    begin
        FgqcCompletdProcedure();
        FgqcpendingProcedure();
        InProcessQCSFGStatus();
        SalesOrdersListBomNoCreated();
    end;

    var
        FGQCCompleted: Integer;
        FGQCPending: Integer;
        InProcessQCSFG: Integer;
        QAPProgress: Integer;
        SalesOrdersBomNotCreated: Integer;

    procedure FgqcpendingProcedure()
    var
        ProductionOrderLvar: Record "Production Order";
        ProductionOrderLineLvar: Record "Prod. Order Line";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        ProductionOrderLvar.Reset();
        ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
        if ProductionOrderLvar.FindSet() then
            repeat
                ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" <> ProductionOrderLineLvar.Quantity then begin
                    if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                        ProductionOrderLvar.Mark(true);
                end;
            until ProductionOrderLineLvar.Next() = 0;
        ProductionOrderLvar.MarkedOnly(true);
        if ProductionOrderLineLvar.FindSet() then
            FGQCPending := ProductionOrderLvar.Count;


    end;

    procedure FgqcCompletdProcedure()
    var
        ProductionOrderLvar: Record "Production Order";
        ProductionOrderLineLvar: Record "Prod. Order Line";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        ProductionOrderLvar.Reset();
        ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
        if ProductionOrderLvar.FindSet() then
            repeat
                ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" = ProductionOrderLineLvar.Quantity then begin
                    if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                        ProductionOrderLvar.Mark(true);
                end;
            until ProductionOrderLineLvar.Next() = 0;
        ProductionOrderLvar.MarkedOnly(true);
        if ProductionOrderLineLvar.FindSet() then
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

    procedure SalesOrdersListBomNoCreated()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Item: Record Item;
        SalesOrderList: Page "Sales Order List";
    begin
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SetRange(Type, SalesLine.Type::Item);
        if SalesLine.FindSet() then
            repeat
                if item.Get(SalesLine."No.") and (Item."Production BOM No." = '') then begin
                    if SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") then
                        SalesHeader.Mark(true);
                end;

            until SalesLine.Next() = 0;
        SalesHeader.MarkedOnly(true);
        if SalesHeader.FindSet() then
            SalesOrdersBomNotCreated := SalesHeader.Count;
    end;
}
pageextension 50054 "Released prod OrderExt" extends "Released Production Order"
{
    layout
    {
        addlast(General)
        {
            field("Sales Order No"; Rec."Sales Order No")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Sales Order No field.';
            }
            field("Sales Order Line No."; Rec."Sales Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Order Line No. field.';
            }
            field(RD; Rec.RD)
            {
                ApplicationArea = ALL;
                Caption = 'R&D';
            }
            /*field("Sales Order No(Parent)"; Rec."Sales Order No(Parent)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Parent Sales Order No field.';
            }
            field("Parent Sales Line No."; Rec."Parent Sales Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Parent Sales Order Line No. field.';
            }*/
            field("Subcontracting Order"; Rec."Subcontracting Order")
            {
                Visible = false;
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Sales Order No field.';
            }
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Purchase Order No. field.';
                Visible = false;
            }
            field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Lot No. field.';
            }
            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date on which you created the production order.';
            }

        }

        modify("Shortcut Dimension 1 Code")
        {
            trigger OnBeforeValidate()
            begin
                if CopyStr("Shortcut Dimension 1 Code", 1, 1) <> CopyStr("No. Series", 1, 1) then
                    Error('Please Select The Correct Division');
            end;
        }
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                if CopyStr("Location Code", 1, 1) <> CopyStr("No. Series", 1, 1) then
                    Error('Please Select The Correct Division');
            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        //modify()
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 2 Code_B2B"; Rec."Shortcut Dimension 2 Code_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
            }
        }
    }

    actions
    {
        addlast("F&unctions")
        {
            group("Material Issues")
            {
                action("Create MRS")
                {
                    ApplicationArea = All;
                    //PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    Image = Create;
                    ToolTip = 'Executes the Create MRS action.';
                    trigger OnAction()
                    var
                        TransferHeader: Record "Transfer Header";
                        TransferLine: Record "Transfer Line";
                        ProductionOrderLine: Record "Prod. Order Line";
                        InventorySetup: Record "Inventory Setup";
                        NoSeriesMgmt: Codeunit NoSeriesManagement;
                        ProductionOrderComp: Record "Prod. Order Component";
                        LineNoGvar: Integer;
                        FacilityCode: Text;
                        Selection: Integer;
                        ItemRec: Record Item;
                        NoSeries: Record "No. Series";
                        NoSeriesRelationship: Record "No. Series Relationship";
                    begin
                        Clear(HeaderCreated);
                        Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code");
                        Rec.TestField("Assigned User ID");
                        ProductionOrderLine.Reset();
                        ProductionOrderLine.SetRange(Status, Rec.Status);
                        ProductionOrderLine.SetRange("Prod. Order No.", Rec."No.");
                        ProductionOrderLine.SetRange("Create Mrs", true);
                        if not ProductionOrderLine.FindFirst() then
                            Error('Please Select The Lines To Crate Mrs');
                        LineNoGvar := 10000;
                        ProductionOrderLine.Reset();
                        ProductionOrderLine.SetRange(Status, Rec.Status);
                        ProductionOrderLine.SetRange("Prod. Order No.", Rec."No.");
                        ProductionOrderLine.SetRange("Create Mrs", true);
                        if ProductionOrderLine.FindSet() then
                            repeat
                                ProductionOrderComp.Reset();
                                ProductionOrderComp.SetRange(Status, ProductionOrderLine.Status);
                                ProductionOrderComp.SetRange("Prod. Order No.", ProductionOrderLine."Prod. Order No.");
                                ProductionOrderComp.SetRange("Prod. Order Line No.", ProductionOrderLine."Line No.");
                                if ProductionOrderComp.FindSet() then begin
                                    if not HeaderCreated then begin
                                        InventorySetup.Get();
                                        //FacilityCode := 'DOMESTIC,EOU';
                                        //Selection := StrMenu(FacilityCode, 1, 'Select a dimension');
                                        TransferHeader.Init;
                                        //TransferHeader."Production Order Line No." := Rec."Line No.";
                                        NoSeries.Reset();
                                        NoSeriesRelationship.SetRange(Code, InventorySetup."MRS Nos.");
                                        NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", Rec."Shortcut Dimension 1 Code");
                                        if NoSeriesRelationship.FindSet() then
                                            repeat
                                                NoSeries.Code := NoSeriesRelationship."Series Code";
                                                NoSeries.Mark := true;
                                            until NoSeriesRelationship.Next() = 0;
                                        if NoSeries.Get(InventorySetup."MRS Nos.") then
                                            if NoSeries."Shortcut Dimension 1 Code_B2B" = Rec."Shortcut Dimension 1 Code" then
                                                NoSeries.Mark := true;
                                        NoSeries.MarkedOnly := true;
                                        //if PAGE.RunModal(0, NoSeries) = ACTION::LookupOK then begin
                                        //Noseries.SETRANGE(Code, PurchaseSetup."Quote Nos.");
                                        //IF PAGE.RUNMODAL(458, Noseries) = ACTION::LookupOK THEN
                                        if NoSeries.FindSet() then
                                            // SalesOrderHeader."No." := NoseriesMgmt.GetNextNo(NoSeries.Code, WorkDate(), true);
                                            TransferHeader."No." := NoSeriesMgmt.GetNextNo(NoSeries.Code, WorkDate(), true);
                                        TransferHeader."No. Series" := NoSeries.Code;
                                        TransferHeader.Insert(true);
                                        if Rec."Shortcut Dimension 1 Code" = 'DOM' then begin
                                            TransferHeader.Validate("Transfer-from Code", InventorySetup."Stores Location(DOM)");
                                            TransferHeader.Validate("Transfer-to Code", InventorySetup."Production Location(DOM)");
                                        end else
                                            if Rec."Shortcut Dimension 1 Code" = 'EOU' then begin
                                                TransferHeader.Validate("Transfer-from Code", InventorySetup."Stores Location(EOU)");
                                                TransferHeader.Validate("Transfer-to Code", InventorySetup."Production Location(EOU)");
                                            end;
                                        TransferHeader."Production Order No." := Rec."No.";
                                        TransferHeader."Created From MRS" := true;
                                        TransferHeader.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                                        TransferHeader.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                                        TransferHeader.Validate("Assigned User ID", Rec."Assigned User ID");
                                        TransferHeader.Modify(true);
                                        HeaderCreated := true;
                                    end;
                                    repeat
                                        //if ItemRec.Get(ProductionOrderComp."Item No.") And ((ItemRec."Item Category Code" <> 'FG')) then begin
                                        TransferLine.Init();
                                        TransferLine."Document No." := TransferHeader."No.";
                                        TransferLine."Line No." := LineNoGvar;
                                        LineNoGvar += 10000;
                                        TransferLine.Insert(true);
                                        TransferLine.Validate("Item No.", ProductionOrderComp."Item No.");

                                        TransferLine.Validate("Unit of Measure Code", ProductionOrderComp."Unit of Measure Code");
                                        TransferLine.Validate(Quantity, ProductionOrderComp."Expected Quantity");
                                        TransferLine.Modify(true);
                                    // end;
                                    until ProductionOrderComp.Next() = 0;
                                end;
                            until ProductionOrderLine.Next() = 0;
                        Message('Transfer Order-%1 Has Been Created', TransferHeader."No.");
                    end;
                }
                action("Create Additional MRS")
                {
                    ApplicationArea = All;
                    //PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    Image = Create;
                    ToolTip = 'Executes the Create Additional MRS action.';
                    trigger OnAction()
                    var
                        TransferHeader: Record "Transfer Header";
                        InventorySetup: Record "Inventory Setup";
                        NoSeriesMgmt: Codeunit NoSeriesManagement;
                        FacilityCode: Text;
                        Selection: Integer;
                        NoSeries: Record "No. Series";
                        NoSeriesRelationship: Record "No. Series Relationship";
                    begin
                        Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code");
                        Rec.TestField("Assigned User ID");
                        InventorySetup.Get();
                        TransferHeader.Init;
                        NoSeries.Reset();
                        NoSeriesRelationship.SetRange(Code, InventorySetup."MRS Nos.");
                        NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", Rec."Shortcut Dimension 1 Code");
                        if NoSeriesRelationship.FindSet() then
                            repeat
                                NoSeries.Code := NoSeriesRelationship."Series Code";
                                NoSeries.Mark := true;
                            until NoSeriesRelationship.Next() = 0;
                        if NoSeries.Get(InventorySetup."MRS Nos.") then
                            if NoSeries."Shortcut Dimension 1 Code_B2B" = Rec."Shortcut Dimension 1 Code" then
                                NoSeries.Mark := true;
                        NoSeries.MarkedOnly := true;
                        //if PAGE.RunModal(0, NoSeries) = ACTION::LookupOK then begin
                        //Noseries.SETRANGE(Code, PurchaseSetup."Quote Nos.");
                        //IF PAGE.RUNMODAL(458, Noseries) = ACTION::LookupOK THEN
                        if NoSeries.FindSet() then
                            // SalesOrderHeader."No." := NoseriesMgmt.GetNextNo(NoSeries.Code, WorkDate(), true);
                            TransferHeader."No." := NoSeriesMgmt.GetNextNo(NoSeries.Code, WorkDate(), true);
                        TransferHeader."No. Series" := NoSeries.Code;
                        // TransferHeader."Production Order Line No." := Rec."Line No.";
                        //TransferHeader."No." := NoSeriesMgmt.GetNextNo(InventorySetup."MRS Nos.", WorkDate(), true);

                        TransferHeader.Insert(true);
                        TransferHeader.Validate("Assigned User ID", Rec."Assigned User ID");
                        if Rec."Shortcut Dimension 1 Code" = 'DOM' then begin
                            TransferHeader.Validate("Transfer-from Code", InventorySetup."Stores Location(DOM)");
                            TransferHeader.Validate("Transfer-to Code", InventorySetup."Production Location(DOM)");
                        end else
                            if Rec."Shortcut Dimension 1 Code" = 'EOU' then begin
                                TransferHeader.Validate("Transfer-from Code", InventorySetup."Stores Location(EOU)");
                                TransferHeader.Validate("Transfer-to Code", InventorySetup."Production Location(EOU)");
                            end;
                        TransferHeader."Production Order No." := Rec."No.";
                        TransferHeader."Created From MRS" := true;
                        TransferHeader.Modify(true);
                        Message('Transfer Order has been created -%1', TransferHeader."No.");
                    end;
                }
                action("Mrs List")
                {
                    ApplicationArea = All;
                    Image = List;
                    //PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    RunObject = page "Transfer Orders MRS";
                    RunPageLink = "Production Order No." = field("No.");
                    ToolTip = 'Executes the Mrs List action.';
                    trigger OnAction()
                    begin
                        //Message('Hi');
                    end;
                }
                action("Posted MRS Shipments")
                {
                    ApplicationArea = All;
                    Image = List;
                    //PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    RunObject = page "Posted Transfer Shipments";
                    RunPageLink = "Production Order No." = field("No.");
                    ToolTip = 'Executes the Posted MRS Shipments action.';
                    trigger OnAction()
                    begin
                        //Message('Hi');
                    end;
                }
                action("Posted MRS Receipts")
                {
                    ApplicationArea = All;
                    Image = List;
                    //PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    RunObject = page "Posted Transfer Receipts";
                    RunPageLink = "Production Order No." = field("No.");
                    ToolTip = 'Executes the Posted MRS Receipts action.';
                    trigger OnAction()
                    begin
                        // Message('Hi');
                    end;
                }
                action("Excess Material Return")
                {
                    ApplicationArea = All;
                    //PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    Image = Create;
                    ToolTip = 'Executes the Create Excess Material Return action.';

                    trigger OnAction()
                    var
                        TransferHeader: Record "Transfer Header";
                        TransferLineGrec: Record "Transfer Line";
                        InventorySetup: Record "Inventory Setup";
                        NoSeriesMgmt: Codeunit NoSeriesManagement;
                        FacilityCode: Text;
                        Selection: Integer;
                        LineNoLvar: Integer;
                        NoSeries: Record "No. Series";
                        NoSeriesRelationship: Record "No. Series Relationship";
                        ProdOrderLineGrec: Record "Prod. Order Line";
                        TransferReceiptHdrGrec: Record "Transfer Receipt Header";
                        TransferReceiptLineGrec: Record "Transfer Receipt Line";
                        ItemLedgerEntryGrec: Record "Item Ledger Entry";
                        ItemNoGvar: Text;
                        QuantityGvar: Decimal;
                        ItemLedgerEntryGrec2: Record "Item Ledger Entry";
                    begin
                        Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code");
                        Rec.TestField("Assigned User ID");
                        /*ProdOrderLineGrec.Reset();
                        ProdOrderLineGrec.SetRange(Status, Status);
                        ProdOrderLineGrec.SetRange("Prod. Order No.", "No.");
                        ProdOrderLineGrec.SetFilter("Remaining Quantity", '>%1', 0);
                        if ProdOrderLineGrec.FindFirst() then
                            Error('You cannot create material returns');*/
                        LineNoLvar := 10000;
                        clear(HedaerCretedNew);
                        TransferReceiptHdrGrec.Reset();
                        TransferReceiptHdrGrec.SetRange("Production Order No.", Rec."No.");
                        if TransferReceiptHdrGrec.FindSet() then
                            repeat
                                TransferReceiptLineGrec.Reset();
                                TransferReceiptLineGrec.SetRange("Document No.", TransferReceiptHdrGrec."No.");
                                TransferReceiptLineGrec.SetFilter("Item No.", '<>%1', '');
                                if TransferReceiptLineGrec.FindSet() then
                                    repeat
                                        ItemLedgerEntryGrec.Reset();
                                        ItemLedgerEntryGrec.SetRange("Document Type", ItemLedgerEntryGrec."Document Type"::"Transfer Receipt");
                                        ItemLedgerEntryGrec.SetRange("Document No.", TransferReceiptLineGrec."Document No.");
                                        ItemLedgerEntryGrec.SetRange("Document Line No.", TransferReceiptLineGrec."Line No.");
                                        ItemLedgerEntryGrec.SetFilter("Remaining Quantity", '>%1', 0);
                                        ItemLedgerEntryGrec.SetCurrentKey("Item No.");
                                        if ItemLedgerEntryGrec.FindSet() then begin
                                            if not HedaerCretedNew then begin
                                                InventorySetup.Get();
                                                InventorySetup.TestField("Transfer Order Nos.");
                                                //FacilityCode := 'DOMESTIC,EOU';
                                                //Selection := StrMenu(FacilityCode, 1, 'Select a dimension');
                                                TransferHeader.Init;
                                                //TransferHeader."Production Order Line No." := Rec."Line No.";
                                                NoSeries.Reset();
                                                NoSeriesRelationship.SetRange(Code, InventorySetup."Transfer Order Nos.");
                                                NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", Rec."Shortcut Dimension 1 Code");
                                                if NoSeriesRelationship.FindSet() then
                                                    repeat
                                                        NoSeries.Code := NoSeriesRelationship."Series Code";
                                                        NoSeries.Mark := true;
                                                    until NoSeriesRelationship.Next() = 0;
                                                if NoSeries.Get(InventorySetup."Transfer Order Nos.") then
                                                    if NoSeries."Shortcut Dimension 1 Code_B2B" = Rec."Shortcut Dimension 1 Code" then
                                                        NoSeries.Mark := true;
                                                NoSeries.MarkedOnly := true;
                                                //if PAGE.RunModal(0, NoSeries) = ACTION::LookupOK then begin
                                                //Noseries.SETRANGE(Code, PurchaseSetup."Quote Nos.");
                                                //IF PAGE.RUNMODAL(458, Noseries) = ACTION::LookupOK THEN
                                                if NoSeries.FindSet() then
                                                    // SalesOrderHeader."No." := NoseriesMgmt.GetNextNo(NoSeries.Code, WorkDate(), true);
                                                    TransferHeader."No." := NoSeriesMgmt.GetNextNo(NoSeries.Code, WorkDate(), true);
                                                // TransferHeader."No." := NoSeriesMgmt.GetNextNo(InventorySetup."MRS Nos.", WorkDate(), true);
                                                TransferHeader."No. Series" := NoSeries.Code;
                                                TransferHeader.Insert(true);

                                                if Rec."Shortcut Dimension 1 Code" = 'DOM' then begin
                                                    TransferHeader.Validate("Transfer-from Code", InventorySetup."Production Location(DOM)");
                                                    TransferHeader.Validate("Transfer-to Code", InventorySetup."Stores Location(DOM)");
                                                end else
                                                    if Rec."Shortcut Dimension 1 Code" = 'EOU' then begin
                                                        TransferHeader.Validate("Transfer-from Code", InventorySetup."Production Location(EOU)");
                                                        TransferHeader.Validate("Transfer-to Code", InventorySetup."Stores Location(EOU)");
                                                    end;
                                                TransferHeader."Production Order No." := Rec."No.";
                                                TransferHeader.Validate("Assigned User ID", Rec."Assigned User ID");
                                                TransferHeader.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                                                TransferHeader.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                                                //TransferHeader."Production Order Line No." := Rec."Line No.";
                                                TransferHeader.Validate("Excess Material Returns", true);
                                                TransferHeader.Modify(true);
                                                HedaerCretedNew := true;
                                            end;
                                            repeat
                                                Clear(QuantityGvar);
                                                if ItemNoGvar <> ItemLedgerEntryGrec."Item No." then begin
                                                    ItemNoGvar := ItemLedgerEntryGrec."Item No.";
                                                    ItemLedgerEntryGrec2.Reset();
                                                    ItemLedgerEntryGrec2.SetRange("Document Type", ItemLedgerEntryGrec2."Document Type"::"Transfer Receipt");
                                                    ItemLedgerEntryGrec2.SetRange("Document No.", TransferReceiptLineGrec."Document No.");
                                                    ItemLedgerEntryGrec2.SetRange("Item No.", ItemLedgerEntryGrec."Item No.");
                                                    if ItemLedgerEntryGrec2.FindSet() then begin
                                                        repeat
                                                            // ItemLedgerEntryGrec2.CalcSums("Remaining Quantity");
                                                            QuantityGvar += ItemLedgerEntryGrec2."Remaining Quantity" / ItemLedgerEntryGrec2."Qty. per Unit of Measure";
                                                        until ItemLedgerEntryGrec2.Next() = 0;
                                                    end;
                                                    TransferLineGrec.Init();
                                                    TransferLineGrec."Document No." := TransferHeader."No.";
                                                    TransferLineGrec."Line No." := LineNoLvar;
                                                    TransferLineGrec.Insert(true);
                                                    LineNoLvar += 10000;
                                                    TransferLineGrec.Validate("Item No.", ItemNoGvar);
                                                    TransferLineGrec.Validate(Quantity, QuantityGvar);
                                                    TransferLineGrec.Validate("Unit of Measure Code", ItemLedgerEntryGrec."Unit of Measure Code");
                                                    //TransferLineGrec.Validate(l);
                                                    TransferLineGrec.Modify(true);
                                                end;
                                            until ItemLedgerEntryGrec.Next() = 0;
                                        end;
                                    until TransferReceiptLineGrec.Next() = 0;
                            until TransferReceiptHdrGrec.Next() = 0;
                        Message('Excess Material Return-%1 Has Been Created', TransferHeader."No.");
                    end;
                }
                action("Excess Material Return List")
                {
                    ApplicationArea = All;
                    Image = List;
                    //PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    RunObject = page "Transfer Orders";
                    RunPageLink = "Production Order No." = field("No.");
                    //ToolTip = 'Executes the Mrs List action.';
                    trigger OnAction()
                    begin
                        //Message('Hi');
                    end;
                }
                action("Finished Good Transfer")
                {
                    ApplicationArea = All;
                    //PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    Image = Create;
                    //ToolTip = 'Executes the Create Excess Material Return action.';

                    trigger OnAction()
                    var
                        TransferHeader: Record "Transfer Header";
                        TransferLine: Record "Transfer Line";
                        InventorySetup: Record "Inventory Setup";
                        NoSeriesMgmt: Codeunit NoSeriesManagement;
                        FacilityCode: Text;
                        Selection: Integer;
                        NoSeries: Record "No. Series";
                        NoSeriesRelationship: Record "No. Series Relationship";
                        ProdOrderLineGrec: Record "Prod. Order Line";
                        ItemLedgerEntries: Record "Item Ledger Entry";
                        ItemNoLVar: Text;
                        LineNoLvar: Integer;
                        ItemLedgerEntry2: Record "Item Ledger Entry";
                        QuantityLvar: Decimal;
                    begin
                        Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code");
                        Rec.TestField("Assigned User ID");
                        /*ProdOrderLineGrec.Reset();
                        ProdOrderLineGrec.SetRange(Status, Status);
                        ProdOrderLineGrec.SetRange("Prod. Order No.", "No.");
                        ProdOrderLineGrec.SetFilter("Remaining Quantity", '>%1', 0);
                        if ProdOrderLineGrec.FindFirst() then
                            Error('You cannot create material returns');*/

                        LineNoLvar := 10000;
                        ItemLedgerEntries.Reset();
                        ItemLedgerEntries.SetRange("Document No.", Rec."No.");
                        ItemLedgerEntries.SetRange("Entry Type", ItemLedgerEntries."Entry Type"::Output);
                        ItemLedgerEntries.SetFilter("Remaining Quantity", '>%1', 0);
                        ItemLedgerEntries.SetCurrentKey("Item No.");
                        if ItemLedgerEntries.FindSet() then begin
                            if not HeaderCreated then begin
                                InventorySetup.Get();
                                InventorySetup.TestField("Transfer Order Nos.");
                                // FacilityCode := 'DOMESTIC,EOU';
                                //Selection := StrMenu(FacilityCode, 1, 'Select a dimension');
                                TransferHeader.Init;
                                NoSeries.Reset();
                                NoSeriesRelationship.SetRange(Code, InventorySetup."Transfer Order Nos.");
                                NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", Rec."Shortcut Dimension 1 Code");
                                if NoSeriesRelationship.FindSet() then
                                    repeat
                                        NoSeries.Code := NoSeriesRelationship."Series Code";
                                        NoSeries.Mark := true
                                    until NoSeriesRelationship.Next() = 0;
                                if NoSeries.Get(InventorySetup."Transfer Order Nos.") then
                                    if NoSeries."Shortcut Dimension 1 Code_B2B" = Rec."Shortcut Dimension 1 Code" then
                                        NoSeries.Mark := true;
                                NoSeries.MarkedOnly := true;
                                if NoSeries.FindSet() then
                                    TransferHeader."No." := NoSeriesMgmt.GetNextNo(NoSeries.Code, WorkDate(), true);
                                TransferHeader."No. Series" := NoSeries.Code;
                                TransferHeader.Insert(true);
                                if Rec."Shortcut Dimension 1 Code" = 'DOM' then begin
                                    TransferHeader.Validate("Transfer-from Code", InventorySetup."Production Location(DOM)");
                                    TransferHeader.Validate("Transfer-to Code", InventorySetup."Stores Location(DOM)");
                                end else
                                    if Rec."Shortcut Dimension 1 Code" = 'EOU' then begin
                                        TransferHeader.Validate("Transfer-from Code", InventorySetup."Production Location(EOU)");
                                        TransferHeader.Validate("Transfer-to Code", InventorySetup."Stores Location(EOU)");
                                    end;
                                TransferHeader."Production Order No." := Rec."No.";
                                TransferHeader.Validate("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                                TransferHeader.Validate("Shortcut Dimension 2 Code", Rec."Shortcut Dimension 2 Code");
                                TransferHeader."Finished Good Transfer" := true;
                                TransferHeader.Modify(true);
                                HeaderCreated := true;
                            end;
                            repeat
                                if ItemNoLVar <> ItemLedgerEntries."Item No." then begin
                                    ItemNoLVar := ItemLedgerEntries."Item No.";
                                    TransferLine.Init();
                                    TransferLine."Document No." := TransferHeader."No.";
                                    TransferLine."Line No." := LineNoLvar;
                                    TransferLine.Insert(true);
                                    LineNoLvar += 10000;
                                    Clear(QuantityLvar);
                                    ItemLedgerEntry2.Reset();
                                    ItemLedgerEntry2.SetRange("Document No.", Rec."No.");
                                    ItemLedgerEntry2.SetRange("Entry Type", ItemLedgerEntry2."Entry Type"::Output);
                                    ItemLedgerEntry2.SetRange("Item No.", ItemLedgerEntries."Item No.");
                                    ItemLedgerEntry2.SetFilter("Remaining Quantity", '>%1', 0);
                                    if ItemLedgerEntry2.FindSet() then begin
                                        repeat
                                            //ItemLedgerEntry2.CalcSums("Remaining Quantity");
                                            QuantityLvar += ItemLedgerEntry2."Remaining Quantity" / ItemLedgerEntry2."Qty. per Unit of Measure";
                                        until ItemLedgerEntry2.Next() = 0;
                                    end;
                                    TransferLine.Validate("Item No.", ItemLedgerEntries."Item No.");
                                    TransferLine.Validate(Quantity, QuantityLvar);
                                    TransferLine.Validate("Unit of Measure Code", ItemLedgerEntries."Unit of Measure Code");
                                    TransferLine.Modify(true);
                                end;
                            until ItemLedgerEntries.Next() = 0;
                        end;
                        Message('Transfer Order %1 Has Been Created', TransferHeader."No.");
                    end;
                }
                action("Finished Good Transfer List")
                {
                    ApplicationArea = All;
                    Image = List;
                    //PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    RunObject = page "Transfer Orders";
                    RunPageLink = "Production Order No." = field("No.");
                    //ToolTip = 'Executes the Mrs List action.';
                    trigger OnAction()
                    begin
                        //Message('Hi');
                    end;
                }
            }
        }
        modify(RefreshProductionOrder)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                Rec.TestField("Assigned User ID");
                if "Subcontracting Order" then
                    Rec.TestField("Purchase Order No.");
                if (not "Subcontracting Order") then begin
                    if ("Shortcut Dimension 2 Code" <> 'D99-GEN') and ("Shortcut Dimension 2 Code" <> 'E99-GEN') then begin
                        Rec.TestField("Sales Order No");
                        Rec.TestField("Sales Order Line No.");
                    end;
                end;
                /*if ((("Shortcut Dimension 2 Code" <> 'D99-GEN') and ("Shortcut Dimension 2 Code" <> 'E99-GEN')) or (not "Subcontracting Order")) then begin
                    Rec.TestField("Sales Order No");
                    Rec.TestField("Sales Order Line No.");
                end;*/
            end;
        }
        modify("Change &Status")
        {
            trigger OnBeforeAction()
            var
                TransferReceiptHdrGrec: Record "Transfer Receipt Header";
                TransferReceiptLineGrec: Record "Transfer Receipt Line";
                ItemLedgerEntryGrec: Record "Item Ledger Entry";
            begin
                if (not "Subcontracting Order") then begin
                    if ("Shortcut Dimension 2 Code" <> 'D99-GEN') and ("Shortcut Dimension 2 Code" <> 'E99-GEN') then begin
                        Rec.TestField("Sales Order No");
                        Rec.TestField("Sales Order Line No.");
                    end;
                end;
                TransferReceiptHdrGrec.Reset();
                TransferReceiptHdrGrec.SetRange("Production Order No.", Rec."No.");
                TransferReceiptHdrGrec.SetRange("Excess Material Returns", false);
                TransferReceiptHdrGrec.SetRange("Finished Good Transfer", false);
                if TransferReceiptHdrGrec.FindSet() then
                    repeat
                        TransferReceiptLineGrec.Reset();
                        TransferReceiptLineGrec.SetRange("Document No.", TransferReceiptHdrGrec."No.");
                        if TransferReceiptLineGrec.FindSet() then
                            repeat
                                ItemLedgerEntryGrec.Reset();
                                ItemLedgerEntryGrec.SetRange("Document Type", ItemLedgerEntryGrec."Document Type"::"Transfer Receipt");
                                ItemLedgerEntryGrec.SetRange("Document No.", TransferReceiptLineGrec."Document No.");
                                ItemLedgerEntryGrec.SetFilter("Remaining Quantity", '>%1', 0);
                                ItemLedgerEntryGrec.SetCurrentKey("Item No.");
                                if ItemLedgerEntryGrec.FindFirst() then begin
                                    Error('Excess Material Is Available in Production Floor Against To  Rpo-%1. It Should be Zero', Rec."No.");
                                end;
                            until TransferReceiptLineGrec.Next() = 0;
                    until TransferReceiptHdrGrec.Next() = 0;
            end;


        }
        addlast(processing)
        {
            action("Change Sales No")
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                Caption = 'Update Sales Data';

                trigger OnAction()
                var
                    ProdOrderReport: Report "Update Production Order";
                    ProductionOrder: Record "Production Order";
                begin
                    Clear(ProdOrderReport);
                    ProductionOrder.Reset();
                    ProductionOrder.SetRange(Status, Rec.Status);
                    ProductionOrder.SetRange("No.", Rec."No.");
                    if ProductionOrder.FindFirst() then begin
                        ProdOrderReport.GetValues("Shortcut Dimension 2 Code");
                        ProdOrderReport.SetTableView(ProductionOrder);
                        ProdOrderReport.RunModal();
                    end;
                    //Report.RunModal(Report::"Update Production Order", true, true, ProductionOrder);
                end;
            }
            action(Discharge)
            {

                ApplicationArea = All;


                trigger OnAction()


                begin
                    if Rec.RD then
                        Dischargr()
                    else
                        Error('RD must be true');
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Shortcut Dimension 2 Code_B2B" = '' then
            Rec."Shortcut Dimension 2 Code_B2B" := Rec."Shortcut Dimension 2 Code";

    end;
    //B2BDNROn04Jul2023>>
    procedure Dischargr()
    var
        myInt: Integer;
        prodORderLine: Record "Prod. Order Line";
        ItemjnLine: Record "Item Journal Line";
        ItemjnLine1: Record "Item Journal Line";
        ItemLedger: Record "Item Ledger Entry";
        InventorySetup: Record "Inventory Setup";
        ItemjnlPostline: Codeunit "Item Jnl.-Post Line";
        EntryNo: Integer;
        Item: Record Item;
    begin
        if not Confirm('%1', false, CoNfirmTxt) then
            exit;

        InventorySetup.Get();
        ItemjnLine.Reset();
        ItemjnLine.SetRange("Document No.", "No.");
        if ItemjnLine.FindLast() then
            EntryNo := ItemjnLine."Line No." + 10000
        else
            EntryNo := 10000;
        prodORderLine.Reset();
        prodORderLine.SetRange("Prod. Order No.", "No.");
        prodORderLine.Setfilter("Item No.", '<>%1', '');
        if prodORderLine.FindSet() then begin
            repeat
                Item.Get(prodORderLine."Item No.");
                ItemLedger.Reset();

                ItemLedger.SetRange("Order No.", prodORderLine."Prod. Order No.");
                ItemLedger.SetRange("Order Line No.", prodORderLine."Line No.");
                ItemLedger.SetRange("Entry Type", ItemjnLine."Entry Type"::Output);
                ItemLedger.SetFilter("Remaining Quantity", '>%1', 0);
                if ItemLedger.FindSet() then begin
                    repeat
                        ItemjnLine1.Init();
                        ItemjnLine1."Line No." := EntryNo;
                        ItemjnLine1."Journal Template Name" := InventorySetup."Journal Template Name";
                        ItemjnLine1."Journal Batch Name" := InventorySetup."Journal Batch Name";
                        ItemjnLine1.validate("Item No.", ItemLedger."Item No.");
                        ItemjnLine1."Document No." := Rec."No.";
                        ItemjnLine1.Validate("Posting Date", WorkDate());
                        ItemjnLine1.Validate("Entry Type", ItemjnLine1."Entry Type"::"Negative Adjmt.");
                        ItemjnLine1.Validate(Quantity, ItemLedger."Remaining Quantity");
                        ItemjnLine1.validate("Location Code", ItemLedger."Location Code");
                        ItemjnLine1.Validate("Shortcut Dimension 1 Code", ItemLedger."Global Dimension 1 Code");
                        ItemjnLine1."Gen. Prod. Posting Group" := rec."Gen. Prod. Posting Group";
                        EntryNo := EntryNo + 10000;
                        if (Item."Item Tracking Code" <> '') then
                            UpdateResEntry(ItemjnLine1, ItemLedger)
                        else
                            ItemjnLine1.Validate("Applies-to Entry", ItemLedger."Entry No.");
                        ItemjnlPostline.RunWithCheck(ItemjnLine1);
                    until ItemLedger.Next() = 0;
                end;
            until prodORderLine.Next() = 0;
        end;
        Message('%1', CompletedTxt);
    end;

    procedure UpdateResEntry(ItemJournalline: Record "Item Journal Line"; ItemLedgerEntry: Record "Item Ledger Entry")
    Var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        Entrynum: Integer;
    begin
        IF ReservationEntry2.FINDlast() THEN
            EntryNum := ReservationEntry2."Entry No." + 1
        ELSE
            EntryNum := 1;
        ReservationEntry.INIT();
        ReservationEntry."Entry No." := EntryNum;
        ReservationEntry.VALIDATE(Positive, FALSE);
        ReservationEntry.VALIDATE("Item No.", ItemJournalline."Item No.");
        ReservationEntry.VALIDATE("Location Code", ItemJournalline."Location Code");
        ReservationEntry.VALIDATE("Quantity (Base)", -ItemJournalline.Quantity);
        ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
        ReservationEntry.VALIDATE("Creation Date", ItemJournalline."Posting Date");
        ReservationEntry.VALIDATE("Source Type", DATABASE::"Item Journal Line");
        ReservationEntry.VALIDATE("Source Subtype", 3);
        ReservationEntry.VALIDATE("Source ID", ItemJournalline."Journal Template Name");
        ReservationEntry.VALIDATE("Source Batch Name", ItemJournalline."Journal Batch Name");
        ReservationEntry.VALIDATE("Source Ref. No.", ItemJournalline."Line No.");
        ReservationEntry.VALIDATE("Shipment Date", ItemJournalline."Posting Date");
        if ItemLedgerEntry."Serial No." <> '' then
            ReservationEntry.VALIDATE("Serial No.", ItemLedgerEntry."Serial No.");
        ReservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
        ReservationEntry.VALIDATE("Planning Flexibility", ReservationEntry."Planning Flexibility"::Unlimited);
        if ItemLedgerEntry."Lot No." <> '' then
            ReservationEntry.VALIDATE("Lot No.", ItemLedgerEntry."Lot No.");
        ReservationEntry.VALIDATE(Correction, FALSE);
        ReservationEntry.INSERT();
    end;
    //B2BDNROn04Jul2023<<

    var
        myInt: Integer;
        HeaderCreated: Boolean;
        HedaerCretedNew: Boolean;
        CoNfirmTxt: Label 'Do you want to Discharge?';
        CompletedTxt: Label 'Discharged successfully';
}
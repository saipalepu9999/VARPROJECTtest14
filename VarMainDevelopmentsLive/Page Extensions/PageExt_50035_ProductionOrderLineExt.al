pageextension 50035 "Production Order Line Ext" extends "Released Prod. Order Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("Sales Order No"; Rec."Sales Order No")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Sales Order No field.';
            }
            field("CreateMrs"; Rec."Create Mrs")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Create Mrs field.';
            }
        }
        addafter("Finished Quantity")
        {
            field("Subcontracting Order"; Rec."Subcontracting Order")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Sales Order No field.';

            }
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Purchase Order No. field.';

            }
            field("Purchase Order Line No."; Rec."Purchase Order Line No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Purchase Order No. field.';

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
                        InventorySetup: Record "Inventory Setup";
                        NoSeriesMgmt: Codeunit NoSeriesManagement;
                        ProductionOrderComp: Record "Prod. Order Component";
                        LineNoGvar: Integer;
                        FacilityCode: Text;
                        Selection: Integer;
                    begin
                        InventorySetup.Get();
                        FacilityCode := 'DOMESTIC,EOU';
                        Selection := StrMenu(FacilityCode, 1, 'Select a dimension');
                        TransferHeader.Init;
                        if Selection = 1 then begin
                            TransferHeader.Validate("Transfer-from Code", InventorySetup."Stores Location(DOM)");
                            TransferHeader.Validate("Transfer-to Code", InventorySetup."Production Location(DOM)");
                        end else
                            if Selection = 2 then begin
                                TransferHeader.Validate("Transfer-from Code", InventorySetup."Stores Location(EOU)");
                                TransferHeader.Validate("Transfer-to Code", InventorySetup."Production Location(EOU)");
                            end;
                        TransferHeader."Production Order No." := Rec."Prod. Order No.";
                        TransferHeader."Production Order Line No." := Rec."Line No.";
                        TransferHeader."No." := NoSeriesMgmt.GetNextNo(InventorySetup."MRS Nos.", WorkDate(), true);
                        TransferHeader.Insert(true);
                        //TransferHeader.Modify(true);
                        LineNoGvar := 10000;
                        ProductionOrderComp.Reset();
                        ProductionOrderComp.SetRange(Status, rec.Status);
                        ProductionOrderComp.SetRange("Prod. Order No.", Rec."Prod. Order No.");
                        ProductionOrderComp.SetRange("Prod. Order Line No.", Rec."Line No.");
                        if ProductionOrderComp.FindSet() then
                            repeat
                                TransferLine.Init();
                                TransferLine."Document No." := TransferHeader."No.";
                                TransferLine."Line No." := LineNoGvar;
                                LineNoGvar += 10000;
                                TransferLine.Insert(true);
                                TransferLine.Validate("Item No.", ProductionOrderComp."Item No.");
                                TransferLine.Validate(Quantity, ProductionOrderComp."Expected Quantity");
                                TransferLine.Validate("Unit of Measure Code", ProductionOrderComp."Unit of Measure Code");
                                TransferLine.Modify(true);
                            until ProductionOrderComp.Next() = 0;
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
                    begin
                        InventorySetup.Get();
                        FacilityCode := 'DOMESTIC,EOU';
                        Selection := StrMenu(FacilityCode, 1, 'Select a dimension');
                        TransferHeader.Init;
                        if Selection = 1 then begin
                            TransferHeader.Validate("Transfer-from Code", InventorySetup."Stores Location(DOM)");
                            TransferHeader.Validate("Transfer-to Code", InventorySetup."Production Location(DOM)");
                        end else
                            if Selection = 2 then begin
                                TransferHeader.Validate("Transfer-from Code", InventorySetup."Stores Location(EOU)");
                                TransferHeader.Validate("Transfer-to Code", InventorySetup."Production Location(EOU)");
                            end;
                        TransferHeader."Production Order No." := Rec."Prod. Order No.";
                        TransferHeader."Production Order Line No." := Rec."Line No.";
                        TransferHeader."No." := NoSeriesMgmt.GetNextNo(InventorySetup."MRS Nos.", WorkDate(), true);
                        TransferHeader.Insert(true);
                        //TransferHeader.Modify(true);

                    end;
                }
                action("Mrs List")
                {
                    ApplicationArea = All;
                    Image = List;
                    //PromotedCategory = Process;
                    //Promoted = true;
                    //PromotedIsBig = true;
                    RunObject = page "Transfer Orders";
                    RunPageLink = "Production Order No." = field("Prod. Order No."), "Production Order Line No." = field("Line No.");
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
                    RunPageLink = "Production Order No." = field("Prod. Order No.");
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
                    RunPageLink = "Production Order No." = field("Prod. Order No.");
                    ToolTip = 'Executes the Posted MRS Receipts action.';
                    trigger OnAction()
                    begin
                        // Message('Hi');
                    end;
                }
            }
        }
        //B2BMSOn10Mar2023>>
        addafter("I&nspectionB2B")
        {
            action("Open PO")
            {
                ApplicationArea = All;
                Image = ViewDocumentLine;
                RunObject = page "Purchase Order";
                RunPageLink = "Document Type" = const(Order), "No." = field("Purchase Order No.");
                trigger OnAction()
                begin
                    // Message('Hi');
                end;
            }
        }
        //B2BMSOn10Mar2023<<
    }

    var
        myInt: Integer;
}
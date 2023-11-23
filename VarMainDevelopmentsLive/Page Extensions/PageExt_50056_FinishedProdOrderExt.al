pageextension 50056 "Finished prod OrderExt" extends "Finished Production Order"
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
    }

    actions
    {
        addlast(Processing)
        {
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
        }
    }

    var
        myInt: Integer;
        HeaderCreated: Boolean;
}
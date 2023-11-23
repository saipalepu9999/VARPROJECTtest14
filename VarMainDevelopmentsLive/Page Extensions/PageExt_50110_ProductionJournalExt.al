pageextension 50110 ProductionJournalExt extends "Production Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the cost of one unit of the item or resource on the line.';
            }

            field("Unit Amount"; Rec."Unit Amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the price of one unit of the item on the journal line.';
            }
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                ProductionOrder: Record "Prod. Order Line";
                PurchaseLine: Record "Purchase Line";
                Text001: Label 'Location Should Be %1';
            begin
               /* ItemJnlGrec.Reset();
                ItemJnlGrec.SetRange("Journal Template Name", Rec."Journal Template Name");
                ItemJnlGrec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                ItemJnlGrec.SetRange("Order Type", ItemJnlGrec."Order Type"::Production);
                ItemJnlGrec.SetRange("Order No.", Rec."Order No.");
                ItemJnlGrec.SetRange("Order Line No.", Rec."Order Line No.");
                if ItemJnlGrec.FindSet() then
                    repeat
                        if ItemJnlGrec."Entry Type" = ItemJnlGrec."Entry Type"::Consumption then begin
                            ProductionOrder.Reset();
                            ProductionOrder.SetRange(Status, ProductionOrder.Status::Released);
                            ProductionOrder.SetRange("Prod. Order No.", ItemJnlGrec."Document No.");
                            ProductionOrder.SetRange("Subcontracting Order", true);
                            //ProductionOrder.SetRange("Production Order No.", ItemJnlGrec."Document No.");
                            if ProductionOrder.FindFirst() then begin
                                if (ProductionOrder."Subcontracting Order") and (ProductionOrder."Purchase Order No." <> '') and (ProductionOrder."Purchase Order Line No." <> 0) then begin
                                    PurchaseLine.Reset();
                                    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                                    PurchaseLine.SetRange("Document No.", ProductionOrder."Purchase Order No.");
                                    PurchaseLine.SetRange("Line No.", ProductionOrder."Purchase Order Line No.");
                                    //PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                                    if PurchaseLine.FindFirst() then
                                        if PurchaseLine."Location Code" <> ItemJnlGrec."Location Code" then
                                            Error(StrSubstNo(Text001, PurchaseLine."Location Code"));
                                end;

                            end;
                        end;
                    until ItemJnlGrec.Next() = 0;*/
            end;
        }
    }

    var
        myInt: Integer;
        pag: Page 9010;
        pa: Page 99000832;
        ItemJnlGrec: record "Item Journal Line";
}
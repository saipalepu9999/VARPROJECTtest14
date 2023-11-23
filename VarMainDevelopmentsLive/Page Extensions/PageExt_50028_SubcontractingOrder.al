pageextension 50028 SubContractingExt extends "Subcontracting Order"
{
    layout
    {
        addlast(General)
        {
            //4.12 >>
            field("Short Close Status"; Rec."Short Close Status")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Short Close Status field.';

            }
            field("Short Closed By"; Rec."Short Closed By")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Short Closed By field.';
            }
            field("Short Closed DateTime"; Rec."Short Closed DateTime")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Short Closed DateTime field.';
            }
            //4.12 <<
        }
    }

    actions
    {
        addbefore("P&ost")
        {
            //4.12 
            action("Short Close")
            {
                ApplicationArea = All;
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Short Close the order based on Qty Received and Invoiced';

                trigger OnAction()
                var
                    PurchLine: Record "Purchase Line";
                    ConfirmText: Label 'Do you want to Short Close the Purchase Order %1 ?';
                    NotApplicableErr: Label 'Qty Received and Qty Invoiced should be matching for Line %1';
                    SuccessMsg: Label 'Purchase Order %1 is Short Closed';
                    ShortClosed: Boolean;
                    ProductionOrderLine: Record "Prod. Order Line";
                begin

                    PurchLine.Reset();
                    PurchLine.SetRange("Document Type", Rec."Document Type");
                    PurchLine.SetRange("Document No.", Rec."No.");
                    PurchLine.SetFilter("No.", '<>%1', '');
                    PurchLine.SetFilter(Quantity, '<>%1', 0);
                    PurchLine.SetRange(ShortClosed, false);
                    if PurchLine.FindSet() then
                        repeat
                            if PurchLine."Quantity Invoiced" <> PurchLine."Quantity Received" then
                                Error(NotApplicableErr, PurchLine."Line No.");
                        until PurchLine.Next() = 0;


                    if not Confirm(StrSubstNo(ConfirmText, Rec."No."), false) then
                        exit;

                    Clear(ShortClosed);
                    PurchLine.Reset();
                    PurchLine.SetRange("Document Type", Rec."Document Type");
                    PurchLine.SetRange("Document No.", Rec."No.");
                    PurchLine.SetFilter("No.", '<>%1', '');
                    PurchLine.SetFilter(Quantity, '<>%1', 0);
                    PurchLine.SetRange(ShortClosed, false);
                    if PurchLine.FindSet() then begin
                        repeat
                            if PurchLine."Quantity Invoiced" = PurchLine."Quantity Received" then begin
                                PurchLine.ShortClosed := true;
                                PurchLine."Original Qty" := PurchLine.Quantity;
                                PurchLine.Quantity := PurchLine."Quantity Invoiced";
                                PurchLine."Short Close Diff Qty" := PurchLine."Original Qty" - PurchLine.Quantity;
                                PurchLine."Outstanding Quantity" := 0;
                                PurchLine.Modify();
                                ShortClosed := true;
                                ProductionOrderLine.Reset();
                                ProductionOrderLine.SetRange("Prod. Order No.", PurchLine."Prod. Order No.");
                                ProductionOrderLine.SetRange("Line No.", PurchLine."Prod. Order Line No.");
                                if ProductionOrderLine.FindFirst() then begin
                                    ProductionOrderLine."Subcontracting Order No." := '';
                                    ProductionOrderLine.Modify();
                                end;
                            end;
                        until PurchLine.Next() = 0;
                        if ShortClosed then begin
                            Rec.Validate("Short Close Status", Rec."Short Close Status"::ShortClosed);
                            Rec.Validate("Short Closed By", UserId);
                            Rec.Validate("Short Closed DateTime", CurrentDateTime);
                            Rec.Modify();
                        end;
                    end;
                end;
            }
            //4.12 <<
        }
    }

    var
        myInt: Integer;
}
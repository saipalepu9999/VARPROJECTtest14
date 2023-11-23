pageextension 50144 InspectionDataList extends "Inspection Data Sheet List B2B"
{
    PromotedActionCategories = 'New,Action,Report,Process,Cancel';
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(Processing)
        {
            action("Cancel IDS")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ConfirmText: Label 'Do you want cancel';
                    ReleasePod: Record "Prod. Order Line";
                begin


                    if not Confirm(StrSubstNo(ConfirmText, Rec."No."), false) then
                        exit;
                    ReleasePod.Reset();
                    ReleasePod.SetRange("Prod. Order No.", rec."Prod. Order No.");
                    ReleasePod.SetRange("Line No.", rec."Prod. Order Line");
                    if ReleasePod.FindFirst() then begin
                        //  ReleasePod."Quantity Sent to Quality B2B" := ReleasePod.qua + rec.Quantity;
                        ReleasePod."Quantity Sent to Quality B2B" := ReleasePod."Quantity Sent to Quality B2B" - rec.Quantity;
                        ReleasePod."Qty Sending to Quality B2B" := ReleasePod."Qty Sending to Quality B2B" + rec.Quantity;
                        ReleasePod.Modify();
                    end;
                    Rec.Delete(true);
                end;

            }
        }

    }

    var
        myInt: Integer;
}
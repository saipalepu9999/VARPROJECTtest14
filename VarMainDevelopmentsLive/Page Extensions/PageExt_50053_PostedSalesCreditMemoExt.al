pageextension 50053 PostedSalesCreditMemoExt extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("Shipping and Billing")
        {
            group("Sales Information")
            {
                field("Tender/Project"; Rec."Tender/Project")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender/Project Conformation By Customer field.';
                }
                field("Liquidated Damages"; Rec."Liquidated Damages")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Liquidated Damages field.';
                }
                field("Green Card Applicable"; Rec."Green Card Applicable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Applicable field.';

                }
                field("Green Card Type"; Rec."Green Card Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Type field.';
                }
                field("Green Card Received"; Rec."Green Card Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Received field.';
                }

                field("Green Card Receipt Date"; Rec."Green Card Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Receipt Date field.';
                }
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
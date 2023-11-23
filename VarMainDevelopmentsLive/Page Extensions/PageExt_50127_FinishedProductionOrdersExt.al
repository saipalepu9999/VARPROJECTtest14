pageextension 50127 FinishedProdOrdersExt extends "Finished Production Orders"
{
    layout
    {
        addafter("Due Date")
        {

            field("Creation Date"; Rec."Creation Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date on which you created the production order.';
            }

        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
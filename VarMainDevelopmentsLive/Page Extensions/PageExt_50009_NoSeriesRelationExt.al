pageextension 50009 NoSeriesRelationShipsExt extends "No. Series Relationships"
{
    layout
    {
        addlast(Control1)
        {
            field("Shortcut Dimension 1 Code_B2B"; Rec."Shortcut Dimension 1 Code_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
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
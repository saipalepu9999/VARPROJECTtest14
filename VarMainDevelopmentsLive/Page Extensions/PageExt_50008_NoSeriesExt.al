pageextension 50008 NoSeriexExt extends "No. Series"
{
    layout
    {
        addbefore(Code)
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
pageextension 50138 TdsAdjsutmentJnlExt extends "TDS Adjustment Journal"
{
    layout
    {
        modify("External Document No.")
        {
            Visible = true;
            Editable = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
pageextension 50117 GeneralJouranlTempExt extends "General Journal Templates"
{
    layout
    {
        modify("Test Report ID")
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
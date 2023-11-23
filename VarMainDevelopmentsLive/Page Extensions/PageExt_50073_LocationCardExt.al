pageextension 50073 LocationCardExte extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            field("Stores Location"; Rec."Stores Location")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Stores Location field.';
            }
            field("Item Project Code"; Rec."Item Project Code")
            {
                ApplicationArea = all;
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
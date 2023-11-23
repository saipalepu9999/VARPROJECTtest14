pageextension 50116 "Customer Card Exten" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Approval Status_B2B"; Rec."Approval Status_B2B")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Status field.';
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
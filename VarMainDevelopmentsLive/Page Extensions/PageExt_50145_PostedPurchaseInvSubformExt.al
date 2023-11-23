pageextension 50145 PostedPurcInvSubformExt extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addbefore("Shortcut Dimension 1 Code")
        {
            field("GST Group Code"; "GST Group Code")
            {
                ApplicationArea = all;
            }
            field("HSN/SAC Code"; "HSN/SAC Code")
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
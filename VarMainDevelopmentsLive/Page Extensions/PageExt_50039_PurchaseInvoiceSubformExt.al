pageextension 50039 PurchInvSubformExt extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("Line Amount")
        {
            field("Salvage Value"; Rec."Salvage Value")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Salvage Value field.';
            }
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
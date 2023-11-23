pageextension 50129 TransferShipmentSubfmExt extends "Posted Transfer Shpt. Subform"
{
    layout
    {
        addlast(Control1)
        {
            
            field("Prod. Expected date"; Rec."Prod. Expected date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prod. Expected Date field.';
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
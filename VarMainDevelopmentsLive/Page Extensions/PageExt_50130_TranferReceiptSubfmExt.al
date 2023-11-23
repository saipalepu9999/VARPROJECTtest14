pageextension 50130 TransferReceiptSubfmExt extends "Posted Transfer Rcpt. Subform"
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
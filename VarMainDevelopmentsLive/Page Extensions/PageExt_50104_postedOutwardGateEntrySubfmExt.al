pageextension 50104 PostedOutWardGateEntrySubfmExt extends "Posted Outward Gate SubForm"
{
    layout
    {
        addlast(list)
        {

            field(Quantity; Rec.Quantity)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity field.';
            }
        }
        modify("Challan No.")
        {
            Visible = false;
        }
        modify("Challan Date")
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
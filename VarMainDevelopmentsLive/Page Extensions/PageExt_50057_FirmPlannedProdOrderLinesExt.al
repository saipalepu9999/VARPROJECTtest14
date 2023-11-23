pageextension 50057 "FirmPlannedProdOrderLinesExt" extends "Firm Planned Prod. Order Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("Sales Order No"; Rec."Sales Order No")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Sales Order No field.';
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
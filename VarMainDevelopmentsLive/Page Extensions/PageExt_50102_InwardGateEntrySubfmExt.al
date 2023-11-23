pageextension 50102 InwardGateEntrySubfm extends "Inward Gate Entry SubForm"
{
    layout
    {
        addafter("Source Type")
        {
            field("Source Type New"; "Source Type")
            {
                ApplicationArea = all;
                ValuesAllowed = " ", "Sales Return Order", "Purchase Order", "Transfer Receipt", Inspection;
            }
        }
        modify("Source Type")
        {
            Visible = false;
        }
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
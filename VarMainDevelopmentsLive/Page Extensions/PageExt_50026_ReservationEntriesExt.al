pageextension 50026 ReservationEntriesExt extends "Reservation Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Vendor Lot No_B2B"; Rec."Vendor Lot No_B2B")
            {
                ApplicationArea = all;
                Caption = 'Vendor Lot No';
                ToolTip = 'Specifies the value of the Vendor Lot No field.';
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
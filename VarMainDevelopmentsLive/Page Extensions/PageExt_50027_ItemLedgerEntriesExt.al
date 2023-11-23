pageextension 50027 ItemledgerEntriesExt extends "Item Ledger Entries"
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
            } //b2bjkon31jan
            field("Pc No."; "Pc No.")
            {
                ApplicationArea = all;
            }
            field("Pc Date"; "Pc Date")
            {
                ApplicationArea = all;
            }
            field("Bill of Entry No."; "Bill of Entry No.")
            {
                ApplicationArea = all;
            }
            field("Bill of Entry Date"; "Bill of Entry Date")
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
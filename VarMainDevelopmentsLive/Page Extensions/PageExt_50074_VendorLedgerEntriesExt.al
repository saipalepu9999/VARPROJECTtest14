pageextension 50074 VendorLedgerEntriesExt extends "Vendor Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            
            field("QC Status"; Rec."QC Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the QC Status field.';
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
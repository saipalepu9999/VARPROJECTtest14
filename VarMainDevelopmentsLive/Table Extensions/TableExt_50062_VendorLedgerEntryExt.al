tableextension 50062 VendorLedgEntryExt extends "Vendor Ledger Entry"
{
    fields
    {
        field(50000; "QC Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Accepted,"Partially Accepted","Rejecetd";
        }
    }
    
    var
        myInt: Integer;
}
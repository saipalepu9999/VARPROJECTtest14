tableextension 50087 DetailedEmpLedgerEntryExt extends "Detailed Employee Ledger Entry"
{
    fields
    {
        field(50000; "P.A.N.No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'P.A.N.No.';
        }
    }

    var
        myInt: Integer;
}
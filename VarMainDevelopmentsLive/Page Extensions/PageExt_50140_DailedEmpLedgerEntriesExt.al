pageextension 50140 DetailedEmpLedgerEntriesExt extends "Detailed Empl. Ledger Entries"
{
    layout
    {
        addafter("Entry No.")
        {
            field("P.A.N.No.";"P.A.N.No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
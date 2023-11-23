pageextension 50139 EmployeeLedgerEntriesExt extends "Employee Ledger Entries"
{
    layout
    {
        addafter("Entry No.")
        {
            field("P.A.N.No."; "P.A.N.No.")
            {
                ApplicationArea = all;
            }
        }
    }
}
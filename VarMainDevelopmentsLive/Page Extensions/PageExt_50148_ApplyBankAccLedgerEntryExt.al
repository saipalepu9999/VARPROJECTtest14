pageextension 50148 ApplyBankAccountLedger extends "Apply Bank Acc. Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter("External Document No.")
        {
            field("Cheque No."; "Cheque No.")
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
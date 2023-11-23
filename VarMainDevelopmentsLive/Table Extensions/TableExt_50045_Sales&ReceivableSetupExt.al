tableextension 50045 "Sales&ReceivableSetupExt" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Attachment Path"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}
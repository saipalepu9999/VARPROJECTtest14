tableextension 50084 TransferReceiptLineExt extends "Transfer Receipt Line"
{
    fields
    {
        field(50005; "Prod. Expected date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Required By Date';
        }
    }

    var
        myInt: Integer;
}
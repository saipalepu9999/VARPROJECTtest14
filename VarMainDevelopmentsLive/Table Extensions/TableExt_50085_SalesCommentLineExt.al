tableextension 50085 SalesCommentLineExt extends "Sales Comment Line"
{
    fields
    {
        field(50000; "Code New"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
        }
    }

    var
        myInt: Integer;
}
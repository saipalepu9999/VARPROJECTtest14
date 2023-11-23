tableextension 50076 PostedGateEntryLineExt extends "Posted Gate Entry Line"
{
    fields
    {
        field(50000; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    var
        myInt: Integer;
}
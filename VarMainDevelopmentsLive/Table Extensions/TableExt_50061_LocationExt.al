tableextension 50061 "Location Extension" extends Location
{
    fields
    {
        field(50000; "Stores Location"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Item Project Code"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}
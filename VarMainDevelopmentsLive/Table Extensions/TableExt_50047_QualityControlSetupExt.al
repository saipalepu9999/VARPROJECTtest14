tableextension 50047 QualityControlSetupExt extends "Quality Control Setup B2B"
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
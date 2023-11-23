tableextension 50046 "ManufacturingSetupExt" extends "Manufacturing Setup"
{
    fields
    {
        field(50000; "Attachment Path"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Time Based On Output Qty"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Planning Orders(DOM)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50003; "Planning Orders(EOU)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    var
        myInt: Integer;
}
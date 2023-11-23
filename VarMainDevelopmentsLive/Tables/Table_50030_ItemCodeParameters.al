table 50030 "Item Parameters"
{
    DataClassification = CustomerContent;
    LookupPageId = "Item Parameters Drill Down";
    DrillDownPageId = "Item Parameters Drill Down";

    fields
    {
        field(1; "Parameter Type"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; Code; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Coding Index"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Parent Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Parent Type"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Parent Code New"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Lot Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Tracking Code";
        }
    }

    keys
    {
        key(Key1; "Parameter Type", Code, "Parent Type", "Parent Code", "Parent Code New")
        {
            Clustered = true;
        }
        key(Key2; "Coding Index")
        {

        }
    }



}
table 50022 "Consum Entry Against Output"
{
    DataClassification = ToBeClassified;
    Caption = 'Consumption Entries Against Output';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;

        }
        field(2; "Output Entry No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Output Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Output Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Output Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Output Serial No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Consumption Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Consumption Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Consumption Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Consumption Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Consumption Serial No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Consumption Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Output Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
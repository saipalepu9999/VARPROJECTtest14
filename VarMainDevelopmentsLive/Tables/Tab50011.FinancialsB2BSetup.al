table 50011 "Financials B2B Setup"
{
    Caption = 'Financials B2B Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Total Code"; Code[1])
        {
            Caption = 'Total Code';
            DataClassification = ToBeClassified;
            ValuesAllowed = 'A', 'B', 'C';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Gross Block As At Account"; Code[20])
        {
            Caption = 'Gross Block As At Account';
            TableRelation = "G/L Account"."No.";
            DataClassification = ToBeClassified;
        }
        field(5; "Gross Block Additions"; Code[20])
        {
            Caption = 'Gross Block Additions';
            TableRelation = "G/L Account"."No.";
            DataClassification = ToBeClassified;
        }
        field(6; "Gross Block Deletions"; Code[20])
        {
            Caption = 'Gross Block Deletions';
            TableRelation = "G/L Account"."No.";
            DataClassification = ToBeClassified;
        }
        field(7; "Acc Dep. As At Account"; Code[20])
        {
            Caption = 'Acc Dep. As At Account';
            TableRelation = "G/L Account"."No.";
            DataClassification = ToBeClassified;
        }
        field(8; "Acc Dep. Additions"; Code[20])
        {
            Caption = 'Acc Dep. Additions';
            TableRelation = "G/L Account"."No.";
            DataClassification = ToBeClassified;
        }
        field(9; "Acc Dep. Deletions"; Code[20])
        {
            Caption = 'Acc Dep. Deletions';
            TableRelation = "G/L Account"."No.";
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}

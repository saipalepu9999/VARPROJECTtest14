table 50028 "Shortage Table"
{
    Caption = 'Shortage Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Transfer Order Line No."; Integer)
        {
            Caption = 'Transfer Order Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(4; "Item Description"; Text[50])
        {
            Caption = 'Item Description';
            DataClassification = ToBeClassified;
        }
        field(5; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "Carry Out"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Carry Out';
        }
    }
    keys
    {
        key(PK; "Transfer Order No.", "Transfer Order Line No.")
        {
            Clustered = true;
        }
    }
    var
    re : Report 18041;
}

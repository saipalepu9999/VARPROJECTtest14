tableextension 50031 ItemLedgerEntriesExt extends "Item Ledger Entry"
{
    fields
    {

        field(50001; "Pc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pc No.';
        }
        field(50002; "Pc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Pc Date';
        }
        field(50003; "Dc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dc No.';
        }
        field(50004; "Dc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Dc Date';
        }
        field(50005; "Duty Involved_B2B"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Duty Involved For Cleared';
        }
        field(50006; "Bill of Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Bill of Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Production Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        cu: Codeunit 22;
}
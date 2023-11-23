table 50019 SalesCheckList
{
    DataClassification = ToBeClassified;
    Caption = 'Sales Check list';

    fields
    {
        field(1; "Document Type"; Enum "Sales Comment Document Type")
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            TableRelation = SalesCheckListSetup.Code;
            ValidateTableRelation = false;
            //TestTableRelation = false;
            trigger OnValidate()
            var
                SalesCheckListSetupLvar: Record SalesCheckListSetup;
            begin
                SalesCheckListSetupLvar.Reset();
                SalesCheckListSetupLvar.SetRange(Code, Code);
                if SalesCheckListSetupLvar.FindFirst() then begin
                    Comment := SalesCheckListSetupLvar.Comment;
                end;
            end;
        }
        field(6; Comment; Text[500])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }
        field(7; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = ToBeClassified;
        }
        field(8; Check; Option)
        {
            Caption = 'Check';
            OptionMembers = " ",Yes,No;
            //OptionCaption = ' ,Yes,No';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
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
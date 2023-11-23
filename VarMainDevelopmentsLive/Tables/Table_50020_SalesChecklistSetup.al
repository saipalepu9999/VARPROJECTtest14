table 50020 SalesCheckListSetup
{
    DataClassification = ToBeClassified;
    Caption = 'QAP check list setup';
    LookupPageId = SalesCheckListSetupList;
    DrillDownPageId = SalesCheckListSetupList;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Comment; Text[500])
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
        key(key2; Code)
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Code, Comment)
        {
        }
        fieldgroup(Brick; "Entry No.", Code, Comment)
        {
        }
    }

    var
        SalesCheckListSetup: Record SalesCheckListSetup;
        Re: page 9807;

    trigger OnInsert()
    begin
        SalesCheckListSetup.Reset();
        if SalesCheckListSetup.FindLast() then
            "Entry No." := SalesCheckListSetup."Entry No." + 1
        else
            "Entry No." := 1;
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
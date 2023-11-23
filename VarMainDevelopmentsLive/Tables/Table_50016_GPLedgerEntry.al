table 50016 "GP Ledger Entry"
{
    DrillDownPageID = "GP Ledger Entries";
    LookupPageID = "GP Ledger Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Source Type"; Option)
        {
            OptionMembers = "RGP Out","RGP In";
            DataClassification = CustomerContent;
        }
        field(10; "Source No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(11; Type; Option)
        {
            OptionMembers = ,Item,"Fixed Asset",Calibration,"G/L Account";
            DataClassification = CustomerContent;
        }
        field(12; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Unit Of Measure"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(21; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Quantity Received"; Decimal)
        {
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(23; "Remaining Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(25; Open; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Applied Entries"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(32; "Consignee No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(34; "Consignee Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(35; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            //TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(36; "Department Name"; Text[200])
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
        }
        field(37; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
        }
        field(38; "Created Name"; Text[200])
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
        }
        field(39; Location; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Posted Gate Pass Line"."Location Code" WHERE("Document No." = FIELD("Source No.")));
        }
        field(40; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            //TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(41; "Posted RDC No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No.", Quantity)
        {
            Clustered = true;
        }
        key(Key2; Type, "No.", "Source No.", "Applied Entries", "Source Type")
        {
            SumIndexFields = "Quantity Received";
        }
    }

    fieldgroups
    {
    }
}


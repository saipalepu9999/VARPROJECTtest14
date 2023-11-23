tableextension 50056 PostedInsdatasheetHdrExt extends "Posted Ins DatasheetHeader B2B"
{
    fields
    {
        field(50008; "Vendor Test Certificate_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Test Certificate Required';
            Editable = false;
        }
        field(50009; "Warranty Certificate_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Warranty Certificate Required';
            Editable = false;
        }
        field(50002; "Pc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pc No.';
            Editable = false;
        }
        field(50003; "Pc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Pc Date';
            Editable = false;
        }
        field(50004; "Dc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dc No.';
            Editable = false;
        }
        field(50005; "Dc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Dc Date';
            Editable = false;
        }
        field(50006; "Bill of Entry No."; text[20])
        {
            Caption = 'Bill of Entry No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50007; "Bill of Entry Date"; date)
        {
            caption = 'Bill of Entry Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }


}
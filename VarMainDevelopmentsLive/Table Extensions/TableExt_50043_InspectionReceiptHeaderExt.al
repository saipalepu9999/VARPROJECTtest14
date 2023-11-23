tableextension 50043 InspectionReceiptHeaderExt extends "Inspection Receipt Header B2B"
{
    fields
    {
        /*field(50003; "Gate Inward DC NO."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Posted Gate Entry Header_B2B"."No." where("Entry Type" = const(Inward), Type = const(RGP), "Posted IR No." = field("No."));
        }*/
        field(50004; "Vendor Test Certificate_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Test Certificate Required';
            Editable = false;
        }
        field(50005; "Warranty Certificate_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Warranty Certificate Required';
            Editable = false;
        }
        field(50006; "Pc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pc No.';
            Editable = false;
        }
        field(50007; "Pc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Pc Date';
            Editable = false;
        }
        field(50008; "Dc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dc No.';
            Editable = false;
        }
        field(50009; "Dc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Dc Date';
            Editable = false;
        }
        field(50010; "Bill of Entry No."; text[20])
        {
            Caption = 'Bill of Entry No.';
            DataClassification = CustomerContent;
        }
        field(50011; "Bill of Entry Date"; date)
        {
            caption = 'Bill of Entry Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50019; "No. Of Samples Taken"; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}
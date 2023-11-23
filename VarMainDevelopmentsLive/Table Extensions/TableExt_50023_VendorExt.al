tableextension 50023 VendorExtension extends vendor
{
    fields
    {
        field(50000; "MSME Applicable"; Boolean)
        {
            Caption = 'MSME Applicable';
            DataClassification = CustomerContent;
        }
        field(50001; "MSME Certificate No."; Code[20])
        {
            Caption = 'MSME Certificate No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "MSME Certificate No." <> '' then //B2BOn01Aug2022
                    TestField("MSME Applicable", true);
                if "MSME Applicable" then
                    TestField("MSME Certificate No.");
            end;
        }
        field(50002; "MSME Validity Date"; Date)
        {
            Caption = 'MSME Validity Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField("MSME Applicable", true);
            end;
        }
        field(50004; "MSMEownedbySC/STEnterpreneur"; Boolean)
        {
            Caption = 'MSME owned by SC/ST Enterpreneur';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField("MSME Applicable", true);
            end;
        }
        field(50005; "MSMEownedbyWomenEnterpreneur"; Boolean)
        {
            Caption = 'MSME owned by Women Enterpreneur';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField("MSME Applicable", true);
            end;
        }
        field(50010; "Approval Status_B2B"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Status';
            OptionMembers = Open,"Pending for Approval",Released;
            OptionCaption = 'Open,Pending for Approval,Released';
            Editable = false;
        }
        field(50100; "L.S.T. No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50101; "C.S.T. No."; Code[20])
        {
            DataClassification = CustomerContent;
        }

    }

    var
        myInt: Integer;
}
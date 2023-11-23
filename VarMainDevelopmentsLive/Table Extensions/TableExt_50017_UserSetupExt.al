tableextension 50017 "User Setup Ext" extends "User Setup"
{
    fields
    {
        field(50000; "Shortcut Dimension 2 Code_B2B"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }
        field(50001; "Item Reclassification Journals"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Attachment Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Items Access"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Master Access';
            trigger OnValidate()
            var
                userSetup: Record "User Setup";
                CountGvar: Integer;
            begin
                /*userSetup.Reset();
                userSetup.SetRange("Items Access", true);
                if (userSetup.FindFirst()) and (userSetup."User ID" <> "User ID") then
                    Error('Item master access can be provide to only one user at a time');*/
            end;
        }
        field(50004; "Purchase Department Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Global Dimension 1 Filter"; Text[250])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            DataClassification = CustomerContent;
        }
        field(50006; "Global Dimension 2 Filter"; Text[250])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            DataClassification = CustomerContent;
        }
        field(50007; "Assign Security Filter"; Boolean)
        {
            Caption = 'Assign Security Filter';
            DataClassification = CustomerContent;
        }
        field(50008; "RGP In Posting"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
        }
        field(50009; "RGP Posting"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
        }
        field(50010; "User Name"; Text[80])
        {
            CalcFormula = Lookup(User."Full Name" WHERE("User Name" = FIELD("User ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Prod Order Comp Access"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Re-open Accessability"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Production User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Store Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "QC Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}
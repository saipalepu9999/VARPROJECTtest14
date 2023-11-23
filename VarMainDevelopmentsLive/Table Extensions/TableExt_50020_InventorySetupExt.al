tableextension 50020 InventorysetupExt extends "Inventory Setup"
{
    fields
    {
        /*field(50000; "Inward RGP No. Series_B2B"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted RDC Inward';
            TableRelation = "No. Series";

        }
        field(50001; "Inward NRGP No. Series_B2B"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted NRDC Inward';
            TableRelation = "No. Series";
        }
        field(50002; "Outward RGP No. Series_B2B"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted RDC Outward';
            TableRelation = "No. Series";
        }
        field(50003; "Inward Gate Entry Nos.-RGP_B2B"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'RDC Inward';
            TableRelation = "No. Series";
        }
        field(50004; "Inward Gate Entry Nos.NRGP_B2B"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'NRDC Inward';
            TableRelation = "No. Series";
        }
        field(50005; "Outward Gate Entry Nos.RGP_B2B"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'RDC Outward';
            TableRelation = "No. Series";
        }
        field(50006; "Outward Gate EntryNos.NRGP_B2B"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'NRDC Outward';
            TableRelation = "No. Series";
        }
        field(50007; "Outward NRGP No. Series_B2B"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posted NRDC Outward';
            TableRelation = "No. Series";
        }*/
        field(50000; "MTR No.s"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50001; "RGP Out"; Code[20])
        {
            Description = 'RGP1.0';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50002; "RGP In"; Code[20])
        {
            Description = 'RGP1.0';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50003; NRGP; Code[20])
        {
            Description = 'RGP1.0';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(50004; "Transfer order"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
        }
        field(50005; "Material Consumption No.Series"; Text[150])
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
        }
        field(50006; "Material Consumption Location"; Text[150])
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
        }
        field(50007; "WIP Rework Location"; Code[20])
        {
            Caption = 'WIP Rework Location';
            DataClassification = CustomerContent;
            TableRelation = Location;
        }
        field(50008; "Stores Location(DOM)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Stores Location(DOMESTIC)';
            TableRelation = Location;
        }
        field(50009; "Stores Location(EOU)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Stores Location(EOU)';
            TableRelation = Location;
        }
        field(50010; "Production Location(DOM)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Production Location(DOMESTIC)';
            TableRelation = Location;
        }
        field(50011; "Production Location(EOU)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Production Location(EOU)';
            TableRelation = Location;
        }
        field(50012; "Attachment Path"; Text[1024])
        {
            DataClassification = ToBeClassified;
            Caption = 'Attachment Path';
        }
        field(50013; "Transfer-From Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50014; "Transfer-To Location"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(50015; "MRS Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50016; "NCPR Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50017; "Code WorkSheet No."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
            Caption = 'Code Worksheet No.(DOM)';
        }
        //CHB2B20MAR2023<<
        field(50018; "EOU_DOM Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        //CHB2B20MAR2023<<
        //B2BDNR19Apr2023>>
        field(50019; "Code Worksheet No.(EOU)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Caption = 'Code Worksheet No.(EOU)';
        }
        //B2BDNR19Apr2023<<
        field(50024; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(50025; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";

        }
        field(50026; "Posted NRDC List"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50027; "Posted RDC IN List"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50028; "Posted RDC Out List"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }

    var
        myInt: Integer;
}
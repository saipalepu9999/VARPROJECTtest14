table 50031 "Posted Gate Pass Header"
{
    DataCaptionFields = "No.", "Consignee Name";
    LookupPageID = "Posted RGP Header List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = "RGP Out","RGP In";
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "RGP Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Consignee Type"; Option)
        {
            OptionMembers = Customer,Vendor,Party;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Consignee No." := '';
                "Consignee Name" := '';
                "Consignee Name 2" := '';
                Address := '';
                "Consignee City" := '';
                "Phone No." := '';
                "Consignee Contact" := '';
                "Telex No." := '';
            end;
        }
        field(6; "Consignee No."; Code[20])
        {
            TableRelation = IF ("Consignee Type" = FILTER(Customer)) Customer
            ELSE
            IF ("Consignee Type" = FILTER(Vendor)) Vendor
            else
            if ("Consignee Type" = filter(Party)) Party;
            DataClassification = CustomerContent;
        }
        field(7; "Consignee Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Consignee Name 2"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(9; Address; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Consignee City"; Code[20])
        {
            TableRelation = "Post Code".Code;
            DataClassification = CustomerContent;
        }
        field(11; "Consignee Contact"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Phone No."; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Telex No."; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(21; "Calibration Status"; Option)
        {
            OptionMembers = "Working in Good Condition"," Reffered To Service"," Usage Subjective",Scrap;
            DataClassification = CustomerContent;
        }
        field(22; "Equipment No"; Code[20])
        {
            Description = 'Cal1.0';
            DataClassification = CustomerContent;
        }
        field(23; Results; Text[30])
        {
            Description = 'Cal1.0';
            DataClassification = CustomerContent;
        }
        field(24; Recommendations; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(25; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(26; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          "Consolidation Code" = FIELD("Global Dimension 1 Code"));
        }
        field(27; Status; Option)
        {
            OptionMembers = "Not Posted",Posted;
            DataClassification = CustomerContent;
        }
        field(30; "External Document No."; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(35; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Calibration Cert No./ IR No"; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                /*
                IF "Equipment No"  <> '' THEN BEGIN
                  IRHeader.SETRANGE("Source Type",IRHeader."Source Type" :: Calibration);
                  IF IRHeader.FIND('-') THEN
                    PAGE.RUN(50015,IRHeader);
                END;
                 */

            end;
        }
        field(40; "GP No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50; "RGP Out No."; Code[20])
        {
            Description = 'For RGP In in Calibration  Cal1.0';
            DataClassification = CustomerContent;
        }
        field(51; "RGP Out Date"; Date)
        {
            Description = 'For RGP In in Calibration  Cal1.0';
            DataClassification = CustomerContent;
        }
        field(52; "RGP Out Posting Date"; Date)
        {
            Description = 'For RGP In in Calibration  Cal1.0';
            DataClassification = CustomerContent;
        }
        field(53; "Excise Challan No."; Code[20])
        {
            Caption = 'Reference No.(If any)';
            DataClassification = CustomerContent;
        }
        field(54; "Excise Challan Date"; Date)
        {
            Caption = 'Reference Date(If any)';
            DataClassification = CustomerContent;
        }
        field(50000; "Responsible Person Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('EMP'));
            DataClassification = CustomerContent;
        }
        field(50001; "Responsible Person"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Approval Status"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";
        }
        field(50003; "Total Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Posted Gate Pass Line"."Total Value" WHERE("Document Type" = FIELD("Document Type"),
                                                                           "Document No." = FIELD("No.")));
            Editable = false;
        }
        field(50004; Shipped; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Mode of Transport"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50006; "Posted By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50007; "Posted By Name"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50010; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50011; "Created Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50012; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(50013; "Posted Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
        }
        field(50014; "Doc. Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = '//B2BCHP1.0';

            trigger OnValidate()
            begin
                "Documented By" := USERID;
            end;
        }
        field(50015; "Documented By"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = '//B2BCHP1.0';
        }
        field(50016; "Reference Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Sales Shipment","Purchase Order","Purchase Return Shipment","Transfer Shipment",Inspection, "Posted Purchase Receipt ";


            trigger OnValidate();
            begin
                if "Reference Type" <> xRec."Reference Type" then begin
                    "Reference No." := '';
                end;
            end;
        }
        field(50017; "Reference No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50018; "Posted RDC No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50020; "Way Bill No."; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50025; "Location Code"; Code[20])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
            Clustered = true;
        }
        key(Key2; "Consignee Type")
        {
        }
        key(Key3; "Consignee No.")
        {
        }
        key(Key4; Status)
        {
        }
        key(Key5; "Consignee Type", "Consignee No.", Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        GatePassLine.SETRANGE("Document Type", "Document Type");
        GatePassLine.SETRANGE("Document No.", "No.");
    end;

    var
        GatePassLine: Record "Gate Pass Line";
        GPLedEntries: Record "GP Ledger Entry";
        NextEntryNo: Integer;
        GpOutLine: Record "Gate Pass Line";
}


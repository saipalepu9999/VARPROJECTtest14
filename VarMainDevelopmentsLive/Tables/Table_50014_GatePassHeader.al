table 50014 "Gate Pass Header"
{
    DataCaptionFields = "No.", "Consignee Name";
    LookupPageID = "RGP Header List";
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

            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit 396;
                InventorySetup: Record "Inventory Setup";
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    InventorySetup.GET;
                    NoSeriesMgt.TestManual(GetNoSeriesCode);
                    "No. Series" := '';
                END;
                "Posting Date" := TODAY;
            end;
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

            trigger OnValidate()
            begin
                CASE "Consignee Type" OF
                    "Consignee Type"::Customer:
                        BEGIN
                            GetCustomer;
                            "Consignee Name" := Customer.Name;
                            "Consignee Name 2" := Customer."Name 2";
                            Address := Customer.Address;
                            "Consignee City" := Customer.City;
                            "Phone No." := Customer."Phone No.";
                            "Consignee Contact" := Customer.Contact;
                            "Telex No." := Customer."Telex No.";
                        END;
                    "Consignee Type"::Vendor:
                        BEGIN
                            GetVendor;
                            "Consignee Name" := Vendor.Name;
                            "Consignee Name 2" := Vendor."Name 2";
                            Address := Vendor.Address;
                            "Consignee City" := Vendor.City;
                            "Phone No." := Vendor."Phone No.";
                            "Consignee Contact" := Vendor.Contact;
                            "Telex No." := Vendor."Telex No.";
                        END;
                    "Consignee Type"::Party:
                        begin
                            GetParty();
                            "Consignee Name" := Party.Name;
                            // "Consignee Name 2" := Party.n
                            Address := Party.Address;
                            if PostCcode.Get(Party."Post Code") then
                                "Consignee City" := PostCcode.City;
                        end;

                END;
            end;
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
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
             Blocked = CONST(false));
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //B2B1.0 >>
                // IF "Global Dimension 1 Code" <> '' THEN
                //    FilterSD1;
                //B2B1.0 <<
            end;
        }
        field(26; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
             Blocked = CONST(false), "Division Code" = field("Global Dimension 1 Code"));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //B2B1.0 >>
                //IF "Global Dimension 2 Code" <> '' THEN
                //  FilterSD2;
                //B2B1.0 <<
            end;
        }
        field(30; "External Document No.";
        Text[50])
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
                /*IF "Equipment No"  <> '' THEN BEGIN
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
            Description = 'B2B.1.0';
            TableRelation = Employee."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                DimensionValueRec.RESET;
                DimensionValueRec.SETRANGE("No.", "Responsible Person Code");
                IF DimensionValueRec.FINDFIRST THEN
                    "Responsible Person" := DimensionValueRec.FullName();
            end;
        }
        field(50001; "Responsible Person"; Text[100])
        {
            Description = 'B2B.1.0';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50002; "Approval Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(50003; "Total Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Gate Pass Line"."Total Value" WHERE("Document Type" = FIELD("Document Type"),
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
            TableRelation = "Transport Method".Code;
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
            OptionMembers = " ","Sales Shipment","Purchase Order","Purchase Return Shipment","Transfer Shipment",Inspection,"Posted Purchase Receipt ";//B2BSPON21JUNE23


            trigger OnValidate();
            begin
                Rec.TestField("Global Dimension 1 Code");
                Rec.TestField("Global Dimension 2 Code");
                if "Reference Type" <> xRec."Reference Type" then begin
                    "Reference No." := '';
                end;
            end;
        }
        field(50017; "Reference No."; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnLookup()


            begin

                case Rec."Reference Type" of
                    Rec."Reference Type"::"Sales Shipment":
                        begin
                            SalesShipHeader.RESET;
                            //SalesShipHeader.SetRange(statu);
                            if "Consignee Type" = "Consignee Type"::Customer then
                                SalesShipHeader.SetRange("Sell-to Customer No.", "Consignee No.");
                            SalesShipHeader.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            SalesShipHeader.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                            if Page.RunModal(Page::"Posted Sales Shipments", SalesShipHeader) = Action::LookupOK then begin
                                //if PAGE.RUNMODAL(Page::"Posted Sales Shipments", SalesShipHeader) = ACTION::LookupOK then begin
                                Rec."Reference No." := SalesShipHeader."No.";
                                Rec."Excise Challan Date" := SalesShipHeader."Posting Date";
                                GatePassLineLrec.Reset();
                                GatePassLineLrec.SetRange("Document Type", Rec."Document Type");
                                GatePassLineLrec.SetRange("Document No.", Rec."No.");
                                if GatePassLineLrec.FindSet() then begin
                                    GatePassLineLrec.DeleteAll();
                                end;
                                UpdateLines(SalesShipHeader);
                            end;
                        end;

                    Rec."Reference Type"::"Purchase Return Shipment":
                        begin
                            ReturnShipHeader.RESET;
                            //ReturnShipHeader.SetRange(sta);
                            ReturnShipHeader.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            ReturnShipHeader.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                            if "Consignee Type" = "Consignee Type"::Vendor then
                                ReturnShipHeader.SetRange("Buy-from Vendor No.", "Consignee No.");
                            if PAGE.RUNMODAL(Page::"Posted Return Shipments", ReturnShipHeader) = ACTION::LookupOK then begin
                                Rec."Reference No." := ReturnShipHeader."No.";
                                Rec."Excise Challan Date" := ReturnShipHeader."Posting Date";
                                GatePassLineLrec.Reset();
                                GatePassLineLrec.SetRange("Document Type", Rec."Document Type");
                                GatePassLineLrec.SetRange("Document No.", Rec."No.");
                                if GatePassLineLrec.FindSet() then begin
                                    GatePassLineLrec.DeleteAll();
                                end;
                                UpdateLines(ReturnShipHeader);
                            end;
                        end;

                    Rec."Reference Type"::"Transfer Shipment":
                        begin
                            TransShptHeader.RESET;
                            //TransShptHeader.SetRange("Approval Status",a);
                            TransShptHeader.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            TransShptHeader.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                            if PAGE.RUNMODAL(Page::"Posted Transfer Shipments", TransShptHeader) = ACTION::LookupOK then begin
                                Rec."Reference No." := TransShptHeader."No.";
                                Rec."Excise Challan Date" := TransShptHeader."Posting Date";
                                GatePassLineLrec.Reset();
                                GatePassLineLrec.SetRange("Document Type", Rec."Document Type");
                                GatePassLineLrec.SetRange("Document No.", Rec."No.");
                                if GatePassLineLrec.FindSet() then begin
                                    GatePassLineLrec.DeleteAll();
                                end;
                                UpdateLines(TransShptHeader);
                            end;
                        end;
                    Rec."Reference Type"::"Purchase Order":
                        begin
                            PurchHeader.RESET;
                            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                            PurchHeader.SetRange(Status, PurchHeader.Status::Released);
                            if "Consignee Type" = "Consignee Type"::Vendor then
                                PurchHeader.SetRange("Buy-from Vendor No.", "Consignee No.");
                            PurchHeader.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            PurchHeader.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                            if PAGE.RUNMODAL(Page::"Purchase Order List", PurchHeader) = ACTION::LookupOK then begin
                                Rec."Reference No." := PurchHeader."No.";
                                Rec."Excise Challan Date" := PurchHeader."Posting Date";
                                GatePassLineLrec.Reset();
                                GatePassLineLrec.SetRange("Document Type", Rec."Document Type");
                                GatePassLineLrec.SetRange("Document No.", Rec."No.");
                                if GatePassLineLrec.FindSet() then begin
                                    GatePassLineLrec.DeleteAll();
                                end;
                                UpdateLines(PurchHeader);
                            end;
                        end;
                    //b2bsp
                    Rec."Reference Type"::Inspection:
                        begin
                            //PurchHeader.RESET;
                            if "Consignee Type" = "Consignee Type"::Vendor then;
                            /*   PurchHeader.SetRange("Buy-from Vendor No.", "Consignee No.");
                           PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                           purchHeader.setrange(Status, PurchHeader.Status::Released);
                           PurchHeader.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                           PurchHeader.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");*/
                            Inspection.Reset();
                            Inspection.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            Inspection.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                            Inspection.SetRange("Vendor No.", "Consignee No.");
                            Inspection.SetRange(Status, true);
                            Inspection.SetFilter("Qty. Rework", '<>%1', 0);

                            if Page.RunModal(Page::"Posted Ins Receipt List B2B", Inspection) = Action::LookupOK then begin
                                // if PAGE.RUNMODAL(Page::"Purchase Order List", PurchHeader) = ACTION::LookupOK then begin

                                Rec."Reference No." := Inspection."No.";
                                Rec."Excise Challan Date" := Inspection."Posting Date";

                                GatePassLineLrec.Reset();
                                GatePassLineLrec.SetRange("Document Type", Rec."Document Type");
                                GatePassLineLrec.SetRange("Document No.", Rec."No.");
                                if GatePassLineLrec.FindSet() then begin
                                    GatePassLineLrec.DeleteAll();
                                end;
                                UpdateLines(Inspection);
                            end;
                        end;


                    Rec."Reference Type"::"Posted Purchase Receipt ":
                        begin
                            //PurchHeader.RESET;
                            if "Consignee Type" = "Consignee Type"::Vendor then;
                            /*   PurchHeader.SetRange("Buy-from Vendor No.", "Consignee No.");
                           PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                           purchHeader.setrange(Status, PurchHeader.Status::Released);
                           PurchHeader.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                           PurchHeader.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");*/
                            PurchaseReceipt.Reset();
                            PurchaseReceipt.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            PurchaseReceipt.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                            // PurchaseReceipt.SetRange("Vendor No.", "Consignee No.");
                            // Inspection.SetRange(Status, true);
                            // PurchaseReceipt.SetFilter("Qty. Rework", '<>%1', 0);

                            if Page.RunModal(Page::"Posted Purchase Receipt", PurchaseReceipt) = Action::LookupOK then begin
                                // if PAGE.RUNMODAL(Page::"Purchase Order List", PurchHeader) = ACTION::LookupOK then begin

                                Rec."Reference No." := PurchaseReceipt."No.";
                                Rec."Excise Challan Date" := PurchaseReceipt."Posting Date";

                                GatePassLineLrec.Reset();
                                GatePassLineLrec.SetRange("Document Type", Rec."Document Type");
                                GatePassLineLrec.SetRange("Document No.", Rec."No.");
                                if GatePassLineLrec.FindSet() then begin
                                    GatePassLineLrec.DeleteAll();
                                end;
                                UpdateLines(PurchaseReceipt);
                            end;
                        end;

                end;

            end;

            trigger OnValidate()
            var
                Text16500: Label 'Source Type must not be blank ';
            begin
                if Rec."Reference Type" = 0 then
                    ERROR(Text16500);
            end;
        }
        field(50018; "Posted RDC No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50020; "Way Bill No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Posting No RGP in"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(50023; "Posting No RGP Out"; Code[20])
        {
            DataClassification = ToBeClassified;


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
        key(Key4; "Consignee Type", "Consignee No.")
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

    trigger OnInsert()
    begin
        InventorySetup.GET;
        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;


    end;






    procedure GetCustomer()
    begin
        TESTFIELD("Consignee No.");
        IF Customer."No." <> "Consignee No." THEN
            Customer.GET("Consignee No.");
    end;


    procedure GetVendor()
    begin
        TESTFIELD("Consignee No.");
        IF Vendor."No." <> "Consignee No." THEN
            Vendor.GET("Consignee No.");
    end;

    procedure GetParty()
    begin
        TESTFIELD("Consignee No.");
        IF Party.Code <> "Consignee No." THEN
            Party.GET("Consignee No.");
    end;


    procedure GetNoSeriesCode(): Code[20]
    begin
        CASE "Document Type" OF
            "Document Type"::"RGP Out":
                EXIT(InventorySetup."RGP Out");
            "Document Type"::"RGP In":
                EXIT(InventorySetup."RGP In");
        END;
    end;


    procedure AssistEdit(OldRGPHeader: Record "Gate Pass Header"): Boolean
    var
        NoSeries: Record "No. Series";
    begin
        InventorySetup.GET;
        TestNoSeries;
        IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldRGPHeader."No. Series", "No. Series") THEN BEGIN
            InventorySetup.GET;
            TestNoSeries;
            NoSeriesMgt.SetSeries("No.");
            if NoSeries.Get("No. Series") then
                "Global Dimension 1 Code" := NoSeries."Shortcut Dimension 1 Code_B2B";
            EXIT(TRUE);
        END;
    end;


    procedure TestNoSeries()
    begin
        CASE "Document Type" OF
            "Document Type"::"RGP Out":
                InventorySetup.TESTFIELD("RGP Out");
            "Document Type"::"RGP In":
                InventorySetup.TESTFIELD("RGP In");
        END;


    end;


    procedure DeleteGatePassLines()
    begin
        IF GatePassLine.FIND('-') THEN
            REPEAT
                GatePassLine.DELETE(TRUE);
            UNTIL GatePassLine.NEXT = 0;
    end;


    procedure PostRGPOut()
    var
        UserSetupGRec: Record 91;
        DimensionValueGRec: Record 349;
    begin
        GatePassHeader.RESET;
        GatePassHeader.SETRANGE("Document Type", "Document Type");
        GatePassHeader.SETRANGE("No.", "No.");
        IF GatePassHeader.FINDFIRST THEN BEGIN
            GPLedEntries.RESET;
            GatePassLine.SETRANGE("Document Type", GatePassHeader."Document Type");
            GatePassLine.SETRANGE("Document No.", GatePassHeader."No.");
            IF GatePassLine.FIND('-') THEN
                GPLedEntries.LOCKTABLE;
            IF GPLedEntries.FIND('+') THEN
                NextEntryNo := GPLedEntries."Entry No."
            ELSE
                NextEntryNo := 0;
            REPEAT
                IF (GatePassLine.Type = GatePassLine.Type::Item) OR (GatePassLine.Type = GatePassLine.Type::"Fixed Asset")
                    /*
                    OR (GatePassLine. Type= GatePassLine. Type:: Calibration)
                    */
                    THEN BEGIN
                    if GatePassLine.Type in [GatePassLine.Type::Item, GatePassLine.Type::"Non-Stock Item"] then
                        GatePassLine.TESTFIELD(GatePassLine."Unit of Measure");
                END;
                GPLedEntries.INIT;
                NextEntryNo := NextEntryNo + 1;
                GPLedEntries."Entry No." := NextEntryNo;
                GPLedEntries."Document Date" := GatePassHeader."Posting Date";
                GPLedEntries."Source Type" := GatePassLine."Document Type";
                GPLedEntries."Source No." := GatePassLine."Document No.";
                GPLedEntries."Line No." := GatePassLine."Line No.";
                GPLedEntries.Type := GatePassLine.Type;
                GPLedEntries."No." := GatePassLine."No.";
                GPLedEntries."Unit Of Measure" := GatePassLine."Unit of Measure";
                GPLedEntries.Quantity := GatePassLine.Quantity;
                GatePassLine.CALCFIELDS("Quantity Received");
                GPLedEntries."Quantity Received" := GatePassLine."Quantity Received";
                GPLedEntries."Remaining Quantity" := GPLedEntries.Quantity - GPLedEntries."Quantity Received";
                GPLedEntries.Open := TRUE;
                //      GPLedEntries."Consignee Type" := GatePassHeader."Consignee Type";
                GPLedEntries."Consignee No." := GatePassHeader."Consignee No.";
                GPLedEntries."Consignee Name" := GatePassHeader."Consignee Name";
                //B2B1.0 >>
                GPLedEntries."Created By" := GatePassHeader."Created By";
                IF DimensionValueGRec.GET('DEPARTMENT', GatePassHeader."Shortcut Dimension 4 Code") THEN
                    GPLedEntries."Department Name" := DimensionValueGRec.Name;
                IF UserSetupGRec.GET(GatePassHeader."Created By") THEN BEGIN
                    UserSetupGRec.CALCFIELDS("User Name");
                    GPLedEntries."Created Name" := UserSetupGRec."User Name";
                END;
                //B2B1.0 <<
                GPLedEntries.INSERT;

            UNTIL GatePassLine.NEXT = 0;

            //B2B1.0 >>

            PostedGatePassHeader."Posted By" := USERID;
            IF UserSetupGRec.GET(USERID) THEN BEGIN
                UserSetupGRec.CALCFIELDS("User Name");
                PostedGatePassHeader."Posted By Name" := UserSetupGRec."User Name";

            END;
            // RdcOutVar.RDCOut();
            //B2B1.0 <<
            //   PostedGatePassHeader.INSERT;
            GatePassHeader.Shipped := TRUE;
            GatePassHeader."Posted By" := USERID;
            IF UserSetupGRec.GET(USERID) THEN BEGIN
                UserSetupGRec.CALCFIELDS("User Name");
                GatePassHeader."Posted By Name" := UserSetupGRec."User Name";
            END;
            GatePassHeader."Posted Date" := WORKDATE;
            GatePassHeader.MODIFY;
        END;

    end;


    procedure PostRGPIN(GatePassHeaderCopy: Record "Gate Pass Header")
    var
        GatePassLineCopy: Record "Gate Pass Line";
        DimensionValue1GRec: Record 349;
        UserSetup1GRec: Record 91;
    begin
        GatePassHeader.RESET;
        GatePassHeader.SETRANGE("Document Type", GatePassHeader."Document Type"::"RGP In");
        GatePassHeader.SETRANGE("No.", GatePassHeaderCopy."No.");
        IF GatePassHeader.FINDFIRST THEN BEGIN
            GPLedEntries.RESET;
            GatePassLine.SETRANGE("Document Type", GatePassLine."Document Type"::"RGP In");
            GatePassLine.SETRANGE("Document No.", GatePassHeader."No.");
            GatePassLine.SETFILTER("Quantity to Receive", '<>%1', 0);
            IF GatePassLine.FIND('-') THEN begin
                GPLedEntries.LOCKTABLE;
                IF GPLedEntries.FIND('+') THEN
                    NextEntryNo := GPLedEntries."Entry No."
                ELSE
                    NextEntryNo := 0;
                REPEAT
                    IF (GatePassLine.Type = GatePassLine.Type::Item) OR (GatePassLine.Type = GatePassLine.Type::"Fixed Asset")

                       THEN BEGIN
                        GatePassLine.CALCFIELDS("Quantity Received");
                        GatePassLine.TESTFIELD("Quantity to Receive");
                        if GatePassLine.Type in [GatePassLine.Type::Item, GatePassLine.Type::"Non-Stock Item"] then
                            GatePassLine.TESTFIELD("Unit of Measure");
                    END;
                    GPLedEntries.INIT;
                    NextEntryNo := NextEntryNo + 1;
                    GPLedEntries."Entry No." := NextEntryNo;
                    GPLedEntries."Document Date" := GatePassHeader."Posting Date";
                    GPLedEntries."Source Type" := GatePassHeader."Document Type";
                    GPLedEntries."Source No." := GatePassHeader."No.";
                    GPLedEntries."Line No." := GatePassLine."Line No.";
                    GPLedEntries.Type := GatePassLine.Type;
                    GPLedEntries."No." := GatePassLine."No.";
                    GPLedEntries."Unit Of Measure" := GatePassLine."Unit of Measure";
                    GPLedEntries.Quantity := GatePassLine."Quantity to Receive";
                    GPLedEntries."Quantity Received" := GatePassLine."Quantity to Receive";
                    GatePassLine.CALCFIELDS("Quantity Received");
                    GPLedEntries."Remaining Quantity" := GatePassLine.Quantity - (GatePassLine."Quantity to Receive" + GatePassLine."Quantity Received");
                    GPLedEntries.Open := FALSE;
                    GPLedEntries."Applied Entries" := GatePassLine."Applies GP No";
                    //      GPLedEntries."Consignee Type" := GatePassHeader."Consignee Type";
                    GPLedEntries."Consignee No." := GatePassHeader."Consignee No.";
                    GPLedEntries."Consignee Name" := GatePassHeader."Consignee Name";
                    //B2B1.0 >>
                    GPLedEntries."Created By" := GatePassHeader."Created By";
                    IF DimensionValue1GRec.GET('DEPARTMENT', GatePassHeader."Shortcut Dimension 4 Code") THEN
                        GPLedEntries."Department Name" := DimensionValue1GRec.Name;
                    IF UserSetup1GRec.GET(GatePassHeader."Created By") THEN BEGIN
                        UserSetup1GRec.CALCFIELDS("User Name");
                        GPLedEntries."Created Name" := UserSetup1GRec."User Name";
                    END;
                    //B2B1.0 <<
                    GPLedEntries."Posted RDC No." := Rec."No.";
                    GPLedEntries.INSERT;

                    GPLedEntries.RESET;
                    GPLedEntries.SETRANGE(Open, TRUE);
                    GPLedEntries.SETRANGE("Source No.", GatePassLine."Applies GP No");
                    GPLedEntries.SETRANGE("Line No.", GatePassLine."Line No.");
                    IF GPLedEntries.FIND('-') THEN BEGIN
                        GPLedEntries."Remaining Quantity" := GatePassLine."Remaining Quantity";
                        IF GPLedEntries."Remaining Quantity" = 0 THEN
                            GPLedEntries.Open := FALSE;
                        GPLedEntries.MODIFY;
                    END;


                UNTIL GatePassLine.NEXT = 0;
            end;

            CLEAR(RemQty);
            GatePassLineCopy.RESET;
            GatePassLineCopy.SETRANGE("Document No.", "No.");
            IF GatePassLineCopy.FINDSET THEN BEGIN
                REPEAT
                    RemQty += GatePassLineCopy."Remaining Quantity";
                    GatePassLineCopy."Quantity to Receive" := 0;
                    GatePassLineCopy.MODIFY;
                UNTIL GatePassLineCopy.NEXT = 0;
            END;

            IF RemQty = 0 THEN BEGIN
                DELETE;
                GatePassHeader.Delete();
                /*
               GatePassLine.RESET;
               GatePassLine.SETRANGE("Document Type", GatePassLine."Document Type"::"RGP Out");
               GatePassLine.SETRANGE("Document No.", "No.");
               IF GatePassLine.FIND('-') THEN
                   GatePassLine.DELETEALL;*/

                               GatePassLine.RESET;
                               GatePassLine.SETRANGE("Document Type", GatePassLine."Document Type"::"RGP IN");
                               GatePassLine.SETRANGE("Document No.", GatePassHeaderCopy."No.");
                               IF GatePassLine.FIND('-') THEN
                                   GatePassLine.DELETEALL;
            END;
        END;

    end;


    procedure FilterSD1()
    begin
        flag := FALSE;
        DimensionValue3GRec.RESET;
        usersetup.INIT;
        usersetup.SETRANGE("User ID", UPPERCASE(USERID));
        usersetup.SETRANGE("Assign Security Filter", TRUE);
        IF usersetup.FIND('-') THEN
            ss := usersetup."Global Dimension 1 Filter";
        DimensionValue3GRec.SETFILTER(Code, ss);
        IF DimensionValue3GRec.FIND('-') THEN;
        REPEAT
            IF DimensionValue3GRec.Code = "Global Dimension 1 Code" THEN
                flag := TRUE;
        UNTIL DimensionValue3GRec.NEXT = 0;
        IF NOT flag THEN
            ERROR('U have no permissions to select this Dimension.');
    end;


    procedure FilterSD2()
    begin
        flag := FALSE;
        DimensionValue4GRec.RESET;
        usersetup.INIT;
        usersetup.SETRANGE("User ID", UPPERCASE(USERID));
        usersetup.SETRANGE("Assign Security Filter", TRUE);
        IF usersetup.FIND('-') THEN
            ss := usersetup."Global Dimension 2 Filter";
        DimensionValue4GRec.SETFILTER(Code, ss);
        IF DimensionValue4GRec.FIND('-') THEN;
        REPEAT
            IF DimensionValue4GRec.Code = "Global Dimension 2 Code" THEN
                flag := TRUE;
        UNTIL DimensionValue4GRec.NEXT = 0;
        IF NOT flag THEN
            ERROR('U have no permissions to select this Dimension.');
    end;

    Procedure UpdateLines(Vari: Variant)
    var
        SalesShipmentHdr: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        ReturnShipmentHdr: Record "Return Shipment Header";
        ReturnShipmentLine: Record "Return Shipment Line";
        TransferShipmentHdr: Record "Transfer Shipment Header";
        TransferShipmentLine: Record "Transfer Shipment Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        GatePassLine: Record "Gate Pass Line";
        PurchRcptLine: Record "Purch. Rcpt. Line";

    begin
        RecReference.GetTable(Vari);
        case RecReference.Number of
            Database::"Sales Shipment Header":
                begin
                    LineNoLVar := 10000;
                    RecReference.SetTable(SalesShipmentHdr);
                    SalesShipmentLine.Reset();
                    SalesShipmentLine.SetRange("Document No.", SalesShipmentHdr."No.");
                    //SalesShipmentLine.SetRange(Type, SalesShipmentLine.Type::Item);
                    if SalesShipmentLine.FindSet() then begin
                        repeat
                            GatePassLine.Init();
                            GatePassLine."Document Type" := Rec."Document Type";
                            GatePassLine."Document No." := Rec."No.";
                            GatePassLine."Line No." := LineNoLVar;
                            LineNoLVar += 10000;
                            if SalesShipmentLine.Type = SalesShipmentLine.Type::Item then
                                GatePassLine.Type := GatePassLine.Type::Item
                            else
                                if SalesShipmentLine.Type = SalesShipmentLine.Type::"Fixed Asset" then
                                    GatePassLine.Type := GatePassLine.Type::"Fixed Asset"
                                else
                                    if SalesShipmentLine.Type = SalesShipmentLine.Type::"G/L Account" then
                                        GatePassLine.Type := GatePassLine.Type::"G/L Account";
                            GatePassLine.validate("No.", SalesShipmentLine."No.");
                            GatePassLine.Description := SalesShipmentLine.Description;
                            GatePassLine.validate(Quantity, SalesShipmentLine.Quantity);
                            GatePassLine."Unit of Measure" := SalesShipmentLine."Unit of Measure Code";
                            if SalesShipmentLine.Type = SalesShipmentLine.Type::"G/L Account" then
                                GatePassLine.Validate("Unit Rate", SalesShipmentLine."Unit Price");
                            GatePassLine.Insert();
                        until SalesShipmentLine.Next() = 0;
                    end;
                end;
            Database::"Return Shipment Header":
                begin
                    LineNoLVar := 10000;
                    RecReference.SetTable(ReturnShipmentHdr);
                    ReturnShipmentLine.Reset();
                    ReturnShipmentLine.SetRange("Document No.", ReturnShipmentHdr."No.");
                    //ReturnShipmentLine.SetRange(Type, ReturnShipmentLine.Type::Item);
                    if ReturnShipmentLine.FindSet() then begin
                        repeat
                            GatePassLine.Init();
                            GatePassLine."Document Type" := Rec."Document Type";
                            GatePassLine."Document No." := Rec."No.";
                            GatePassLine."Line No." := LineNoLVar;
                            LineNoLVar += 10000;
                            if ReturnShipmentLine.Type = ReturnShipmentLine.Type::Item then
                                GatePassLine.Type := GatePassLine.Type::Item
                            else
                                if ReturnShipmentLine.Type = ReturnShipmentLine.Type::"Fixed Asset" then
                                    GatePassLine.Type := GatePassLine.Type::"Fixed Asset"
                                else
                                    if ReturnShipmentLine.Type = ReturnShipmentLine.Type::"G/L Account" then
                                        GatePassLine.Type := GatePassLine.Type::"G/L Account";
                            GatePassLine.validate("No.", ReturnShipmentLine."No.");
                            GatePassLine.Description := ReturnShipmentLine.Description;
                            GatePassLine.validate(Quantity, ReturnShipmentLine.Quantity);
                            GatePassLine."Unit of Measure" := ReturnShipmentLine."Unit of Measure Code";
                            if ReturnShipmentLine.Type = ReturnShipmentLine.Type::"G/L Account" then
                                GatePassLine.Validate("Unit Rate", ReturnShipmentLine."Direct Unit Cost");
                            GatePassLine.Insert();
                        until ReturnShipmentLine.Next() = 0;
                    end;
                end;

            Database::"Transfer Shipment Header":
                begin
                    LineNoLVar := 10000;
                    RecReference.SetTable(TransferShipmentHdr);
                    TransferShipmentLine.Reset();
                    TransferShipmentLine.SetRange("Document No.", TransferShipmentHdr."No.");
                    //TransferShipmentLine.SetRange(Type, TransferShipmentLine.Type::Item);
                    if TransferShipmentLine.FindSet() then begin
                        repeat
                            //LineNoLVar := 10000;
                            GatePassLine.Init();
                            GatePassLine."Document Type" := Rec."Document Type";
                            GatePassLine."Document No." := Rec."No.";
                            GatePassLine."Line No." := LineNoLVar;
                            LineNoLVar += 10000;
                            GatePassLine.Type := GatePassLine.Type::Item;
                            GatePassLine.validate("No.", TransferShipmentLine."Item No.");
                            GatePassLine.Description := TransferShipmentLine.Description;
                            GatePassLine.validate(Quantity, TransferShipmentLine.Quantity);
                            GatePassLine."Unit of Measure" := TransferShipmentLine."Unit of Measure Code";
                            GatePassLine.Insert();
                        until TransferShipmentLine.Next() = 0;
                    end;
                end;
            Database::"Purchase Header":
                begin
                    LineNoLVar := 10000;
                    RecReference.SetTable(PurchaseHeader);
                    PurchaseLine.Reset();
                    PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                    // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    if PurchaseLine.FindSet() then begin
                        repeat
                            GatePassLine.Init();
                            GatePassLine."Document Type" := Rec."Document Type";
                            GatePassLine."Document No." := Rec."No.";
                            GatePassLine."Line No." := LineNoLVar;
                            LineNoLVar += 10000;
                            if PurchaseLine.Type = PurchaseLine.Type::Item then
                                GatePassLine.Type := GatePassLine.Type::Item
                            else
                                if PurchaseLine.Type = PurchaseLine.Type::"Fixed Asset" then
                                    GatePassLine.Type := GatePassLine.Type::"Fixed Asset"
                                else
                                    if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then
                                        GatePassLine.Type := GatePassLine.Type::"G/L Account";
                            GatePassLine.validate("No.", PurchaseLine."No.");
                            GatePassLine.Description := PurchaseLine.Description;
                            GatePassLine.validate(Quantity, PurchaseLine.Quantity);
                            GatePassLine."Unit of Measure" := PurchaseLine."Unit of Measure Code";
                            //GatePassLine."Unit Rate" := PurchaseLine."Direct Unit Cost";
                            if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then
                                GatePassLine.Validate("Unit Rate", PurchaseLine."Direct Unit Cost");
                            GatePassLine.Insert();
                        until PurchaseLine.Next() = 0;
                    end;
                end;
            Database::"Inspection Receipt Header B2B":
                begin
                    LineNoLVar := 10000;
                    RecReference.SetTable(Inspection);
                    //InspectionLine.Reset();
                    //PurchaseLine.SetRange("Document No.", InspectionHdr."No.");
                    // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    // if PurchaseLine.FindSet() then begin
                    //repeat
                    GatePassLine.Init();
                    GatePassLine."Document Type" := Rec."Document Type";
                    GatePassLine."Document No." := Rec."No.";
                    GatePassLine."Line No." := LineNoLVar;
                    //LineNoLVar += 10000;
                    GatePassLine.Type := GatePassLine.Type::Item;
                    //    GatePassLine.validate("No.", InspectionHdr."No.");
                    GatePassLine."No." := Inspection."Item No.";
                    GatePassLine.Description := Inspection."Item Description";
                    GatePassLine.validate(Quantity, Inspection."Qty. Rework");
                    GatePassLine."Unit of Measure" := Inspection."Unit of Measure Code";
                    //GatePassLine."Unit Rate" := PurchaseLine."Direct Unit Cost";
                    //if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then
                    //  GatePassLine.Validate("Unit Rate", PurchaseLine."Direct Unit Cost");
                    GatePassLine.Insert();
                    //until PurchaseLine.Next() = 0;
                end;

            Database::"Purch. Rcpt. Header":
                begin
                    LineNoLVar := 10000;
                    RecReference.SetTable(PurchaseReceipt);
                    PurchRcptLine.Reset();
                    PurchRcptLine.SetRange("Document No.", PurchaseReceipt."No.");
                    // PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
                    if PurchaseLine.FindSet() then begin
                        repeat
                            GatePassLine.Init();
                            GatePassLine."Document Type" := Rec."Document Type";
                            GatePassLine."Document No." := Rec."No.";
                            GatePassLine."Line No." := LineNoLVar;
                            LineNoLVar += 10000;
                            if PurchRcptLine.Type = PurchRcptLine.Type::Item then
                                GatePassLine.Type := GatePassLine.Type::Item
                            else
                                if PurchRcptLine.Type = PurchRcptLine.Type::"Fixed Asset" then
                                    GatePassLine.Type := GatePassLine.Type::"Fixed Asset"
                                else
                                    if PurchRcptLine.Type = PurchRcptLine.Type::"G/L Account" then
                                        GatePassLine.Type := GatePassLine.Type::"G/L Account";
                            GatePassLine.validate("No.", PurchRcptLine."No.");
                            GatePassLine.Description := PurchRcptLine.Description;
                            GatePassLine.validate(Quantity, PurchRcptLine.Quantity);
                            GatePassLine."Unit of Measure" := PurchRcptLine."Unit of Measure Code";
                            //GatePassLine."Unit Rate" := PurchaseLine."Direct Unit Cost";
                            if PurchRcptLine.Type = PurchRcptLine.Type::"G/L Account" then
                                GatePassLine.Validate("Unit Rate", PurchRcptLine."Direct Unit Cost");
                            GatePassLine.Insert();
                        until PurchRcptLine.Next() = 0;
                    end;
                end;
        end;



    end;

    var
        RecReference: RecordRef;
        NoSeriesMgt: Codeunit NoSeriesManagement;

        InventorySetup: Record 313;
        Customer: Record 18;
        Vendor: Record 23;
        Party: Record Party;
        PostCcode: Record "Post Code";
        GatePassHeader: Record "Gate Pass Header";
        GatePassLine: Record "Gate Pass Line";
        PostedGatePassHeader: Record "Posted Gate Pass Header";
        PostedGatePassLine: Record "Posted Gate Pass Line";
        GPLedEntries: Record "GP Ledger Entry";
        NextEntryNo: Integer;
        PRGPOutLine: Record "Posted Gate Pass Line";
        "B2B.1.0": Integer;
        DimensionValueRec: Record Employee;
        RemQty: Decimal;
        flag: Boolean;
        DimensionValue3GRec: Record 349;
        usersetup: Record "User Setup";
        ss: Text;
        DimensionValue4GRec: Record 349;
        NoSeriesGvar: Code[20];
        GateEntryHeader: Record "Gate Pass Header";
        SalesShipHeader: record "Sales Shipment Header";
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
        Inspection: Record "Inspection Receipt Header B2B";//B2BSPON21JUNE23
        PurchaseReceipt: Record "Purch. Rcpt. Header";
        ReturnShipHeader: Record "Return Shipment Header";
        TransHeader: Record "Transfer Header";
        TransShptHeader: Record "Transfer Shipment Header";
        GateEntryLneLRec: Record "Gate Pass Line";
        GateEntLneLRec: Record "Gate Pass Line";
        LineNoLVar: Integer;
        Text16500: Label 'Source Type must not be blank in %1 %2.';
        SourName: text[100];
        GateEntryHeaderLrec: Record "Gate Pass Header";
        GatePassLineLrec: Record "Gate Pass Line";
        LineNoVar: Integer;
        RdcOutVar: Page 50043;
}


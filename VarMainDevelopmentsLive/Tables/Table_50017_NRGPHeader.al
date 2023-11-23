table 50017 "NRGP Header"
{
    DrillDownPageID = "NRGP List";
    LookupPageID = "NRGP List";
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
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    InventorySetup.GET;
                    NoSeriesMgt.TestManual(InventorySetup.NRGP);
                    "No. Series" := '';
                END;
                "Posting Date" := TODAY;
            end;
        }
        field(5; "Consignee Type"; Option)
        {
            OptionMembers = Customer,Vendor,Party,Transfer;//B2BSPON21JUNE23
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
            Caption = 'TelePhone No.';
        }
        field(20; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(25; Status; Option)
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
        field(40; "GP No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Location Code"; Code[20])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(42; "Global Dimension 1 Code"; Code[20])
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
        field(43; "Global Dimension 2 Code"; Code[20])
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
        field(50001; "Responsible Person"; Text[50])
        {
            Description = 'B2B.1.0';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50016; "Reference Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Sales Shipment","Purchase Order","Purchase Return Shipment","Transfer Shipment",Inspection,"Posted Purchase Receipt";


            trigger OnValidate();
            begin
                Rec.TestField("Global Dimension 1 Code");
                Rec.TestField("Global Dimension 2 Code");
                if "Reference Type" <> xRec."Reference Type" then begin
                    "Reference No." := '';
                end;
            end;
        }
        field(50017; "Reference No."; Code[20])//B2BSPON21JUNE23
        {
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                GateEntryHeader: Record "Gate Pass Header";
                SalesShipHeader: record "Sales Shipment Header";
                SalesHeader: Record "Sales Header";
                PurchHeader: Record "Purchase Header";
                ReturnShipHeader: Record "Return Shipment Header";
                TransHeader: Record "Transfer Header";
                TransShptHeader: Record "Transfer Shipment Header";
                GateEntryLneLRec: Record "Gate Pass Line";
                GateEntLneLRec: Record "Gate Pass Line";
                LineNoLVar: Integer;
                Text16500: Label 'Source Type must not be blank in %1 %2.';
                SourName: text[100];
                GateEntryHeaderLrec: Record "Gate Pass Header";
                Inspection: Record "Inspection Receipt Header B2B";
                PurchaseReceipt: Record "Purch. Rcpt. Header";
            begin

                case Rec."Reference Type" of
                    Rec."Reference Type"::"Sales Shipment":
                        begin
                            SalesShipHeader.RESET;
                            if "Consignee Type" = "Consignee Type"::Customer then
                                SalesShipHeader.SetRange("Sell-to Customer No.", "Consignee No.");
                            SalesShipHeader.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            SalesShipHeader.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                            if PAGE.RUNMODAL(page::"Posted Sales Shipments", SalesShipHeader) = ACTION::LookupOK then begin
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
                            if "Consignee Type" = "Consignee Type"::Vendor then
                                ReturnShipHeader.SetRange("Buy-from Vendor No.", "Consignee No.");
                            ReturnShipHeader.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            ReturnShipHeader.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
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
                            if "Consignee Type" = "Consignee Type"::Vendor then
                                PurchHeader.SetRange("Buy-from Vendor No.", "Consignee No.");
                            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                            purchHeader.setrange(Status, PurchHeader.Status::Released);
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
                            PurchHeader.RESET;
                            if "Consignee Type" = "Consignee Type"::Vendor then
                                /*   PurchHeader.SetRange("Buy-from Vendor No.", "Consignee No.");
                               PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                               purchHeader.setrange(Status, PurchHeader.Status::Released);
                               PurchHeader.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                               PurchHeader.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");*/
                            Inspection.Reset();
                            Inspection.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            Inspection.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                            Inspection.SetRange("Vendor No.", "Consignee No.");
                            Inspection.SetFilter("Qty. Rework", '<>%1', 0);
                            // if Page.RunModal(Page::"Inspection Receipt List B2B", Inspection) = Action::LookupOK then begin
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
                    Rec."Reference Type"::"Posted Purchase Receipt":
                        begin
                            PurchaseReceipt.RESET;
                            if "Consignee Type" = "Consignee Type"::Vendor then
                                PurchaseReceipt.SetRange("Buy-from Vendor No.", "Consignee No.");
                            // PurchaseReceipt.SetRange("Document Type", PurchaseReceipt."Document Type"::);
                            // PurchaseReceipt.setrange(Status, PurchaseReceipt.Status::Released);
                            PurchaseReceipt.SetRange("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                            PurchaseReceipt.SetRange("Shortcut Dimension 2 Code", "Global Dimension 2 Code");
                            if PAGE.RUNMODAL(Page::"Posted Purchase Receipt", PurchaseReceipt) = ACTION::LookupOK then begin
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
        field(54; "Excise Challan Date"; Date)
        {
            Caption = 'Reference Date(If any)';
            DataClassification = CustomerContent;
        }
        field(55; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(56; "Posted Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
        }
        field(50020; "Way Bill No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Posting No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        InventorySetup.GET;
        IF "No." = '' THEN BEGIN
            NoSeriesMgt.InitSeries(InventorySetup.NRGP, xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    /* procedure TrackingShpmntLine(Type: Integer; Subtype: Integer; ID: Code[20]; BatchName: Code[10]; ProdOrderLine: Integer; RefNo: Integer): Boolean
     var
         TempItemLedgEntry: Record "Item Ledger Entry" temporary;
         ItemTRackingCu: Codeunit "Item Tracking Doc. Management";
         NRGPLine: Record "NRGP Line";

     begin
         NRGPLine.Reset();
         NRGPLine.SetRange("Document No.", "No.");
         if NRGPLine.FindSet() then begin
             repeat
                 ItemTRackingCu.RetrieveEntriesFromShptRcpt(TempItemLedgEntry, DATABASE::"Return Shipment Line", 0, "Reference No.", '', 0, NRGPLine."Line No.");
                 if TempItemLedgEntry.FindSet() then;
             until NRGPLine.Next() = 0

         end;


     end;*/

    Procedure UpdateLines(Vari: Variant)
    var
        SalesShipmentHdr: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        ReturnShipmentHdr: Record "Return Shipment Header";
        ReturnShipmentLine: Record "Return Shipment Line";
        TransferShipmentHdr: Record "Transfer Shipment Header";
        TransferShipmentLine: Record "Transfer Shipment Line";
        PurchaseHeader: Record "Purchase Header";
        PurchaseRcptHdr: Record "Purch. Rcpt. Header";
        PurchaseLine: Record "Purchase Line";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        GatePassLine: Record "NRGP Line";
        InspectionLine: Record "Inspection Receipt Line B2B";
        InspectionHdr: Record "Inspection Receipt Header B2B";

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

            //b2bsp
            Database::"Inspection Receipt Header B2B":
                begin
                    LineNoLVar := 10000;
                    RecReference.SetTable(InspectionHdr);
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
                    GatePassLine."No." := InspectionHdr."Item No.";
                    GatePassLine.Description := InspectionHdr."Item Description";
                    //     GatePassLine.validate(Quantity, InspectionHdr.Quantity);
                    GatePassLine.validate(Quantity, InspectionHdr."Qty. Rework");
                    GatePassLine."Unit of Measure" := InspectionHdr."Unit of Measure Code";
                    //GatePassLine."Unit Rate" := PurchaseLine."Direct Unit Cost";
                    //if PurchaseLine.Type = PurchaseLine.Type::"G/L Account" then
                    //  GatePassLine.Validate("Unit Rate", PurchaseLine."Direct Unit Cost");
                    GatePassLine.Insert();
                    //until PurchaseLine.Next() = 0;
                end;
            Database::"Purch. Rcpt. Header":
                begin
                    LineNoLVar := 10000;
                    RecReference.SetTable(PurchaseRcptHdr);
                    PurchRcptLine.Reset();
                    PurchRcptLine.SetRange("Document No.", PurchaseRcptHdr."No.");
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
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InventorySetup: Record 313;
        Customer: Record 18;
        Vendor: Record 23;
        Party: Record Party;
        PostCcode: Record "Post Code";
        NextEntryNo: Integer;
        NRGPHeader: Record "NRGP Header";
        "B2B.1.0": Integer;
        DimensionValueRec: Record Employee;
        LineNoLVar: Integer;
        RecReference: RecordRef;
        GatePassLineLrec: Record "NRGP Line";
        NoSeries: Record "No. Series";
        NoSeriesGvar: Text;


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


    procedure AssistEdit(OldNRGPHeader: Record "NRGP Header"): Boolean
    begin
        NRGPHeader := Rec;
        InventorySetup.GET;
        InventorySetup.TestField(NRGP);
        IF NoSeriesMgt.SelectSeries(InventorySetup.NRGP, OldNRGPHeader."No. Series", "No. Series") THEN BEGIN
            //InventorySetup.GET;
            //NoSeriesGvar := NRGPHeader."No.";
            NoSeriesMgt.SetSeries("No.");
            //Rec := NRGPHeader;
            if NoSeries.Get("No. Series") then
                "Global Dimension 1 Code" := NoSeries."Shortcut Dimension 1 Code_B2B";
            EXIT(TRUE);
        END;
    end;


}


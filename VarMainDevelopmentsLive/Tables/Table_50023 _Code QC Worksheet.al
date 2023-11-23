table 50023 "Code QC Worksheet"
{
    // version C2C
    Caption = 'Code To Code WorkSheet';

    fields
    {
        field(1; "QC Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Retest,Stability Test,Miscellaneous';
            OptionMembers = Retest,"Stability Test",Miscellaneous;
        }
        field(2; "Worksheet Doc No."; Code[20])
        {
        }
        field(5; "Posting Date"; Date)
        {
        }
        field(8; "From Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate();
            var
                ItemRec: Record Item;
            begin
                Rec.TESTFIELD(Status, Rec.Status::Open);
                if (CopyStr("From Item No.", 1, 1) <> 'D') And (CopyStr("From Item No.", 1, 1) <> 'E') then
                    Error('You cannot Select this item');
                IF ItemRec.GET("From Item No.") THEN BEGIN
                    "From Item Description" := ItemRec.Description;
                    UOM := ItemRec."Base Unit of Measure";
                END else begin
                    "From Item Description" := '';
                    UOM := '';
                    Quantity := 0;
                    "Lot No." := '';
                    "Expiry Date" := 0D;
                    "Unit Cost" := 0;
                    "Shortcut Dimension 1 Code" := '';
                    "Shortcut Dimension 2 Code" := '';
                    Location := '';
                end;
            end;
        }
        field(9; "From Item Description"; Text[50])
        {
            Editable = false;
        }
        field(11; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);
            end;
        }
        field(12; UOM; Code[10])
        {
            Editable = false;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("From Item No."));
        }
        field(13; "ItemLedgEntry No."; Integer)
        {
            Caption = 'Item Ledg Entry No.';
            TableRelation = IF ("Loan License" = CONST(false)) "Item Ledger Entry" WHERE("Item No." = FIELD("From Item No."),
                                                                                   Open = CONST(true),
                                                                                   "Location Code" = FIELD(Location));

            trigger OnValidate();
            begin
                TESTFIELD(Status, Status::Open);

                UpdateILEItem;
            end;
        }
        field(14; Location; Code[10])
        {
            TableRelation = Location.Code;
            trigger OnValidate()
            var
                InventorySetup: Record "Inventory Setup";
            begin
                InventorySetup.Get();
                if Location <> InventorySetup."Transfer-From Location" then
                    Error('From Location Should be %1', InventorySetup."Transfer-From Location");
            end;
        }
        field(15; "Sample Qty"; Decimal)
        {
            Editable = true;
        }
        field(16; "Sample UOM"; Code[10])
        {
            Editable = true;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("To Item No."));

            trigger OnValidate();
            begin
                ItemUOM.GET("From Item No.", UOM);
            end;
        }
        field(18; "Inspection Receipt No."; Code[20])
        {
            Description = 'Changed from A.R. No. to Inspection Receipt No.';
            Editable = false;
        }
        field(19; "Lot No."; Code[20])
        {
            Editable = false;
        }
        field(21; "Expiry Date"; Date)
        {
        }
        field(22; "Mfg. Date"; Date)
        {
        }
        field(23; "Specification ID"; Code[20])
        {
        }
        field(26; "IDS Posting No.Series"; Code[20])
        {
        }
        field(27; "QC Status"; Option)
        {
            Editable = false;
            OptionCaption = '" ,IDS,IR,PIR"';
            OptionMembers = " ",IDS,IR,PIR;
        }
        field(30; "Last Inspection Date"; Date)
        {
            Description = 'UD 2.0';
        }
        field(31; "Next Inspection Date"; Date)
        {
            Description = 'UD 2.0';
        }
        field(32; "Loan License"; Boolean)
        {
        }
        field(35; "Reason for Retest"; Text[250])
        {
        }
        field(200; "AR No."; Code[20])
        {
        }
        field(201; Posted; Boolean)
        {
        }
        field(202; "To Item No."; Code[20])
        {

            trigger OnValidate();
            var
                ItemRec: Record Item;
                PurchInvLine: Record 123;
                DefaultDimension: Record "Default Dimension";
                GLSetup: Record "General Ledger Setup";
            begin
                GLSetup.Get();
                TESTFIELD(Status, Status::Open);
                if (CopyStr("To Item No.", 1, 1) <> 'E') and (CopyStr("To Item No.", 1, 1) <> 'D') then
                    Error('You cannot Select this item');
                IF ItemRec.GET("To Item No.") THEN BEGIN
                    "To Item Description" := ItemRec.Description;
                    //"Specification ID" := ItemRec."Spec ID";
                    DefaultDimension.Reset();
                    DefaultDimension.SetRange("Table ID", 27);
                    DefaultDimension.SetRange("No.", "To Item No.");
                    DefaultDimension.SetRange("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
                    if DefaultDimension.FindFirst() then
                        "New Shortcut Dimension 1 Code" := DefaultDimension."Dimension Value Code";
                END;

                //DM 1.1>>End
                PurchInvLine.RESET;
                PurchInvLine.SETCURRENTKEY("Posting Date");
                PurchInvLine.SETRANGE(Type, PurchInvLine.Type::Item);
                PurchInvLine.SETRANGE("No.", "From Item No.");
                IF PurchInvLine.FINDLAST THEN
                    "Unit Cost" := PurchInvLine."Unit Cost (LCY)";
            end;
        }
        field(203; "To Item Description"; Text[50])
        {
            Editable = false;
        }
        field(205; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
        }
        field(206; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;

        }
        field(207; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,"Pending For Approval",Released;
        }
        field(208; "Unit Cost"; Decimal)
        {
        }
        field(209; "New Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1,' + 'New';
            Caption = 'New Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;

        }
        field(210; "New Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2,' + 'New';
            Caption = 'New Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), "Division Code" = field("New Shortcut Dimension 1 Code"));

        }
        field(211; "New Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'New Location';
            TableRelation = Location;
            trigger OnValidate()
            var
                InventorySetup: Record "Inventory Setup";
            begin
                // InventorySetup.Get();
                //if "New Location Code" <> InventorySetup."Transfer-To Location" then
                //   Error('To Location Should be %1', InventorySetup."Transfer-To Location");
            end;
        }
        field(212; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';

        }
        field(213; "New Lot No."; Code[20])
        {
            Caption = 'New Lot No.';

        }
        field(214; "New Serial No."; Code[20])
        {
            Caption = 'New Serial No.';

        }
    }

    keys
    {
        key(Key1; "QC Type", "Worksheet Doc No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        IF "QC Status" <> "QC Status"::" " THEN;
        //ERROR(Text000);
    end;

    trigger OnInsert();
    begin
        //DM 1.1>>Begin
        InventorySetUp.GET;
        InventorySetUp.TESTFIELD("Code WorkSheet No.");
        "Worksheet Doc No." := NoSeriesMgt.GetNextNo(InventorySetUp."Code WorkSheet No.", WORKDATE, TRUE);
        //DM 1.1<<End
    end;

    trigger OnModify();
    begin
        //DM 1.2 >>Begin
        IF "QC Status" <> "QC Status"::" " THEN
            ERROR(Text004);
        //DM 1.2 <<End
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FileManagmentCu: Codeunit "File Management";
        Text000: Label 'You cannot delete the items, which are under inspection.';
        ItemUOM: Record 5404;
        LastInspectionDate: Date;
        DateFilter1: Text[30];
        Text001: Label 'You can''t choose ILE which is under inspection.';
        CodeQCWorkSheet: Record 50023;
        ILE: Record 32;
        ValueEntry: Record "Value Entry";
        Text003: Label 'You can''t change the Item No. When it is in Under Inspection.';
        Text005: Label 'Sampling Quantity must not be greaterthan Quantity.';
        Text004: Label 'You cannot modify the Items that are in Under Inspection.';
        Text006: Label 'Do you want to delete the existing records ?';
        "----Locations-------": Integer;
        LocationType: Option "Inventory Location","Production Location","Sample Location","Rejected Location";
        Text007: Label 'From Item No. cannot be blank';
        Text008: Label 'Item Ledger Entry already exists in Worksheet No %1';
        Text009: Label 'Do you want to convert Item %1,%3 to Item %2,%4?';
        Text010: Label 'To Item must not be blank for code to code transfer.';
        Text011: Label 'Code to Code transfer posted successfully';
        InventorySetUp: Record "Inventory Setup";

    procedure SuggestRetestItems("ItemNo.": Code[20]);
    var
        Item: Record 27;
        ItemLedgEntry: Record 32;
        QCWorkSheet: Record 50023;
        DocumentNo: Code[20];
        CheckDate: Date;
        Text000: Label 'Item  #1###########################\';
        Window: Dialog;
        Text001: Label 'Sample Qty / Sample UOM for retest is not defined for the Item %1.';
        QCWorksheetRec: Record 50023;
        ItemLedgerEntryPage: Page "Item Ledger Entries";
    begin
        //DM 1.4 >>Begin

        InventorySetUp.GET;
        Window.OPEN(Text000);

        ItemLedgEntry.RESET;
        ItemLedgEntry.SETRANGE("Item No.", "ItemNo.");
        ItemLedgEntry.SETRANGE(Open, TRUE);
        ItemLedgEntry.SetRange("Location Code", 'DOMSTORES');
        ItemLedgerEntryPage.SetTableView(ItemLedgEntry);
        ItemLedgerEntryPage.LookupMode(true);
        if ItemLedgerEntryPage.RunModal() = Action::LookupOK then begin
            ItemLedgerEntryPage.SetSelectionFilter(ItemLedgEntry);
            IF ItemLedgEntry.FIND('-') THEN           //UD 1.0
                REPEAT
                    Window.UPDATE(1, Item."No.");
                    QCWorkSheet.INIT;
                    QCWorkSheet."QC Type" := QCWorkSheet."QC Type"::Retest;
                    QCWorkSheet."Worksheet Doc No." := NoSeriesMgt.GetNextNo(InventorySetUp."Code WorkSheet No.", WORKDATE, TRUE);
                    QCWorkSheet."Posting Date" := WORKDATE;
                    QCWorkSheet."From Item No." := ItemLedgEntry."Item No.";
                    QCWorkSheet."From Item Description" := Item.Description;
                    QCWorkSheet.Quantity := ItemLedgEntry."Remaining Quantity";
                    QCWorkSheet.UOM := ItemLedgEntry."Unit of Measure Code";
                    QCWorkSheet."ItemLedgEntry No." := ItemLedgEntry."Entry No.";
                    QCWorkSheet.Location := ItemLedgEntry."Location Code";
                    QCWorkSheet."New Location Code" := 'EOUSTORES';
                    QCWorkSheet."Lot No." := ItemLedgEntry."Lot No.";
                    QCWorkSheet."Expiry Date" := ItemLedgEntry."Expiration Date";
                    QCWorkSheet."Serial No." := ItemLedgEntry."Serial No.";
                    QCWorkSheet."Shortcut Dimension 1 Code" := ItemLedgEntry."Global Dimension 1 Code";
                    QCWorkSheet."Shortcut Dimension 2 Code" := ItemLedgEntry."Global Dimension 2 Code";
                    ValueEntry.Reset();
                    ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                    ValueEntry.SetRange("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
                    if ValueEntry.FindFirst() then
                        QCWorkSheet."Unit Cost" := ValueEntry."Cost per Unit";
                    QCWorkSheet.INSERT;
                UNTIL ItemLedgEntry.NEXT = 0;//UD 1.0
        end;
        Window.CLOSE;
    end;

    procedure SetUpNewLine(LastQCWorkSheet: Record 50023);
    var
        QCWorkSheet: Record 50023;
    begin
        InventorySetUp.GET;
        IF QCWorkSheet.FIND('-') THEN BEGIN
            "Posting Date" := LastQCWorkSheet."Posting Date";
            "Worksheet Doc No." := LastQCWorkSheet."Worksheet Doc No.";
        END ELSE BEGIN
            "Posting Date" := WORKDATE;
            IF InventorySetUp."Code WorkSheet No." <> '' THEN BEGIN
                CLEAR(NoSeriesMgt);
                "Worksheet Doc No." := NoSeriesMgt.TryGetNextNo(InventorySetUp."Code WorkSheet No.", "Posting Date");
            END;
        END;
    end;

    procedure CreateInspectionDataSheets(CodeQCWorksheet: Record 50023);
    begin

        // CodeQCWorksheet.TESTFIELD("Sample Qty");
        // CodeQCWorksheet.TESTFIELD("Sample UOM");
        // CodeQCWorksheet.TESTFIELD("Specification ID");
        // ItemUOM.GET("From Item No.","Sample UOM");
        // IF (CodeQCWorksheet."Sample Qty"* ItemUOM."Qty. per Unit of Measure") > CodeQCWorksheet.Quantity THEN
        //  ERROR(Text005);
        // InspectDataSheet.CreateCodetoCodeInspectDataSheet(CodeQCWorksheet);
        // CodeQCWorksheet."QC Status" := CodeQCWorksheet."QC Status" :: IDS;
        // CodeQCWorksheet.MODIFY;
    end;

    procedure PostCodeToCodeTransfer(ToItemNoP: Code[20]);
    var
        ItemJrnlLine: Record 83;
        Item: Record 27;
        Item2: Record 27;
        ItemLedgEntry: Record 32;
        ItemJnlPostLine: Codeunit 22;
        LineNo: Integer;
        LocationLRec: Record 14;
    begin
        IF ToItemNoP = '' THEN
            ERROR(Text010);

        Item.GET("From Item No.");
        IF Item."Item Tracking Code" <> '' THEN BEGIN
            Item2.GET(ToItemNoP);
            Item2.TESTFIELD("Item Tracking Code");
        END;

        // validation to get status from QLE
        // end

        IF NOT CONFIRM(Text009, FALSE, "From Item No.", ToItemNoP, "From Item Description", "To Item Description") THEN
            EXIT;

        // post negative entry for From Item
        ItemJrnlLine.RESET;
        ItemJrnlLine.SETRANGE("Journal Template Name", 'ITEM');
        ItemJrnlLine.SETRANGE("Journal Batch Name", 'DEFAULT');
        IF ItemJrnlLine.FINDLAST THEN
            LineNo := ItemJrnlLine."Line No.";
        CLEAR(ItemJrnlLine);
        ItemLedgEntry.GET("ItemLedgEntry No.");
        ItemJrnlLine.INIT;
        ItemJrnlLine."Journal Template Name" := 'ITEM';
        ItemJrnlLine."Journal Batch Name" := 'DEFAULT';
        ItemJrnlLine."Line No." := LineNo + 10000;
        ItemJrnlLine."Entry Type" := ItemJrnlLine."Entry Type"::"Negative Adjmt.";
        ItemJrnlLine.VALIDATE("Document No.", "Worksheet Doc No.");
        ItemJrnlLine.VALIDATE("Item No.", "From Item No.");
        ItemJrnlLine.VALIDATE("Posting Date", Rec."Posting Date");
        ItemJrnlLine.VALIDATE("Location Code", Location);
        ItemJrnlLine.VALIDATE("Unit of Measure Code", UOM);
        ItemJrnlLine.VALIDATE(Quantity, Quantity);
        ItemJrnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
        ItemJrnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
        //ItemJrnlLine.Validate("Order No.");
        LocationLRec.GET(Location);
        IF "Lot No." = '' THEN
            ItemJrnlLine."Applies-to Entry" := "ItemLedgEntry No.";
        ItemJrnlLine.INSERT;
        IF "Lot No." <> '' THEN
            UpdateNegAdjResEntry(ItemJrnlLine);
        ItemJnlPostLine.RUN(ItemJrnlLine);
        ItemJrnlLine.Delete();
        // post positive entry for To Item
        ItemJrnlLine.RESET;
        ItemJrnlLine.SETRANGE("Journal Template Name", 'ITEM');
        ItemJrnlLine.SETRANGE("Journal Batch Name", 'DEFAULT');
        IF ItemJrnlLine.FINDLAST THEN
            LineNo := ItemJrnlLine."Line No.";
        CLEAR(ItemJrnlLine);
        ItemLedgEntry.GET("ItemLedgEntry No.");
        ItemJrnlLine.INIT;
        ItemJrnlLine."Journal Template Name" := 'ITEM';
        ItemJrnlLine."Journal Batch Name" := 'DEFAULT';
        ItemJrnlLine."Line No." := LineNo + 10000;
        ItemJrnlLine."Entry Type" := ItemJrnlLine."Entry Type"::"Positive Adjmt.";
        ItemJrnlLine.VALIDATE("Document No.", "Worksheet Doc No.");
        ItemJrnlLine.VALIDATE("Item No.", ToItemNoP);
        ItemJrnlLine.VALIDATE("Posting Date", Rec."Posting Date");
        if "New Location Code" <> '' then
            ItemJrnlLine.VALIDATE("Location Code", "New Location Code")
        else
            ItemJrnlLine.VALIDATE("Location Code", Location);
        ItemJrnlLine.VALIDATE("Unit of Measure Code", UOM);
        ItemJrnlLine.VALIDATE(Quantity, Quantity);
        if "New Shortcut Dimension 1 Code" <> '' then
            ItemJrnlLine.VALIDATE("Shortcut Dimension 1 Code", "New Shortcut Dimension 1 Code")
        else
            ItemJrnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
        if "New Shortcut Dimension 2 Code" <> '' then
            ItemJrnlLine.VALIDATE("Shortcut Dimension 2 Code", "New Shortcut Dimension 2 Code")
        else
            ItemJrnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
        ItemJrnlLine."Unit Cost" := "Unit Cost";
        /*IF "Lot No." = '' THEN
            ItemJrnlLine."Applies-to Entry" := "ItemLedgEntry No.";*/
        ItemJrnlLine.INSERT;
        //Message('%1', Rec."Lot No.");
        IF "Lot No." <> '' THEN
            UpdatePosAdjResEntry(ItemJrnlLine);
        ItemJnlPostLine.RUN(ItemJrnlLine);
        ItemJrnlLine.Delete();
        // post Transfer entry for To Item
        /* ItemJrnlLine.RESET;
         ItemJrnlLine.SETRANGE("Journal Template Name", 'ITEM');
         ItemJrnlLine.SETRANGE("Journal Batch Name", 'DEFAULT');
         IF ItemJrnlLine.FINDLAST THEN
             LineNo := ItemJrnlLine."Line No.";
         CLEAR(ItemJrnlLine);
         ItemLedgEntry.GET("ItemLedgEntry No.");
         ItemJrnlLine.INIT;
         ItemJrnlLine."Journal Template Name" := 'ITEM';
         ItemJrnlLine."Journal Batch Name" := 'DEFAULT';
         ItemJrnlLine."Line No." := LineNo + 10000;
         ItemJrnlLine."Entry Type" := ItemJrnlLine."Entry Type"::Transfer;
         ItemJrnlLine.VALIDATE("Document No.", "Worksheet Doc No.");
         ItemJrnlLine.VALIDATE("Item No.", ToItemNoP);
         ItemJrnlLine.VALIDATE("Posting Date", WORKDATE);
         ItemJrnlLine.VALIDATE("Location Code", Location);
         ItemJrnlLine.Validate("New Location Code", "New Location Code");
         ItemJrnlLine.VALIDATE("Unit of Measure Code", UOM);
         //ItemJrnlLine.Validate(NE);
         ItemJrnlLine.VALIDATE(Quantity, Quantity);
         ItemJrnlLine.VALIDATE("Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
         ItemJrnlLine.VALIDATE("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code");
         ItemJrnlLine.Validate("New Shortcut Dimension 1 Code", "New Shortcut Dimension 1 Code");
         ItemJrnlLine.Validate("New Shortcut Dimension 2 Code", "New Shortcut Dimension 2 Code");
         ItemJrnlLine."Unit Cost" := "Unit Cost";
         //IF "Lot No." = '' THEN
         //    ItemJrnlLine."Applies-to Entry" := "ItemLedgEntry No.";
         ItemJrnlLine.INSERT;
         IF "Lot No." <> '' THEN
             UpdateTransferAdjResEntry(ItemJrnlLine);
         ItemJnlPostLine.RUN(ItemJrnlLine);
         ItemJrnlLine.Delete();*/
    end;

    procedure UpdateNegAdjResEntry(ItemJrnlLineP: Record 83);
    var
        TempReservationEntry: Record 337;
        ReserveEntry: Record 337;
        EntryNo: Integer;
    begin
        CLEAR(ReserveEntry);
        IF TempReservationEntry.FIND('+') THEN
            EntryNo := TempReservationEntry."Entry No."
        ELSE
            EntryNo := 0;

        ReserveEntry."Entry No." := EntryNo + 1;
        ReserveEntry.VALIDATE(Positive, FALSE);
        ReserveEntry.VALIDATE("Item No.", ItemJrnlLineP."Item No.");
        ReserveEntry.VALIDATE("Location Code", ItemJrnlLineP."Location Code");
        ReserveEntry.VALIDATE("Reservation Status", ReserveEntry."Reservation Status"::Prospect);
        ReserveEntry.VALIDATE("Source Type", DATABASE::"Item Journal Line");
        ReserveEntry.VALIDATE("Source Subtype", 3);
        ReserveEntry.VALIDATE("Source ID", ItemJrnlLineP."Journal Template Name");
        ReserveEntry.VALIDATE("Source Batch Name", ItemJrnlLineP."Journal Batch Name");
        ReserveEntry.VALIDATE("Source Ref. No.", ItemJrnlLineP."Line No.");
        ReserveEntry.VALIDATE("Suppressed Action Msg.", FALSE);
        ReserveEntry.VALIDATE("Qty. per Unit of Measure", ItemJrnlLineP."Qty. per Unit of Measure");
        ReserveEntry.VALIDATE("Planning Flexibility", ReserveEntry."Planning Flexibility"::Unlimited);
        ReserveEntry.VALIDATE("Expiration Date", "Expiry Date");
        ReserveEntry.VALIDATE("Lot No.", "Lot No.");
        if "Serial No." <> '' then
            ReserveEntry.Validate("Serial No.", "Serial No.");
        ReserveEntry.VALIDATE("Quantity (Base)", -(ItemJrnlLineP.Quantity * ItemJrnlLineP."Qty. per Unit of Measure"));
        ReserveEntry.VALIDATE(Quantity, -(ItemJrnlLineP.Quantity * ItemJrnlLineP."Qty. per Unit of Measure"));
        ReserveEntry.VALIDATE("Appl.-to Item Entry", "ItemLedgEntry No.");
        ReserveEntry.VALIDATE(Correction, FALSE);
        ReserveEntry.INSERT;
    end;

    procedure UpdatePosAdjResEntry(ItemJrnlLineP: Record 83);
    var
        TempReservationEntry: Record 337;
        ReserveEntry: Record 337;
        EntryNo: Integer;
    begin
        CLEAR(ReserveEntry);
        IF TempReservationEntry.FIND('+') THEN
            EntryNo := TempReservationEntry."Entry No."
        ELSE
            EntryNo := 0;

        ReserveEntry."Entry No." := EntryNo + 1;
        ReserveEntry.VALIDATE(Positive, TRUE);
        ReserveEntry.VALIDATE("Item No.", ItemJrnlLineP."Item No.");
        ReserveEntry.VALIDATE("Location Code", ItemJrnlLineP."Location Code");
        ReserveEntry.VALIDATE("Reservation Status", ReserveEntry."Reservation Status"::Prospect);
        ReserveEntry.VALIDATE("Source Type", DATABASE::"Item Journal Line");
        ReserveEntry.VALIDATE("Source Subtype", 2);
        ReserveEntry.VALIDATE("Source ID", ItemJrnlLineP."Journal Template Name");
        ReserveEntry.VALIDATE("Source Batch Name", ItemJrnlLineP."Journal Batch Name");
        ReserveEntry.VALIDATE("Source Ref. No.", ItemJrnlLineP."Line No.");
        ReserveEntry.VALIDATE("Suppressed Action Msg.", FALSE);
        ReserveEntry.VALIDATE("Qty. per Unit of Measure", ItemJrnlLineP."Qty. per Unit of Measure");
        ReserveEntry.VALIDATE("Planning Flexibility", ReserveEntry."Planning Flexibility"::Unlimited);
        ReserveEntry.VALIDATE("Expiration Date", "Expiry Date");
        if "New Lot No." = '' then
            ReserveEntry.VALIDATE("Lot No.", "Lot No.")
        else
            ReserveEntry.Validate("Lot No.", "New Lot No.");
        if "New Serial No." <> '' then
            ReserveEntry.VALIDATE("Serial No.", "New Serial No.")
        else
            if "Serial No." <> '' then
                ReserveEntry.Validate("Serial No.", "Serial No.");
        ReserveEntry.VALIDATE("Quantity (Base)", (ItemJrnlLineP.Quantity * ItemJrnlLineP."Qty. per Unit of Measure"));
        ReserveEntry.VALIDATE(Quantity, (ItemJrnlLineP.Quantity * ItemJrnlLineP."Qty. per Unit of Measure"));
        ReserveEntry.VALIDATE(Correction, FALSE);
        ReserveEntry.INSERT;

        MESSAGE(Text011);

        Posted := TRUE;
        MODIFY;
    end;

    procedure UpdateTransferAdjResEntry(ItemJrnlLineP: Record 83);
    var
        TempReservationEntry: Record 337;
        ReserveEntry: Record 337;
        EntryNo: Integer;
    begin
        CLEAR(ReserveEntry);
        IF TempReservationEntry.FIND('+') THEN
            EntryNo := TempReservationEntry."Entry No."
        ELSE
            EntryNo := 0;

        ReserveEntry."Entry No." := EntryNo + 1;
        ReserveEntry.VALIDATE(Positive, TRUE);
        ReserveEntry.VALIDATE("Item No.", ItemJrnlLineP."Item No.");
        ReserveEntry.VALIDATE("Location Code", ItemJrnlLineP."Location Code");
        ReserveEntry.VALIDATE("Reservation Status", ReserveEntry."Reservation Status"::Prospect);
        ReserveEntry.VALIDATE("Source Type", DATABASE::"Item Journal Line");
        ReserveEntry.VALIDATE("Source Subtype", 4);
        ReserveEntry.VALIDATE("Source ID", ItemJrnlLineP."Journal Template Name");
        ReserveEntry.VALIDATE("Source Batch Name", ItemJrnlLineP."Journal Batch Name");
        ReserveEntry.VALIDATE("Source Ref. No.", ItemJrnlLineP."Line No.");
        ReserveEntry.VALIDATE("Suppressed Action Msg.", FALSE);
        ReserveEntry.VALIDATE("Qty. per Unit of Measure", ItemJrnlLineP."Qty. per Unit of Measure");
        ReserveEntry.VALIDATE("Planning Flexibility", ReserveEntry."Planning Flexibility"::Unlimited);
        ReserveEntry.VALIDATE("Expiration Date", "Expiry Date");
        ReserveEntry.Validate("New Expiration Date", "Expiry Date");
        ReserveEntry.VALIDATE("Lot No.", "Lot No.");
        ReserveEntry.Validate("New Lot No.", "Lot No.");
        ReserveEntry.VALIDATE("Quantity (Base)", -(ItemJrnlLineP.Quantity * ItemJrnlLineP."Qty. per Unit of Measure"));
        ReserveEntry.VALIDATE(Quantity, -(ItemJrnlLineP.Quantity * ItemJrnlLineP."Qty. per Unit of Measure"));
        ReserveEntry.VALIDATE(Correction, FALSE);
        ReserveEntry.INSERT;

        MESSAGE(Text011);

        Posted := TRUE;
        MODIFY;
    end;

    procedure UpdateILEItem();

    begin

        IF ILE.GET("ItemLedgEntry No.") THEN BEGIN
            //"QC Type" :=  QCWorkSheet."QC Type" :: Retest;
            //"Worksheet Doc No." := NoSeriesMgt.GetNextNo(InventorySetUp."WorkSheet No.",WORKDATE,TRUE);
            "From Item No." := ILE."Item No.";
            "Posting Date" := WORKDATE;
            Quantity := ILE."Remaining Quantity";
            UOM := ILE."Unit of Measure Code";
            "Lot No." := ILE."Lot No.";
            "Serial No." := ILE."Serial No.";
            "Expiry Date" := ILE."Expiration Date";
            Location := ILE."Location Code";
            "Shortcut Dimension 1 Code" := ILE."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := ILE."Global Dimension 2 Code";
            ValueEntry.Reset();
            ValueEntry.SetRange("Item Ledger Entry No.", ILE."Entry No.");
            ValueEntry.SetRange("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
            if ValueEntry.FindFirst() then
                "Unit Cost" := ValueEntry."Cost per Unit";
        END else begin
            Quantity := 0;
            "Lot No." := '';
            "Serial No." := '';
            "Expiry Date" := 0D;
            "Unit Cost" := 0;
            "Shortcut Dimension 1 Code" := '';
            "Shortcut Dimension 2 Code" := '';
        end;

    end;

    procedure SuggestRetestItemsEOUtoDOM("ItemNo.": Code[20]);
    var
        Item: Record 27;
        ItemLedgEntry: Record 32;
        QCWorkSheet: Record 50023;
        DocumentNo: Code[20];
        CheckDate: Date;
        Text000: Label 'Item  #1###########################\';
        Window: Dialog;
        Text001: Label 'Sample Qty / Sample UOM for retest is not defined for the Item %1.';
        QCWorksheetRec: Record 50023;
        ItemLedgerEntryPage: Page "Item Ledger Entries";
    begin
        //DM 1.4 >>Begin

        InventorySetUp.GET;
        Window.OPEN(Text000);

        ItemLedgEntry.RESET;
        ItemLedgEntry.SETRANGE("Item No.", "ItemNo.");
        ItemLedgEntry.SETRANGE(Open, TRUE);
        ItemLedgEntry.SetRange("Location Code", 'EOUSTORES');
        ItemLedgerEntryPage.SetTableView(ItemLedgEntry);
        ItemLedgerEntryPage.LookupMode(true);
        if ItemLedgerEntryPage.RunModal() = Action::LookupOK then begin
            ItemLedgerEntryPage.SetSelectionFilter(ItemLedgEntry);
            IF ItemLedgEntry.FIND('-') THEN           //UD 1.0
                REPEAT
                    Window.UPDATE(1, Item."No.");
                    QCWorkSheet.INIT;
                    QCWorkSheet."QC Type" := QCWorkSheet."QC Type"::Retest;
                    QCWorkSheet."Worksheet Doc No." := NoSeriesMgt.GetNextNo(InventorySetUp."Code Worksheet No.(EOU)", WORKDATE, TRUE);
                    QCWorkSheet."Posting Date" := WORKDATE;
                    QCWorkSheet."From Item No." := ItemLedgEntry."Item No.";
                    QCWorkSheet."From Item Description" := Item.Description;
                    QCWorkSheet.Quantity := ItemLedgEntry."Remaining Quantity";
                    QCWorkSheet.UOM := ItemLedgEntry."Unit of Measure Code";
                    QCWorkSheet."ItemLedgEntry No." := ItemLedgEntry."Entry No.";
                    QCWorkSheet.Location := ItemLedgEntry."Location Code";
                    QCWorkSheet."New Location Code" := 'DOMSTORES';
                    QCWorkSheet."Lot No." := ItemLedgEntry."Lot No.";
                    QCWorkSheet."Expiry Date" := ItemLedgEntry."Expiration Date";
                    QCWorkSheet."Serial No." := ItemLedgEntry."Serial No.";
                    QCWorkSheet."Shortcut Dimension 1 Code" := ItemLedgEntry."Global Dimension 1 Code";
                    QCWorkSheet."Shortcut Dimension 2 Code" := ItemLedgEntry."Global Dimension 2 Code";
                    ValueEntry.Reset();
                    ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry."Entry No.");
                    ValueEntry.SetRange("Entry Type", ValueEntry."Entry Type"::"Direct Cost");
                    if ValueEntry.FindFirst() then
                        QCWorkSheet."Unit Cost" := ValueEntry."Cost per Unit";
                    QCWorkSheet.INSERT;
                UNTIL ItemLedgEntry.NEXT = 0;//UD 1.0
        end;
        Window.CLOSE;
    end;

}


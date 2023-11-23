tableextension 50030 ItemJournalExt extends "Item Journal Line"
{
    fields
    {
        
        field(50001; "Pc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pc No.';
        }
        field(50002; "Pc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Pc Date';
        }
        field(50003; "Dc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dc No.';
        }
        field(50004; "Dc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Dc Date';
        }
        field(50005; "Duty Involved_B2B"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Duty Involved For Cleared';
        }
        field(50006; "Bill of Entry No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Bill of Entry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        modify("Output Quantity")
        {
            trigger OnAfterValidate()
            var

            begin
                if CurrFieldNo = FieldNo("Output Quantity") then
                    UpdateTimes();

            end;
        }


        field(50011; "Applies-to Entry2"; Integer)
        {
            Caption = 'Applies-to Entry';

            trigger OnLookup()
            begin
                SelectItemEntry2(FieldNo("Applies-to Entry"));
            end;

            trigger OnValidate()
            var
                ItemLedgEntry: Record "Item Ledger Entry";
                ItemTrackingLines: Page "Item Tracking Lines";
                ShowTrackingExistsError: Boolean;
                IsHandled: Boolean;
            begin
                //IsHandled := false;
                //OnBeforeValidateAppliesToEntry(Rec, CurrFieldNo, IsHandled);
                // if IsHandled then
                //    exit;

                if "Applies-to Entry" <> 0 then begin
                    ItemLedgEntry.Get("Applies-to Entry");

                    if "Value Entry Type" = "Value Entry Type"::Revaluation then begin
                        if "Inventory Value Per" <> "Inventory Value Per"::" " then
                            Error(Text00006, FieldCaption("Applies-to Entry"));

                        if "Inventory Value Per" = "Inventory Value Per"::" " then
                            if not RevaluationPerEntryAllowed1("Item No.") then
                                Error(RevaluationPerEntryNotAllowedErr1);

                        InitRevalJnlLine1(ItemLedgEntry);
                        ItemLedgEntry.TestField(Positive, true);
                    end else begin
                        TestField(Quantity);
                        if Signed(Quantity) * ItemLedgEntry.Quantity > 0 then begin
                            if Quantity > 0 then
                                FieldError(Quantity, Text0030);
                            if Quantity < 0 then
                                FieldError(Quantity, Text0029);
                        end;
                        ShowTrackingExistsError := ItemLedgEntry.TrackingExists();
                        //OnValidateAppliesToEntryOnAferCalcShowTrackingExistsError(Rec, xRec, ShowTrackingExistsError);
                        if ShowTrackingExistsError then
                            Error(Text0033, FieldCaption("Applies-to Entry"), ItemTrackingLines.Caption);

                        if not ItemLedgEntry.Open then
                            Message(Text0032, "Applies-to Entry");

                        if "Entry Type" = "Entry Type"::Output then begin
                            ItemLedgEntry.TestField("Order Type", "Order Type"::Production);
                            ItemLedgEntry.TestField("Order No.", "Order No.");
                            ItemLedgEntry.TestField("Order Line No.", "Order Line No.");
                            ItemLedgEntry.TestField("Entry Type", "Entry Type");
                        end;
                    end;

                    "Location Code" := ItemLedgEntry."Location Code";
                    "Variant Code" := ItemLedgEntry."Variant Code";
                end else
                    if "Value Entry Type" = "Value Entry Type"::Revaluation then begin
                        Validate("Unit Amount", 0);
                        Validate(Quantity, 0);
                        "Inventory Value (Calculated)" := 0;
                        "Inventory Value (Revalued)" := 0;
                        "Location Code" := '';
                        "Variant Code" := '';
                        "Bin Code" := '';
                    end;
            end;
        }
        field(50012; "Production Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        ManufacturingSetup: Record "Manufacturing Setup";
        Item: Record Item;
        ProdOrderRoutingline: Record "Prod. Order Routing Line";
        CapacityLedgerEntry: Record "Capacity Ledger Entry";
        Text0029: Label 'must be positive';
        Text0030: Label 'must be negative';
        Text0031: Label 'You can not insert item number %1 because it is not produced on released production order %2.';
        Text0032: Label 'When posting, the entry %1 will be opened first.';
        Text0033: Label 'If the item carries serial or lot numbers, then you must use the %1 field in the %2 window.';
        Text00006: Label 'You must not enter %1 in a revaluation sum line.';
        RevaluationPerEntryNotAllowedErr1: Label 'This item has already been revalued with the Calculate Inventory Value function, so you cannot use the Applies-to Entry field as that may change the valuation.';



    procedure UpdateTimes()
    begin

        IF NOT ManufacturingSetup."Time Based On Output Qty" THEN
            EXIT;

        ManufacturingSetup.GET;

        IF ProdOrderRoutingline.GET(ProdOrderRoutingLine.Status::Released, "Order No.", "Routing Reference No.", "Routing No.", "Operation No.") THEN BEGIN
            // Run Tine
            VALIDATE("Run Time", ("Output Quantity" + "Scrap Quantity") * ProdOrderRoutingLine."Run Time");
            // Setup Time
            CapacityLedgerEntry.SETRANGE("Order No.", "Order No.");
            CapacityLedgerEntry.SETRANGE("Routing No.", "Routing No.");
            CapacityLedgerEntry.SETRANGE("Routing Reference No.", "Routing Reference No.");
            CapacityLedgerEntry.SETRANGE("Order Line No.", "Order Line No.");
            CapacityLedgerEntry.SETRANGE("Operation No.", "Operation No.");
            IF CapacityLedgerEntry.FINDFIRST THEN
                VALIDATE("Setup Time", 0)
            else
                VALIDATE("Setup Time", ProdOrderRoutingLine."Setup Time");
        END;
    end;


    local procedure SelectItemEntry2(CurrentFieldNo: Integer)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ItemJnlLine2: Record "Item Journal Line";
        PositiveFilterValue: Boolean;
    begin
        //OnBeforeSelectItemEntry(Rec, xRec, CurrentFieldNo);

        if ("Entry Type" = "Entry Type"::Output) and
           ("Value Entry Type" <> "Value Entry Type"::Revaluation) and
           (CurrentFieldNo = FieldNo("Applies-to Entry"))
        then begin
            ItemLedgEntry.SetCurrentKey(
              "Order Type", "Order No.", "Order Line No.", "Entry Type", "Prod. Order Comp. Line No.");
            ItemLedgEntry.SetRange("Order Type", "Order Type"::Production);
            ItemLedgEntry.SetRange("Order No.", "Order No.");
            ItemLedgEntry.SetRange("Order Line No.", "Order Line No.");
            ItemLedgEntry.SetRange("Entry Type", "Entry Type");
            ItemLedgEntry.SetRange("Prod. Order Comp. Line No.", 0);
        end else begin
            ItemLedgEntry.SetCurrentKey("Item No.", Positive);
            ItemLedgEntry.SetRange("Item No.", "Item No.");
        end;

        if "Location Code" <> '' then
            ItemLedgEntry.SetRange("Location Code", "Location Code");

        if CurrentFieldNo = FieldNo("Applies-to Entry") then begin
            if Quantity <> 0 then begin
                PositiveFilterValue := (Signed(Quantity) < 0) or ("Value Entry Type" = "Value Entry Type"::Revaluation);
                ItemLedgEntry.SetRange(Positive, PositiveFilterValue);
            end;

            if "Value Entry Type" <> "Value Entry Type"::Revaluation then begin
                ItemLedgEntry.SetCurrentKey("Item No.", Open);
                ItemLedgEntry.SetRange(Open, true);
            end;
        end else
            ItemLedgEntry.SetRange(Positive, false);

        //OnSelectItemEntryOnBeforeOpenPage(ItemLedgEntry, Rec, CurrentFieldNo);

        if PAGE.RunModal(PAGE::"Item Ledger Entries", ItemLedgEntry) = ACTION::LookupOK then begin
            ItemJnlLine2 := Rec;
            if CurrentFieldNo = FieldNo("Applies-to Entry") then
                ItemJnlLine2.Validate("Applies-to Entry", ItemLedgEntry."Entry No.")
            else
                ItemJnlLine2.Validate("Applies-from Entry", ItemLedgEntry."Entry No.");
            CheckItemAvailable(CurrentFieldNo);
            Rec := ItemJnlLine2;
        end;
    end;

    local procedure RevaluationPerEntryAllowed1(ItemNo: Code[20]): Boolean
    var
        ValueEntry: Record "Value Entry";
    begin
        GetItem1();
        if Item."Costing Method" <> Item."Costing Method"::Average then
            exit(true);

        ValueEntry.SetRange("Item No.", ItemNo);
        ValueEntry.SetRange("Entry Type", ValueEntry."Entry Type"::Revaluation);
        ValueEntry.SetRange("Partial Revaluation", true);
        exit(ValueEntry.IsEmpty);
    end;

    local procedure GetItem1()
    begin
        if Item."No." <> "Item No." then
            Item.Get("Item No.");
        // OnAfterGetItemChange(Item, Rec);
    end;

    local procedure InitRevalJnlLine1(ItemLedgEntry2: Record "Item Ledger Entry")
    var
        ItemApplnEntry: Record "Item Application Entry";
        ValueEntry: Record "Value Entry";
        CostAmtActual: Decimal;
    begin
        if "Value Entry Type" <> "Value Entry Type"::Revaluation then
            exit;

        ItemLedgEntry2.TestField("Item No.", "Item No.");
        ItemLedgEntry2.TestField("Completely Invoiced", true);
        ItemLedgEntry2.TestField(Positive, true);
        ItemApplnEntry.CheckAppliedFromEntryToAdjust(ItemLedgEntry2."Entry No.");

        Validate("Entry Type", ItemLedgEntry2."Entry Type");
        "Posting Date" := ItemLedgEntry2."Posting Date";
        Validate("Unit Amount", 0);
        Validate(Quantity, ItemLedgEntry2."Invoiced Quantity");

        ValueEntry.Reset();
        ValueEntry.SetCurrentKey("Item Ledger Entry No.", "Entry Type");
        ValueEntry.SetRange("Item Ledger Entry No.", ItemLedgEntry2."Entry No.");
        ValueEntry.SetFilter("Entry Type", '<>%1', ValueEntry."Entry Type"::Rounding);
        ValueEntry.Find('-');
        repeat
            if not (ValueEntry."Expected Cost" or ValueEntry."Partial Revaluation") then
                CostAmtActual := CostAmtActual + ValueEntry."Cost Amount (Actual)";
        until ValueEntry.Next() = 0;

        Validate("Inventory Value (Calculated)", CostAmtActual);
        Validate("Inventory Value (Revalued)", CostAmtActual);

        "Location Code" := ItemLedgEntry2."Location Code";
        "Variant Code" := ItemLedgEntry2."Variant Code";
        "Applies-to Entry" := ItemLedgEntry2."Entry No.";
        CopyDim(ItemLedgEntry2."Dimension Set ID");

        //OnAfterInitRevalJnlLine(Rec, ItemLedgEntry2);
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
        //ReserveEntry.VALIDATE("Expiration Date", "Expiry Date");
        //ReserveEntry.Validate("New Expiration Date", "Expiry Date");
        ReserveEntry.VALIDATE("Lot No.", "Lot No.");
        ReserveEntry.Validate("New Lot No.", "Lot No.");
        ReserveEntry.VALIDATE("Quantity (Base)", -(ItemJrnlLineP.Quantity * ItemJrnlLineP."Qty. per Unit of Measure"));
        ReserveEntry.VALIDATE(Quantity, -(ItemJrnlLineP.Quantity * ItemJrnlLineP."Qty. per Unit of Measure"));
        ReserveEntry.VALIDATE(Correction, FALSE);
        ReserveEntry.INSERT;
        // MESSAGE('Reservation E');
        //Posted := TRUE;
        MODIFY;
    end;


}
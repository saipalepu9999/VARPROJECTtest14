codeunit 50007 "EventsSubscribers"
{
    Permissions = tabledata "Purch. Rcpt. Header" = rm;
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    [EventSubscriber(ObjectType::Codeunit, codeunit::NoSeriesManagement, 'OnBeforeFilterSeries', '', true, true)]
    local procedure OnBeforeFilterSeries(var NoSeries: Record "No. Series"; NoSeriesCode: Code[20]; var IsHandled: Boolean)
    var
        NoSeriesRelationship: Record "No. Series Relationship";
        UserSetupGrec: Record "User Setup";
        FacilityCode: Text;
        Selection: Integer;
    begin
        //Clear(UserSetupGrec);
        //if UserSetupGrec.get(UserId) then;

        //FacilityCode := 'DOMESTIC,EOU';
        //Selection := StrMenu(FacilityCode, 1, 'Select a dimension'); 
        NoSeries.Reset();
        NoSeriesRelationship.SetRange(Code, NoSeriesCode);
        /*if Selection = 1 then
            NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", 'DOMESTIC')
        else
            if Selection = 2 then
                NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", 'EOU');*/
        if NoSeriesRelationship.FindSet() then
            repeat
                NoSeries.Code := NoSeriesRelationship."Series Code";
                NoSeries.Mark := true;
            until NoSeriesRelationship.Next() = 0;
        if NoSeries.Get(NoSeriesCode) then
            NoSeries.Mark := true;
        NoSeries.MarkedOnly := true;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, 99000830, 'OnCreateReservEntryExtraFields', '', false, false)]
    local procedure UpdateNewFields(var InsertReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification"; NewTrackingSpecification: Record "Tracking Specification")
    var
        myInt: Codeunit 22;
    begin
        if InsertReservEntry."Vendor Lot No_B2B" = '' then
            InsertReservEntry."Vendor Lot No_B2B" := NewTrackingSpecification."Vendor Lot No_B2B"

    end;

    [EventSubscriber(ObjectType::Page, 6510, 'OnAfterMoveFields', '', false, false)]
    local procedure OnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    var
        myInt: Integer;
    begin
        if ReservEntry."Vendor Lot No_B2B" = '' then
            ReservEntry."Vendor Lot No_B2B" := TrkgSpec."Vendor Lot No_B2B";

    end;

    [EventSubscriber(ObjectType::table, 336, 'OnAfterCopyTrackingFromTrackingSpec', '', false, false)]
    local procedure OnAfterCopyTrackingFromTrackingSpec(var TrackingSpecification: Record "Tracking Specification"; FromTrackingSpecification: Record "Tracking Specification")
    begin
        if TrackingSpecification."Vendor Lot No_B2B" = '' then
            TrackingSpecification."Vendor Lot No_B2B" := FromTrackingSpecification."Vendor Lot No_B2B";

    end;


    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyNewTrackingFromNewSpec', '', false, false)]
    local procedure OnAfterCopyNewTrackingFromNewSpec(var ItemJournalLine: Record "Item Journal Line"; TrackingSpecification: Record "Tracking Specification")
    begin
        if ItemJournalLine."Vendor Lot No_B2B" = '' then
            ItemJournalLine."Vendor Lot No_B2B" := TrackingSpecification."Vendor Lot No_B2B";//b2bjkon31jan
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        if NewItemLedgEntry."Vendor Lot No_B2B" = '' then
            NewItemLedgEntry."Vendor Lot No_B2B" := ItemJournalLine."Vendor Lot No_B2B";//b2bjkon31jan
        NewItemLedgEntry."Pc No." := ItemJournalLine."Pc No.";
        NewItemLedgEntry."Pc Date" := ItemJournalLine."Pc Date";
        NewItemLedgEntry."Dc No." := ItemJournalLine."Dc No.";
        NewItemLedgEntry."Dc Date" := ItemJournalLine."Dc Date";
        NewItemLedgEntry."Duty Involved_B2B" := ItemJournalLine."Duty Involved_B2B";
        NewItemLedgEntry."Bill of Entry No." := ItemJournalLine."Bill of Entry No.";
        NewItemLedgEntry."Bill of Entry Date" := ItemJournalLine."Bill of Entry Date";
        NewItemLedgEntry."Production Order No." := ItemJournalLine."Production Order No.";
    end;
    //4.12 >>
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure CheckOrderShortClose(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
            PurchaseHeader.TestField("Short Close Status", PurchaseHeader."Short Close Status"::Open);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnModifyRecordEvent', '', false, false)]
    local procedure CheckHeadShortCloseBeforeModify(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header")
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            Rec.TestField("Short Close Status", Rec."Short Close Status"::Open);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnModifyRecordEvent', '', false, false)]
    local procedure CheckLineShortCloseBeforeModify(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            Rec.TestField(ShortClosed, false);
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnBeforeOnDelete', '', false, false)]
    local procedure CheckHeadShortCloseBeforeDelete(var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
            PurchaseHeader.TestField("Short Close Status", PurchaseHeader."Short Close Status"::Open);
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnBeforeDeleteEvent', '', false, false)]
    local procedure CheckLineShortCloseBeforeDelete(var Rec: Record "Purchase Line")
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then
            Rec.TestField(ShortClosed, false);
    end;
    //4.12 <<
    //4.07>>
    /*[EventSubscriber(ObjectType::Codeunit, codeunit::"Item Jnl.-Post Line", 'OnAfterInsertItemLedgEntry', '', false, false)]
    local procedure OnAfterInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer; var ValueEntryNo: Integer; var ItemApplnEntryNo: Integer; GlobalValueEntry: Record "Value Entry"; TransferItem: Boolean; var InventoryPostingToGL: Codeunit "Inventory Posting To G/L"; var OldItemLedgerEntry: Record "Item Ledger Entry")
    var
        ItemLedgerEntry2: Record "Item Ledger Entry";
        ProdOrderComponents: Record "Prod. Order Component";
        ItemLedgerEntry3: Record "Item Ledger Entry";
        ReqQunatity: Decimal;
        PrevItemNo: Code[20];
        ConsumEntryAgstOuput: Record "Consum Entry Against Output";
        ConsumEntryAgstOuput2: Record "Consum Entry Against Output";
        AvaliableQty: Decimal;
    begin
        if ItemLedgerEntry."Entry Type" = ItemLedgerEntry."Entry Type"::Output then begin
            ItemLedgerEntry2.Reset();
            ItemLedgerEntry2.SetRange("Entry Type", ItemLedgerEntry2."Entry Type"::Consumption);
            ItemLedgerEntry2.SetRange("Order No.", ItemLedgerEntry."Order No.");
            ItemLedgerEntry2.SetRange("Order Line No.", ItemLedgerEntry."Order Line No.");
            if ItemLedgerEntry2.FindSet() then
                repeat
                    Clear(ProdOrderComponents);
                    ProdOrderComponents.Reset();
                    ProdOrderComponents.SetRange("Prod. Order No.", ItemLedgerEntry2."Order No.");
                    ProdOrderComponents.SetRange("Prod. Order Line No.", ItemLedgerEntry2."Order Line No.");
                    ProdOrderComponents.SetRange("Line No.", ItemLedgerEntry2."Prod. Order Comp. Line No.");
                    if ProdOrderComponents.FindFirst() then;
                    if PrevItemNo <> ItemLedgerEntry2."Item No." then begin
                        PrevItemNo := ItemLedgerEntry2."Item No.";
                        ReqQunatity := ItemLedgerEntry.Quantity * ProdOrderComponents."Quantity per";
                        ItemLedgerEntry3.Reset();
                        ItemLedgerEntry3.SetRange("Entry Type", ItemLedgerEntry3."Entry Type"::Consumption);
                        ItemLedgerEntry3.SetRange("Order No.", ItemLedgerEntry2."Order No.");
                        ItemLedgerEntry3.SetRange("Order Line No.", ItemLedgerEntry2."Order Line No.");
                        ItemLedgerEntry3.SetRange("Item No.", ItemLedgerEntry2."Item No.");
                        ItemLedgerEntry3.SetRange("Prod. Order Comp. Line No.", ItemLedgerEntry2."Prod. Order Comp. Line No.");
                        if ItemLedgerEntry3.FindSet() then
                            repeat
                                ConsumEntryAgstOuput2.Reset();
                                ConsumEntryAgstOuput2.SetRange("Consumption Entry No.", ItemLedgerEntry3."Entry No.");
                                if ConsumEntryAgstOuput2.FindSet() then begin
                                    ConsumEntryAgstOuput2.CalcSums("Consumption Quantity");
                                    AvaliableQty := ItemLedgerEntry3.Quantity - ConsumEntryAgstOuput2."Consumption Quantity";
                                end else
                                    AvaliableQty := ItemLedgerEntry3.Quantity;

                                if (ReqQunatity > 0) and (AvaliableQty > 0) then begin
                                    ConsumEntryAgstOuput.Init();
                                    ConsumEntryAgstOuput."Output Entry No." := ItemLedgerEntry."Entry No.";
                                    ConsumEntryAgstOuput."Output Item No." := ItemLedgerEntry."Item No.";
                                    ConsumEntryAgstOuput."Output Quantity" := ItemLedgerEntry.Quantity;
                                    ConsumEntryAgstOuput."Output Lot No." := ItemLedgerEntry."Lot No.";
                                    ConsumEntryAgstOuput."Output Serial No." := ItemLedgerEntry."Serial No.";
                                    ConsumEntryAgstOuput."Output Posting Date" := ItemLedgerEntry."Posting Date";
                                    ConsumEntryAgstOuput."Consumption Entry No." := ItemLedgerEntry3."Entry No.";
                                    ConsumEntryAgstOuput."Consumption Item No." := ItemLedgerEntry3."Item No.";

                                    if ReqQunatity > AvaliableQty then
                                        ConsumEntryAgstOuput."Consumption Quantity" := AvaliableQty
                                    else
                                        ConsumEntryAgstOuput."Consumption Quantity" := ReqQunatity;
                                    ConsumEntryAgstOuput."Consumption Lot No." := ItemLedgerEntry3."Lot No.";
                                    ConsumEntryAgstOuput."Consumption Serial No." := ItemLedgerEntry3."Serial No.";
                                    ConsumEntryAgstOuput."Consumption Posting Date" := ItemLedgerEntry3."Posting Date";
                                    ConsumEntryAgstOuput.Insert();
                                    ReqQunatity -= AvaliableQty;
                                end;
                            until ItemLedgerEntry3.Next() = 0
                    end;
                until ItemLedgerEntry2.Next() = 0;
        end;
    end;*/
    //4.07<<

    Procedure PlanningShecdule(SalesLine: Record "Sales Line")
    var
        BomComponent: array[99] of Record "Production BOM Line";
        Item: Record Item;
        ItemLocal: Record Item;
        AllowedQty: Decimal;
        WIPQuantity: Decimal;
        WIPItemCode: Code[20];
        UomMgmt: Codeunit "Unit of Measure Management";
        ProductionBOMHeader: Record "Production BOM Header";
        ScheduleLineDetails1: Record "Sales Planning Line";
        BomItem: Record Item;
        Integer: Record Integer;
        SalesPlanningLine: Record "Sales Planning Schedule";
    begin
        Item.Get(SalesLine."No.");
        if Item."Production BOM No." = '' then
            exit;
        Level := 1;
        CalculateDate := WorkDate();
        ProdBOM.Get(Item."Production BOM No.");

        VersionCode[Level] := VersionMgt.GetBOMVersion(Item."Production BOM No.", CalculateDate, true);
        Clear(BomComponent);
        BomComponent[Level]."Production BOM No." := Item."Production BOM No.";
        BomComponent[Level].SetRange("Production BOM No.", Item."Production BOM No.");
        BomComponent[Level].SetRange("Version Code", VersionCode[Level]);
        BomComponent[Level].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
        BomComponent[Level].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
        NoListType[Level] := NoListType[Level] ::Item;
        NoList[Level] := Item."No.";
        Quantity[Level] :=
          UOMMgt.GetQtyPerUnitOfMeasure(Item, SalesLine."Unit of Measure Code") /
          UOMMgt.GetQtyPerUnitOfMeasure(
            Item,
            VersionMgt.GetBOMUnitOfMeasure(
              Item."Production BOM No.", VersionCode[Level]));
        SalesPlanningLine.Init();
        SalesPlanningLine."Sales Order No." := SalesLine."Document No.";
        SalesPlanningLine."Sales Order Line No." := SalesLine."Line No.";
        SalesPlanningLine."Item No." := SalesLine."No.";
        SalesPlanningLine."Planned Quantity" := SalesLine.Quantity * Quantity[Level];
        SalesPlanningLine."Unit Of measurement" := SalesLine."Unit of Measure Code";
        SalesPlanningLine."Expected Delivery Date" := SalesPlanningLine."Expected Delivery Date";
        SalesPlanningLine."Production Bom No." := Item."Production BOM No.";
        SalesPlanningLine."Production Bom Vesion No." := VersionCode[Level];
        SalesPlanningLine.Insert(true);
        Quantity[Level] := SalesLine.Quantity * Quantity[Level];
        Integer.Reset();
        Integer.SetFilter(Number, '>%1', 0);
        if Integer.FindSet() then
            repeat
                if Integer.Number > 1 then
                    while BomComponent[Level].Next() = 0 do begin
                        Level := Level - 1;
                        if Level < 1 then
                            exit;
                    end;
                NextLevel := Level;
                Clear(CompItem);
                QtyPerUnitOfMeasure := 1;
                case BomComponent[Level].Type of
                    BomComponent[Level].Type::Item:
                        begin
                            CompItem.Get(BomComponent[Level]."No.");
                            if CompItem."Production BOM No." <> '' then begin
                                ProdBOM.Get(CompItem."Production BOM No.");
                                if ProdBOM.Status <> ProdBOM.Status::Closed then begin
                                    NextLevel := Level + 1;
                                    if Level > 1 then
                                        if (NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1]) then
                                            Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                                    Clear(BomComponent[NextLevel]);
                                    NoListType[NextLevel] := NoListType[NextLevel] ::Item;
                                    NoList[NextLevel] := CompItem."No.";
                                    VersionCode[NextLevel] :=
                                      VersionMgt.GetBOMVersion(CompItem."Production BOM No.", CalculateDate, true);
                                    BomComponent[NextLevel].SetRange("Production BOM No.", CompItem."Production BOM No.");
                                    BomComponent[NextLevel].SetRange("Version Code", VersionCode[NextLevel]);
                                    BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                                    BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                                    IF Level > 1 THEN
                                        IF BomComponent[Level - 1].Type = BomComponent[Level - 1].Type::Item THEN
                                            IF BomItem.GET(BomComponent[Level - 1]."No.") THEN
                                                QtyPerUnitOfMeasure :=
                                                  UOMMgt.GetQtyPerUnitOfMeasure(BomItem, BomComponent[Level - 1]."Unit of Measure Code") /
                                                  UOMMgt.GetQtyPerUnitOfMeasure(
                                                    BomItem, VersionMgt.GetBOMUnitOfMeasure(BomItem."Production BOM No.", VersionCode[Level]));
                                    if NextLevel <> Level then
                                        Quantity[NextLevel] := BomComponent[NextLevel - 1].Quantity * QtyPerUnitOfMeasure * Quantity[Level];
                                    SalesPlanningLine.Init();
                                    SalesPlanningLine."Sales Order No." := SalesLine."Document No.";
                                    SalesPlanningLine."Sales Order Line No." := SalesLine."Line No.";
                                    SalesPlanningLine."Item No." := CompItem."No.";
                                    SalesPlanningLine."Planned Quantity" := Quantity[Level] * QtyPerUnitOfMeasure * BomComponent[Level].Quantity;
                                    SalesPlanningLine."Unit Of measurement" := SalesLine."Unit of Measure Code";
                                    SalesPlanningLine."Expected Delivery Date" := SalesPlanningLine."Expected Delivery Date";
                                    SalesPlanningLine."Production Bom No." := CompItem."Production BOM No.";
                                    SalesPlanningLine."Production Bom Vesion No." := VersionCode[Level];
                                    SalesPlanningLine.Insert(true);
                                end;
                            end;
                        end;
                end;


                Level := NextLevel;
            until Integer.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inspection Jnl. Post Line B2B", 'OnBeforeModifyStatusInspRcptLine', '', false, false)]
    procedure OnBeforeModifyStatusInspRcptLine(var InspectRcptHdr: Record "Inspection Receipt Header B2B")
    var
        PurchRcptHdr: Record "Purch. Rcpt. Header";
    begin
        if PurchRcptHdr.Get(InspectRcptHdr."Receipt No.") then begin
            PurchRcptHdr."Quality Remarks" := InspectRcptHdr."Quality Remarks";
            PurchRcptHdr.Modify();
        end;
    end;

    var
        Text000: Label 'As of ';
        Text008: Label '&Receive';
        Text009: Label '&Ship,&Receive';
        SelectionLvar: Integer;
        UserSetupLrec: Record "User Setup";
        ProdBOM: Record "Production BOM Header";
        BomComponent: array[99] of Record "Production BOM Line";
        CompItem: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        ItemFilter: Text;
        CalculateDate: Date;
        NoList: array[99] of Code[20];
        VersionCode: array[99] of Code[20];
        Quantity: array[99] of Decimal;
        QtyPerUnitOfMeasure: Decimal;
        Level: Integer;
        NextLevel: Integer;
        BOMQty: Decimal;
        QtyExplosionofBOMCaptLbl: Label 'Quantity Explosion of BOM';
        CurrReportPageNoCaptLbl: Label 'Page';
        BOMQtyCaptionLbl: Label 'Total Quantity';
        BomCompLevelQtyCaptLbl: Label 'BOM Quantity';
        BomCompLevelDescCaptLbl: Label 'Description';
        BomCompLevelNoCaptLbl: Label 'No.';
        LevelCaptLbl: Label 'Level';
        BomCompLevelUOMCodeCaptLbl: Label 'Unit of Measure Code';
        NoListType: array[99] of Option " ",Item,"Production BOM";
        ProdBomErr: Label 'The maximum number of BOM levels, %1, was exceeded. The process stopped at item number %2, BOM header number %3, BOM level %4.';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Post-Inspection Data Sheet B2B", 'OnAfterInsertInspectionReportHeader', '', false, false)]
    procedure OnAfterInsertInspectionReportHeader(var InspectReportHeader: Record "Inspection Receipt Header B2B"; InspectHeader: Record "Posted Ins DatasheetHeader B2B")
    var
        PurchRcptHdr: Record "Purch. Rcpt. Header";
    begin
        if PurchRcptHdr.Get(InspectReportHeader."Receipt No.") then begin
            PurchRcptHdr."Quality Remarks" := InspectReportHeader."Quality Remarks";
            PurchRcptHdr.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeOnDelete', '', false, false)]

    local procedure OnBeforeOnDelete(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        PaymentTermsconditions: Record "Payment Terms And Conditions";
    begin
        PaymentTermsconditions.Reset();
        PaymentTermsconditions.SetRange("Document No.", PurchaseHeader."No.");
        if PaymentTermsconditions.FindSet() then
            PaymentTermsconditions.DeleteAll();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure OnAfterConfirmPost(var SalesHeader: Record "Sales Header")
    var
        SalesCheckList: Record SalesCheckList;
    begin
        if SalesHeader.Ship then begin
            SalesCheckList.Reset();
            SalesCheckList.SetRange("Document Type", SalesHeader."Document Type");
            SalesCheckList.SetRange("No.", SalesHeader."No.");
            SalesCheckList.SetFilter(Check, '%1|%2', SalesCheckList.Check::No, SalesCheckList.Check::" ");
            if SalesCheckList.FindFirst() then
                Error('QAP check must be checked');
        end;
    end;
    //B2BJK ON nov11 >>
    /*[EventSubscriber(ObjectType::Page, Page::"Posted Inspection Receipt B2B", 'CreateRGPOutOnAfterSendToVendor', '', false, false)]

    procedure CreateRGPOutOnAfterSendToVendor(InspectionReceiptHdr: Record "Inspection Receipt Header B2B")
    var
        GatePassHeader: Record "Gate Pass Header";
        GatePassLine: Record "Gate Pass Line";
        NoSeries: Record "No. Series";
        NoSeriesRelationship: Record "No. Series Relationship";
        InventorySetup: Record "Inventory Setup";
        NoseriesMgmt: Codeunit NoSeriesManagement;
    begin
        InventorySetup.Get();
        InventorySetup.TestField("RGP Out");
        GatePassHeader.Init();
        GatePassHeader."Document Type" := GatePassHeader."Document Type"::"RGP Out";
        NoSeries.Reset();
        NoSeriesRelationship.SetRange(Code, InventorySetup."RGP Out");
        NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", InspectionReceiptHdr."Shortcut Dimension 1 Code");
        if NoSeriesRelationship.FindSet() then
            repeat
                NoSeries.Code := NoSeriesRelationship."Series Code";
                NoSeries.Mark := true;
            until NoSeriesRelationship.Next() = 0;
        if NoSeries.Get(InventorySetup."RGP Out") then
            if NoSeries."Shortcut Dimension 1 Code_B2B" = InspectionReceiptHdr."Shortcut Dimension 1 Code" then
                NoSeries.Mark := true;
        NoSeries.MarkedOnly := true;
        if NoSeries.FindSet() then
            GatePassHeader."No." := NoseriesMgmt.GetNextNo(NoSeries.Code, WorkDate(), true);
        //GatePassHeader."No." := '';
        GatePassHeader."No. Series" := NoSeries.Code;
        GatePassHeader.Insert(true);
        GatePassHeader.Validate("Consignee Type", GatePassHeader."Consignee Type"::Vendor);
        GatePassHeader.Validate("Consignee No.", InspectionReceiptHdr."Vendor No.");
        GatePassHeader.Validate("Posting Date", WorkDate());
        GatePassHeader.Validate("Global Dimension 1 Code", InspectionReceiptHdr."Shortcut Dimension 1 Code");
        GatePassHeader.Validate("Global Dimension 2 Code", InspectionReceiptHdr."Shortcut Dimension 2 Code");
        GatePassHeader.Modify(true);
        GatePassLine.Init();
        GatePassLine."Document Type" := GatePassHeader."Document Type";
        GatePassLine."Document No." := GatePassHeader."No.";
        GatePassLine."Line No." := 10000;
        GatePassLine.Insert(true);
        GatePassLine.Validate(Type, GatePassLine.Type::Item);
        GatePassLine.Validate("No.", InspectionReceiptHdr."Item No.");
        GatePassLine.Validate("Unit of Measure", InspectionReceiptHdr."Unit of Measure Code");
        GatePassLine.Validate(Quantity, InspectionReceiptHdr."Qty. sent to Vendor(Rework)");
        GatePassLine.Modify(true);
        Message('RDC out created -%1', GatePassHeader."No.");
        //CreateRGPInOnAfterReceive(InspectionReceiptHdr);
    end;*/

    /*//[EventSubscriber(ObjectType::Page, Page::"Posted Inspection Receipt B2B", 'CreateRGPInOnAfterReceive', '', false, false)]
    local procedure CreateRGPInOnAfterReceive(InspectionReceiptHdr: Record "Inspection Receipt Header B2B")
    var
        GatePassHeader: Record "Gate Entry Header_B2B";
        GatePassLine: Record "Gate Entry Line_B2B";
    begin
        GatePassHeader.Init();
        GatePassHeader."Entry Type" := GatePassHeader."Entry Type"::Inward;
        GatePassHeader.Type := GatePassHeader.Type::RGP;
        GatePassHeader."No." := '';
        GatePassHeader.Insert(true);
        GatePassHeader.Validate("Location Code", InspectionReceiptHdr."Location Code");
        GatePassHeader.Validate("Vendor No", InspectionReceiptHdr."Vendor No.");
        GatePassHeader."Posted IR No." := InspectionReceiptHdr."No.";
        GatePassHeader.Modify(true);
        GatePassLine.Init();
        GatePassLine."Entry Type" := GatePassHeader."Entry Type";
        GatePassLine.Type := GatePassHeader.Type;
        GatePassLine."Gate Entry No." := GatePassHeader."No.";
        GatePassLine."Line No." := 10000;
        GatePassLine.Insert(true);
        GatePassLine.Validate("Source Type", GatePassLine."Source Type"::Others);
        GatePassLine.Validate("Source No.", InspectionReceiptHdr."No.");
        GatePassLine.Modify(true);
        Message('RDC in created -%1', GatePassHeader."No.");
    end;*/
    //B2BJK ON nov11 <<
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure DocAttachFlowForPurchaseLineInsert(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        Item: Record Item;
        FromRecRef: RecordRef;
        ToRecRef: RecordRef;
    begin
        if Rec."Line No." = 0 then
            exit;

        if Rec.IsTemporary() then
            exit;

        if not Item.Get(Rec."No.") then
            exit;

        FromRecRef.GetTable(Item);
        ToRecRef.GetTable(Rec);

        CopyAttachmentsNew(FromRecRef, ToRecRef);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure OnCopyFromItemOnAfterCheck(var PurchaseLine: Record "Purchase Line"; Item: Record Item; CallingFieldNo: Integer)
    begin
        PurchaseLine."Vendor Test Certificate_B2B" := Item."Vendor Test Certificate_B2B";
        PurchaseLine."Warranty Certificate_B2B" := Item."Warranty Certificate_B2B";
    end;
    /*[EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterAssignItemValues', '', false, false)]
    
    local procedure OnAfterAssignItemValues(var PurchLine: Record "Purchase Line"; Item: Record Item; CurrentFieldNo: Integer; PurchHeader: Record "Purchase Header")
    begin
    end;*/
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure DocAttachFlowForSalesLineInsert(var Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        FromRecRef: RecordRef;
        ToRecRef: RecordRef;
    begin
        if Rec."Line No." = 0 then
            exit;

        if Rec.IsTemporary() then
            exit;

        // Skipping if the parent sales header came from a quote
        if SalesHeader.Get(Rec."Document Type", Rec."Document No.") then
            if SalesHeader."Quote No." <> '' then
                exit;

        if not Item.Get(Rec."No.") then
            exit;

        FromRecRef.GetTable(Item);
        ToRecRef.GetTable(Rec);

        CopyAttachmentsNew(FromRecRef, ToRecRef);
    end;

    procedure CopyAttachmentsNew(var FromRecRef: RecordRef; var ToRecRef: RecordRef)
    var
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
        FromFieldRef: FieldRef;
        ToFieldRef: FieldRef;
        FromDocumentType: Enum "Incoming Document Type";
        FromLineNo: Integer;
        FromNo: Code[20];
        ToNo: Code[20];
        ToDocumentType: Enum "Incoming Document Type";
        ToLineNo: Integer;
    begin
        FromDocumentAttachment.SetRange("Table ID", FromRecRef.Number);
        if FromDocumentAttachment.IsEmpty() then
            exit;
        case FromRecRef.Number() of
            DATABASE::Customer,
            DATABASE::Vendor,
            DATABASE::Item:
                begin
                    FromFieldRef := FromRecRef.Field(1);
                    FromNo := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("No.", FromNo);
                end;
            DATABASE::"Sales Header",
            DATABASE::"Purchase Header":
                begin
                    FromFieldRef := FromRecRef.Field(1);
                    FromDocumentType := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("Document Type", FromDocumentType);
                    FromFieldRef := FromRecRef.Field(3);
                    FromNo := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("No.", FromNo);
                end;
            DATABASE::"Sales Line",
            DATABASE::"Purchase Line":
                begin
                    FromFieldRef := FromRecRef.Field(1);
                    FromDocumentType := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("Document Type", FromDocumentType);
                    FromFieldRef := FromRecRef.Field(3);
                    FromNo := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("No.", FromNo);
                    FromFieldRef := FromRecRef.Field(4);
                    FromLineNo := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("Line No.", FromLineNo);
                end
        end;

        case ToRecRef.Number() of
            DATABASE::"Sales Line":
                if FromRecRef.Number() <> DATABASE::"Sales Line" then
                    FromDocumentAttachment.SetRange("Flow To Sales", true);
            DATABASE::"Sales Header":
                if FromRecRef.Number() <> DATABASE::"Sales Header" then
                    FromDocumentAttachment.SetRange("Flow To Sales", true);
            DATABASE::"Purchase Line":
                if FromRecRef.Number() <> DATABASE::"Purchase Line" then
                    FromDocumentAttachment.SetRange("Flow To Purchase", true);
            DATABASE::"Purchase Header":
                if FromRecRef.Number() <> DATABASE::"Purchase Header" then
                    FromDocumentAttachment.SetRange("Flow To Purchase", true);
        end;

        if FromDocumentAttachment.FindSet() then
            repeat
                Clear(ToDocumentAttachment);
                ToDocumentAttachment.Init();
                ToDocumentAttachment.TransferFields(FromDocumentAttachment);
                ToDocumentAttachment.Validate("Table ID", ToRecRef.Number);

                ToFieldRef := ToRecRef.Field(3);
                ToNo := ToFieldRef.Value();
                ToDocumentAttachment.Validate("No.", ToNo);

                case ToRecRef.Number() of
                    DATABASE::"Sales Header",
                    DATABASE::"Purchase Header":
                        begin
                            ToFieldRef := ToRecRef.Field(1);
                            ToDocumentType := ToFieldRef.Value();
                            ToDocumentAttachment.Validate("Document Type", ToDocumentType);
                        end;
                    DATABASE::"Sales Line",
                    DATABASE::"Purchase Line":
                        begin
                            ToFieldRef := ToRecRef.Field(1);
                            ToDocumentType := ToFieldRef.Value();
                            ToDocumentAttachment.Validate("Document Type", ToDocumentType);

                            ToFieldRef := ToRecRef.Field(4);
                            ToLineNo := ToFieldRef.Value();
                            ToDocumentAttachment.Validate("Line No.", ToLineNo);
                        end;
                end;

                //if not ToDocumentAttachment.Insert(true) then;
                if not ToDocumentAttachment.Insert then;
                ToDocumentAttachment."Attached Date" := FromDocumentAttachment."Attached Date";
                ToDocumentAttachment.Modify();

            until FromDocumentAttachment.Next() = 0;

        // Copies attachments for header and then calls CopyAttachmentsForPostedDocsLines to copy attachments for lines.
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", 'OnCreateProdOrderOnAfterProdOrderInsert', '', false, false)]

    local procedure OnCreateProdOrderOnAfterProdOrderInsert(var ProductionOrder: Record "Production Order"; SalesLine: Record "Sales Line")
    begin
        ProductionOrder."Sales Order No" := SalesLine."Document No.";
        ProductionOrder."Sales Order Line No." := SalesLine."Line No.";
    end;

    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", 'OnCreateProductionOrderOnBeforeProdOrderLineModify', '', false, false)]
    local procedure OnCreateProductionOrderOnBeforeProdOrderLineModify(var ProdOrderLine: Record "Prod. Order Line"; var SalesLine: Record "Sales Line"; var ProdOrder: Record "Production Order"; var SalesLineReserve: Codeunit "Sales Line-Reserve")
    begin
        ProdOrderLine."Sales Order No" := SalesLine."Document No.";
    end;*/
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order Lines", 'OnBeforeProdOrderLineInsert', '', false, false)]
    local procedure OnBeforeProdOrderLineInsert(var ProdOrderLine: Record "Prod. Order Line"; var ProductionOrder: Record "Production Order"; SalesLineIsSet: Boolean; var SalesLine: Record "Sales Line")
    begin
        ProdOrderLine."Sales Order No" := SalesLine."Document No.";
    end;

    [EventSubscriber(ObjectType::Page, page::"Sales Order Planning", 'OnCreateProdOrderOnAfterGetParameters', '', false, false)]

    local procedure OnCreateProdOrderOnAfterGetParameters(var SalesPlanningLine: Record "Sales Planning Line"; var NewStatus: Enum "Production Order Status"; var NewOrderType: Enum "Create Production Order Type")
    var
        NewStatusGvar: Enum "Production Order Status";
        CreateOrderFromSales: Page "Create Order From Sales";
        NewOrderTypeGvar: Enum "Create Production Order Type";
    begin
        CreateOrderFromSales.GetParametersNew(NewStatusGvar, NewOrderTypeGvar);
        NewStatus := NewStatusGvar;
        NewOrderType := NewOrderTypeGvar;
    end;

    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchHeader', '', false, false)]

    local procedure OnAfterCopyItemJnlLineFromPurchHeader(var ItemJnlLine: Record "Item Journal Line"; PurchHeader: Record "Purchase Header")
    begin
        ItemJnlLine."Pc No." := PurchHeader."Pc No.";
        ItemJnlLine."Pc Date" := PurchHeader."Pc Date";
        ItemJnlLine."Dc No." := PurchHeader."Dc No.";
        ItemJnlLine."Dc Date" := PurchHeader."Dc Date";
        ItemJnlLine."Duty Involved_B2B" := PurchHeader."Duty Involved_B2B";
        ItemJnlLine."Bill of Entry No." := PurchHeader."Bill of Entry No.";
        ItemJnlLine."Bill of Entry Date" := PurchHeader."Bill of Entry Date";
    end;

    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
    begin
        // ItemJnlLine."Pc No." := PurchLine."Pc No.";
        // ItemJnlLine."Pc Date" := PurchLine."Pc Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inspection Data Sheets B2B", 'OnAfterInitInspectionHeaderInsTypePurchase', '', false, false)]
    procedure OnAfterInitInspectionHeaderInsTypePurchase(var InspectDataHeader: Record "Ins Datasheet Header B2B"; PurchRcptHeader: record "Purch. Rcpt. Header"; PurchRcptLine: Record "Purch. Rcpt. Line")
    begin
        InspectDataHeader."Pc No." := PurchRcptHeader."Pc No.";
        InspectDataHeader."Pc Date" := PurchRcptHeader."Pc Date";
        InspectDataHeader."Dc No." := PurchRcptHeader."Dc No.";
        InspectDataHeader."Dc Date" := PurchRcptHeader."Dc Date";
        InspectDataHeader."Bill of Entry No." := PurchRcptHeader."Bill of Entry No.";
        InspectDataHeader."Bill of Entry Date" := PurchRcptHeader."Bill of Entry Date";
        InspectDataHeader."Vendor Test Certificate_B2B" := PurchRcptLine."Vendor Test Certificate_B2B";
        InspectDataHeader."Warranty Certificate_B2B" := PurchRcptLine."Warranty Certificate_B2B";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Post-Inspection Data Sheet B2B", 'OnBeforeInsertInspectionReportHeader', '', false, false)]
    procedure OnBeforeInsertInspectionReportHeader(var InspectReportHeader: Record "Inspection Receipt Header B2B"; InspectHeader: Record "Posted Ins DatasheetHeader B2B")
    begin
        InspectReportHeader."Pc No." := InspectHeader."Pc No.";
        InspectReportHeader."Pc Date" := InspectHeader."Pc Date";
        InspectReportHeader."Dc No." := InspectHeader."Dc No.";
        InspectReportHeader."Dc Date" := InspectHeader."Dc Date";
        InspectReportHeader."Bill of Entry No." := InspectHeader."Bill of Entry No.";
        InspectReportHeader."Bill of Entry Date" := InspectHeader."Bill of Entry Date";
        InspectReportHeader."Vendor Test Certificate_B2B" := InspectHeader."Vendor Test Certificate_B2B";
        InspectReportHeader."Warranty Certificate_B2B" := InspectHeader."Warranty Certificate_B2B";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inspection Data Sheets B2B", 'OnAfterInitInspectionHeaderInsTypePurchaseLot', '', false, false)]
    procedure OnAfterInitInspectionHeaderInsTypePurchaseLot(var InspectDataHeader: Record "Ins Datasheet Header B2B"; PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchRcptLine: Record "Purch. Rcpt. Line"; InspLot: Record "Inspection Lot B2B")
    begin
        InspectDataHeader."Pc No." := PurchRcptHeader."Pc No.";
        InspectDataHeader."Pc Date" := PurchRcptHeader."Pc Date";
        InspectDataHeader."Dc No." := PurchRcptHeader."Dc No.";
        InspectDataHeader."Dc Date" := PurchRcptHeader."Dc Date";
        InspectDataHeader."Bill of Entry No." := PurchRcptHeader."Bill of Entry No.";
        InspectDataHeader."Bill of Entry Date" := PurchRcptHeader."Bill of Entry Date";
        InspectDataHeader."Vendor Test Certificate_B2B" := PurchRcptLine."Vendor Test Certificate_B2B";
        InspectDataHeader."Warranty Certificate_B2B" := PurchRcptLine."Warranty Certificate_B2B";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inspection Data Sheets B2B", 'OnAfterInitInspectionHeaderInsTypeProductionOrder', '', false, false)]
    procedure OnAfterInitInspectionHeaderInsTypeProductionOrder(var InspectDataHeader: Record "Ins Datasheet Header B2B"; ProdOrderLine: Record "Prod. Order Line"; PurchRcptLine: Record "Purch. Rcpt. Line"; ProdOrderRoutingLine: Record "Prod. Order Routing Line"; ProdOrderLine1: Record "Prod. Order Line")
    var
        ItemLrec: Record Item;
        PurchaseHdrLrec: Record "Purchase Header";
        ProdOrderLineLrec: Record "Prod. Order Line";
    begin
        if ItemLrec.Get(ProdOrderLine."Item No.") then begin
            InspectDataHeader."Vendor Test Certificate_B2B" := ItemLrec."Vendor Test Certificate_B2B";
            InspectDataHeader."Warranty Certificate_B2B" := ItemLrec."Warranty Certificate_B2B";
        end;
        ProdOrderLine.Reset();
        ProdOrderLine.SetRange("Prod. Order No.", InspectDataHeader."Prod. Order No.");
        ProdOrderLine.SetFilter("Purchase Order No.", '<>%1', '');
        if ProdOrderLine.FindFirst() then begin
            PurchaseHdrLrec.Reset();
            PurchaseHdrLrec.SetRange("Document Type", PurchaseHdrLrec."Document Type"::Order);
            PurchaseHdrLrec.SetRange("No.", ProdOrderLine."Purchase Order No.");
            if PurchaseHdrLrec.FindFirst() then begin
                InspectDataHeader."Vendor No." := PurchaseHdrLrec."Buy-from Vendor No.";
                InspectDataHeader."Vendor Name" := PurchaseHdrLrec."Buy-from Vendor Name";
                InspectDataHeader.Address := PurchaseHdrLrec."Buy-from Address";
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Indent Header", 'OnAfterAssisitEdit', '', false, false)]
    procedure OnAfterAssisitEdit(IndentNoPar: Code[20]; Var IndentHeaderRec: Record "Indent Header")
    var
        NoSeriesRec: Record "No. Series";
    begin
        if NoSeriesRec.Get(IndentNoPar) then
            IndentHeaderRec."Shortcut Dimension 1 Code_B2B" := NoSeriesRec."Shortcut Dimension 1 Code_B2B";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Indent Req Header", 'OnAfterAssisitEditIndReq', '', false, false)]
    procedure OnAfterAssisitEditIndReq(Var IndentNoPar: Code[20]; Var IndentReqHeaderRec: Record "Indent Req Header")
    var
        NoSeriesRec: Record "No. Series";
    begin
        if NoSeriesRec.Get(IndentNoPar) then
            IndentReqHeaderRec."Shortcut Dimension 1 Code_B2B" := NoSeriesRec."Shortcut Dimension 1 Code_B2B";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", 'OnAfterCreateProdOrderFromSalesLine', '', false, false)]
    local procedure OnAfterCreateProdOrderFromSalesLine(var ProdOrder: Record "Production Order"; var SalesLine: Record "Sales Line")
    begin
        ProdOrder.Validate("Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 1 Code");
        ProdOrder.Validate("Shortcut Dimension 2 Code", SalesLine."Shortcut Dimension 2 Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", 'OnCreateProdOrderOnBeforeProdOrderInsert', '', false, false)]

    local procedure OnCreateProdOrderOnBeforeProdOrderInsert(var ProductionOrder: Record "Production Order"; SalesLine: Record "Sales Line")
    var
        NoseriesMgmt: Codeunit NoSeriesManagement;
        ManufacturingSetup: Record "Manufacturing Setup";
        NoSeries: Record "No. Series";
        NoSeriesRelationship: Record "No. Series Relationship";
        SalesHeader: Record "Sales Header";
    begin
        ManufacturingSetup.Get();
        //ManufacturingSetup.TestField("Released Order Nos.");
        ManufacturingSetup.TestField("Planning Orders(DOM)");
        ManufacturingSetup.TestField("Planning Orders(EOU)");
        /*NoSeries.Reset();
        NoSeriesRelationship.SetRange(Code, ManufacturingSetup."Released Order Nos.");
        NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", SalesLine."Shortcut Dimension 1 Code");
        if NoSeriesRelationship.FindSet() then
            repeat
                NoSeries.Code := NoSeriesRelationship."Series Code";
                NoSeries.Mark := true;
            until NoSeriesRelationship.Next() = 0;
        if NoSeries.Get(ManufacturingSetup."Released Order Nos.") then
            if NoSeries."Shortcut Dimension 1 Code_B2B" = SalesLine."Shortcut Dimension 1 Code" then
                NoSeries.Mark := true;
        NoSeries.MarkedOnly := true; */
        //if PAGE.RunModal(0, NoSeries) = ACTION::LookupOK then begin
        //Noseries.SETRANGE(Code, PurchaseSetup."Quote Nos.");
        //IF PAGE.RUNMODAL(458, Noseries) = ACTION::LookupOK THEN
        if SalesHeader.get(SalesLine."Document Type", SalesLine."Document No.") then begin
            if SalesHeader."Shortcut Dimension 1 Code" = 'DOM' then
                ProductionOrder."No." := NoseriesMgmt.GetNextNo(ManufacturingSetup."Planning Orders(DOM)", WorkDate(), true)
            else
                if SalesHeader."Shortcut Dimension 1 Code" = 'DOM' then
                    // if NoSeries.FindSet() then
                    ProductionOrder."No." := NoseriesMgmt.GetNextNo(ManufacturingSetup."Planning Orders(EOU)", WorkDate(), true);
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Indent Req Header", 'OnAfterLookUp', '', false, false)]
    procedure OnAfterLookUp(Var IndentReqHeaderRec: Record "Indent Req Header")
    var
        PurchaseSetup: Record "Purchases & Payables Setup";
        NoSeries: Record "No. Series";
        NoSeriesRelationship: Record "No. Series Relationship";
    begin
        PurchaseSetup.GET;
        /*IF Type = Type::Enquiry THEN
            Noseries.SETRANGE(Code, PurchaseSetup."Enquiry Nos.")
        ELSE
            IF Type = Type::Quote THEN
                Noseries.SETRANGE(Code, PurchaseSetup."Quote Nos.")
            ELSE
                Noseries.SETRANGE(Code, PurchaseSetup."Order Nos.");*/
        NoSeries.Reset();
        NoSeriesRelationship.Reset();
        IF IndentReqHeaderRec.Type = IndentReqHeaderRec.Type::Enquiry THEN
            NoSeriesRelationship.SetRange(Code, PurchaseSetup."Enquiry Nos.")
        ELSE
            IF IndentReqHeaderRec.Type = IndentReqHeaderRec.Type::Quote THEN
                NoSeriesRelationship.SETRANGE(Code, PurchaseSetup."Quote Nos.")
            else
                if IndentReqHeaderRec.Type = IndentReqHeaderRec.Type::Order then
                    NoSeriesRelationship.SETRANGE(Code, PurchaseSetup."Order Nos.");
        NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", IndentReqHeaderRec."Shortcut Dimension 1 Code_B2B");
        if NoSeriesRelationship.FindSet() then
            repeat
                NoSeries.Code := NoSeriesRelationship."Series Code";
                NoSeries.Mark := true;
            until NoSeriesRelationship.Next() = 0;
        IF IndentReqHeaderRec.Type = IndentReqHeaderRec.Type::Enquiry THEN begin
            if NoSeries.Get(PurchaseSetup."Enquiry Nos.") then
                if Noseries."Shortcut Dimension 1 Code_B2B" = IndentReqHeaderRec."Shortcut Dimension 1 Code_B2B" then
                    NoSeries.Mark := true;
        end ELSE
            IF IndentReqHeaderRec.Type = IndentReqHeaderRec.Type::Quote THEN begin
                if NoSeries.Get(PurchaseSetup."Quote Nos.") then
                    if Noseries."Shortcut Dimension 1 Code_B2B" = IndentReqHeaderRec."Shortcut Dimension 1 Code_B2B" then
                        NoSeries.Mark := true;
            end else
                if IndentReqHeaderRec.Type = IndentReqHeaderRec.Type::Order then begin
                    if NoSeries.Get(PurchaseSetup."Order Nos.") then
                        if Noseries."Shortcut Dimension 1 Code_B2B" = IndentReqHeaderRec."Shortcut Dimension 1 Code_B2B" then
                            NoSeries.Mark := true;
                end;
        NoSeries.MarkedOnly := true;
        if PAGE.RunModal(0, NoSeries) = ACTION::LookupOK then
            //Noseries.SETRANGE(Code, PurchaseSetup."Quote Nos.");
            //IF PAGE.RUNMODAL(458, Noseries) = ACTION::LookupOK THEN
            // NoSeriesGvar := Noseries.Code;
            //end;
            //IF PAGE.RUNMODAL(458, Noseries) = ACTION::LookupOK THEN
            IndentReqHeaderRec."No.Series" := Noseries.Code;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", 'OnBeforeInsertSalesOrderHeader', '', false, false)]

    local procedure OnBeforeInsertSalesOrderHeader(var SalesOrderHeader: Record "Sales Header"; var SalesQuoteHeader: Record "Sales Header")
    var
        NoseriesMgmt: Codeunit NoSeriesManagement;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        NoSeries: Record "No. Series";
        NoSeriesRelationship: Record "No. Series Relationship";
    begin
        SalesReceivablesSetup.Get();
        SalesReceivablesSetup.TestField("Order Nos.");
        NoSeries.Reset();
        NoSeriesRelationship.SetRange(Code, SalesReceivablesSetup."Order Nos.");
        NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", SalesQuoteHeader."Shortcut Dimension 1 Code");
        if NoSeriesRelationship.FindSet() then
            repeat
                NoSeries.Code := NoSeriesRelationship."Series Code";
                NoSeries.Mark := true;
            until NoSeriesRelationship.Next() = 0;
        if NoSeries.Get(SalesReceivablesSetup."Order Nos.") then
            if NoSeries."Shortcut Dimension 1 Code_B2B" = SalesQuoteHeader."Shortcut Dimension 1 Code" then
                NoSeries.Mark := true;
        NoSeries.MarkedOnly := true;
        //if PAGE.RunModal(0, NoSeries) = ACTION::LookupOK then begin
        //Noseries.SETRANGE(Code, PurchaseSetup."Quote Nos.");
        //IF PAGE.RUNMODAL(458, Noseries) = ACTION::LookupOK THEN
        if NoSeries.FindSet() then
            SalesOrderHeader."No." := NoseriesMgmt.GetNextNo(NoSeries.Code, WorkDate(), true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer);
    begin
        //if PurchaseHeader."Document Type" <> PurchaseHeader."Document Type"::Invoice then begin
        HideDialog := true;
        NewConfirmPost(PurchaseHeader, IsHandled);
        // end;
    end;

    local procedure NewConfirmPost(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean): Boolean
    var
        Selection: Integer;
        ConfirmManagement: Codeunit "Confirm Management";
        // ShipInvoiceQst: Label '&Receive ,&Invoice ,Receive &and Invoice';
        ShipInvoiceQst: Label '&Receive';
        PostConfirmQst: Label 'Do you want to post the %1?', Comment = '%1 = Document Type';
        ReceiveInvoiceQst: Label '&Receive,&Invoice,Receive &and Invoice';
        NothingToPostErr: Label 'There is nothing to post.';
        DocCancelShortErr: Label 'Document already %1';
        ShipInvoiceQstNew: Label '&Ship,&Invoice,Ship &and Invoice';
    begin
        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Order:
                begin
                    // if (PurchaseHeader."Cancel Shortclose Appr. Status" = PurchaseHeader."Cancel Shortclose Appr. Status"::Cancelled) or
                    //    (PurchaseHeader."Cancel Shortclose Appr. Status" = PurchaseHeader."Cancel Shortclose Appr. Status"::"Short Closed") then
                    //    Error(DocCancelShortErr, PurchaseHeader."Cancel Shortclose Appr. Status");
                    Selection := StrMenu(ShipInvoiceQst, 1);
                    PurchaseHeader.Receive := Selection in [1, 1];
                    //PurchaseHeader.Invoice := Selection in [2, 3];
                    if Selection = 0 then
                        exit(false);
                end;
            PurchaseHeader."Document Type"::"Return Order":
                begin
                    Selection := StrMenu(ShipInvoiceQst, 1);
                    PurchaseHeader.Ship := Selection in [1, 3];
                    PurchaseHeader.Invoice := Selection in [2, 3];
                    if Selection = 0 then
                        exit(false);
                end;

            else
                if not ConfirmManagement.GetResponseOrDefault(
                     StrSubstNo(PostConfirmQst, LowerCase(Format(PurchaseHeader."Document Type"))), true)
                then begin
                    IsHandled := true;
                    exit(false);
                end;
        end;
        PurchaseHeader."Print Posted Documents" := false;
        exit(true);
    end;

    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnAfterInsertLines', '', false, false)]

    
    local procedure OnAfterInsertLines(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetFilter("No.", '<>%1', '');
        if PurchLine.FindFirst() then begin
            PurchHeader.Validate("Shortcut Dimension 1 Code", PurchLine."Shortcut Dimension 1 Code");
            PurchHeader.Validate("Shortcut Dimension 2 Code", PurchLine."Shortcut Dimension 2 Code");
        end;
    end;*/

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnCreateInvLinesOnBeforeFind', '', false, false)]
    local procedure OnCreateInvLinesOnBeforeFind(var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchHeader: Record "Purchase Header")
    begin
        //Message('%1,%2', PurchRcptLine."Shortcut Dimension 1 Code", PurchRcptLine."Shortcut Dimension 2 Code");
        PurchHeader.Validate("Shortcut Dimension 1 Code", PurchRcptLine."Shortcut Dimension 1 Code");
        PurchHeader.Validate("Shortcut Dimension 2 Code", PurchRcptLine."Shortcut Dimension 2 Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        PurchInvHdrRec: Record "Purch. Inv. Header";
        PurchInvLineRec: Record "Purch. Inv. Line";
        PurchRcptLineRec: Record "Purch. Rcpt. Line";
        ItemRec: Record Item;
        QtyAcceptedLvar: Decimal;
        QtyRejectedLvar: Decimal;
        TotalQuantityLvar: Decimal;
    begin
        if VendorLedgerEntry."Document Type" = VendorLedgerEntry."Document Type"::Invoice then begin
            PurchInvLineRec.Reset();
            PurchInvLineRec.SetRange("Document No.", VendorLedgerEntry."Document No.");
            PurchInvLineRec.SetRange(Type, PurchInvLineRec.Type::Item);
            PurchInvLineRec.SetFilter("No.", '<>%1', '');
            if PurchInvLineRec.FindSet() then
                repeat
                    PurchRcptLineRec.Reset();
                    PurchRcptLineRec.SetRange("Document No.", PurchInvLineRec."Receipt No.");
                    PurchRcptLineRec.SetRange("Line No.", PurchRcptLineRec."Line No.");
                    if PurchRcptLineRec.FindFirst() then begin
                        TotalQuantityLvar += PurchRcptLineRec.Quantity;
                        QtyAcceptedLvar += PurchRcptLineRec."Quantity Accepted B2B";
                        QtyRejectedLvar += PurchRcptLineRec."Quantity Rejected B2B";
                    end;
                until PurchInvLineRec.Next() = 0;
            if TotalQuantityLvar = QtyAcceptedLvar then
                VendorLedgerEntry."QC Status" := VendorLedgerEntry."QC Status"::Accepted
            else
                if TotalQuantityLvar = QtyRejectedLvar then
                    VendorLedgerEntry."QC Status" := VendorLedgerEntry."QC Status"::Rejecetd
                else
                    VendorLedgerEntry."QC Status" := VendorLedgerEntry."QC Status"::"Partially Accepted";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Header", 'OnBeforeDeleteOneTransferOrder', '', false, false)]
    local procedure OnBeforeDeleteOneTransferOrder(var TransHeader2: Record "Transfer Header"; var TransLine2: Record "Transfer Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Header", 'OnAfterCopyFromTransferHeader', '', false, false)]

    local procedure OnAfterCopyFromTransferHeaderShipment(var TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferShipmentHeader."Production Order No." := TransferHeader."Production Order No.";
        TransferShipmentHeader."Excess Material Returns" := TransferHeader."Excess Material Returns";
        TransferShipmentHeader."Finished Good Transfer" := TransferHeader."Finished Good Transfer";
        TransferShipmentHeader."Subcon Order No." := TransferHeader."Subcon Order No.";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Line", 'OnAfterCopyFromTransferLine', '', false, false)]

    local procedure OnAfterCopyShipFromTransferLine(var TransferShipmentLine: Record "Transfer Shipment Line"; TransferLine: Record "Transfer Line")
    begin
        TransferShipmentLine."Prod. Expected date" := TransferLine."Prod. Expected date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Line", 'OnAfterCopyFromTransferLine', '', false, false)]

    local procedure OnAfterCopyFromTransferLine(var TransferReceiptLine: Record "Transfer Receipt Line"; TransferLine: Record "Transfer Line")
    begin
        TransferReceiptLine."Prod. Expected date" := TransferLine."Prod. Expected date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Transfer Receipt Header", 'OnAfterCopyFromTransferHeader', '', false, false)]

    local procedure OnAfterCopyFromTransferHeaderReceipt(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader."Production Order No." := TransferHeader."Production Order No.";
        TransferReceiptHeader."Excess Material Returns" := TransferHeader."Excess Material Returns";
        TransferReceiptHeader."Finished Good Transfer" := TransferHeader."Finished Good Transfer";
        TransferReceiptHeader."Subcon Order No." := TransferHeader."Subcon Order No.";
    end;

    //[EventSubscriber(ObjectType::Codeunit, codeunit::"Prod. Order Status Management", 'OnBeforeChangeStatusOnProdOrder', '', false, false)]
    local procedure OnBeforeChangeStatusOnProdOrder(var ProductionOrder: Record "Production Order"; NewStatus: Option Quote,Planned,"Firm Planned",Released,Finished; var IsHandled: Boolean; NewPostingDate: Date; NewUpdateUnitCost: Boolean)
    var
        ProdOrderLine: Record "Prod. Order Line";
        PurchaseLine: Record "Purchase Line";
        Error0001: Label 'Subcontracting order : %1 not yet completely invoiced';
    begin
        if NewStatus = NewStatus::Finished then begin
            ProdOrderLine.Reset();
            ProdOrderLine.SetRange(Status, ProductionOrder.Status);
            ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
            if ProdOrderLine.FindSet() then
                repeat
                    if ProdOrderLine."Subcontracting Order" then begin
                        ProdOrderLine.TestField("Purchase Order No.");
                        PurchaseLine.Reset();
                        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                        PurchaseLine.SetRange("Document No.", ProdOrderLine."Purchase Order No.");
                        PurchaseLine.SetRange("Line No.", ProdOrderLine."Purchase Order Line No.");
                        PurchaseLine.SetFilter("No.", '<>%1', '');
                        if PurchaseLine.FindFirst() then
                            if PurchaseLine.Quantity <> PurchaseLine."Quantity Invoiced" then
                                Error(Error0001, PurchaseLine."Document No.");
                    end;
                until ProdOrderLine.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Calculate Prod. Order", 'OnAfterTransferRoutingLine', '', false, false)]
    local procedure OnAfterTransferRoutingLine(var ProdOrderLine: Record "Prod. Order Line"; var RoutingLine: Record "Routing Line"; var ProdOrderRoutingLine: Record "Prod. Order Routing Line")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        if ProdOrderLine."Subcontracting Order" then begin
            PurchaseLine.Reset();
            PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
            PurchaseLine.SetRange("Document No.", ProdOrderLine."Purchase Order No.");
            PurchaseLine.SetRange("Line No.", ProdOrderLine."Purchase Order Line No.");
            PurchaseLine.SetFilter("No.", '<>%1', '');
            if PurchaseLine.FindFirst() then begin
                PurchaseLine.TestField("Unit Cost");
                ProdOrderRoutingLine.Validate("Direct Unit Cost", PurchaseLine."Unit Cost");
            end;
        End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeRunWithCheck', '', false, false)]
    local procedure OnBeforeRunWithCheck(var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean; CalledFromApplicationWorksheet: Boolean; PostponeReservationHandling: Boolean; var IsHandled: Boolean)
    var
        ProdOrderLine: Record "Prod. Order Line";
        PurchRecptLine: Record "Purch. Rcpt. Line";
        Error0001: Label 'Output Quantity must be less than or Equal to quantity received in subcontracting order : %1';
    begin

        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Output then begin
            if ProdOrderLine.Get(ProdOrderLine.Status::Released, ItemJournalLine."Order No.", ItemJournalLine."Order Line No.") then
                if ProdOrderLine."Subcontracting Order" then begin
                    ProdOrderLine.TestField("Purchase Order No.");
                    PurchRecptLine.Reset();
                    PurchRecptLine.SetRange("Order No.", ProdOrderLine."Purchase Order No.");
                    PurchRecptLine.SetRange("Order Line No.", ProdOrderLine."Purchase Order Line No.");
                    PurchRecptLine.SetFilter("No.", '<>%1', '');
                    if PurchRecptLine.FindSet() then
                        PurchRecptLine.CalcSums(Quantity);
                    if ItemJournalLine."Output Quantity" > (PurchRecptLine.Quantity - ProdOrderLine."Finished Quantity") then
                        Error(Error0001, ProdOrderLine."Purchase Order No.");
                end;
        end;
    end;

    //[EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyFromWorkCenter', '', false, false)]
    local procedure OnAfterCopyFromWorkCenter(var ItemJournalLine: Record "Item Journal Line"; WorkCenter: Record "Work Center")
    var
        ProdOrderLine: Record "Prod. Order Line";
        PurchaseLine: Record "Purchase Line";
    begin
        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Output then begin
            ProdOrderLine.Get(ProdOrderLine.Status::Released, ItemJournalLine."Order No.", ItemJournalLine."Order Line No.");
            if ProdOrderLine."Subcontracting Order" then begin
                ProdOrderLine.TestField("Purchase Order No.");
                PurchaseLine.Reset();
                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SetRange("Document No.", ProdOrderLine."Purchase Order No.");
                PurchaseLine.SetRange("Line No.", ProdOrderLine."Purchase Order Line No.");
                PurchaseLine.SetFilter("No.", '<>%1', '');
                if PurchaseLine.FindFirst() then
                    ItemJournalLine."Unit Cost Calculation" := PurchaseLine."Unit Cost";

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch. Line CaptionClass Mgmt", 'OnGetPurchaseLineCaptionClass', '', false, false)]
    local procedure ChangeCustomizedCaption(FieldNumber: Integer; PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean; var Caption: Text; var PurchaseLine: Record "Purchase Line"
       )
    var
        DirectUnitCostInclGST: Label 'Direct Unit Cost Incl. GST';
        DirectUnitCostExclGST: Label 'Direct Unit Cost Excl. GST';
        LineAmtInclGST: Label 'Line Amount Incl. GST';
        LineAmtExclGST: Label 'Line Amount Excl. GST';
    begin


        Case FieldNumber of
            PurchaseLine.FieldNo("Direct Unit Cost"):
                begin
                    if PurchaseHeader."Prices Including VAT" then
                        Caption := DirectUnitCostInclGST
                    else
                        Caption := DirectUnitCostExclGST;
                    IsHandled := true;

                end;

            PurchaseLine.FieldNo("Line Amount"):
                begin
                    if PurchaseHeader."Prices Including VAT" then
                        Caption := LineAmtInclGST
                    else
                        Caption := LineAmtExclGST;
                    IsHandled := true;

                end;


        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnCodeOnBeforePostTransferOrder', '', false, false)]
    local procedure OnCodeOnBeforePostTransferOrder(var TransHeader: Record "Transfer Header"; var DefaultNumber: Integer; var Selection: Option; var IsHandled: Boolean)
    var
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
        InvtSetup: Record "Inventory Setup";
        TransferOrderPostTransfer: Codeunit "TransferOrder-Post Transfer";
    // Text008: Label '&Receive';
    // Text009: Label '&Ship,&Receive';
    // SelectionLvar: Integer;
    // UserSetupLrec: Record "User Setup";
    //EmployeeLrec : Record Employee;
    begin
        InvtSetup.Get();
        if TransHeader."Created From MRS" then begin
            if TransHeader."Direct Transfer" then
                case InvtSetup."Direct Transfer Posting" of
                    InvtSetup."Direct Transfer Posting"::"Receipt and Shipment":
                        begin
                            TransferPostShipment.Run(TransHeader);
                            TransferPostReceipt.Run(TransHeader);
                        end;
                    InvtSetup."Direct Transfer Posting"::"Direct Transfer":
                        TransferOrderPostTransfer.Run(TransHeader);
                end
            else begin
                if DefaultNumber = 0 then
                    DefaultNumber := 1;
                if ((UserSetupLrec.Get(UserId)) and (UserSetupLrec."Production User")) then begin
                    SelectionLvar := StrMenu(Text008, DefaultNumber);
                    //Message('%1', SelectionLvar);
                    case SelectionLvar of
                        0:
                            begin
                                IsHandled := true;
                                exit;
                            end;
                        1:
                            TransferPostReceipt.Run(TransHeader);
                    end;
                end else begin
                    SelectionLvar := StrMenu(Text009, DefaultNumber);
                    //Message('%1', SelectionLvar);
                    case SelectionLvar of
                        0:
                            begin
                                IsHandled := true;
                                exit;
                            end;
                        1:
                            TransferPostShipment.Run(TransHeader);
                        2:
                            TransferPostReceipt.Run(TransHeader);
                    end;
                end;

            end;
            IsHandled := true;
        end;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptHeaderInsert', '', false, false)]

    local procedure OnBeforePurchRcptHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WhseReceive: Boolean; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; WhseShip: Boolean)
    begin
        PurchRcptHeader."Vendor Invoice No." := PurchaseHeader."Vendor Invoice No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Attachment Mgmt", 'OnBeforeCopyAttachmentsForPostedDocsLines', '', false, false)]
    local procedure OnBeforeCopyAttachmentsForPostedDocsLines(var FromRecRef: RecordRef; var ToRecRef: RecordRef; var IsHandled: Boolean)
    var
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
        FromFieldRef: FieldRef;
        ToFieldRef: FieldRef;
        FromDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        FromNo: Code[20];
        ToNo: Code[20];
    //IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeCopyAttachmentsForPostedDocsLines(FromRecRef, ToRecRef, IsHandled);
        if IsHandled then
            exit;

        FromDocumentAttachment.SetRange("Table ID", FromRecRef.Number);

        FromFieldRef := FromRecRef.Field(1);
        FromDocumentType := FromFieldRef.Value();
        FromDocumentAttachment.SetRange("Document Type", FromDocumentType);

        FromFieldRef := FromRecRef.Field(3);
        FromNo := FromFieldRef.Value();
        FromDocumentAttachment.SetRange("No.", FromNo);

        // Find any attached docs for headers (sales / purch)
        if FromDocumentAttachment.FindSet() then
            repeat
                Clear(ToDocumentAttachment);
                ToDocumentAttachment.Init();
                ToDocumentAttachment.TransferFields(FromDocumentAttachment);
                ToDocumentAttachment.Validate("Table ID", ToRecRef.Number);

                ToFieldRef := ToRecRef.Field(3);
                ToNo := ToFieldRef.Value();
                ToDocumentAttachment.Validate("No.", ToNo);
                Clear(ToDocumentAttachment."Document Type");
                //OnCopyAttachmentsForPostedDocsOnBeforeToDocumentAttachmentInsert(FromDocumentAttachment, ToDocumentAttachment);
                ToDocumentAttachment.Insert;
            //OnCopyAttachmentsForPostedDocsOnAfterToDocumentAttachmentInsert(FromDocumentAttachment, ToDocumentAttachment);
            until FromDocumentAttachment.Next() = 0;
        IsHandled := true;
        //CopyAttachmentsForPostedDocsLines(FromRecRef, ToRecRef);
    end;

    [EventSubscriber(ObjectType::Page, page::"Purchase Enquiry", 'OnLookUpNoSeries', '', false, false)]
    procedure OnLookUpNoSeries(Var PurchaseEnquiry: Record "Purchase Header"; var NoSeriesPar: Code[20])
    var
        PurchaseSetup: Record "Purchases & Payables Setup";
        //Noseries: Record "No. Series";
        NoSeries: Record "No. Series";
        NoSeriesRelationship: Record "No. Series Relationship";
    begin
        PurchaseSetup.GET;
        PurchaseSetup.TestField(PurchaseSetup."Quote Nos.");
        NoSeries.Reset();
        NoSeriesRelationship.SetRange(Code, PurchaseSetup."Quote Nos.");
        NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", PurchaseEnquiry."Shortcut Dimension 1 Code");
        if NoSeriesRelationship.FindSet() then
            repeat
                NoSeries.Code := NoSeriesRelationship."Series Code";
                NoSeries.Mark := true;
            until NoSeriesRelationship.Next() = 0;
        if NoSeries.Get(PurchaseSetup."Quote Nos.") then
            if Noseries."Shortcut Dimension 1 Code_B2B" = PurchaseEnquiry."Shortcut Dimension 1 Code" then
                NoSeries.Mark := true;
        NoSeries.MarkedOnly := true;
        if PAGE.RunModal(0, NoSeries) = ACTION::LookupOK then begin
            //Noseries.SETRANGE(Code, PurchaseSetup."Quote Nos.");
            //IF PAGE.RUNMODAL(458, Noseries) = ACTION::LookupOK THEN
            NoSeriesPar := Noseries.Code;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetGLBalAccount', '', false, false)]
    local procedure OnAfterAccountNoOnValidateGetGLBalAccount(var GenJournalLine: Record "Gen. Journal Line"; var GLAccount: Record "G/L Account"; CallingFieldNo: Integer)
    begin
        GenJournalLine."Bal. Account Description" := GLAccount.Name;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetCustomerBalAccount', '', false, false)]

    local procedure OnAfterAccountNoOnValidateGetCustomerBalAccount(var GenJournalLine: Record "Gen. Journal Line"; var Customer: Record Customer; CallingFieldNo: Integer)
    begin
        GenJournalLine."Bal. Account Description" := Customer.Name;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetVendorBalAccount', '', false, false)]
    local procedure OnAfterAccountNoOnValidateGetVendorBalAccount(var GenJournalLine: Record "Gen. Journal Line"; var Vendor: Record Vendor; CallingFieldNo: Integer)
    begin
        GenJournalLine."Bal. Account Description" := Vendor.Name;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetEmployeeBalAccount', '', false, false)]
    local procedure OnAfterAccountNoOnValidateGetEmployeeBalAccount(var GenJournalLine: Record "Gen. Journal Line"; var Employee: Record Employee; CallingFieldNo: Integer)
    begin
        GenJournalLine."Bal. Account Description" := Employee."First Name";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetBankBalAccount', '', false, false)]
    local procedure OnAfterAccountNoOnValidateGetBankBalAccount(var GenJournalLine: Record "Gen. Journal Line"; var BankAccount: Record "Bank Account"; CallingFieldNo: Integer)
    begin
        GenJournalLine."Bal. Account Description" := BankAccount.Name;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetFABalAccount', '', false, false)]
    local procedure OnAfterAccountNoOnValidateGetFABalAccount(var GenJournalLine: Record "Gen. Journal Line"; var FixedAsset: Record "Fixed Asset")
    begin
        GenJournalLine."Bal. Account Description" := FixedAsset.Description;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterAccountNoOnValidateGetICPartnerBalAccount', '', false, false)]
    local procedure OnAfterAccountNoOnValidateGetICPartnerBalAccount(var GenJournalLine: Record "Gen. Journal Line"; var ICPartner: Record "IC Partner")
    begin
        GenJournalLine."Bal. Account Description" := ICPartner.Name;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnAfterStorePurchDocument', '', false, false)]

    local procedure OnAfterStorePurchDocument(var PurchaseHeader: Record "Purchase Header"; var PurchaseHeaderArchive: Record "Purchase Header Archive")
    var
        PaymentTermsOrder: Record "Payment Terms And Conditions";
        PaymentTermsArchive: Record "Payment Terms And Conditions";
    begin
        PaymentTermsOrder.Reset();
        PaymentTermsOrder.SetRange(DocumentType, PaymentTermsOrder.DocumentType::Order);
        PaymentTermsOrder.SetRange("Document No.", PurchaseHeader."No.");
        PaymentTermsOrder.SetRange("Doc. No. Occurrence", 0);
        PaymentTermsOrder.SetRange("Version No.", 0);
        if PaymentTermsOrder.FindSet() then
            repeat
                PaymentTermsArchive.Init();
                PaymentTermsArchive.DocumentType := PaymentTermsArchive.DocumentType::Order;
                PaymentTermsArchive."Document No." := PurchaseHeaderArchive."No.";
                PaymentTermsArchive.LineNo := PaymentTermsOrder.LineNo;
                PaymentTermsArchive.Code := PaymentTermsOrder.Code;
                PaymentTermsArchive.Description := PaymentTermsOrder.Description;
                PaymentTermsArchive."Doc. No. Occurrence" := PurchaseHeaderArchive."Doc. No. Occurrence";
                PaymentTermsArchive."Version No." := PurchaseHeaderArchive."Version No.";
                PaymentTermsArchive.Sequence := PaymentTermsOrder.Sequence;
                PaymentTermsArchive.Insert();
            until PaymentTermsOrder.Next() = 0;
    end;
    /*local procedure OnCreateProdOrderOnBeforeProdOrderInsert(var ProductionOrder: Record "Production Order"; SalesLine: Record "Sales Line")
    begin
    end;*/
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterCreateItemJnlLine', '', false, false)]

    local procedure OnAfterCreateItemJnlLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferShipmentHeader: Record "Transfer Shipment Header"; TransferShipmentLine: Record "Transfer Shipment Line")
    begin
        ItemJournalLine."Production Order No." := TransferShipmentHeader."Production Order No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforePostItemJournalLine', '', false, false)]
    local procedure OnBeforePostItemJournalLine(var ItemJournalLine: Record "Item Journal Line"; TransferLine: Record "Transfer Line"; TransferReceiptHeader: Record "Transfer Receipt Header"; TransferReceiptLine: Record "Transfer Receipt Line"; CommitIsSuppressed: Boolean; TransLine: Record "Transfer Line"; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header")
    begin
        ItemJournalLine."Production Order No." := TransferReceiptHeader."Production Order No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterApplyItemLedgEntrySetFilters', '', false, false)]
    local procedure ApplyFiltersProjectCode(var ItemLedgerEntry2: Record "Item Ledger Entry"; ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin

        if (ItemJournalLine."Shortcut Dimension 2 Code" <> '') then
            if (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Consumption) or
               (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer) or
                 (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt.") then
                ItemLedgerEntry2.Setrange("Global Dimension 2 Code", ItemJournalLine."Shortcut Dimension 2 Code");

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnRetrieveLookupDataOnBeforeTransferToTempRec', '', false, false)]
    local procedure TrackingApplyFilter(var TempTrackingSpecification: Record "Tracking Specification"; var ItemLedgerEntry: Record "Item Ledger Entry")
    Var
        ProductionOrder: Record "Production Order";
        ItemJnlLine: REcord "Item Journal Line";
        TransferHeader: Record "Transfer Header";
    begin

        if (TempTrackingSpecification."Source ID" <> '') then begin //and (TempTrackingSpecification."Source Type" = Database::"Prod. Order Line") then begin

            //message('%1', TempTrackingSpecification."Source Type");
            case TempTrackingSpecification."Source Type" of
                83:
                    Begin
                        ItemJnlLine.Reset;
                        ItemJnlLine.setrange("Journal Template Name", TempTrackingSpecification."Source ID");
                        ItemJnlLine.Setrange("Journal Batch Name", TempTrackingSpecification."Source Batch Name");
                        ItemJnlLine.Setrange("Line No.", TempTrackingSpecification."Source Ref. No.");
                        if ItemJnlLine.FindFirst() then begin
                            if ItemJnlLine."Order No." <> '' then begin
                                ProductionOrder.Reset;
                                ProductionOrder.Setrange("No.", ItemJnlLine."Order No.");
                                if ProductionOrder.findfirst then
                                    if ProductionOrder."Shortcut Dimension 2 Code" <> '' then
                                        ItemLedgerEntry.Setrange("Global Dimension 2 Code", ProductionOrder."Shortcut Dimension 2 Code");
                            end else begin

                                if ItemJnlLine."Shortcut Dimension 2 Code" <> '' then
                                    ItemLedgerEntry.Setrange("Global Dimension 2 Code", ItemJnlLine."Shortcut Dimension 2 Code");


                            end;

                        end;
                    end;

                5741:
                    Begin
                        TransferHeader.Reset;
                        TransferHeader.Setrange("No.", TempTrackingSpecification."Source ID");
                        if TransferHeader.FindFirst() then begin
                            if TransferHeader."Shortcut Dimension 2 Code" <> '' then
                                ItemLedgerEntry.Setrange("Global Dimension 2 Code", TransferHeader."Shortcut Dimension 2 Code");

                        end;
                    end;

            end;

        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnSelectItemEntryOnBeforeOpenPage', '', false, false)]
    local procedure AppliestoEntryLookupProject(ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry")
    begin

        if ItemJournalLine."Shortcut Dimension 2 Code" <> '' then
            ItemLedgerEntry.SetRange("Global Dimension 2 Code", ItemJournalLine."Shortcut Dimension 2 Code");



    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", 'OnAfterSetTrackingFilterFromSpec', '', false, false)]
    local procedure AppliestoEntryLookupProjectTracking(var ItemLedgerEntry: Record "Item Ledger Entry"; TrackingSpecification: Record "Tracking Specification")
    var
        ProductionOrder: Record "Production Order";
        ItemJnlLine: REcord "Item Journal Line";
        TransferHeader: Record "Transfer Header";
    begin

        if (TrackingSpecification."Source ID" <> '') then begin


            case TrackingSpecification."Source Type" of
                83:
                    Begin
                        ItemJnlLine.Reset;
                        ItemJnlLine.setrange("Journal Template Name", TrackingSpecification."Source ID");
                        ItemJnlLine.Setrange("Journal Batch Name", TrackingSpecification."Source Batch Name");
                        ItemJnlLine.Setrange("Line No.", TrackingSpecification."Source Ref. No.");
                        if ItemJnlLine.FindFirst() then begin
                            if ItemJnlLine."Order No." <> '' then begin
                                ProductionOrder.Reset;
                                ProductionOrder.Setrange("No.", ItemJnlLine."Order No.");
                                if ProductionOrder.findfirst then
                                    if ProductionOrder."Shortcut Dimension 2 Code" <> '' then
                                        ItemLedgerEntry.Setrange("Global Dimension 2 Code", ProductionOrder."Shortcut Dimension 2 Code");
                            end else begin

                                if ItemJnlLine."Shortcut Dimension 2 Code" <> '' then
                                    ItemLedgerEntry.Setrange("Global Dimension 2 Code", ItemJnlLine."Shortcut Dimension 2 Code");


                            end;

                        end;
                    end;

                5741:
                    Begin
                        TransferHeader.Reset;
                        TransferHeader.Setrange("No.", TrackingSpecification."Source ID");
                        if TransferHeader.FindFirst() then begin
                            if TransferHeader."Shortcut Dimension 2 Code" <> '' then
                                ItemLedgerEntry.Setrange("Global Dimension 2 Code", TransferHeader."Shortcut Dimension 2 Code");

                        end;
                    end;

            end;

        end;


    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]

    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    var
        ItemLedgerEntryLvar: Record "Item Ledger Entry";
    begin
        if (ItemLedgerEntry."Entry Type" <> ItemLedgerEntry."Entry Type"::Purchase) or (ItemLedgerEntry."Document Type" <> ItemLedgerEntry."Document Type"::"Purchase Receipt") then begin
            if (ItemLedgerEntry."Entry Type" <> ItemLedgerEntry."Entry Type"::Sale) or (ItemLedgerEntry."Lot No." = '') then begin
                ItemLedgerEntryLvar.Reset();
                ItemLedgerEntryLvar.SetFilter("Entry Type", '%1|%2', ItemLedgerEntryLvar."Entry Type"::Purchase, ItemLedgerEntryLvar."Entry Type"::"Positive Adjmt.");
                //ItemLedgerEntryLvar.SetRange("Document Type", ItemLedgerEntryLvar."Document Type"::"Purchase Receipt");
                ItemLedgerEntryLvar.SetRange("Item No.", ItemLedgerEntry."Item No.");
                ItemLedgerEntryLvar.SetRange("Lot No.", ItemLedgerEntry."Lot No.");
                //ite
                if ItemLedgerEntryLvar.FindFirst() then begin
                    ItemLedgerEntry."Vendor Lot No_B2B" := ItemLedgerEntryLvar."Vendor Lot No_B2B";
                end;
            end;
        end;
    end;

    /*[EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Get Receipt", 'OnAfterInsertLines', '', false, false)]
    local procedure OnAfterInsertLines_B2B(var PurchHeader: Record "Purchase Header")
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", PurchHeader."Document Type");
        PurchLine.SetRange("Document No.", PurchHeader."No.");
        PurchLine.SetRange("Service Line B2B", true);
        if PurchLine.FindFirst() then begin
            PurchHeader."Service B2B" := true;
            PurchHeader.Modify();
        end;
    end;*/
    [EventSubscriber(ObjectType::Table, Database::"Employee Ledger Entry", 'OnAfterCopyEmployeeLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure OnAfterCopyEmployeeLedgerEntryFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var EmployeeLedgerEntry: Record "Employee Ledger Entry")
    var
        EmployeeGrec: Record Employee;
    begin
        if EmployeeGrec.Get(GenJournalLine."Account No.") then;
        EmployeeLedgerEntry."P.A.N.No." := EmployeeGrec."P.A.N.No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldEmplLedgEntry', '', false, false)]
    local procedure OnBeforeInsertDtldEmplLedgEntry(DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; GenJournalLine: Record "Gen. Journal Line"; var DtldEmplLedgEntry: Record "Detailed Employee Ledger Entry")
    var
        EmployeeGrec: Record Employee;
    begin
        if EmployeeGrec.Get(GenJournalLine."Account No.") then;
        DtldEmplLedgEntry."P.A.N.No." := EmployeeGrec."P.A.N.No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnAfterInsertLines', '', false, false)]
    local procedure OnAfterInsertLines(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    var
        SalesOrderHeader: Record "Sales Header";
        SalesShptLine: Record "Sales Shipment Line";
    begin
        SalesShptLine.Reset();
        SalesShptLine.SetRange("Document No.", SalesLine."Shipment No.");
        SalesShptLine.SetRange("Line No.", SalesLine."Shipment Line No.");
        if SalesShptLine.FindFirst() then begin
            SalesOrderHeader.Reset();
            SalesOrderHeader.SetRange("Document Type", SalesOrderHeader."Document Type"::Order);
            SalesOrderHeader.SetRange("No.", SalesShptLine."Order No.");
            if SalesOrderHeader.FindFirst() then begin
                SalesHeader."Posting No." := SalesOrderHeader."Posting No.";
                SalesHeader."Payment Terms Code" := SalesOrderHeader."Payment Terms Code";
                SalesHeader.Modify();
            end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnAfterInsertLines', '', false, false)]
    local procedure OnAfterInsertLinesPurch(var PurchHeader: Record "Purchase Header")
    var
        PurchInvHeader: Record "Purchase Header";
        PurchOrderHeader: Record "Purchase Header";
        PurchInvLine: Record "Purchase Line";
        PurchRcptLine: Record "Purch. Rcpt. Line";
    begin
        PurchInvLine.Reset();
        PurchInvLine.SetRange("Document Type", PurchInvLine."Document Type"::Invoice);
        PurchInvLine.SetRange("Document No.", PurchHeader."No.");
        PurchInvLine.SetFilter("No.", '<>%1', '');
        if PurchInvLine.FindFirst() then begin
            PurchRcptLine.Reset();
            PurchRcptLine.SetRange("Document No.", PurchInvLine."Receipt No.");
            PurchRcptLine.SetRange("Line No.", PurchInvLine."Receipt Line No.");
            if PurchRcptLine.FindFirst() then begin
                PurchOrderHeader.Reset();
                PurchOrderHeader.SetRange("Document Type", PurchOrderHeader."Document Type"::Order);
                PurchOrderHeader.SetRange("No.", PurchRcptLine."Order No.");
                if PurchOrderHeader.FindFirst() then begin
                    PurchHeader.Validate("Payment Terms Code", PurchOrderHeader."Payment Terms Code");
                    PurchHeader.Modify();
                end;
            end;
        end;
    end;
}
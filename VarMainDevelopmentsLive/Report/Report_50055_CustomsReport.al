report 50055 "Customs Report New "
{

    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\CustomsReportMonthlyNew.rdl';
    Caption = 'Customs Report Monthly ANNEXURE-I';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Item No.");

            column(PCNo_Date_Cap; PCNo_Date_Cap)
            { }
            column(PCNo_Cap; PCNo_Cap)
            { }
            column(Bill_of_Entry_Cap; Bill_of_Entry_Cap)
            { }
            column(Bill_of_Entry_Dt_Cap; Bill_of_Entry_Dt_Cap)
            { }
            column(ANNEXURE; ANNEXURE)
            { }
            column(Material_Consumption_for_the_Month; Material_Consumption_for_the_Month)
            { }
            column(Description_Cap; Description_Cap)
            { }
            column(UOM_Cap; UOM_Cap)
            { }
            column(Lot_No_; "Lot No.")
            {

            }
            column(Entry_No_; "Entry No.")
            {

            }

            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }
            column(Balance_Qty_in_Store; Balance_Qty_in_Store)
            { }
            column(closingBalance; closingBalance)
            { }
            column(ClosingBal_Cap; ClosingBal_Cap)
            { }
            column(StartDate; StartDate)
            { }
            column(EndDate; format(EndDate, 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(PcNo; "Pc No.")
            { }
            column(PcDate; format("Pc Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(BillofEntryNo; "Bill of Entry No.")
            { }
            column(BillofEntryDate; format("Bill of Entry Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(clearedQty; clearedQty)
            { }
            column(ReceivedQty; ReceivedQty)
            { }
            column(Document_No_; "Document No.")
            { }
            /* column(ItemNo; ItemNo)
             { }*/
            column(UOM; UOM)
            {

            }
            column(TotalOpeningItem; TotalOpeningItem)
            {

            }
            column(OpeningstockItem; OpeningstockItem)
            {

            }
            column(CustomDutyItem; CustomDutyItem)
            {

            }
            column(OpeningConsumptionITem; OpeningConsumptionITem)
            {

            }

            column(InvoicedQty; InvoicedQty)
            { }
            column(RemainingQty; RemainingQty)
            { }
            column(Description; Item.Description)
            { }
            column(ItemNo; Item."No.")
            {
            }
            column(DutyInvolved_B2B; DutyInvolved_B2B)
            { }
            column(DirectUnitCost; DirectUnitCost)
            { }
            column(TotalAmountINR; TotalAmountINR)
            { }
            column(InwardStock; InwardStock)
            { }
            column(Openingstock; Openingstock)
            { }
            column(OutwardStock; OutwardStock)
            { }
            column(ClosingStock; ClosingStock)
            { }
            column(InvoiceValue; InvoiceValue)
            { }
            column(InvoiceValueINR; InvoiceValueINR)
            { }
            column(Remarks; Remarks)
            { }
            column(Item_No_; "Item No.")
            { }
            column(SalesQty; SalesQty)
            { }
            column(PrevInwardStock; PrevInwardStock)
            { }
            column(PrevOutwardStock; PrevOutwardStock)
            { }
            column(PrevOutwardAmount; PrevOutwardAmount)
            { }
            column(BalanceStock; BalanceStock)
            { }
            column(OutwardAmount; OutwardAmount)
            { }
            column(NewStartDate; format(NewStartDate, 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(OpeningBalnc; OpeningBalnc)
            {

            }
            column(OpeningBalncConsumption; OpeningBalncConsumption)
            { }
            column(TOtalOPnBalnc; TOtalOPnBalnc) { }
            column(OpeningConsumption; OpeningConsumption) { }
            column(NextMntOBQty; NextMntOBQty) { }
            column(NextMntRecQty; NextMntRecQty) { }
            column(NextMntClearQty; NextMntClearQty) { }
            column(BalanceQty; BalanceQty) { }
            column(TotalOpeningValue; TotalOpeningValue) { }
            column(TotalNxtMntValue; TotalNxtMntValue) { }
            column(CustomDuty; CustomDuty) { }
            column(CustomDuty1; CustomDuty1) { }
            column(BalanceQty1; BalanceQty1) { }
            //column(OBCurrCap; 'Received Qty Up to ' + NxtMonthName + ' ' + Format(Date2DMY(StartDate, 3) - 1)) { }PreviousMonthVar
            column(OBCurrCap; 'Received Qty Up to ' + NxtMonthName + ' ' + Format(Date2DMY(PreviousMonthVar, 3))) { }
            column(ClearedCurrCap; 'Qty Cleared Till ' + NxtMonthName + ' ' + Format(Date2DMY(PreviousMonthVar, 3))) { }
            column(OBNextCap; 'OB ' + CurrentMntName + ' ' + Format(Date2DMY(StartDate, 3))) { }
            column(NxtMntPurchCap; CurrentMntName + ' ' + Format(Date2DMY(EndDate, 3)) + ' Purchase ') { }
            column(ClearedNxtCap; 'Qty Cleared in ' + CurrentMntName + ' ' + Format(Date2DMY(EndDate, 3))) { }
            column(TotalClearedCurrCap; 'Total Amount in INR for Cleared Qty upto ' + NxtMonthName + ' ' + Format(Date2DMY(StartDate, 3))) { }
            column(TotalClearedNxtCap; 'Total Amount in INR for Cleared Qty upto ' + CurrentMntName + ' ' + Format(Date2DMY(EndDate, 3))) { }
            column(Title; 'Material Consumption for the month of ' + CurrentMntName) { }

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";
                PurchRectLine: Record "Purch. Rcpt. Line";
                PurchInvLine: Record "Purch. Inv. Line";
                PurchInvHead: Record "Purch. Inv. Header";
                DateRec: Record Date;
                NxtMntStart: Date;
                NxtMntEnd: Date;
                PrevMnthEndDate: Date;
            begin

                NxtMntStart := CalcDate('-1M', StartDate);
                if (PcNoVar <> "Item Ledger Entry"."Pc No.") or (PcDateVar <> "Item Ledger Entry"."Pc Date") or (BOEVar <> "Item Ledger Entry"."Bill of Entry No.") or (BOEDate <> "Item Ledger Entry"."Bill of Entry Date") and (ItemVar <> "Item Ledger Entry"."Item No.") or (LotGvar <> "Item Ledger Entry"."Lot No.") then begin
                    Clear(Openingstock);
                    Clear(OpeningConsumption);
                    Clear(NextMntOBQty);
                    Clear(NextMntRecQty);
                    Clear(NextMntClearQty);
                    Clear(BalanceQty);
                    Clear(TotalOpeningValue);
                    Clear(TotalNxtMntValue);
                    Clear(CustomDuty);
                    Clear(UOM);
                    Clear(CustomDutyItem);
                    Clear(OpeningConsumptionITem);
                    Clear(OpeningstockItem);
                    clear(TotalOpeningItem);
                    PcNoVar := "Item Ledger Entry"."Pc No.";
                    PcDateVar := "Item Ledger Entry"."Pc Date";
                    BOEVar := "Item Ledger Entry"."Bill of Entry No.";
                    BOEDate := "Item Ledger Entry"."Bill of Entry Date";
                    ItemVar := "Item Ledger Entry"."Item No.";
                    LotGvar := "Item Ledger Entry"."Lot No.";
                    Item.Get("Item Ledger Entry"."Item No.");
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ItemLedgerEntry.SetFilter("Posting Date", '%1..%2', NxtMntStart, CalcDate('CM', NewStartDate));
                    ItemLedgerEntry.SetRange("Pc No.", "Item Ledger Entry"."Pc No.");
                    ItemLedgerEntry.SetRange("Bill of Entry No.", "Item Ledger Entry"."Bill of Entry No.");
                    ItemLedgerEntry.SetRange("Pc Date", "Item Ledger Entry"."Pc Date");
                    ItemLedgerEntry.SetRange("Bill of Entry Date", "Item Ledger Entry"."Bill of Entry Date");
                    ItemLedgerEntry.SetRange("Lot No.", "Item Ledger Entry"."Lot No.");
                    ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                    ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
                    if ItemLedgerEntry.FindSet() then begin
                        ItemLedgerEntry.CalcSums(Quantity);
                        Openingstock := ItemLedgerEntry.Quantity;
                    end;

                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ItemLedgerEntry.SetRange("Lot No.", "Item Ledger Entry"."Lot No.");
                    ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                    ItemLedgerEntry.SetFilter("Posting Date", '..%1',  CalcDate('CM', NewStartDate));
                    if ItemLedgerEntry.FindSet() then begin
                        repeat

                            OpeningConsumption += ABS(ItemLedgerEntry.Quantity);

                        until ItemLedgerEntry.Next() = 0;
                    end;
                    /*    ItemLedgerEntry.Reset();
                        ItemLedgerEntry.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                        ItemLedgerEntry.SetRange("Pc No.", "Item Ledger Entry"."Pc No.");
                        ItemLedgerEntry.SetRange("Bill of Entry No.", "Item Ledger Entry"."Bill of Entry No.");
                        ItemLedgerEntry.SetRange("Pc Date", "Item Ledger Entry"."Pc Date");
                        ItemLedgerEntry.SetRange("Bill of Entry Date", "Item Ledger Entry"."Bill of Entry Date");
                        ItemLedgerEntry.SetRange("Lot No.", "Item Ledger Entry"."Lot No.");
                        ItemLedgerEntry.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                        if ItemLedgerEntry.FindSet() then begin
                            ItemLedgerEntry.CalcSums(Quantity);
                            NextMntOBQty := ItemLedgerEntry.Quantity;
                        end;*/



                    DateRec.Reset();
                    DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
                    DateRec.SetRange("Period No.", Date2DMY(StartDate, 2));
                    if DateRec.FindFirst() then
                        CurrentMntName := DateRec."Period Name";
                    DateRec.Reset();
                    DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
                    DateRec.SetRange("Period No.", Date2DMY(NxtMntStart, 2));
                    if DateRec.FindFirst() then
                        NxtMonthName := DateRec."Period Name";
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ItemLedgerEntry.SetRange("Pc No.", "Item Ledger Entry"."Pc No.");
                    ItemLedgerEntry.SetRange("Bill of Entry No.", "Item Ledger Entry"."Bill of Entry No.");
                    ItemLedgerEntry.SetRange("Pc Date", "Item Ledger Entry"."Pc Date");
                    ItemLedgerEntry.SetRange("Bill of Entry Date", "Item Ledger Entry"."Bill of Entry Date");
                    ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
                    if ItemLedgerEntry.FindSet() then begin
                        ItemLedgerEntry.CalcSums(Quantity);
                        NextMntRecQty := ItemLedgerEntry.Quantity;
                    end;
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    //ItemLedgerEntry.SetRange("Pc No.", "Item Ledger Entry"."Pc No.");
                    //                   ItemLedgerEntry.SetRange("Bill of Entry No.", "Item Ledger Entry"."Bill of Entry No.");
                    //                ItemLedgerEntry.SetRange("Pc Date", "Item Ledger Entry"."Pc Date");
                    //              ItemLedgerEntry.SetRange("Bill of Entry Date", "Item Ledger Entry"."Bill of Entry Date");
                    ItemLedgerEntry.SetRange("Lot No.", "Item Ledger Entry"."Lot No.");
                    ItemLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                    if ItemLedgerEntry.FindSet() then begin
                        repeat
                            ItemLedgerEntry.CalcFields("Cost Amount (Actual)", "Cost Amount (Expected)");
                            TotalNxtMntValue += (Abs(ItemLedgerEntry."Cost Amount (Actual)" + Abs(ItemLedgerEntry."Cost Amount (Expected)")));


                            NextMntClearQty += abs(ItemLedgerEntry.Quantity);
                        until ItemLedgerEntry.Next() = 0;
                    end;
                    //BalanceQty := (NextMntOBQty + NextMntRecQty) - (NextMntClearQty + OpeningConsumption);
                    BalanceQty := (Openingstock + NextMntRecQty) - (OpeningConsumption + NextMntClearQty);
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ItemLedgerEntry.SetFilter("Posting Date", '%1<', StartDate);
                    if ItemLedgerEntry.FindSet() then begin
                        ItemLedgerEntry.CalcSums(Quantity);
                        OpeningBalnc := ItemLedgerEntry.Quantity;
                    end;
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                    ItemLedgerEntry.SetFilter("Posting Date", '%1<', StartDate);
                    if ItemLedgerEntry.FindSet() then begin
                        OpeningBalncConsumption := ItemLedgerEntry.Quantity;
                    end;
                    FirsLineGVar := false;
                    PurchRectLine.Reset();
                    PurchRectLine.SetRange(Type, PurchRectLine.Type::Item); //TotalNxtMntValue := NextMntRecQty * PurchRectLine."Unit Cost";
                    //  IF (OpeningConsumption <> 0) AND (Openingstock <> 0) then
                    PurchRectLine.SetRange("No.", "Item Ledger Entry"."Item No.");
                    PurchRectLine.SetRange("Document No.", ItemLedgerEntry."Document No.");
                    PurchRectLine.SetRange("Line No.", "Item Ledger Entry"."Document Line No.");
                    if PurchRectLine.FindFirst() then;
                    TotalOpeningValue := Openingstock * PurchRectLine."Unit Cost";

                    //    TotalNxtMntValue := (TOtalOPnBalnc / (Openingstock * OpeningConsumption));
                    /*   PurchInvLine.Reset();
                       PurchInvLine.SetRange("Receipt No.", PurchRectLine."Document No.");
                       PurchInvLine.SetRange("Receipt Line No.", PurchRectLine."Line No.");
                         if PurchInvLine.FindFirst() then begin
                             CustomDuty := PurchInvLine."Custom Duty Amount";
                             PurchInvHead.Get(PurchInvLine."Document No.");
                             if PurchInvHead."Currency Factor" <> 0 then
                                 CustomDuty := Round(CustomDuty / PurchInvHead."Currency Factor", 0.01);
                             //CustomDuty1 += CustomDuty;
                         end;*/

                    ValueEntry.Reset();
                    ValueEntry.SetRange("Item Ledger Entry No.", "Entry No.");
                    ValueEntry.SetRange(Adjustment, false);
                    ValueEntry.SetRange("Document Type", ValueEntry."Document Type"::"Purchase Invoice");
                    if ValueEntry.FindFirst() then begin
                        TOtalOPnBalnc := ValueEntry."Cost per Unit" * OpeningConsumption;
                    end;
                    CustomDuty := Round((TOtalOPnBalnc * ((30.98 / 100))), 0.01);

                    //IF (OpeningConsumption <> 0) AND (Openingstock <> 0) then
                    // TotalNxtMntValue := (TOtalOPnBalnc / (Openingstock * OpeningConsumption));
                    PrevMnthEndDate := NewStartDate - 1;
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ItemLedgerEntry.SetFilter("Posting Date", '%1..%2', 0D, PrevMnthEndDate);
                    ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                    ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
                    if ItemLedgerEntry.FindSet() then begin
                        repeat
                            OpeningstockItem += ItemLedgerEntry.Quantity;
                            PurchRectLine.Reset();
                            PurchRectLine.SetRange(Type, PurchRectLine.Type::Item);
                            PurchRectLine.SetRange("No.", "Item Ledger Entry"."Item No.");
                            PurchRectLine.SetRange("Document No.", ItemLedgerEntry."Document No.");
                            PurchRectLine.SetRange("Line No.", "Item Ledger Entry"."Document Line No.");
                            if PurchRectLine.FindFirst() then
                                TotalOpeningItem += (ItemLedgerEntry.Quantity * PurchRectLine."Unit Cost");
                        /* PurchInvLine.Reset();
                         PurchInvLine.SetRange("Receipt No.", PurchRectLine."Document No.");
                         PurchInvLine.SetRange("Receipt Line No.", PurchRectLine."Line No.");
                         if PurchInvLine.FindFirst() then begin
                             PurchInvHead.Get(PurchInvLine."Document No.");
                             if PurchInvHead."Currency Factor" <> 0 then
                                 CustomDutyItem += Round(PurchInvLine."Custom Duty Amount" / PurchInvHead."Currency Factor", 0.01)
                             else
                                 CustomDutyItem += PurchInvLine."Custom Duty Amount";
                             //CustomDuty1 += CustomDuty;
                         end;*/

                        until ItemLedgerEntry.Next() = 0;
                    end;
                    CustomDutyItem := Round((TotalOpeningItem * ((30.98 / 100))), 0.01);
                    ItemLedgerEntry.Reset();
                    ItemLedgerEntry.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                    ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Consumption);
                    ItemLedgerEntry.SetFilter("Posting Date", '..%1', PrevMnthEndDate);
                    if ItemLedgerEntry.FindSet() then begin
                        ItemLedgerEntry.CalcSums(Quantity);
                        OpeningConsumptionITem := ABS(ItemLedgerEntry.Quantity);
                    end;
                    PreivousMonthIntVar := Date2DMY(StartDate, 2);
                    if PreivousMonthIntVar = 1 then
                        PreviousMonthVar := CalcDate('-1y', StartDate)
                    else
                        PreviousMonthVar := StartDate;

                    if (Openingstock = 0) and (OpeningConsumption = 0) and (NextMntOBQty = 0) and (NextMntRecQty = 0) and (NextMntClearQty = 0) and (BalanceQty = 0)
                     and (TotalOpeningValue = 0) and (TotalNxtMntValue = 0) and (CustomDuty = 0) then
                        currreport.Skip();
                end else
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            begin
                FirsLineGVar := true;
                //  Clear(BalanceQty1);
                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('Start and End dates are mandatory.');
                NewStartDate := CalcDate('-1D', StartDate);
                NxtMntStart := CalcDate('-1M', StartDate);
                SetCurrentKey("Pc No.", "Pc Date", "Bill of Entry No.", "Bill of Entry Date", "Item No.", "Lot No.");
                SETFILTER("Posting Date", '%1..%2', NxtMntStart, EndDate);
                SetFilter("Pc No.", '<>%1', '');
                SetFilter("Pc Date", '<>%1', 0D);
                SetFilter("Bill of Entry No.", '<>%1', '');
                SetFilter("Bill of Entry Date", '<>%1', 0D);
                SetRange("Entry Type", "Entry Type"::Purchase);
                SetRange("Document Type", "Document Type"::"Purchase Receipt");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Date Filters")
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the StartDate field.';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Specifies the value of the EndDate field.';
                    }
                }
            }
        }
    }
    var
        ItemNoGvar: Text;
        SalesQty: Integer;
        SalesLineAmt: Decimal;
        InwardStock: Decimal;
        NewStartDate: Date;
        NxtMntStart: Date;
        PurchRecptLn: Record "Purch. Rcpt. Line";
        PurchRecptHdr: Record "Purch. Rcpt. Header";
        ReceivedQty: Decimal;
        clearedQty: Decimal;
        TotalAmountINR: Decimal;
        DirectUnitCost: Decimal;
        DutyInvolved_B2B: Decimal;
        InvoicedQty: Decimal;
        RemainingQty: Decimal;
        UOM: Code[20];
        StartDate: Date;
        EndDate: Date;
        closingBalance1: decimal;
        ClosingBal_Cap: label 'Closing Balance';
        ItemNo: Code[20];
        ANNEXURE: Label 'ANNEXURE-I';
        Material_Consumption_for_the_Month: Label 'Material Consumption for the Month';
        PCNo_Cap: Label 'PC. NO.';
        PCNo_Date_Cap: Label 'PC. Date';
        Bill_of_Entry_Cap: Label 'Bill of Entry No';
        Bill_of_Entry_Dt_Cap: Label 'Bill of Entry Dt';
        Description_Cap: Label 'Description';
        UOM_Cap: Label 'UOM';
        Balance_Qty_in_Store: Label 'Balance Qty in Store';
        Remarks: Label 'Remarks';
        FullQtyUtilisedCaptionLbl: Label 'Full Qty Utilised for Production';
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
        Openingstock: Decimal;
        OpeningConsumption: Decimal;
        NextMntOBQty: Decimal;
        NextMntRecQty: Decimal;
        NextMntClearQty: Decimal;
        BalanceQty: Decimal;
        TotalOpeningValue: Decimal;
        TotalNxtMntValue: Decimal;
        CustomDuty: Decimal;
        CustomDuty1: Decimal;
        OutwardStock: Decimal;
        ClosingStock: Decimal;
        InvoiceValueINR: Decimal;
        InvoiceValue: Decimal;
        DetailedGSTLedger: Record "Detailed GST Ledger Entry";
        GSTAmount: Decimal;
        ItemNoNew: Code[20];
        PrevInwardStock: Decimal;
        PrevOutwardStock: Decimal;
        PrevOutwardAmount: Decimal;
        OutwardAmount: Decimal;
        BalanceStock: Decimal;
        Item: Record Item;
        CurrentMntName: Text[20];
        NxtMonthName: Text[20];
        OpeningQty: Decimal;
        ClosingBalance: Decimal;
        ClosingBalance2: Decimal;
        BalanceQty1: Decimal;
        FirsLineGVar: Boolean;
        ItemLedgerGvar2: Record "Item Ledger Entry";
        PcNoVar: text;
        PcDateVar: Date;
        BOEVar: Text;
        BOEDate: Date;
        ItemVar: Text;
        OpeningBalnc: Decimal;
        OpeningBalncConsumption: Decimal;
        TOtalOPnBalnc: Decimal;
        PreviousMonthVar: Date;
        PreivousMonthIntVar: Integer;
        LotGvar: Text;
        OpeningstockItem: Decimal;
        OpeningConsumptionITem: Decimal;
        CustomDutyItem: Decimal;
        TotalOpeningItem: Decimal;

}
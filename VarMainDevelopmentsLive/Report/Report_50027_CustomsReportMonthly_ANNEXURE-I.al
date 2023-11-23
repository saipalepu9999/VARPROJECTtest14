report 50027 "Customs Report Monthly "
{

    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\CustomsReportMonthly.rdl';
    Caption = 'Customs Report Monthly_ANNEXURE-I_50027';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {

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
            column(UOM; UOM)
            { }
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
            column(ItemNo; ItemNo)
            { }
            column(InvoicedQty; InvoicedQty)
            { }
            column(RemainingQty; RemainingQty)
            { }
            column(Description; Item.Description)
            { }
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

            trigger OnAfterGetRecord()
            var
                ItemLedgerEntry: Record "Item Ledger Entry";

            begin
                Clear(Openingstock);
                Clear(InwardStock);
                Clear(OutwardStock);
                Clear(ClosingStock);
                Clear(InvoiceValue);
                Clear(InvoiceValueINR);
                Clear(PcNo);
                Clear(PCDate);
                Clear(BillofEntryNo);
                Clear(BillofEntryDate);
                Clear(PrevInwardStock);
                Clear(PrevOutwardStock);
                Clear(PrevOutwardAmount);

                if Item.Get("Item No.") then;

                //Prev Month>>
                if ItemNo <> "Item No." then begin
                    ItemNo := "Item No.";
                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                    ItemLedgerEntry.SETFILTER("Posting Date", '..%1', NewStartDate);
                    ItemLedgerEntry.SetFilter("Document Type", '%1|%2|%3|%4|%5', ItemLedgerEntry."Document Type"::"Purchase Invoice",
                                                                                 ItemLedgerEntry."Document Type"::"Purchase Receipt",
                                                                                 ItemLedgerEntry."Document Type"::"Sales Credit Memo",
                                                                                 ItemLedgerEntry."Document Type"::"Sales Return Receipt",
                                                                                 ItemLedgerEntry."Document Type"::"Transfer Receipt");
                    IF ItemLedgerEntry.FINDSET THEN begin
                        ItemLedgerEntry.CalcSums(Quantity);
                        PrevInwardStock := ItemLedgerEntry.Quantity;
                    end;

                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                    ItemLedgerEntry.SETFILTER("Posting Date", '..%1', NewStartDate);
                    ItemLedgerEntry.SetFilter("Entry Type", '%1|%2', ItemLedgerEntry."Entry Type"::"Positive Adjmt.",
                                                                     ItemLedgerEntry."Entry Type"::Output);
                    IF ItemLedgerEntry.FINDSET THEN begin
                        ItemLedgerEntry.CalcSums(Quantity);
                        PrevInwardStock += ItemLedgerEntry.Quantity;
                    end;

                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SetAutoCalcFields("Cost Amount (Actual)");
                    ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                    ItemLedgerEntry.SETFILTER("Posting Date", '..%1', NewStartDate);
                    ItemLedgerEntry.SetFilter("Document Type", '%1|%2|%3|%4|%5', ItemLedgerEntry."Document Type"::"Sales Invoice",
                                                                                 ItemLedgerEntry."Document Type"::"Sales Shipment",
                                                                                 ItemLedgerEntry."Document Type"::"Purchase Return Shipment",
                                                                                 ItemLedgerEntry."Document Type"::"Purchase Credit Memo",
                                                                                 ItemLedgerEntry."Document Type"::"Transfer Shipment");
                    IF ItemLedgerEntry.FINDSET THEN begin
                        repeat
                            PrevOutwardStock += ABS(ItemLedgerEntry.Quantity);
                            PrevOutwardAmount += Abs(ItemLedgerEntry."Cost Amount (Actual)");
                        until ItemLedgerEntry.Next() = 0;
                    end;

                    ItemLedgerEntry.RESET;
                    ItemLedgerEntry.SetAutoCalcFields("Cost Amount (Actual)");
                    ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                    ItemLedgerEntry.SETFILTER("Posting Date", '..%1', NewStartDate);
                    ItemLedgerEntry.SetFilter("Entry Type", '%1|%2', ItemLedgerEntry."Entry Type"::"Negative Adjmt.",
                                                                     ItemLedgerEntry."Entry Type"::Consumption);
                    IF ItemLedgerEntry.FINDSET THEN begin
                        repeat
                            PrevOutwardStock += ABS(ItemLedgerEntry.Quantity);
                            PrevOutwardAmount += Abs(ItemLedgerEntry."Cost Amount (Actual)");
                        until ItemLedgerEntry.Next() = 0;
                    end;

                    Openingstock := PrevInwardStock - PrevOutwardStock;
                    BalanceStock := Openingstock;
                end;
                //Prev Month<<

                //Current Month>>
                // ItemLedgerEntry.RESET;
                // ItemLedgerEntry.SETRANGE("Item No.", "Item No.");
                // ItemLedgerEntry.SETFILTER("Posting Date", '..%1', NewStartDate);
                // IF ItemLedgerEntry.FINDSET THEN begin
                //     ItemLedgerEntry.CalcSums(Quantity);
                //     Openingstock := ItemLedgerEntry.Quantity;
                // end;

                if "Document Type" IN ["Document Type"::"Purchase Invoice",
                                        "Document Type"::"Purchase Receipt",
                                        "Document Type"::"Sales Credit Memo",
                                        "Document Type"::"Sales Return Receipt",
                                        "Document Type"::"Transfer Receipt"] then
                    InwardStock := Quantity;

                if "Entry Type" IN ["Entry Type"::"Positive Adjmt.",
                                    "Entry Type"::Output] then
                    InwardStock := Quantity;

                If "Document Type" IN ["Document Type"::"Sales Invoice",
                                        "Document Type"::"Sales Shipment",
                                        "Document Type"::"Purchase Return Shipment",
                                        "Document Type"::"Purchase Credit Memo",
                                        "Document Type"::"Transfer Shipment"] then begin
                    CalcFields("Cost Amount (Actual)");
                    OutwardStock := ABS(Quantity);
                    OutwardAmount := ABS("Cost Amount (Actual)");
                end;

                if "Entry Type" IN ["Entry Type"::"Negative Adjmt.",
                                     "Entry Type"::Consumption] then begin
                    CalcFields("Cost Amount (Actual)");
                    OutwardStock := ABS(Quantity);
                    OutwardAmount := ABS("Cost Amount (Actual)");
                end;
                //Current Month<<
                BalanceStock := BalanceStock + InwardStock - OutwardStock;
            end;

            trigger OnPreDataItem()
            begin
                if (StartDate = 0D) or (EndDate = 0D) then
                    Error('Start and End dates are mandatory.');
                NewStartDate := CalcDate('-1D', StartDate);
                SetCurrentKey("Item No.", "Posting Date");
                SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
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

        SalesQty: Integer;
        SalesLineAmt: Decimal;
        InwardStock: Decimal;
        NewStartDate: Date;
        PurchRecptLn: Record "Purch. Rcpt. Line";
        PurchRecptHdr: Record "Purch. Rcpt. Header";
        ReceivedQty: Decimal;
        clearedQty: Decimal;
        TotalAmountINR: Decimal;
        DirectUnitCost: Decimal;
        DutyInvolved_B2B: Decimal;
        BillofEntryNo: Text[20];
        BillofEntryDate: Date;
        PcNo: Code[10];
        PcDate: Date;
        InvoicedQty: Decimal;
        RemainingQty: Decimal;
        UOM: Code[20];
        ItemLedgerEntry: Record "Item Ledger Entry";
        StartDate: Date;
        EndDate: Date;
        closingBalance: decimal;
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
}
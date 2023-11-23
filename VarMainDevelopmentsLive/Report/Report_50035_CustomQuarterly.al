report 50035 "Custom Quarterly Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Custom Quarterly Report - 50035';
    RDLCLayout = 'Report\Layouts\CustomsQuarterlyReturn2.rdl';
    DefaultLayout = RDLC;

    dataset
    {

        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Pc No." = filter(<> ''), "Bill of Entry No." = filter(<> ''), "Document Type" = Const("Purchase Receipt"));



            column(QuarterlyReturnCaptionLbl; QuarterlyReturnCaptionLbl)
            { }
            column(BillofEntryCaptionLbl; BillofEntryCaptionLbl)
            { }
            column(PCSINoCaptionLbl; PCSINoCaptionLbl)
            { }
            column(DescriptionCaptionLbl; DescriptionCaptionLbl)
            { }
            column(OpeningBalCaptionLbl; OpeningBalCaptionLbl)
            { }
            column(DetailsofGoodsCaptionLbl; DetailsofGoodsCaptionLbl)
            { }
            column(SpecifiedPurposeCaptionLbl; SpecifiedPurposeCaptionLbl)
            { }
            column(GoodsManufacturedCaptionLbl; GoodsManufacturedCaptionLbl)
            { }
            column(ValueofGoodsCaptionLbl; ValueofGoodsCaptionLbl)
            { }
            column(QuantityofGoodsCaptionLbl; QuantityofGoodsCaptionLbl)
            { }
            column(QuantityConsumedCaptionLbl; QuantityConsumedCaptionLbl)
            { }
            column(QuantityReexportedCaptionLbl; QuantityReexportedCaptionLbl)
            { }
            column(QuantityClearedCaptionLbl; QuantityClearedCaptionLbl)
            { }
            column(ClosingBalCaptionLbl; ClosingBalCaptionLbl)
            { }
            column(DescCaptionLbl; DescCaptionLbl)
            { }
            column(QuantityCaptionLbl; QuantityCaptionLbl)
            { }
            column(ValueCaptionLbl; ValueCaptionLbl)
            { }
            column(FormCaptionLbl; FormCaptionLbl)
            { }
            column(OneCaptionLbl; OneCaptionLbl)
            { }
            column(TwoCaptionLbl; TwoCaptionLbl)
            { }
            column(ThreeCaptionLbl; ThreeCaptionLbl)
            { }
            column(FourCaptionLbl; FourCaptionLbl)
            { }
            column(FiveCaptionLbl; FiveCaptionLbl)
            { }
            column(SixCaptionLbl; SixCaptionLbl)
            { }
            column(SevenCaptionLbl; SevenCaptionLbl)
            { }
            column(EightCaptionLbl; EightCaptionLbl)
            { }
            column(NineCaptionLbl; NineCaptionLbl)
            { }
            column(TenCaptionLbl; TenCaptionLbl)
            { }
            column(ElevenCaptionLbl; ElevenCaptionLbl)
            { }
            column(TwelveCaptionLbl; TwelveCaptionLbl)
            { }
            column(ThirteenCaptionLbl; ThirteenCaptionLbl)
            { }
            column(FourteenCaptionLbl; FourteenCaptionLbl)
            { }
            column(FifteenCaptionLbl; FifteenCaptionLbl)
            { }
            column(TotalCaptionLbl; TotalCaptionLbl)
            { }
            column(ForManufacturingCaptionLbl; ForManufacturingCaptionLbl)
            { }
            column(ThermalBatteriesCaptonLbl; ThermalBatteriesCaptonLbl)
            { }
            column(ReturnForQuarterCapLbl; ReturnForQuarterCapLbl)
            { }
            column(StartDate; StartDate)
            { }
            column(EndDate; EndDate)
            { }
            column(ToCaptionLbl; ToCaptionLbl)
            { }
            column(Item_No_; "Item No.")
            { }
            column(Description; Item1.Description)
            { }
            column(Item_Category_Code; "Item Category Code")
            { }
            column(Quantity; Quantity)
            { }
            /* column(PcNo; PcNo)
             { }
             column(PCDate; format(PCDate, 0, '<Day,2>-<Month,2>-<Year4>'))
             { }
             column(BillofEntryNo; BillofEntryNo)
             { }
             column(BillofEntryDate; format(BillofEntryDate, 0, '<Day,2>-<Month,2>-<Year4>'))
             { }*/
            column(Openingstock; Openingstock)
            { }
            column(InwardStock; InwardStock)
            { }
            column(OutwardStock; OutwardStock)
            { }
            column(ClosingStock; ClosingStock)
            { }
            column(InvoiceValue; InvoiceValue)
            { }
            column(InvoiceValueINR; InvoiceValueINR)
            { }
            column(CurrencyCode; CurrencyCodeGvar)
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(SalesLineAmt; SalesLineAmt)
            { }
            column(SalesQty; SalesQty)
            { }
            column(PcNo_ItemLedgerEntry; "Pc No.")
            {
            }
            column(PcDate_ItemLedgerEntry; format("Pc Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(BillofEntryNo_ItemLedgerEntry; "Bill of Entry No.")
            {
            }
            column(BillofEntryDate_ItemLedgerEntry; format("Bill of Entry Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(ThermalCaptionLbl; ThermalCaptionLbl)
            {
            }
            column(SalesQty1; SalesQty1)
            {
            }
            column(SalesValues; SalesValues)
            {
            }
            column(TotalColCap; TotalColCap)
            { }

            trigger OnAfterGetRecord()
            var
                NewStartDate: Date;
                ItemLedgerEntry: Record "Item Ledger Entry";
                TempItemLedgerEntry: Record "Item Ledger Entry" temporary;
            begin
                Clear(Openingstock);
                Clear(InwardStock);
                Clear(OutwardStock);
                Clear(ClosingStock);
                Clear(InvoiceValue);
                Clear(InvoiceValueINR);
                // Clear(PcNo);
                // Clear(PCDate);
                //Clear(BillofEntryNo);
                //Clear(BillofEntryDate);
                Clear(Item1);
                Clear(SalesQty1);
                // if ("Pc No." = PcNo) AND ("Pc Date" = PCDate) AND ("Bill of Entry No." = BillofEntryNo) AND ("Item No." = ItemNo) then
                //  CurrReport.Skip();
                if Item1.Get("Item No.") then;
                //PcNo := "Item Ledger Entry"."Pc No.";
                // PCDate := "Item Ledger Entry"."Pc Date";
                //BillofEntryNo := "Item Ledger Entry"."Bill of Entry No.";
                ItemNo := "Item Ledger Entry"."Item No.";



                // if PurchInvHdr.Get("Document No.") then begin
                //     PcNo := PurchInvHdr."Pc No.";
                //     PCDate := PurchInvHdr."Pc Date";
                //     BillofEntryNo := PurchInvHdr."Bill of Entry No.";
                //     BillofEntryDate := PurchInvHdr."Bill of Entry Date";
                // end;

                NewStartDate := CALCDATE('-1D', StartDate);
                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                ItemLedgerEntry.SETFILTER("Posting Date", '<%1', StartDate);
                IF ItemLedgerEntry.FINDSET THEN begin
                    ItemLedgerEntry.CalcSums(Quantity);
                    Openingstock := ItemLedgerEntry.Quantity;
                end;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
                //ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
                ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
                IF ItemLedgerEntry.FINDSET THEN begin
                    ItemLedgerEntry.CalcSums(Quantity);
                    InwardStock := ItemLedgerEntry.Quantity;
                end;

                // ItemLedgerEntry.RESET;
                // ItemLedgerEntry.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                // ItemLedgerEntry.SetRange("Document No.", ItemLedgerEntry2."Document No.");
                // ItemLedgerEntry.SetRange("Document Line No.", ItemLedgerEntry2."Document Line No.");
                // ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                // ItemLedgerEntry.SetFilter("Entry Type", '%1|%2', ItemLedgerEntry."Entry Type"::"Positive Adjmt.",
                //                                                  ItemLedgerEntry."Entry Type"::Output);
                // IF ItemLedgerEntry.FINDSET THEN begin
                //     ItemLedgerEntry.CalcSums(Quantity);
                //     InwardStock += ItemLedgerEntry.Quantity;
                // end;

                ItemLedgerEntry.RESET;
                ItemLedgerEntry.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                ItemLedgerEntry.SetFilter("Entry Type", '%1', ItemLedgerEntry."Entry Type"::Consumption);
                ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF ItemLedgerEntry.FINDSET THEN begin
                    ItemLedgerEntry.CalcSums(Quantity);
                    OutwardStock := ABS(ItemLedgerEntry.Quantity);
                end;
                ItemLedgerEntry.RESET;
                // ItemLedgerEntry.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                IF ItemLedgerEntry.FINDSET THEN begin
                    repeat
                        TempItemLedgerEntry.DeleteAll();
                        FindAppliedEntries(ItemLedgerEntry, TempItemLedgerEntry);
                        if TempItemLedgerEntry.FindSet() then begin
                            repeat
                                if TempItemLedgerEntry."Entry Type" = TempItemLedgerEntry."Entry Type"::Output then
                                    SalesQty1 += TempItemLedgerEntry.Quantity;
                            until TempItemLedgerEntry.Next() = 0;
                            ItemLedgerEntry.CalcFields("Sales Amount (Expected)");
                            SalesValues += ItemLedgerEntry."Sales Amount (Expected)";
                        end;
                    until ItemLedgerEntry.Next() = 0;
                end;

                // ItemLedgerEntry.RESET;
                // ItemLedgerEntry.SETRANGE("Item No.", "Item Ledger Entry"."Item No.");
                // ItemLedgerEntry.SetRange("Document No.", ItemLedgerEntry2."Document No.");
                // ItemLedgerEntry.SetRange("Document Line No.", ItemLedgerEntry2."Document Line No.");
                // ItemLedgerEntry.SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                // ItemLedgerEntry.SetFilter("Entry Type", '%1|%2', ItemLedgerEntry."Entry Type"::"Negative Adjmt.",
                //                                                  ItemLedgerEntry."Entry Type"::Consumption);
                // IF ItemLedgerEntry.FINDSET THEN begin
                //     repeat
                //         OutwardStock += ABS(ItemLedgerEntry.Quantity);
                //     until ItemLedgerEntry.Next() = 0;
                // end;

                ClosingStock := (Openingstock + InwardStock) - OutwardStock;

                if NOT PurchInvHdr.Get("Document No.") then
                    Clear(PurchInvHdr);

                DetailedGSTLedger.Reset();
                DetailedGSTLedger.SetRange("Document No.", "Document No.");
                //    DetailedGSTLedger.SetRange("Document Line No.", "Line No.");
                if DetailedGSTLedger.FindSet() then
                    repeat
                        GSTAmount += DetailedGSTLedger."GST Amount";
                    until DetailedGSTLedger.Next() = 0;
                /*if PurchInvHdr."Currency Code" <> '' then begin
                    InvoiceValue := Amount;
                    InvoiceValueINR := Round(Amount / PurchInvHdr."Currency Factor", 0.01) + GSTAmount;
                end else begin
                    InvoiceValueINR := Amount + GSTAmount;
                    InvoiceValue := 0;
                end;*/
                Clear(PurchRcptHdrGrec);
                Clear(CurrencyCodeGvar);
                PurchRcptLineGrec.Reset();
                PurchRcptLineGrec.SetRange("Document No.", "Item Ledger Entry"."Document No.");
                PurchRcptLineGrec.SetRange("Line No.", "Item Ledger Entry"."Document Line No.");
                if PurchRcptLineGrec.FindFirst() then begin
                    if PurchRcptHdrGrec.Get(PurchRcptLineGrec."Document No.") then;
                    CurrencyCodeGvar := PurchRcptHdrGrec."Currency Code";
                    InvoiceValue := "Item Ledger Entry".Quantity * PurchRcptLineGrec."Unit Cost";
                    InvoiceValueINR := "Item Ledger Entry".Quantity * PurchRcptLineGrec."Unit Cost (LCY)";
                end;
                SalesInvLine.Reset();
                SalesInvLine.SetFilter("No.", '<>%1', '');
                SalesInvLine.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                If SalesInvLine.FindSet() then begin
                    SalesInvLine.CalcSums(Quantity, "Line Amount");
                    SalesQty := SalesInvLine.Quantity;
                    SalesLineAmt := SalesInvLine."Line Amount";
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetCurrentKey("Pc No.", "Bill of Entry No.", "Item No.");
                SETFILTER("Posting Date", '%1..%2', StartDate, EndDate);
                SetFilter("Pc No.", '<>%1', '');
                SetRange("Document Type", "Document Type"::"Purchase Receipt");
                SetFilter("Pc Date", '<>%1', 0D);
                SetFilter("Bill of Entry No.", '<>%1', '');
                SetFilter("Bill of Entry Date", '<>%1', 0D);
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
        StartDate: Date;
        EndDate: Date;
        QuarterlyReturnCaptionLbl: Label 'QUARTERLY RETURN';
        PCSINoCaptionLbl: Label 'PC/SI No.';
        BillofEntryCaptionLbl: Label 'Bill of Entry No. and Date';
        DescriptionCaptionLbl: Label 'Description of goods imported at concessional rate';
        OpeningBalCaptionLbl: Label 'Opening Balance on the 1st day of the quarter';
        DetailsofGoodsCaptionLbl: Label 'Details of goods imported during the quarter';
        SpecifiedPurposeCaptionLbl: Label 'Specified purpose for procuring the goods at concesional rate of duty';
        GoodsManufacturedCaptionLbl: Label 'Goods manufactured during the quarter/Output service provided';
        ValueofGoodsCaptionLbl: Label 'Value of goods received during the quarter';
        QuantityofGoodsCaptionLbl: Label 'Quantity of goods received during the quarter';
        QuantityConsumedCaptionLbl: Label 'Quantity consumed for the intended purpose during the quarter';
        QuantityReexportedCaptionLbl: Label 'Quantity Reexported during the quarter';
        QuantityClearedCaptionLbl: Label 'Quantity cleared in to the domestic market during the quarter';
        ClosingBalCaptionLbl: Label 'Closing Balance on the last day of the quarter';
        ThermalCaptionLbl: Label 'Thermal Batteries';
        DescCaptionLbl: Label 'Description';
        QuantityCaptionLbl: Label 'Quantity';
        ValueCaptionLbl: Label 'Value';
        FormCaptionLbl: Label 'Form';
        TotalCaptionLbl: Label 'Total';
        OneCaptionLbl: Label '1';
        TwoCaptionLbl: Label '2';
        ThreeCaptionLbl: Label '3';
        FourCaptionLbl: Label '4';
        FiveCaptionLbl: Label '5';
        SixCaptionLbl: Label '6';
        SevenCaptionLbl: Label '7';
        EightCaptionLbl: Label '8';
        NineCaptionLbl: Label '9';
        TenCaptionLbl: Label '10';
        ElevenCaptionLbl: Label '11';
        TwelveCaptionLbl: Label '12';
        ThirteenCaptionLbl: Label '13';
        FourteenCaptionLbl: Label '14';
        FifteenCaptionLbl: Label '15';
        ToCaptionLbl: Label 'to';
        pa3: Page 38;
        ForManufacturingCaptionLbl: Label 'For Manufacturing of Thermal Batteries';
        ThermalBatteriesCaptonLbl: Label 'Thermal Batteries';
        ReturnForQuarterCapLbl: Label 'Return for the Quarter Ending :';
        PurchRecptLn: Record "Purch. Rcpt. Line";
        PurchInvHdr: Record "Purch. Inv. Header";
        //PurchInvLine: Record "Purch. Inv. Line";
        ILE: Record "Item Ledger Entry";
        Month: Date;
        //PcNo: Code[20];
        // PCDate: Date;
        // BillofEntryNo: Text[50];
        // BillofEntryDate: Date;
        Openingstock: Decimal;
        InwardStock: Decimal;
        OutwardStock: Decimal;
        ClosingStock: Decimal;
        TotalInwardStock: Decimal;
        TotalOutwardStock: Decimal;
        InvoiceValue: Decimal;
        GSTAmount: Decimal;
        DetailedGSTLedger: Record "Detailed GST Ledger Entry";
        InvoiceValueINR: Decimal;
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry2: Record "Item Ledger Entry";
        SalesInvLine: Record "Sales Invoice Line";
        SalesQty: Integer;
        SalesLineAmt: Decimal;
        ItemNo: text[50];
        Amount: Decimal;
        Desc: Text[50];
        Item1: Record Item;
        PurchRcptHdrGrec: Record "Purch. Rcpt. Header";
        PurchRcptLineGrec: Record "Purch. Rcpt. Line";
        CurrencyCodeGvar: Text;
        SalesQty1: Decimal;
        SalesValues: Decimal;
        TotalColCap: Label 'Total of column (4) and (6)';

    procedure FindAppliedEntries(ItemLedgEntry: Record "Item Ledger Entry"; var TempItemLedgerEntry: Record "Item Ledger Entry" temporary)
    var
        ItemApplnEntry: Record "Item Application Entry";
    begin
        with ItemLedgEntry do
            if Positive then begin
                ItemApplnEntry.Reset();
                ItemApplnEntry.SetCurrentKey("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
                ItemApplnEntry.SetRange("Inbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SetFilter("Outbound Item Entry No.", '<>%1', 0);
                ItemApplnEntry.SetRange("Cost Application", true);
                if ItemApplnEntry.Find('-') then
                    repeat
                        InsertTempEntry(TempItemLedgerEntry, ItemApplnEntry."Outbound Item Entry No.", ItemApplnEntry.Quantity);
                    until ItemApplnEntry.Next() = 0;
            end else begin
                ItemApplnEntry.Reset();
                ItemApplnEntry.SetCurrentKey("Outbound Item Entry No.", "Item Ledger Entry No.", "Cost Application");
                ItemApplnEntry.SetRange("Outbound Item Entry No.", "Entry No.");
                ItemApplnEntry.SetRange("Item Ledger Entry No.", "Entry No.");
                ItemApplnEntry.SetRange("Cost Application", true);
                if ItemApplnEntry.Find('-') then
                    repeat
                        InsertTempEntry(TempItemLedgerEntry, ItemApplnEntry."Inbound Item Entry No.", -ItemApplnEntry.Quantity);
                    until ItemApplnEntry.Next() = 0;
            end;
    end;

    local procedure InsertTempEntry(var TempItemLedgerEntry: Record "Item Ledger Entry" temporary; EntryNo: Integer; AppliedQty: Decimal)
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        IsHandled: Boolean;
    begin
        ItemLedgEntry.Get(EntryNo);

        IsHandled := false;
        if IsHandled then
            exit;

        if AppliedQty * ItemLedgEntry.Quantity < 0 then
            exit;

        if not TempItemLedgerEntry.Get(EntryNo) then begin
            TempItemLedgerEntry.Init();
            TempItemLedgerEntry := ItemLedgEntry;
            TempItemLedgerEntry.Quantity := AppliedQty;
            TempItemLedgerEntry.Insert();
        end else begin
            TempItemLedgerEntry.Quantity := TempItemLedgerEntry.Quantity + AppliedQty;
            TempItemLedgerEntry.Modify();
        end;
    end;

}

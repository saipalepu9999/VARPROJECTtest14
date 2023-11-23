report 50086 "Item Ledger Entry Upd"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Item Ledger Entry Upd';
    ProcessingOnly = true;

    Permissions = tabledata "Item Ledger Entry" = rm, tabledata "Value Entry" = rm,
      tabledata "Inventory Adjmt. Entry (Order)" = rm,
      tabledata "Avg. Cost Adjmt. Entry Point" = rm;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.");

            trigger OnPreDataItem()
            begin
                if (ProdOrderNo = '') or (ProdOrderLineNo = '') or (ENtrynum = 0) or (ProdOrderCompLineNo = '') then
                    Error(ReqPageprodErr);
                Setrange("Entry No.", EntryNum)

            end;

            trigger OnAfterGetRecord()
            begin
                "Order No." := ProdOrderNo;
                Evaluate("Order Line No.", ProdOrderLineNo);
                Evaluate("Prod. Order Comp. Line No.", ProdOrderCompLineNo);
                "Document No." := ProdOrderNo;
                modify;
                IsModified := true;

                ValueEntry.Reset;
                ValueEntry.Setrange("Item Ledger Entry No.", "Entry No.");
                if ValueEntry.FindSet() then
                    repeat
                        ValueEntry."Order No." := "Order No.";
                        ValueEntry."Order Line No." := "Order Line No.";
                        ValueEntry."Document No." := "Order No.";
                        ValueEntry.modify;
                    until ValueEntry.next = 0;

                ItemLedgEntryOutPut.Reset;
                ItemLedgEntryOutPut.Setrange("Entry Type", ItemLedgEntryOutPut."Entry Type"::Output);
                ItemLedgEntryOutPut.Setrange("Order No.", ProdOrderNo);
                ItemLedgEntryOutPut.Setrange("Order Line No.", "Order Line No.");
                if ItemLedgEntryOutPut.FindFirst() then begin
                    repeat
                        ItemLedgEntryOutPut."Applied Entry to Adjust" := true;
                        ItemLedgEntryOutPut."Completely Invoiced" := false;
                        ItemLedgEntryOutPut.modify;
                    until ItemLedgEntryOutPut.Next() = 0;

                    if Item.Get(ItemLedgEntryOutPut."Item No.") then begin
                        Item."Cost is Adjusted" := false;
                        Item.modify;
                    end;

                    InvtAdjmtOrderRec.Reset;
                    InvtAdjmtOrderRec.Setrange("Order No.", ProdOrderNo);
                    InvtAdjmtOrderRec.SetRange("Item No.", ItemLedgEntryOutPut."Item No.");
                    if InvtAdjmtOrderRec.FindFirst then begin

                        InvtAdjmtOrderRec."Cost is Adjusted" := false;
                        InvtAdjmtOrderRec."Completely Invoiced" := false;
                        InvtAdjmtOrderRec."Allow Online Adjustment" := false;
                        InvtAdjmtOrderRec.modify;
                    end;

                    AvgCostAdjmtEntryPointRec.Reset;
                    AvgCostAdjmtEntryPointRec.SetRange("Item No.", ItemLedgEntryOutPut."Item No.");
                    if AvgCostAdjmtEntryPointRec.FindFirst then begin
                        repeat
                            AvgCostAdjmtEntryPointRec."Cost Is Adjusted" := false;
                            AvgCostAdjmtEntryPointRec.Modify()
                       until AvgCostAdjmtEntryPointRec.next = 0;

                    end;
                end;
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Filters';
                    field("Prod Order No."; ProdOrderNo)
                    {
                        ApplicationArea = All;
                        TableRelation = "Production Order"."No." where(Status = const(Finished));

                    }
                    field("Prod Order LineNo."; ProdOrderLineNo)
                    {
                        ApplicationArea = all;


                        trigger OnLookup(var Text: Text): Boolean
                        var

                        begin

                            exit(LookupOrderLineNum(Text));
                        end;

                    }

                    field("Prod Order Comp LineNo."; ProdOrderCompLineNo)
                    {
                        ApplicationArea = all;


                        trigger OnLookup(var Text: Text): Boolean
                        var

                        begin

                            exit(LookupOrderCompLineNum(Text));
                        end;

                    }
                    field("Entry No."; EntryNum)
                    {
                        ApplicationArea = All;
                        TableRelation = "Item Ledger Entry" where("Entry Type" = Const(Consumption));

                    }
                }
            }
        }


    }
    trigger OnPostReport()
    begin

        if IsModified then
            Message(ProcessMsg)

    end;



    procedure LookupOrderLineNum(var ProdOrderLineNUM: Text): Boolean
    var
        ProdOrderLine: Record "Prod. Order Line";

    begin

        ProdOrderLine.RESET;
        ProdOrderLine.SETRANGE(Status, ProdOrderLine.Status::Finished);
        ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrderNo);
        IF PAGE.RUNMODAL(0, ProdOrderLine) = ACTION::LookupOK THEN
            ProdOrderLinenum := Format(ProdOrderLine."Line No.");
        ProdOrderLinenumInt := ProdOrderLine."Line No.";
        exit(true)

    end;

    procedure LookupOrderCompLineNum(var ProdOrderCompLineNUM: Text): Boolean
    var
        ProdOrderCompLine: Record "Prod. Order Component";

    begin

        ProdOrderCompLine.RESET;
        ProdOrderCompLine.SETRANGE(Status, ProdOrderCompLine.Status::Finished);
        ProdOrderCompLine.SETRANGE("Prod. Order No.", ProdOrderNo);
        ProdOrderCompLine.SETRANGE("Prod. Order Line No.", ProdOrderLinenumInt);
        IF PAGE.RUNMODAL(0, ProdOrderCompLine) = ACTION::LookupOK THEN
            ProdOrderCompLinenum := Format(ProdOrderCompLine."Line No.");
        exit(true)

    end;

    var

        ProdOrderNo: Code[20];
        ProdOrderLineNo: Text;
        ProdOrderCompLineNo: Text;
        ProdOrderLinenumInt: Integer;
        EntryNum: Integer;
        ILEError: Label 'You can process at a time single ILE entry not more than one';
        ProcessMsg: Label 'Updated successfully';
        ReqPageprodErr: Label 'Request Page filter values must not be empty.';
        IsModified: Boolean;
        ValueEntry: record "Value Entry";
        ItemLedgEntryOutPut: Record "Item Ledger Entry";
        Item: Record Item;
        InvtAdjmtOrderRec: Record "Inventory Adjmt. Entry (Order)";
        ItemLedgEntry2: Record "Item Ledger Entry";
        AvgCostAdjmtEntryPointRec: Record "Avg. Cost Adjmt. Entry Point";
}
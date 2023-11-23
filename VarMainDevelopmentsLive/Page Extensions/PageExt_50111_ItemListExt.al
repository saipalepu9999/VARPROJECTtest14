pageextension 50111 ItemListExt extends "Item List"
{
    layout
    {
        addafter(InventoryField)
        {

            field("Quantity Accepted B2B"; Rec."Quantity Accepted B2B")
            {
                ApplicationArea = All;
                ToolTip = 'satsified the quantity in inspection data sheet that is Quantity Accepted ';
                Caption = 'Available Inventory To Use';
                trigger OnDrillDown()
                var
                    ItemLedgEntry: Record 32;
                    QualityItemLedgEntry: Record 33000262;
                begin
                    // Start  B2BQC1.00.00 - 01 Open respected Item Ledger Entries
                    Rec.CALCFIELDS("Quantity Under Inspection B2B", "Quantity Rejected B2B", "Quantity Rework B2B", "Quantity Sent for Rework B2B");
                    IF (Rec."QC Enabled B2B" = TRUE) OR (Rec."WIP QC Enabled B2B" = TRUE) THEN
                        IF (Rec."Quantity Under Inspection B2B" = 0) AND (Rec."Quantity Rejected B2B" = 0) AND (Rec."Quantity Rework B2B" = 0) AND (Rec."Quantity Sent for Rework B2B" = 0) THEN BEGIN
                            ItemLedgEntry.SETRANGE("Item No.", Rec."No.");
                            ItemLedgEntry.SETRANGE(Open, TRUE);
                            PAGE.RUNMODAL(38, ItemLedgEntry);
                        END ELSE BEGIN
                            ItemLedgEntry.RESET();
                            ItemLedgEntry.SETRANGE("Item No.", Rec."No.");
                            ItemLedgEntry.SETRANGE(Open, TRUE);
                            IF ItemLedgEntry.FIND('-') THEN
                                REPEAT
                                    ItemLedgEntry.MARK(TRUE);
                                    IF QualityItemLedgEntry.GET(ItemLedgEntry."Entry No.") THEN
                                        ItemLedgEntry.MARK(FALSE);
                                UNTIL ItemLedgEntry.NEXT() = 0;
                            ItemLedgEntry.MARKEDONLY(TRUE);
                            PAGE.RUNMODAL(38, ItemLedgEntry);
                        END;
                END;

                // Stop   B2BQC1.00.00 - 01
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord()
    begin
        // Start  B2BQC1.00.00 - 01 Calculate Quantity accepted field

        IF (Rec."QC Enabled B2B" = TRUE) AND (Rec.Inventory >= 0) THEN
            Rec."Quantity Accepted B2B" := Rec.Inventory - (Rec."Quantity Rejected B2B" + Rec."Quantity Under Inspection B2B" + Rec."Quantity Rework B2B" +
                                                Rec."Quantity Sent for Rework B2B");
        // Stop   B2BQC1.00.00 - 01
    End;

    var
        myInt: Integer;
}
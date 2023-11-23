report 50016 VendorLotUpdateInIle
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Vendor Lot No Update In Ile';

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            trigger OnAfterGetRecord()
            begin
                ItemLedgerEntry.Reset();
                ItemLedgerEntry.SetFilter("Vendor Lot No_B2B", '%1', '');
                ItemLedgerEntry.SetFilter("Lot No.", '<>%1', '');
                ItemLedgerEntry.SetFilter("Document Type", '<>%1', ItemLedgerEntry."Document Type"::"Purchase Receipt");
                if ItemLedgerEntry.FindSet() then begin
                    repeat
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
                                    ItemLedgerEntry.Modify();
                                end;
                            end;
                        end;
                    until ItemLedgerEntry.Next() = 0;
                end;
                Message('Done');
            end;
        }
    }

    /*requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; SourceExpression)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }*/



    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ItemLedgherEntry2: Record "Item Ledger Entry";
        ItemLedgerEntryLvar: Record "Item Ledger Entry";
}
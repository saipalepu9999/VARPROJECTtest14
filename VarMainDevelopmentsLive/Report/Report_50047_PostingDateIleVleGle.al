report 50047 "PostingDateChangeinIleVle"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "Item Ledger Entry" = RM, tabledata "Value Entry" = RM, tabledata "G/L Entry" = RM;
    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;

            trigger OnAfterGetRecord()
            begin
                // Item Ledger Entries
                ItemLedgerEntryGrec.Reset();
                ItemLedgerEntryGrec.SetRange("Document No.", DocumentNoGvar);
                if ItemLedgerEntryGrec.FindSet() then
                    ItemLedgerEntryGrec.ModifyAll("Posting Date", PostingDateGvar);

                // Value Entries
                ValueEntryGrec.Reset();
                ValueEntryGrec.SetRange("Document No.", DocumentNoGvar);
                if ValueEntryGrec.FindSet() then
                    ValueEntryGrec.ModifyAll("Posting Date", PostingDateGvar);

                //GeneralLedgerEntries
                GeneralLedgerEntryGrec.Reset();
                GeneralLedgerEntryGrec.SetRange("Document No.", DocumentNoGvar);
                if GeneralLedgerEntryGrec.FindSet() then
                    GeneralLedgerEntryGrec.ModifyAll("Posting Date", PostingDateGvar);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(DocumentNoGvar; DocumentNoGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Document No.';
                    }
                    field(PostingDateGvar; PostingDateGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Posting Date';
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
    }



    var
        ItemLedgerEntryGrec: Record "Item Ledger Entry";
        ValueEntryGrec: Record "Value Entry";
        GeneralLedgerEntryGrec: Record "G/L Entry";
        DocumentNoGvar: Code[20];
        PostingDateGvar: Date;
}
pageextension 50119 PurchaseJournalExt extends "Purchase Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                GenJnlLine: Record "Gen. Journal Line";
                fixedAsset: Record "Fixed Asset";
                VendLedgentry: Record "Vendor Ledger Entry";
                PurchInvLine: Record "Purch. Inv. Line";
            begin
                GenJnlLine.Reset();
                GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                if GenJnlLine.FindSet() then begin
                    repeat
                        GenJnlLine.TestField("Shortcut Dimension 1 Code");
                        GenJnlLine.TestField("Shortcut Dimension 2 Code");
                    until GenJnlLine.Next() = 0;
                end;
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            var
                GenJnlLine: Record "Gen. Journal Line";
            begin
                GenJnlLine.Reset();
                GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                if GenJnlLine.FindSet() then begin
                    repeat
                        GenJnlLine.TestField("Shortcut Dimension 1 Code");
                        GenJnlLine.TestField("Shortcut Dimension 2 Code");
                    until GenJnlLine.Next() = 0;
                end;
            end;
        }
        addlast("&Line")
        {
            action("Line Narration")
            {
                PromotedOnly = true;
                ApplicationArea = Basic, Suite;
                Caption = 'Line Narration';
                Image = LineDescription;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Select this option to enter narration for a particular line.';

                trigger OnAction()
                var
                    GenNarration: Record "Gen. Journal Narration";
                    LineNarrationPage: Page "Line Narration";
                begin
                    GetGenJnlNarration(GenNarration, true);
                    LineNarrationPage.SetTableView(GenNarration);
                    LineNarrationPage.RunModal();

                    // ShowOldNarration();
                    VoucherFunctions.ShowOldNarration(Rec);
                    CurrPage.Update(true);
                end;
            }
            action("Voucher Narration")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Voucher Narration';
                Image = LineDescription;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Select this option to enter narration for the voucher.';

                trigger OnAction()
                var
                    GenNarration: Record "Gen. Journal Narration";
                    VoucherNarration: Page "Voucher Narration";
                begin
                    GenNarration.Reset();
                    GenNarration.SetRange("Journal Template Name", "Journal Template Name");
                    GenNarration.SetRange("Journal Batch Name", "Journal Batch Name");
                    GenNarration.SetRange("Document No.", "Document No.");
                    GenNarration.SetFilter("Gen. Journal Line No.", '%1', 0);
                    VoucherNarration.SetTableView(GenNarration);
                    VoucherNarration.RunModal();
                    // ShowOldNarration();
                    //VoucherFunctions.ShowOldNarration(Rec);
                    CurrPage.Update(true);
                end;
            }
        }
    }
    local procedure GetGenJnlNarration(var GenNarration: Record "Gen. Journal Narration"; LineNarration: Boolean)
    begin
        GenNarration.Reset();
        GenNarration.SetRange("Journal Template Name", "Journal Template Name");
        GenNarration.SetRange("Journal Batch Name", "Journal Batch Name");
        GenNarration.SetRange("Document No.", "Document No.");
        if LineNarration then
            GenNarration.SetRange("Gen. Journal Line No.", "Line No.")
        else
            GenNarration.SetFilter("Gen. Journal Line No.", '%1', 0);
    end;

    var
        JournalVoucher: Page "Journal Voucher";
        VoucherFunctions: Codeunit "Voucher Functions";
}
pageextension 50115 GeneralJournalPageExt extends "General Journal"
{
    layout
    {
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        addlast(Control1)
        {

            field("FA Posting Type"; Rec."FA Posting Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the posting type, if Account Type field contains Fixed Asset.';
            }
        }
    }

    actions
    {
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
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
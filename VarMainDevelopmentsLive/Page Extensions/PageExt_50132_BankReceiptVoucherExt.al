pageextension 50132 BankReceiptVoucherExt extends "Bank Receipt Voucher"
{
    layout
    {

        addafter(Comment)
        {
            field("BG No."; Rec."BG No.")
            {
                ApplicationArea = all;
            }
            field("FD No."; Rec."FD No.")
            {
                ApplicationArea = all;
            }
        }

        // Add changes to page layout here
      
    }

    actions
    {
        addafter(PostAndPrint)
        {
            action("Print")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                var
                    GenJnlLine: Record "Gen. Journal Line";
                begin
                    GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    //GenJnlLine.SetRange("Line No.", Rec."Line No.");
                    Report.RunModal(Report::"Bank Receipt", true, true, GenJnlLine);
                end;
            }
        }
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
        modify(PostAndPrint)
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
    }

    var
        myInt: Integer;
}
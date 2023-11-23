pageextension 50131 ContraVoucherExt extends "Contra Voucher"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(PostAndPrint)
        {
            action("Print SBI")
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                var
                    GenJnlLine: Record "Gen. Journal Line";
                begin
                    GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                   // GenJnlLine.SetRange("Line No.", Rec."Line No.");
                    Report.RunModal(Report::"SBI Report", true, true, GenJnlLine);
                end;
            }
            action("Print HDFC")
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
                    Report.RunModal(Report::"HDFC Report", true, true, GenJnlLine);
                end;
            }
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
                    GenJnlLine.SetRange("Line No.", Rec."Line No.");
                    Report.RunModal(Report::"BankVoucher", true, true, GenJnlLine);
                end;
            }
        }
    }

    var
        myInt: Integer;
}
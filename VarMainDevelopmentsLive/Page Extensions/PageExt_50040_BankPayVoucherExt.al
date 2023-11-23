pageextension 50040 BankPaymentVoucherExt extends "Bank Payment Voucher"
{
    layout
    {
        addafter("Account No.")
        {
            field("GST Credit"; Rec."GST Credit")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the GST Credit as selected from the given options';
            }
        }
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
                    //GenJnlLine.SetRange("Line No.", Rec."Line No.");
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
                    // GenJnlLine.SetRange("Line No.", Rec."Line No.");
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
                    //GenJnlLine.SetRange("Line No.", Rec."Line No.");
                    Report.RunModal(Report::"BankVoucher", true, true, GenJnlLine);
                end;
            }
            action("Print New")
            {
                ApplicationArea = All;
                Image = Print;
                Visible = false;
                trigger OnAction()
                var
                    GenJnlLine: Record "Gen. Journal Line";
                begin
                    GenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    //GenJnlLine.SetRange("Line No.", Rec."Line No.");
                    Report.RunModal(Report::BankVoucherNew, true, true, GenJnlLine);
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
                        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Vendor then begin
                            VendLedgentry.Reset();
                            VendLedgentry.SetRange("Applies-to ID", "Applies-to ID");
                            if VendLedgentry.FindFirst() then begin
                                PurchInvLine.Reset();
                                PurchInvLine.SetRange("Document No.", VendLedgentry."Document No.");
                                PurchInvLine.SetFilter(Type, '%1', PurchInvLine.Type::"Fixed Asset");
                                if PurchInvLine.FindSet() then
                                    repeat
                                        if fixedAsset.Get(PurchInvLine."No.") then begin
                                            if fixedAsset."QC Status" in [fixedAsset."QC Status"::Hold, fixedAsset."QC Status"::"QC Pending", fixedAsset."QC Status"::Rejected, fixedAsset."QC Status"::Rework] then
                                                Error('QC Is Not Accepeted For This Asset Please Check Once');
                                        end;
                                    until PurchInvLine.Next() = 0;
                            end;
                        end;
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
pageextension 50068 PurchaseReturnOrderExt extends "Purchase Return Order"
{
    layout
    {
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 2 Code_B2B"; Rec."Shortcut Dimension 2 Code_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
            }
        }
    }

    actions
    {
        modify("Re&lease")
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        addafter("CopyQualityRejectedItems B2B")
        {
            action("Copy mrv B2B")
            {
                Caption = 'CopyMRV';
                ApplicationArea = all;
                Image = Copy;
                //Visible = false;
                trigger OnAction();
                begin
                    CopyMrv(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Shortcut Dimension 2 Code_B2B" = '' then
            Rec."Shortcut Dimension 2 Code_B2B" := Rec."Shortcut Dimension 2 Code";
    end;


    procedure CopyMrv(PurchHeader: Record "Purchase Header");

    var
        PurchLine: Record "Purchase Line";

        LineNo: Integer;
        ItemGrec: Record Item;
        MrvLedgerEntry: Record "MRV Quality Ledger Entry";
    begin

        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::"Return Order");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        if PurchLine.FindLast() then
            LineNo := PurchLine."Line No." + 10000
        else
            LineNo := 10000;
        MrvLedgerEntry.Reset();
        MrvLedgerEntry.SetRange("Vendor No.", Rec."Buy-from Vendor No.");
        MrvLedgerEntry.SetRange("Location Code", Rec."Location Code");
        MrvLedgerEntry.SetFilter("Rejected Quantity", '<>%1', 0);
        //  MrvLedgerEntry.SetFilter("Rework Quantity", '=%1', 0);
        if MrvLedgerEntry.FindSet() then begin
            repeat
                PurchLine.INIT();
                PurchLine."Document Type" := PurchLine."Document Type"::"Return Order";
                PurchLine."Document No." := PurchHeader."No.";
                PurchLine."Line No." := LineNo;
                LineNo := LineNo + 10000;
                PurchLine.INSERT(true);
                PurchLine.VALIDATE(Type, PurchLine.Type::Item);
                PurchLine.VALIDATE("No.", MrvLedgerEntry."Item No.");
                PurchLine.VALIDATE("Location Code", MrvLedgerEntry."Location Code");
                PurchLine.Validate(Quantity, MrvLedgerEntry."Rejected Quantity");
                PurchLine.Modify(true);
            until MrvLedgerEntry.NEXT() = 0;
        end;
    end;

}
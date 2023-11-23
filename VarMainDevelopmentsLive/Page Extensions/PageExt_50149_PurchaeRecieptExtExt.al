pageextension 50149 PurchaeRecieptExt extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify("&Undo Receipt")
        {
            trigger OnAfterAction()
            var
                MrvLedger: Record "MRV Quality Ledger Entry";
            begin
                MrvLedger.SetRange("Document No.", rec."Document No.");
                MrvLedger.SetRange("Document Line No.", REC."Line No.");
                if MrvLedger.FindSet() then begin
                    repeat
                        MrvLedger.Delete();
                    until MrvLedger.Next() = 0;
                end;
            end;
        }

        // Add changes to page actions here
        addafter("&Line")
        {
            action("MRV Quality")
            {
                ApplicationArea = Suite;

                Ellipsis = true;
                Image = Receipt;
                Visible = VisibleTrue;
                ToolTip = 'Tracks the connection of a supply to its corresponding demand. This can help you find the original demand that created a specific production order or purchase order.';

                trigger OnAction()
                var
                    MrvLedger: Record "MRV Quality Ledger Entry";
                    MRVStatus: Boolean;
                begin
                    MrvLedger.Reset();
                    MrvLedger.SetRange("Document No.", rec."Document No.");
                    MrvLedger.SetRange("Document Line No.", REC."Line No.");
                    if not MrvLedger.FindFirst() then
                        MRVQuality()
                    else
                        PAGE.Run(Page::"MRV Quality Ledger Entries", MrvLedger);
                end;
            }

        }
    }
    local procedure MRVQuality()
    var
        MRVLedgerVar: Record "MRV Quality Ledger Entry";
        PurchRecptHdr: Record "Purch. Rcpt. Header";
        PurchRecptLine: Record "Purch. Rcpt. Line";
        LinenoVar: Integer;
    begin
        rec.TestField(Quantity);
        PurchRecptLine.Reset();
        PurchRecptLine.SetRange("Document No.", Rec."Document No.");
        PurchRecptLine.SetRange("Line No.", rec."Line No.");
        // if not PurchRecptLine.FindSet() then begin
        /*   MRVLedgerVar.Reset();
           MRVLedgerVar.SetRange("Document No.", Rec."Document No.");
           IF MRVLedgerVar.FindLast() THEN
               LineNovar := MRVLedgerVar."Line No." + 10000 else*/
        LineNovar := 10000;
        PurchRecptHdr.Reset();
        PurchRecptHdr.SetRange("No.", rec."Document No.");
        if PurchRecptHdr.FindFirst() then begin
            PurchRecptLine.Reset();
            PurchRecptLine.SetRange("Document No.", rec."Document No.");
            if PurchRecptLine.FindSet() then begin
                repeat
                    MRVLedgerVar.Init();
                    MRVLedgerVar."Document No." := PurchRecptLine."Document No.";
                    MRVLedgerVar."Document Line No." := PurchRecptLine."Line No.";
                    MRVLedgerVar."Line No." := LinenoVar + 10000;

                    LinenoVar += 10000;
                    MRVLedgerVar."Vendor No." := PurchRecptLine."Buy-from Vendor No.";
                    if PurchRecptLine.Type = PurchRecptLine.Type::Item then
                        MRVLedgerVar."Item No." := PurchRecptLine."No.";
                    MRVLedgerVar."Location Code" := PurchRecptLine."Location Code";
                    MRVLedgerVar.Quantity := PurchRecptLine.Quantity;
                    MRVLedgerVar."Posting Date" := Today;
                    MRVLedgerVar."User ID" := UserId;
                    MRVLedgerVar.Insert(true);
                until PurchRecptLine.Next() = 0;

            end;
            MRVLedgerVar.Reset();
            MRVLedgerVar.SetRange("Document No.", rec."Document No.");
            MRVLedgerVar.SetRange("Document Line No.", REC."Line No.");
            PAGE.Run(Page::"MRV Quality Ledger Entries", MRVLedgerVar);
        end;

    end;

    var
        VisibleTrue: Boolean;

    trigger OnAfterGetRecord()
    begin
        if Rec."QC Enabled B2B" then
            VisibleTrue := false
        else
            VisibleTrue := true;
    end;

}
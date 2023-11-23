pageextension 50141 PostedPurchaseCrMemoExt extends "Posted Purchase Credit Memo"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(AttachAsPDF)
        {
            action("Pri&nt")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Credit Memo';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                begin
                    PurchCrMemoHdr.Reset();
                    PurchCrMemoHdr.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Posted Purchase Credit Memo", true, true, PurchCrMemoHdr);
                end;
            }
        }
    }

    var
        myInt: Integer;
}
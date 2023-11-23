pageextension 50123 PostedPurchInvExte extends "Posted Purchase Invoice"
{
    layout
    {
        addlast(General)
        {

            field("NewRemarks"; Rec."New Remarks")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
                Editable = false;
            }
        }
    }

    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {
            action("Pri&nt")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                //Visible = NOT IsOfficeAddin;

                trigger OnAction()
                var
                    PurchInvHdr: Record "Purch. Inv. Header";
                begin
                    PurchInvHdr.Reset();
                    PurchInvHdr.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Posted Purchase Invoice", true, true, PurchInvHdr);
                end;
            }
        }

    }

    var
        myInt: Integer;
}
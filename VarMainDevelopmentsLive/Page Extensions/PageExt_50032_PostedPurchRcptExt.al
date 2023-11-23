pageextension 50032 PostedPurchRcptExt extends "Posted Purchase Receipt"
{
    Caption = 'Posted MRV Document';
    layout
    {
        addlast(General)
        {
            field("Quality Remarks"; Rec."Quality Remarks")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the value of the Quality Remarks field.';
            }
            field("Pc No."; Rec."Pc No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Procurement Certificate No. field.';
            }
            field("Pc Date"; Rec."Pc Date")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Procurement Certificate Date field.';
            }
            field("Dc No."; Rec."Dc No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Delivery Challan No. field.';
            }
            field("Dc Date"; Rec."Dc Date")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Delivery Challan Date field.';
            }
            field("PO Ack.Date"; Rec."PO Ack.Date")
            {
                ApplicationArea = all;
                Editable = false;
            }

        }
        addafter("Vendor Shipment No.")
        {
            field("Vendor Invoice No."; Rec."Vendor Invoice No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {
        modify("&Print")
        {
            Visible = false;
        }
        addafter("&Print")
        {
            action("MRV Report")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    PurhRcptHdr: Record "Purch. Rcpt. Header";
                    PurchRcptLine: Record "Purch. Rcpt. Line";
                begin
                    PurchRcptLine.Reset();
                    PurchRcptLine.SetRange("Document No.", Rec."No.");
                    Report.RunModal(Report::MaterialReceiptVoucher, true, true, PurchRcptLine);
                end;
            }
        }
    }

    var
        myInt: Integer;
}
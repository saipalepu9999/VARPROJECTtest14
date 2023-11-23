pageextension 50047 PostedInspectionReceiptExt extends "Posted Inspection Receipt B2B"
{
    layout
    {
        addlast(Returns)
        {
            /* field("Gate Inward DC NO."; Rec."Gate Inward DC NO.")
             {
                 ApplicationArea = all;
                 Editable = BoolGvar;
             }*/
        }
        addafter("Item Description")
        {

            field("Vendor Test Certificate_B2B"; Rec."Vendor Test Certificate_B2B")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Test Certificate Required field.';
            }
            field("Warranty Certificate_B2B"; Rec."Warranty Certificate_B2B")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty Certificate Required field.';
            }
        }
        addlast(Receipt)
        {

            field("Pc No."; Rec."Pc No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pc No. field.';
            }
            field("Pc Date"; Rec."Pc Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pc Date field.';
            }
            field("Dc No."; Rec."Dc No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dc No. field.';
            }
            field("Dc Date"; Rec."Dc Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dc Date field.';
            }
            field("Bill of Entry No."; Rec."Bill of Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bill of Entry No. field.';
            }
            field("Bill of Entry Date"; Rec."Bill of Entry Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bill of Entry Date field.';
            }
            field("No. Of Samples Taken"; "No. Of Samples Taken")
            {
                ApplicationArea = all;
            }
        }
    }


    actions
    {
        addlast(processing)
        {
            /* group("RDC")
             {
                 Caption = 'RDC List';
                 action("RDC Inward List")
                 {
                     Caption = 'RDC Inward List';
                     Image = List;
                     Promoted = true;
                     PromotedOnly = true;
                     PromotedCategory = Process;
                     ApplicationArea = all;
                     RunObject = page "Inward Gate Entry List-RGP";
                     RunPageLink = "Posted IR No." = field("No."), "Entry Type" = const(Inward), Type = const(RGP);
                     //tooltip = 'vendor rework items send to workshops';
                 }
                 action("RDC Outward List")
                 {
                     Caption = 'RDC Outward List';
                     Image = List;
                     Promoted = true;
                     PromotedOnly = true;
                     PromotedCategory = Process;
                     ApplicationArea = all;
                     RunObject = page "Outward Gate Entry List-RGP";
                     RunPageLink = "Posted IR No." = field("No."), "Entry Type" = const(Outward), Type = const(RGP);
                 }
                 action("Posted RDC Inward List ")
                 {
                     Caption = 'Posted RDC Inward List';
                     Image = List;
                     Promoted = true;
                     PromotedOnly = true;
                     PromotedCategory = Process;
                     ApplicationArea = all;
                     RunObject = page "PostedInwardGateEntryList-RGP";
                     RunPageLink = "Posted IR No." = field("No."), "Entry Type" = const(Inward), Type = const(RGP);
                 }
                 action("Posted RDC Outward List")
                 {
                     Caption = 'Posted RDC Outward List';
                     Image = List;
                     Promoted = true;
                     PromotedOnly = true;
                     PromotedCategory = Process;
                     ApplicationArea = all;
                     RunObject = page "PostedOutwardGateEntryList-RGP";
                     RunPageLink = "Posted IR No." = field("No."), "Entry Type" = const(Outward), Type = const(RGP);
                 }
             }*/
            action("Print NCPR")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                trigger OnAction()
                var
                    InspectionReceipt: Record "Inspection Receipt Header B2B";
                    Reportncpr: Report 50049;
                begin
                    InspectionReceipt.Reset();
                    InspectionReceipt.SetRange("No.", Rec."No.");
                    //Report.RunModal(Report::"NCP Report", false, false, InspectionReceipt);
                    Reportncpr.SetTableView(InspectionReceipt);
                    Reportncpr.RunModal();
                end;
            }
            action("Print RDC")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Print;
                trigger OnAction()
                var
                    IRRdc: Report IRRdcReport;
                    PostedInsReceipt: Record "Inspection Receipt Header B2B";
                begin
                    PostedInsReceipt.Reset();
                    PostedInsReceipt.SetRange("No.", Rec."No.");
                    IRRdc.SetTableView(PostedInsReceipt);
                    IRRdc.RunModal();
                end;
            }
            action("Inspection Log Sheet")
            {
                Caption = 'Inspection Log Sheet';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = all;
                tooltip = 'print generating a hardcopy to the electronic data being print';
                trigger OnAction();
                var
                    InspectRcpt: Record "Inspection Receipt Header B2B";
                begin
                    InspectRcpt.Reset();
                    InspectRcpt.SETRANGE(InspectRcpt."No.", Rec."No.");
                    REPORT.RUN(50073, true, false, InspectRcpt);

                end;
            }
        }
        /*modify(Receive)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Gate Inward DC NO.");
            end;
        }*/
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Qty. Rework" = Rec."Qty. Received(Rework)" then
            BoolGvar := true
        else
            BoolGvar := false;
    end;

    var
        BoolGvar: Boolean;
}
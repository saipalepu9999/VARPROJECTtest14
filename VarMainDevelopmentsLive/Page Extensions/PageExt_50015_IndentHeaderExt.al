pageextension 50015 IndentHeaderExt extends "Indent Header"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(processing)
        {
            group(Apprrovals)
            {
                Caption = 'Approvals';
                ToolTip = 'The User Can Send The documents For Approvals';
                action(Approve)
                {
                    ApplicationArea = All;
                    Image = Action;
                    //Visible = false;
                    //Visible = openapp;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Approve action.';
                    trigger OnAction()
                    var
                        approvalmngmt: Codeunit "Approvals Mgmt.";
                    begin
                        approvalmngmt.ApproveRecordApprovalRequest(rec.RecordId);
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = All;
                    Image = SendApprovalRequest;
                    //Visible = Not OpenApprEntrEsists and CanrequestApprovForFlow;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Send Approval Request action.';
                    trigger OnAction()
                    var
                        ApprovalsCodeunit: Codeunit ApprovalsCodeunit;

                    begin
                        if ApprovalsCodeunit.CheckIndentApprovalsWorkflowEnabled(Rec) then
                            ApprovalsCodeunit.OnSendIndentForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = All;
                    Image = CancelApprovalRequest;
                    //Visible = CanCancelapprovalforrecord or CanCancelapprovalforflow;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Cancel Approval Request action.';
                    trigger OnAction()
                    var
                        ApprovalsCodeunit: Codeunit ApprovalsCodeunit;
                    begin
                        ApprovalsCodeunit.OnCancelIndentForApproval(Rec);
                    end;
                }
                action("Approval Entries")
                {
                    ApplicationArea = All;
                    Image = Entries;
                    //Visible = false;
                    //Visible = openapp;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Approval Entries action.';
                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", DATABASE::"Indent Header");
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.RUN;
                    end;
                }

            }
        }
        addlast("F&unctions")
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                Var
                    IndentHeader: Record "Indent Header";
                begin
                    IndentHeader.SETRANGE(IndentHeader."No.", Rec."No.");
                    REPORT.RUNMODAL(REPORT::MIV, TRUE, TRUE, IndentHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}
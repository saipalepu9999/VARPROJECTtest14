pageextension 50012 RoutingExt extends Routing
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(processing)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                ToolTip = 'The User Can Send The documents For Approvals';
                action(Approve)
                {
                    ApplicationArea = All;
                    Image = Action;
                    //Visible = openapp;
                    Visible = false;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Approve action.';
                    trigger OnAction()
                    var
                        approvalmngmt: Codeunit "Approvals Mgmt.";
                    begin
                        approvalmngmt.ApproveRecordApprovalRequest(rec.RecordId());
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
                        if ApprovalsCodeunit.CheckRoutingApprovalsWorkflowEnabled(Rec) then
                            ApprovalsCodeunit.OnSendRoutingForApproval(Rec);
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
                        pa : Page 6510;
                    begin
                        ApprovalsCodeunit.OnCancelRoutingForApproval(Rec);
                    end;
                }
                action("Approval Entries")
                {
                    ApplicationArea = All;
                    Image = Entries;
                    //Visible = openapp;
                    Visible = false;
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
                        ApprovalEntry.SetRange("Table ID", DATABASE::"Ins Datasheet Header B2B");
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.RUN;
                    end;
                }

            }
        }
    }

    var
        myInt: Integer;
}
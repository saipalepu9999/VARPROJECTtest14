pageextension 50013 ProductionBomExt extends "Production BOM"
{
    layout
    {
        modify(Status)
        {
            Editable = BoolGvar;
        }
        modify(Description)
        {
            trigger OnBeforeValidate()
            begin
                
            end;
        }
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
                        if ApprovalsCodeunit.CheckProductionBomApprovalsWorkflowEnabled(Rec) then
                            ApprovalsCodeunit.OnSendProductionBomForApproval(Rec);
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
                        ApprovalsCodeunit.OnCancelProductionBomForApproval(Rec);
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
    trigger OnAfterGetCurrRecord()
    begin
        if (UserSetup.Get(UserId)) and (not UserSetup."Re-open Accessability") then
            BoolGvar := false
        else
            BoolGvar := true;
    end;


    var
        BoolGvar: Boolean;
        UserSetup: Record "User Setup";
}
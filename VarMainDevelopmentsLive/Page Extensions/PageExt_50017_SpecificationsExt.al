pageextension 50017 SpecificationB2BExt extends "Specifications B2B"
{
    layout
    {
        modify(Status)
        {
            Editable = BoolGvar;
        }
    }


    actions
    {
        addlast(processing)
        {
            group(Approvalss)
            {
                Caption = 'Approvals';
                ToolTip = 'The User Can Send The documents For Approvals';
                action(Appprove)
                {
                    ApplicationArea = All;
                    Image = Action;
                    //Visible = false;
                    //Visible = openapp;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Appprove action.';
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
                        Rec.TestField("ISO Format Number");
                        if ApprovalsCodeunit.CheckSpecificationApprovalsWorkflowEnabled(Rec) then
                            ApprovalsCodeunit.OnSendSpecificationForApproval(Rec);
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
                        ApprovalsCodeunit.OnCancelSpecificationForApproval(Rec);
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
                        ApprovalEntry.SetRange("Table ID", DATABASE::"Specification Header B2B");
                        ApprovalEntry.SetRange("Document No.", Rec."Spec ID");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.RUN;
                    end;
                }
                action("Re&lease")
                {
                    Caption = 'Certify';
                    tooltip = 'release is used for any order send to vendor and customer';
                    Image = ReleaseDoc;
                    //Visible = false;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ApplicationArea = all;
                    trigger OnAction();
                    var
                        InspectHeader: Record "Ins Datasheet Header B2B";
                        "Count": Integer;
                        WorkflowManagement: Codeunit "Workflow Management";
                        ApprovalsCodeunit: Codeunit ApprovalsCodeunit;
                        Text006Qst: Label 'This record is under in workflow process. Please cancel approval request if not required.';
                        Text007Qst: Label 'Status must not be equal to Under Development.';
                        Text005Qst: Label 'Workflow is enabled. You can not release manually.';
                        Text001Qst: Label 'Do you want to release the document?';
                    begin
                        if Rec.Status = Rec.Status::"Under Development" then
                            Error('Status Must Be In New');
                        IF WorkflowManagement.CanExecuteWorkflow(Rec, ApprovalsCodeunit.RunworkflowOnSendSpecificationforApprovalCode()) then
                            Error(Text005Qst);
                        Rec.TestField("ISO Format Number");
                        if CONFIRM(Text001Qst, false) then
                            Rec.Status := Rec.Status::Certified;

                        Rec.MODIFY();
                    end;
                }
                action("Re&open")
                {
                    Caption = 'New';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    //Visible = false;
                    tooltip = 'any order edit process used by reopen ';
                    trigger OnAction();
                    var
                        RecordRest: Record "Restricted Record";
                        Text006Qst: Label 'This record is under in workflow process. Please cancel approval request if not required.';
                        Text007Qst: Label 'Status must not be equal to Under Development.';
                        Text005Qst: Label 'Workflow is enabled. You can not Certify manually.';
                        Text001Qst: Label 'Do you want to Certify the document?';
                    begin
                        RecordRest.Reset();
                        RecordRest.SetRange(ID, 33000253);
                        RecordRest.SetRange("Record ID", Rec.RecordId());
                        IF RecordRest.FindFirst() THEN
                            Error(Text006Qst);
                        if Rec.Status = Rec.Status::"Under Development" then
                            Error(Text007Qst);
                        Rec.Status := Rec.Status::New;
                        rec.Modify();

                    end;
                }
                action(ExportPermissionSet)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea =all;
                    Caption = 'Exportper';
                    Image = New;
                    trigger OnAction();
                    begin
                        Xmlport.Run(50112, false, false);
                    end;
                }

            }
        }
    }
    trigger OnModifyRecord(): Boolean
    begin
        Rec.TestField(Status, Rec.Status::New);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if (UserSetup.Get(UserId)) and (not UserSetup."Re-open Accessability") then
            BoolGvar := false
        else
            BoolGvar := true;
    end;

    var
        UserSetup: Record "User Setup";
        BoolGvar: Boolean;

}
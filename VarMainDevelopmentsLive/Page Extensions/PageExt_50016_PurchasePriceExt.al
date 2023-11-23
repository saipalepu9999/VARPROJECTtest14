pageextension 50016 PurchasePriceExt extends "Purchase Prices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(processing)
        {
            action("Re-Open")
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Re-Open action.';
                trigger OnAction()
                begin
                    if Rec."Approval Status_B2B" = Rec."Approval Status_B2B"::"Pending Approval" then
                        exit;

                    Rec."Approval Status_B2B" := Rec."Approval Status_B2B"::Open;
                    Rec.Modify(true);
                end;
            }
            action("Release")
            {
                ApplicationArea = All;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                ToolTip = 'Executes the Release action.';
                trigger OnAction()
                var
                    // ApprovalMgmt: Codeunit "Approval Process";
                    ReleaseText: TextConst ENU = 'Do you want to release the Document?';
                    NoWorkflowEnabledErr: TextConst ENU = 'This document can only be released when the approval process is complete.';
                begin
                    if ApprovalsCodeunit.ISPurchasePriceworkflowenabled(Rec) then
                        Error(NoWorkflowEnabledErr);
                    IF NOT CONFIRM(ReleaseText, FALSE) THEN
                        EXIT;
                    Rec."Approval Status_B2B" := Rec."Approval Status_B2B"::Released;
                    Rec.Modify(true);
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                Visible = false;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Executes the Approve action.';
                //Visible = OpenAppEntrExistsForCurrUser;
                trigger OnAction()
                begin
                    approvalmngmt.ApproveRecordApprovalRequest(Rec.RecordId());
                end;
            }
            /* action("Send Approval Request")
             {
                 ApplicationArea = All;
                 Image = SendApprovalRequest;
                 Visible = Not OpenApprEntrEsists and CanrequestApprovForFlow;
                 Promoted = true;
                 PromotedIsBig = true;
                 PromotedCategory = Process;
                 PromotedOnly = true;
                 trigger OnAction()
                 begin
                     IF allinoneCU.CheckValueBaseApprovalsWorkflowEnabled(Rec) then
                         allinoneCU.OnSendValueBaseWFForApproval(Rec);
                 end;
             }
             action("Cancel Approval Request")
             {
                 ApplicationArea = All;
                 Image = CancelApprovalRequest;
                 Visible = CanCancelapprovalforrecord or CanCancelapprovalforflow;
                 Promoted = true;
                 PromotedIsBig = true;
                 PromotedCategory = Process;
                 PromotedOnly = true;
                 trigger OnAction()
                 begin
                     allinoneCU.OnCancelValueBaseWFForApproval(rec);
                 end;
             }*/
            action(SendApprovalRequestJournalLine)
            {
                ApplicationArea = Basic, Suite;
                //Caption = 'Selected Journal Lines';
                //Enabled = NOT OpenApprovalEntriesOnBatchOrCurrJnlLineExist;
                Image = SendApprovalRequest;
                ToolTip = 'Send selected journal lines for approval.';
                Caption = 'Request Approval';
                trigger OnAction()
                var
                    SalesPrice: Record "Sales Price";
                begin
                    GetCurrentlySelectedLines(Rec);
                    ApprovalsCodeunit.OnSendPurchasePriceForApproval(Rec);
                    //allinoneCU.OnSendValueBaseWFForApproval(Rec);
                end;
            }
            action(CancelApprovalRequestJournalBatch)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Cancel Approval Request';
                //Caption = 'Journal Batch';
                //Enabled = OpenApprovalEntriesOnJnlBatchExist;
                Image = CancelApprovalRequest;
                ToolTip = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.';

                trigger OnAction()
                begin
                    ApprovalsCodeunit.OnCancelPurchasePriceForApproval(Rec);
                    //allinoneCU.OnCancelValueBaseWFForApproval(rec);
                end;
            }
            /*group("Request Approval")
            {

                group(SendApprovalRequest)
                {
                    action(SendApprovalRequestJournalLine)
                    {
                        ApplicationArea = Basic, Suite;
                        //Caption = 'Selected Journal Lines';
                        //Enabled = NOT OpenApprovalEntriesOnBatchOrCurrJnlLineExist;
                        Image = SendApprovalRequest;
                        ToolTip = 'Send selected journal lines for approval.';
                        Caption = 'Request Approval';
                        trigger OnAction()
                        var
                            SalesPrice: Record "Sales Price";
                        begin
                            GetCurrentlySelectedLines(Rec);
                            allinoneCU.OnSendValueBaseWFForApproval(Rec);
                        end;
                    }

                }
                group(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Request';
                    Image = Cancel;
                    action(CancelApprovalRequestJournalBatch)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancel Approval Request';
                        //Caption = 'Journal Batch';
                        //Enabled = OpenApprovalEntriesOnJnlBatchExist;
                        Image = CancelApprovalRequest;
                        ToolTip = 'Cancel sending all journal lines for approval, also those that you may not see because of filters.';

                        trigger OnAction()
                        begin
                            allinoneCU.OnCancelValueBaseWFForApproval(rec);
                        end;
                    }
                }
            }*/

        }
    }
    Procedure GetCurrentlySelectedLines(VAR PurchasePrice: Record "Purchase Price"): Boolean
    BEGIN
        CurrPage.SETSELECTIONFILTER(PurchasePrice);
        EXIT(PurchasePrice.FINDSET());
    END;


    var
        myInt: Integer;
        ApprovalsCodeunit: Codeunit ApprovalsCodeunit;
        approvalmngmt: Codeunit "Approvals Mgmt.";

}
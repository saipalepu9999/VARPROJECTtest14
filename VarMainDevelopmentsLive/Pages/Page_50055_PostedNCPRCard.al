page 50055 "Posted NCPR Card"
{
    ApplicationArea = All;
    //UsageCategory = 
    Caption = 'Posted NCPR Card';
    PageType = Card;
    SourceTable = NCPR;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("IR No."; Rec."IR No.")
                {
                    ToolTip = 'Specifies the value of the IR No. field.';
                    Editable = false;
                }
                field("IR Date"; Rec."IR Date")
                {
                    ToolTip = 'Specifies the value of the IR Date field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
            }
            Group("ProductDescription")
            {
                Caption = 'Product Description';
                field("Product Description"; Rec."Product Description")
                {
                    ToolTip = 'Specifies the value of the Product Description field.';
                    Editable = false;
                }
            }
            group(REFERENCE)
            {
                field("MRV No."; Rec."MRV No.")
                {
                    ToolTip = 'Specifies the value of the MRV No. field.';
                    Editable = false;
                }
                field("MRV Date"; Rec."MRV Date")
                {
                    ToolTip = 'Specifies the value of the MRV Date field.';
                    Editable = false;
                }
                field("Party Name"; Rec."Party Name")
                {
                    ToolTip = 'Specifies the value of the Party Name field.';
                    Editable = false;
                }
                field("Released Prod.Order No"; Rec."Released Prod.Order No")
                {
                    ToolTip = 'Specifies the value of the Released Prod.Order No field.';
                    Editable = false;
                }
                field("Released Prod Order Date"; Rec."Released Prod Order Date")
                {
                    ToolTip = 'Specifies the value of the Released Prod Order Date field.';
                    Editable = false;
                }
            }
            group("Dsecsription Of Non Conformance")
            {
                Caption = 'DESCRIPTION OF NON-CONFORMANCE OF THE PRODUCT:';


                field("Description Initiated By"; Rec."Description Initiated By")
                {
                    ToolTip = 'Specifies the value of the Description Initiated By field.';
                    Editable = false;
                }
                field("Description Initiated Date"; Rec."Description Initiated Date")
                {
                    ToolTip = 'Specifies the value of the Description Initiated Date field.';
                    Editable = false;
                }
                //B2BVCOn14Mar2023>>
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                //B2BVCOn14Mar2023<<
            }
            group("Disposition")
            {

                field(Rework; Rec.Rework)
                {
                    ToolTip = 'Specifies the value of the Rework field.';
                    Editable = false;
                }
                field(Regrade; Rec.Regrade)
                {
                    ToolTip = 'Specifies the value of the Regrade field.';
                    Editable = false;
                }
                field("Reject&Scrap"; Rec."Reject&Scrap")
                {
                    ToolTip = 'Specifies the value of the Reject&Scrap field.';
                    Editable = false;
                }
                field("Reject&Return To Vendor"; Rec."Reject&Return To Vendor")
                {
                    ToolTip = 'Specifies the value of the Reject&Return To Vendor field.';
                    Editable = false;
                }
                field("Authorized/Approved By"; Rec."Authorized/Approved By")
                {
                    ToolTip = 'Specifies the value of the Authorized/Approved By field.';
                    Editable = false;
                }
            }
            group(RootCause)
            {
                Caption = 'Root Cause';
                field("Root Cause"; Rec."Root Cause")
                {
                    ToolTip = 'Specifies the value of the Root Cause field.';
                    Editable = false;
                }
            }
            group(CorrectiveActionPlanned)
            {
                Caption = 'Corrective Action Planned';
                field("Corrective Action Planned"; Rec."Corrective Action Planned")
                {
                    ToolTip = 'Specifies the value of the Corrective Action Planned field.';
                    Editable = false;
                }
                field("Corrctive Initiated By"; Rec."Corrctive Initiated By")
                {
                    ToolTip = 'Specifies the value of the Corrctive Initiated By field.';
                    Editable = false;
                }
                field("Corrective Initiated Date"; Rec."Corrective Initiated Date")
                {
                    ToolTip = 'Specifies the value of the Corrective Initiated Date field.';
                    Editable = false;
                }
            }
            group(CorrectiveActionsImplemented)
            {
                Caption = 'Corrective Action Implemented';

                field("Corrective Action Implemenetd"; Rec."Corrective Action Implemenetd")
                {
                    ToolTip = 'Specifies the value of the Corrective Action Implemenetd field.';
                    Editable = false;
                }
                field("To Be Implemeted By"; Rec."To Be Implemeted By")
                {
                    ToolTip = 'Specifies the value of the To Be Implemeted By field.';
                    Editable = false;
                }
                field("To Be Implemented Date"; Rec."To Be Implemented Date")
                {
                    ToolTip = 'Specifies the value of the To Be Implemented Date field.';
                    Editable = false;
                }
                field("Tobeimplementedby(In house):"; Rec."Tobeimplementedby(In house):")
                {
                    ToolTip = 'Specifies the value of the To be implemented by (In house) : field.';
                    Editable = false;
                }
            }
            group(FollowUpAudit)
            {
                Caption = 'Follow Up Audit';

                field("Follow Up Audit"; Rec."Follow Up Audit")
                {
                    ToolTip = 'Specifies the value of the Follow Up Audit field.';
                    Editable = false;
                }
            }
            group(NCPRClosedNotClosed)
            {
                Caption = 'NCPR Closed/Not Closed';
                field("Ncpr Closed/Not Closed"; Rec."Ncpr Closed/Not Closed")
                {
                    ToolTip = 'Specifies the value of the Ncpr Closed/Not Closed field.';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("NCPR Report")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    NCPRReport: Report "NCP Report";
                    NCPRRec: Record NCPR;
                begin
                    NCPRRec.Reset();
                    NCPRRec.SetRange("No.", Rec."No.");
                    NCPRReport.SetTableView(NCPRRec);
                    NCPRReport.RunModal();
                end;
            }
            action("Release")
            {
                ApplicationArea = All;
                Image = ReleaseDoc;
                Promoted = true;
                Visible = false;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Open then begin
                        Rec.Status := Rec.Status::Release;
                        //CurrPage.Editable(false);
                        Rec.Modify();

                    end;
                end;
            }
            action("Re-Open")
            {
                ApplicationArea = All;
                Image = ReOpen;
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Release then begin
                        Rec.Status := Rec.Status::Open;
                        //CurrPage.Editable(true);
                        Rec.Modify();
                    end;
                end;
            }
        }
    }
    /*trigger OnAfterGetCurrRecord()
    begin
        if Status = Status::Open then
            CurrPage.Editable(true)
        else
            if Status = Status::Release then
                CurrPage.Editable(false);
    end;*/
}

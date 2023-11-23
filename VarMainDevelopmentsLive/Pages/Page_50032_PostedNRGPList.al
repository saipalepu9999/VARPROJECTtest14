page 50032 "Posted NRGP List"
{


    Editable = false;
    PageType = List;
    SourceTable = "NRGP Header";
    SourceTableView = WHERE(Status = FILTER(Posted));
    UsageCategory = Lists;
    ApplicationArea = all;
    CardPageId = "Posted NRGP Header";
    Caption = 'Posted NRDC List';


    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("No. "; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field("Consignee Type"; Rec."Consignee Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Type field.';
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                }
                field("Consignee Name 2"; Rec."Consignee Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Name 2 field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Consignee City"; Rec."Consignee City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee City field.';
                }
                field("Consignee Contact"; Rec."Consignee Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Contact field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Telex No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("Responsible Person Code"; Rec."Responsible Person Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Person Code field.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Person field.';
                }
            }

        }
    }

    actions
    {

        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the &Print action.';

                trigger OnAction()
                var
                    NRGP: Record "NRGP Header";
                begin
                    NRGP.SETRANGE(Status, NRGP.Status::Posted);
                    NRGP.SETRANGE("Document Type", Rec."Document Type");
                    NRGP.SETRANGE("No.", Rec."No.");
                    //REPORT.RUN(Report::NRGP, TRUE, FALSE, NRGP);
                end;
            }
        }
    }

    var

}


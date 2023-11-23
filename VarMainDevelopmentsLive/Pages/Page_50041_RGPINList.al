page 50041 "RGP In List"
{
    Caption = 'RDC In List';
    PageType = List;
    SourceTable = "Gate Pass Header";
    SourceTableView = WHERE("Document Type" = FILTER("RGP In"));
    CardPageId = "RGP In";
    Editable = false;
    //ApplicationArea = all;
    //UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
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
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("External Document No.";
                Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }

                field("Excise Challan No."; Rec."Excise Challan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference No.(If any) field.';
                }
                field("Excise Challan Date"; Rec."Excise Challan Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference Date(If any) field.';
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
        area(navigation)
        {



        }
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
                begin
                    GPInHeader.SETRANGE("Document Type", Rec."Document Type");
                    GPInHeader.SETRANGE("No.", Rec."No.");
                    //REPORT.RUN(Report::"Gate Pass Out", TRUE, FALSE, GPInHeader);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Equipment No", EqptNo);

        Rec."Posting Date" := TODAY;
    end;

    var
        GPInHeader: Record "Gate Pass Header";
        EqptNo: Code[20];



}


pageextension 50030 SalesInvoiceExtension extends "Sales Invoice"
{
    layout
    {
        addlast(General)
        {
            field("Posting No. Series"; Rec."Posting No. Series")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Posting No. Series field.';
            }
            field("Customer Po No."; Rec."Customer Po No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Po No. field.';
            }
            field("Customer Po Date"; Rec."Customer Po Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Po Date field.';
            }
            field(Remarks1; Rec.Remarks1)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks1 field.';
            }
            field(Remarks2; Rec.Remarks2)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks2 field.';
            }
            field("Final Destintion"; Rec."Final Destintion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final Destintion field.';
            }
            field("Amendment No."; Rec."Amendment No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Amendment No. field.';
            }
            field("Amendment Date"; Rec."Amendment Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Amendment Date field.';
            }
            field("Invoice For Rental"; Rec."Invoice For Rental")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Invoice For Rental field.';
            }

        }
        addlast("Tax Info")
        {
            field("BG No."; Rec."BG No.")
            {
                ApplicationArea = All;

            }
            field("BG/FDR"; Rec."BG/FDR")
            {
                ApplicationArea = All;
            }
            field("BG/FDR No."; Rec."BG/FDR No.")
            {
                ApplicationArea = All;
            }
            field("Location GST Reg. No."; Rec."Location GST Reg. No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the GST registration number of the Location specified on the Sales document.';
            }
        }
        modify("VAT Reporting Date")
        {
            Visible = false;
        }
        addlast("Foreign Trade")
        {

            field("Port Of Discharge"; Rec."Port Of Discharge")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Port Of Discharge field.';
            }
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }

        addafter("Tax Info")
        {
            group("Sales Information")
            {
                field("Tender/Project"; Rec."Tender/Project")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender/Project Conformation By Customer field.';
                }
                field("Liquidated Damages"; Rec."Liquidated Damages")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Liquidated Damages field.';
                }
                field("Green Card Applicable"; Rec."Green Card Applicable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Applicable field.';
                    trigger OnValidate()
                    begin
                        if Rec."Green Card Applicable" = Rec."Green Card Applicable"::Yes then
                            EditableGvar := true
                        else
                            EditableGvar := false;
                    end;
                }
                field("Green Card Type"; Rec."Green Card Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Type field.';
                    Editable = EditableGvar;
                }
                field("Green Card Received"; Rec."Green Card Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Received field.';
                    trigger OnValidate()
                    begin
                        if Rec."Green Card Received" = Rec."Green Card Received"::Yes then
                            EditableGvar1 := true
                        else
                            EditableGvar := false;
                    end;
                }

                field("Green Card Receipt Date"; Rec."Green Card Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Receipt Date field.';
                    Editable = EditableGvar1;
                }
            }
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 2 Code_B2B"; Rec."Shortcut Dimension 2 Code_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
            }
        }
        //B2BPR04Jul2023<<<
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                if CopyStr("Location Code", 1, 1) <> CopyStr("No. Series", 1, 1) then
                    Error('Please Select The Correct Location Code');
            end;
        } //B2BPR04Jul2023<<<

    }

    actions
    {
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                Rec.TestField("Location Code");
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                Rec.TestField("Location Code");
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                Rec.TestField("Location Code");
            end;
        }

        addafter("Update Reference Invoice No.")
        {
            action("Draft Commercial Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Draft Commercial Invoice';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    CustomerLrec: Record Customer;
                begin
                    if CustomerLrec.get("Sell-to Customer No.") and (CustomerLrec."GST Customer Type" <> CustomerLrec."GST Customer Type"::Export) then
                        Error('You Cannot Print Export Tax Invoice Because The Customer Type Is %1', CustomerLrec."GST Customer Type");
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() then
                        Report.RunModal(Report::"Sales Commercial Invoice", true, true, SalesHeader);
                end;
            }
            action("Draft Export Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Export Draft Invoice';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    CustomerLrec: Record Customer;
                begin
                    if CustomerLrec.get("Sell-to Customer No.") and (CustomerLrec."GST Customer Type" <> CustomerLrec."GST Customer Type"::Export) then
                        Error('You Cannot Print Export Tax Invoice Because The Customer Type Is %1', CustomerLrec."GST Customer Type");
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() then
                        Report.RunModal(Report::"Export Draft Invoice B2B", true, true, SalesHeader);
                end;
            }
            action("Draft Domestic Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Draft Domestic Invoice';
                //Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    CustomerLrec: Record Customer;
                begin
                    if CustomerLrec.get("Sell-to Customer No.") and (CustomerLrec."GST Customer Type" = CustomerLrec."GST Customer Type"::Export) then
                        Error('You Cannot Print Export Tax Invoice Because The Customer Type Is %1', CustomerLrec."GST Customer Type");
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() then
                        Report.RunModal(Report::"Sales Domestic Invoice", true, true, SalesHeader);


                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Shortcut Dimension 2 Code_B2B" = '' then
            Rec."Shortcut Dimension 2 Code_B2B" := Rec."Shortcut Dimension 2 Code";
    end;

    var
        EditableGvar: Boolean;
        EditableGvar1: Boolean;
}
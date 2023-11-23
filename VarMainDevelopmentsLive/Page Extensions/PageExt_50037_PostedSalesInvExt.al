pageextension 50037 PostedSalesInvExte extends "Posted Sales Invoice"
{
    layout
    {
        addlast(General)
        {

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
            field("BG Margin"; Rec."BG Margin")
            {
                ApplicationArea = all;
            }
            field("BG Margin %"; Rec."BG Margin %")
            {
                ApplicationArea = all;
            }
            field("GCA Exports"; "GCA Exports")
            {
                ApplicationArea = all;
            }
            field("RPA Exports"; "RPA Exports")
            {
                ApplicationArea = all;
            }
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
                field("Green Card Type"; Rec."Green Card Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Type field.';
                }
                field("Green Card Received"; Rec."Green Card Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Received field.';
                }
                field("Green Card Applicable"; Rec."Green Card Applicable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Applicable field.';
                }
                field("Green Card Receipt Date"; Rec."Green Card Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Receipt Date field.';
                }
            }
        }
    }

    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        addafter(Print)
        {

            action("Tax Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Export Tax Invoice';
                //Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    CustomerLrec: Record Customer;
                begin
                    if CustomerLrec.get("Sell-to Customer No.") and (CustomerLrec."GST Customer Type" <> CustomerLrec."GST Customer Type"::Export) then
                        Error('You Cannot Print Export Tax Invoice Because The Customer Type Is %1', CustomerLrec."GST Customer Type");
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", Rec."No.");
                    if SalesInvoiceHeader.FindFirst() then
                        Report.RunModal(Report::"Export Tax Invoice", true, true, SalesInvoiceHeader);
                end;
            }
            action("Proforma Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Proforma Invoice';
                Visible = false;
                //Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", Rec."No.");
                    if SalesInvoiceHeader.FindFirst() then
                        Report.RunModal(Report::"Proforma Invoice", true, true, SalesInvoiceHeader);
                end;
            }
            action("Commercial Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Commercial Invoice';
                //Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    CustomerLrec: Record Customer;
                begin
                    if CustomerLrec.get("Sell-to Customer No.") and (CustomerLrec."GST Customer Type" <> CustomerLrec."GST Customer Type"::Export) then
                        Error('You Cannot Print Export Tax Invoice Because The Customer Type Is %1', CustomerLrec."GST Customer Type");
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", Rec."No.");
                    if SalesInvoiceHeader.FindFirst() then
                        Report.RunModal(Report::"Commercial Invoice", true, true, SalesInvoiceHeader);
                end;
            }
            action("Domestic Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Domestic Invoice';
                //Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    CustomerLrec: Record Customer;
                begin
                    if CustomerLrec.get("Sell-to Customer No.") and (CustomerLrec."GST Customer Type" = CustomerLrec."GST Customer Type"::Export) then
                        Error('You Cannot Print Export Tax Invoice Because The Customer Type Is %1', CustomerLrec."GST Customer Type");
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", Rec."No.");
                    if SalesInvoiceHeader.FindFirst() then
                        Report.RunModal(Report::"Domestic Invoice", true, true, SalesInvoiceHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}
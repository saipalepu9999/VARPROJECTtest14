pageextension 50046 PostedSalesShpmtExt extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Tax Information")
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
        addlast("Tax Information")
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
    }

    actions
    {
        /*modify("Attached Gate Entry")
        {
            Visible = false;
        }*/


        addlast("&Shipment")
        {
            group("Delivery Challan")
            {
                action("RDC Out List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = InwardEntry;
                    RunObject = page "Posted RGP Out List";
                    RunPageLink = "Reference No." = field("No.");
                    ToolTip = 'View attached gate entry list.';
                    Caption = 'RDC Out List';
                }
                action("RDC IN List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = InwardEntry;
                    RunObject = page "Posted RGP IN List";
                    RunPageLink = "Reference No." = field("No.");
                    ToolTip = 'View attached gate entry list.';
                    Caption = 'RDC In List';
                }
                action("NRDC List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = InwardEntry;
                    RunObject = page "Posted NRGP List";
                    RunPageLink = "Reference No." = field("No.");
                    ToolTip = 'View attached gate entry list.';
                    Caption = 'NRDC List';
                }


            }

        }
        /*addafter("&Print")
        {
            action(DeliveryChallan)
            {
                ApplicationArea = All;
                Caption = 'Delivery Challan';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Print;
                Visible = false;
                trigger OnAction()
                var
                    Hdr: Record "Sales Shipment Header";
                begin
                    Hdr.Reset();
                    Hdr.SetRange("Document No.", Rec."No.");
                    Report.RunModal(50013, true, false, Hdr);

                end;
            }
        }*/

    }

    var

}
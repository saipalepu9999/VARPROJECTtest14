pageextension 50036 PostedTransferShpmtExt extends "Posted Transfer Shipment"
{
    layout
    {
        addlast(General)
        {
            field("Production Order No."; Rec."Production Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production Order No. field.';
            }
            field("Sale Order No."; Rec."Sale Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sale Order No. field.';
            }
            field("Production Order Line No."; Rec."Production Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production Order Line No. field.';
            }
            field("Excess Material Returns"; Rec."Excess Material Returns")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Excess Material Returns field.';
            }
            field("Finished Good Transfer"; Rec."Finished Good Transfer")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Finished Good Transfer field.';
            }
            field("Subcon Order No."; Rec."Subcon Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subocn Production Order No. field.';
                Editable = false;
            }
            field("DC Number For Subcon"; Rec."DC Number For Subcon")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the DC No Series For Subcon field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action(MIV)
            {
                Caption = 'MaterialIssuesVoucher';
                ApplicationArea = all;
                Image = Print;
                ToolTip = 'Executes the MaterialIssuesVoucher action.';
                trigger OnAction()
                var
                    Transferhdr: Record "Transfer Header";
                begin
                    Transfshpnthdr.Reset();
                    Transfshpnthdr.SetRange("No.", rec."No.");
                    if Transfshpnthdr.FindFirst() then
                        Report.RunModal(REPORT::MaterialssueVoucher, true, true, Transfshpnthdr);


                end;
            }
        }
        /*modify("Attached Gate Entry")
        {
            Visible = false;
        }*/
        //CHB2B15MAR2023<<
        addafter(MIV)
        {
            action(DCPRINT)
            {
                Caption = 'DC Print';
                ApplicationArea = all;
                Image = Print;
                trigger OnAction()
                var
                    TransferShipmeHead: Record "Transfer Shipment Header";
                begin
                    rec.TestField("Subcon Order No.");
                    TransferShipmeHead.Reset();
                    TransferShipmeHead.SetRange("No.", rec."No.");
                    if TransferShipmeHead.FindFirst() then
                        Report.RunModal(REPORT::RdcPostedTransferShipments, true, true, TransferShipmeHead);


                end;

            }

        }
        //CHB2B15MAR2023>>
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
    }

    var
        myInt: Integer;
        Transfshpnthdr: Record "Transfer Shipment Header";
}
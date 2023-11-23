pageextension 50044 PostedReturnShipmentExt extends "Posted Return Shipment"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        /*modify("Attached Gate Entry")
        {
            Visible = false;
        }*/
        addlast("&Return Shpt.")
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
                action("Print DC")
                {
                    ApplicationArea = All;
                    Image = Print;
                    trigger OnAction()
                    var
                        PostedReturnDhipment: Record "Return Shipment Header";
                    begin
                        PostedReturnDhipment.Reset();
                        PostedReturnDhipment.SetRange("No.", Rec."No.");
                        Report.RunModal(Report::NonReturnableGatepassPro, true, true, PostedReturnDhipment);
                    end;
                }

            }
        }
    }

    var
        myInt: Integer;
}
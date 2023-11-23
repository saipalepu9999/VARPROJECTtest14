pageextension 50031 DimensionValuesExt extends "Dimension Values"
{
    layout
    {
        addlast(Control1)
        {

            field("No Series(PO)"; Rec."No Series(PO)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. Series(PO) field.';
                Visible = false;
            }
            field("Division Code"; Rec."Division Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Division Code field.';
            }
            field("Posting No Series(PO)"; Rec."Posting No Series(PO)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Posting No. Series(PO) field.';
                Visible = false;
            }
            field("Prepmt Cr Memo No Ser(PO)"; Rec."Prepmt Cr Memo No Ser(PO)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prepmt. Cr. Memo No. Series(PO) field.';
                Visible = false;
            }
            field("Prepmt No Series(PO)"; Rec."Prepmt No Series(PO)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prepayment No. Series(PO) field.';
                Visible = false;
            }
            field("Receiving No Series(Po)"; Rec."Receiving No Series(Po)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Receiving No. Series(PO) field.';
                Visible = false;
            }
            field("Return Shpmt No Series(PO)"; Rec."Return Shpmt No Series(PO)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Return Shipment No. Series(PO) field.';
                Visible = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
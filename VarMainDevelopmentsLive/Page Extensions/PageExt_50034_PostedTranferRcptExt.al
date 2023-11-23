pageextension 50034 PostedTransferRcptExt extends "Posted Transfer Receipt"
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
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
pageextension 50055 "Firm Plan prod OrderExt" extends "Firm Planned Prod. Order"
{
    layout
    {
        addlast(General)
        {
            field("Sales Order No"; Rec."Sales Order No")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Sales Order No field.';
            }
            field("Sales Order Line No."; Rec."Sales Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sales Order Line No. field.';
            }
            /*field("Parent Sales Line No."; Rec."Parent Sales Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Parent Sales Order Line No. field.';
            }*/
            field("Lot No."; Rec."Lot No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Lot No. field.';
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
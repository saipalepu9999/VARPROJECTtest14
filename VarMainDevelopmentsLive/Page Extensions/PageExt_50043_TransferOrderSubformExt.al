pageextension 50043 "Transfer Order Subform Ext" extends "Transfer Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Create Indent"; Rec."Create Indent")
            {
                ApplicationArea = All;
                Caption = 'Carry Out Action';
                ToolTip = 'Specifies the value of the Create Indent field.';
            }
            field("Available Inventory"; Rec."Available Inventory")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Available Inventory field.';
            }
            field("Shortage Qty"; Rec."Shortage Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortage Qty field.';
            }
            field("Prod. Expected date"; Rec."Prod. Expected date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prod. Expected Date field.';
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetCurrRecord()
    begin
        begin
            /*  Rec.CalcFields("Available Inventory");
              if (Rec.Quantity - Rec."Available Inventory") > 0 then
                  Rec."Shortage Qty" := Rec.Quantity - Rec."Available Inventory"
              else
                  Rec."Shortage Qty" := 0;*/
        end;
    end;

    var
        myInt: Integer;
}
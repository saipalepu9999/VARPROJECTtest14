pageextension 50075 ProdOrderRoutingExt extends "Prod. Order Routing"
{
    layout
    {
        addlast(Control1)
        {
            
            field("Input Quantity"; Rec."Input Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Input Quantity field.';
            }
            field("Fixed Scrap Qty. (Accum.)"; Rec."Fixed Scrap Qty. (Accum.)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Fixed Scrap Qty. (Accum.) field.';
            }
            field("Direct Unit Cost"; Rec."Direct Unit Cost")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Direct Unit Cost field.';
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
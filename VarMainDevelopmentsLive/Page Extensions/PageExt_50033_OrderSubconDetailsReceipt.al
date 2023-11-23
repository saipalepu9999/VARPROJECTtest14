pageextension 50033 OrderSubconDetailsReceiptExt extends "Order Subcon Details Receipt"
{
    layout
    {
        addafter("Qty. to Reject (V.E.)")
        {
            field("Tolerance Quantity"; Rec."Tolerance Quantity")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Tolerance Quantity field.';
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
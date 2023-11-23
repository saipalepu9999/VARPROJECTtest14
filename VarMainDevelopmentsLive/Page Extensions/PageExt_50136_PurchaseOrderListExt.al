pageextension 50136 PurchaseOrderListExt extends "Purchase Order List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
    }

    var
        myInt: Integer;
}
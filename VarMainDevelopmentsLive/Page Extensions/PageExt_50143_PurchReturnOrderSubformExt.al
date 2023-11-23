pageextension 50143 PurchReturnOrderSubformExt extends "Purchase Return Order Subform"
{
    layout
    {
        addafter("GST Group Code")
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }
}

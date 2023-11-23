pageextension 50120 PurchaseOrderArchieveExt extends "Purchase Order Archive"
{
    layout
    {
        addafter(PurchLinesArchive)
        {
            part(PaymentConditions; "Payment Terms and Condition")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No."),
                "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                "Version No." = field("Version No.");
                UpdatePropagation = Both;
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
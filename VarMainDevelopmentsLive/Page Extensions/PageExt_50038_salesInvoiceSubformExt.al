pageextension 50038 SalesInvoiceSubformExt extends "Sales Invoice Subform"
{
    layout
    {
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
            ApplicationArea = all;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Gen. Bus. Posting Group field.';
            }
        }
        //modify(gen)
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        cu: Codeunit "Purch. Line CaptionClass Mgmt";
}
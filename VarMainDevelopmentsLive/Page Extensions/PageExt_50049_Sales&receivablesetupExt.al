pageextension 50049 "Sales&ReceivablesSetupExt" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Attachment Path"; Rec."Attachment Path")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Attachment Path field.';
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
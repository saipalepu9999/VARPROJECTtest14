pageextension 50069 "SalesQuoteExt" extends "Sales Quote"
{
    layout
    {
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 2 Code_B2B"; Rec."Shortcut Dimension 2 Code_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
            }
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;

        }
        // modify(tax)
    }

    actions
    {
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(MakeOrder)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(MakeInvoice)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Shortcut Dimension 2 Code_B2B" = '' then
            Rec."Shortcut Dimension 2 Code_B2B" := Rec."Shortcut Dimension 2 Code";
    end;

    var
        myInt: Integer;
}
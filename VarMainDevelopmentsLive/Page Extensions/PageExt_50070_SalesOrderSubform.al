pageextension 50070 salesOrderSubform_Ext extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        modify("Item Reference No.")
        {
            Visible = false;
        }
        modify(ShortcutDimCode3)
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        modify(ShortcutDimCode5)
        {
            Visible = false;
        }
        modify(ShortcutDimCode6)
        {
            Visible = false;
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }
        modify(ShortcutDimCode8)
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                SalesHdr: Record "Sales Header";
                ItemRec: Record Item;
            begin
                if type = Type::Item then begin
                    if SalesHdr.get("Document Type", "Document No.") then begin
                        if ItemRec.Get("No.") and (ItemRec."Global Dimension 1 Code" <> SalesHdr."Shortcut Dimension 1 Code") then
                            Error('You Cannot Select This Item When The Division Is %1', SalesHdr."Shortcut Dimension 1 Code");
                    end;
                end;
            end;
        }

        addlast(Control1)
        {

            field("GST Credit"; Rec."GST Credit")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies if the GST credit has to be availed or not.';
            }
            field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
            {
                ApplicationArea = all;
            }
            field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
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
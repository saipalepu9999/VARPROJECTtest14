pageextension 50004 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("Shortcut Dimension 2 Code_B2B"; Rec."Shortcut Dimension 2 Code_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
            }
            field("Item Reclassification Journals"; Rec."Item Reclassification Journals")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Reclassification Journals field.';
            }
            field("Attachment Access"; Rec."Attachment Access")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Attachment Access field.';
            }
            field("Items Access"; Rec."Items Access")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Items Access field.';
            }
            field("Purchase Department Access"; Rec."Purchase Department Access")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Department Access field.';
            }
            field("Prod Order Comp Access"; Rec."Prod Order Comp Access")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prod Order Comp Access field.';
            }
            field("Re-open Accessability"; Rec."Re-open Accessability")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Re-open Accessability field.';
            }
            field("Production User"; Rec."Production User")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production User field.';
            }
            field("Store Approval"; Rec."Store Approval")
            {
                ApplicationArea = all;
            }
            field("QC Approval"; Rec."QC Approval")
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
        Pa: Page 9022;
        Pa1: Page 1310;
}
pageextension 50024 PurchaseInvExt extends "Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field("MSME Certificate No."; Rec."MSME Certificate No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the MSME Certificate No. field.';
            }
            field("MSME Validity Date"; Rec."MSME Validity Date")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the MSME Validity Date field.';
            }
            field("New Remarks"; Rec."New Remarks")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks field.';
            }


        }

        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("VAT Reporting Date")
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
        addafter("Bill of Entry No.")
        {
            field("Duty Involved_B2B"; Rec."Duty Involved_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Duty Involved For Cleared field.';
            }
        }
        //B2BPR04Jul2023<<<
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                if CopyStr("Location Code", 1, 1) <> CopyStr("No. Series", 1, 1) then
                    Error('Please Select The Correct Location Code');
            end;
        } //B2BPR04Jul2023<<<
    }

    actions
    {
        modify("Re&lease")
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(PostAndPrint)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(Preview)
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


}
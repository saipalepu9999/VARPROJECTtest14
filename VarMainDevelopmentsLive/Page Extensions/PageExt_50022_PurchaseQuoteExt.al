pageextension 50023 PurchaseQuoteExt extends "Purchase Quote"
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

        }
        modify("Approval Status")
        {
            Visible = false;
        }
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
    }

    actions
    {
       
        modify(MakeOrder)
        {
            Visible = false;
        }
        
        
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        addlast(processing)
        {
            action("Delete Reservation Entries")
            {
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Delete Reservation Entries action.';
                trigger OnAction()
                Var
                    Reservtionentries: Record "Reservation Entry";
                begin
                    Reservtionentries.Reset();
                    if Reservtionentries.FindSet() then
                        Reservtionentries.DeleteAll();
                    Message('Done');
                end;
            }
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
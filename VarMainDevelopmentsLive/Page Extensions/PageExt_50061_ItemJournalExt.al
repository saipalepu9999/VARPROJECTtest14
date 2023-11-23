pageextension 50061 "Item Journal Ext" extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify(Post)
        {
            Enabled = EditableGvar;
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                //TestField("New Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                //TestField("New Shortcut Dimension 2 Code");
            end;
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Item Reclassification Journals" then begin
            CurrPage.Editable(false);
            EditableGvar := false;
        end else begin
            EditableGvar := true;
            CurrPage.Editable(true);
        end;
    end;

    var
        EditableGvar: Boolean;
}
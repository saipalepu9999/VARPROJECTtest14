pageextension 50060 "ItemReclassJournalExt" extends "Item Reclass. Journal"
{
    layout
    {
        /*modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                InventorySetup: Record "Inventory Setup";
            begin
                if CopyStr(Rec."Item No.", 1, 1) <> CopyStr(Rec."Location Code", 1, 1) then begin
                    //Error('Division Code OF item And Location are not matching Re-enter Item Code/Location');
                    InventorySetup.Get();
                    if InventorySetup."Transfer-From Location" <> Rec."Location Code" then
                        Error('You are not allowed to select this location');
                end;
            end;
        }*/
        /* modify("New Location Code")
         {
             trigger OnAfterValidate()
             var
                 InventorySetup: Record "Inventory Setup";
             begin
                 InventorySetup.Get();
                 if InventorySetup."Transfer-To Location" <> Rec."New Location Code" then
                     Error('You are not allowed to select this location');
             end;
         }*/
    }

    actions
    {
        modify(Post)
        {
            Enabled = EditableGvar;
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("New Shortcut Dimension 1 Code");
                //Rec.TestField("Shortcut Dimension 2 Code");
                Rec.TestField("New Shortcut Dimension 2 Code");
            end;
        }
    }

    /*trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserSetup: record "User Setup";
    begin
        UserSetup.Get(UserId);
        UserSetup.TestField("Item Reclassification Journals");
    end;*/

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
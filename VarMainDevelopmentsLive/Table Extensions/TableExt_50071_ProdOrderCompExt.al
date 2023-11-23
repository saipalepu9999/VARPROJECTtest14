tableextension 50071 "Prod Order Comp Ext" extends "Prod. Order Component"
{
    fields
    {

    }

    var
        UserSetup: Record "User Setup";

    /* trigger OnAfterInsert()
     begin
         if (UserSetup.Get(UserId)) and (not UserSetup."Prod Order Comp Access") then
             Error('You do not have permissions to insert Production Order Components');
     end;

     trigger OnAfterModify()
     begin
         if (UserSetup.Get(UserId)) and (not UserSetup."Prod Order Comp Access") then
             Error('You do not have permissions to modify Production Order Components');
     end;*/
}
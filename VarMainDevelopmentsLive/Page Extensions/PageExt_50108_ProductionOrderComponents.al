pageextension 50108 ProductionOrdereComponentExt extends "Prod. Order Components"
{
    layout
    {

    }

    actions
    {

    }

    var
        UserSetup: Record "User Setup";

    /*trigger OnNewRecord()
    begin
        if (UserSetup.Get(UserId)) and (not UserSetup."Prod Order Comp Access") then
            Error('You do not have permissions to insert Production Order Components');
    end;

    trigger OnAfterModify()
    begin
        if (UserSetup.Get(UserId)) and (not UserSetup."Prod Order Comp Access") then
            Error('You do not have permissions to modify Production Order Components');
    end;*/
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        if (UserSetup.Get(UserId)) and (not UserSetup."Prod Order Comp Access") then
            Error('You do not have permissions to insert Production Order Components');
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if (UserSetup.Get(UserId)) and (not UserSetup."Prod Order Comp Access") then
            Error('You do not have permissions to insert Production Order Components');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if (UserSetup.Get(UserId)) and (not UserSetup."Prod Order Comp Access") then
            Error('You do not have permissions to modify Production Order Components');
    end;
}
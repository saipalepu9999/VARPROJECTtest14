pageextension 50125 TransferOrdersExt extends "Transfer Orders"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        FilterGroup(2);
        SetRange("Created From MRS", false);
        FilterGroup(0);
    end;

    var
        myInt: Integer;
}
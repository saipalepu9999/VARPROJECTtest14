pageextension 50147 PurchaseCrMemoExt extends "Purchase Credit Memo"
{
    layout
    {
        //B2BPR04Jul2023<<<
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                if CopyStr("Location Code", 1, 1) <> CopyStr("No. Series", 1, 1) then
                    Error('Please Select The Correct Location Code');
            end;
        } //B2BPR04Jul2023<<<
        addafter(Status)
        {
            field("New Remarks"; Rec."New Remarks")
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
pageextension 50134 SalesCommentSheetExt extends "Sales Comment Sheet"
{
    layout
    {
        addbefore(Comment)
        {

            field("Code New"; Rec."Code New")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Code field.';
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
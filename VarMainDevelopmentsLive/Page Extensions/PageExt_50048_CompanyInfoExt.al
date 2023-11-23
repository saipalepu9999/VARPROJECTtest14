pageextension 50048 CompanynfoExt extends "Company Information"
{
    layout
    {
        addlast("Tax Information")
        {
            field("I.E.C.No."; Rec."I.E.C.No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the I.E.C.No. field.';

            }
            field("Date Of Commencement"; Rec."Date Of Commencement")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Date Of Commencement Of Production field.';
            }
            field("CIN No."; Rec."CIN No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the CIN No. field.';
            }
        }
    }

    actions
    {

    }

    var
        myInt: Integer;
}
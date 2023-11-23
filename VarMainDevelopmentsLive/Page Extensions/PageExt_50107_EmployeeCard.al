pageextension 50107 EmployeeCard extends "Employee Card"
{
    layout
    {
        addlast(General)
        {
            field(Department; Department)
            {
                ApplicationArea = all;
            }
            field("User ID"; "User ID")
            {
                ApplicationArea = all;
            }
        }
        addlast(Payments)
        {
            field("P.A.N.No."; "P.A.N.No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


}
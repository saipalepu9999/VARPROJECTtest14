pageextension 50114 QCRoleExt extends "Quality Control RC All B2B"
{
    layout
    {
        /*addlast(LayoutGroup)
        {
            part(QCRoles; QCRolePage)
            {
                ApplicationArea = all;
            }
        }*/
        addlast(rolecenter)
        {
            part(QCRoles; QCRolePage)
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

}
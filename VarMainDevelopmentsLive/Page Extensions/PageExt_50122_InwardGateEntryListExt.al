pageextension 50122 InWardGateEntryListExt extends "Inward Gate Entry List"
{
    layout
    {
        addafter("Location Code")
        {
            field(Company; Rec.Company)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Company field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        pa : Page "Sales Order";
}
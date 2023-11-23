pageextension 50121 OutWwardGateEntryListExt extends "Outward Gate Entry List"
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
}
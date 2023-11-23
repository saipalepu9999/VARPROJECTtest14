pageextension 50020 VendorListExtension extends "Vendor List"
{
    //deleteAllowed = false;
    layout
    {
        addlast(Control1)
        {
            field("Net Change"; Rec."Net Change")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Change field.';
            }
            field("Net Change (LCY)"; Rec."Net Change (LCY)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Change (LCY) field.';
            }
            
            field("MSME Applicable"; rec."MSME Applicable")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the MSME Applicable field.';


            }
            field("MSME Certificate No."; rec."MSME Certificate No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the MSME Certificate No. field.';

            }
            field("MSME Validity Date"; rec."MSME Validity Date")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the MSME Validity Date field.';

            }
            field("MSMEownedbySC/STEnterpreneur"; rec."MSMEownedbySC/STEnterpreneur")
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the MSME owned by SC/ST Enterpreneur field.';

            }
            field(MSMEownedbyWomenEnterpreneur; rec.MSMEownedbyWomenEnterpreneur)
            {
                ApplicationArea = all;
                Visible = false;
                ToolTip = 'Specifies the value of the MSME owned by Women Enterpreneur field.';
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
pageextension 50021 VendorCardExtension extends "Vendor Card"
{
    layout
    {
        addlast("Tax Information")
        {
            group("MSME")
            {
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
                    ToolTip = 'Specifies the value of the MSME owned by SC/ST Enterpreneur field.';
                    //Visible = false;

                }
                field(MSMEownedbyWomenEnterpreneur; rec.MSMEownedbyWomenEnterpreneur)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the MSME owned by Women Enterpreneur field.';
                    //Visible = false;
                }


            }
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        addlast(General)
        {
            
            field("Approval Status_B2B"; Rec."Approval Status_B2B")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Approval Status field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        cu: Codeunit 80;
}
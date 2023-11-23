pageextension 50062 InspectionDataSheetExt extends "Inspection Data Sheet B2B"
{
    layout
    {
        addafter("Item Description")
        {

            field("Vendor Test Certificate_B2B"; Rec."Vendor Test Certificate_B2B")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Test Certificate Required field.';
            }
            field("Warranty Certificate_B2B"; Rec."Warranty Certificate_B2B")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty Certificate Required field.';
            }
        }
        addlast(Receipt)
        {

            field("Pc No."; Rec."Pc No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pc No. field.';
            }
            field("Pc Date"; Rec."Pc Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pc Date field.';
            }
            field("Dc No."; Rec."Dc No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dc No. field.';
            }
            field("Dc Date"; Rec."Dc Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dc Date field.';
            }
            field("Bill of Entry No."; Rec."Bill of Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bill of Entry No. field.';
            }
            field("Bill of Entry Date"; Rec."Bill of Entry Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bill of Entry Date field.';
            }
        }

    }

    actions
    {
        addafter("&Print")
        {
            // Add changes to page actions here

        }
    }
    var
        myInt: Integer;
        re: Page "Bank Payment Voucher";
}
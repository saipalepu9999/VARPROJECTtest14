pageextension 50011 InventorySetupExt extends "Inventory Setup"
{
    layout
    {
        addafter(Numbering)
        {
            group("Gate Entry")
            {

                /*field("Inward Gate Entry Nos.NRGP_B2B"; Rec."Inward Gate Entry Nos.NRGP_B2B")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inward Gate Entry Nos.NRGP_B2B field.';
                }
                field("Inward Gate Entry Nos.-RGP_B2B"; Rec."Inward Gate Entry Nos.-RGP_B2B")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inward Gate Entry Nos.-RGP_B2B field.';
                }
                field("Inward NRGP No. Series_B2B"; Rec."Inward NRGP No. Series_B2B")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inward NRGP No. Series_B2B field.';
                }
                field("Inward RGP No. Series_B2B"; Rec."Inward RGP No. Series_B2B")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inward RGP No. Series_B2B field.';
                }
                field("Outward Gate Entry Nos.RGP_B2B"; Rec."Outward Gate Entry Nos.RGP_B2B")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outward Gate Entry Nos.RGP_B2B field.';
                }
                field("Outward Gate EntryNos.NRGP_B2B"; Rec."Outward Gate EntryNos.NRGP_B2B")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outward Gate EntryNos.NRGP_B2B field.';
                }
                field("Outward NRGP No. Series_B2B"; Rec."Outward NRGP No. Series_B2B")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outward NRGP No. Series_B2B field.';
                }
                field("Outward RGP No. Series_B2B"; Rec."Outward RGP No. Series_B2B")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outward RGP No. Series_B2B field.';
                }*/
                field("RGP Out"; Rec."RGP Out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RGP Out field.';
                }
                field("RGP In"; Rec."RGP In")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RGP In field.';
                }
                field(NRGP; Rec.NRGP)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NRGP field.';
                }
                field("Posted NRDC List"; "Posted NRDC List")
                {
                    ApplicationArea = all;
                }
                field("Posted RDC IN List"; "Posted RDC IN List")
                {

                    ApplicationArea = all;
                }
                field("Posted RDC Out List"; "Posted RDC Out List")
                {
                    ApplicationArea = all;
                }
                field("Stores Location(DOM)"; Rec."Stores Location(DOM)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stores Location(DOMESTIC) field.';
                }

            }
        }
        addlast(Numbering)
        {

            field("NCPR Nos."; Rec."NCPR Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NCPR Nos. field.';
            }
            //CHB2B20MAR2023<<
            field("EOU_DOM Nos."; Rec."EOU_DOM Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the EOU_DOM Nos. field.';
            }
            //CHB2B20MAR2023>>
            field("Journal Template Name"; "Journal Template Name")
            {
                ApplicationArea = all;
            }
            field("Journal Batch Name"; "Journal Batch Name")
            {
                ApplicationArea = all;
            }


        }
        addafter("Gate Entry")
        {
            group("Location Configurations")
            {
                field("Stores Location(EOU)"; Rec."Stores Location(EOU)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Stores Location(EOU) field.';
                }
                field("Production Location(DOM)"; Rec."Production Location(DOM)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production Location(DOMESTIC) field.';
                }
                field("Production Location(EOU)"; Rec."Production Location(EOU)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Production Location(EOU) field.';
                }
            }
        }
        addafter("Transfer Order Nos.")
        {

            field("MRS Nos."; Rec."MRS Nos.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the MRS Nos. field.';
            }
        }
        addlast(General)
        {
            field("Attachment Path"; Rec."Attachment Path")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Attachment Path field.';
            }
            field("Transfer-From Location"; Rec."Transfer-From Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer-From Location field.';
            }
            field("Transfer-To Location"; Rec."Transfer-To Location")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Transfer-To Location field.';
            }
            field("Code WorkSheet No."; "Code WorkSheet No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Code WorkSheet No. field.';
            }
            field("Code Worksheet No.(EOU)"; "Code Worksheet No.(EOU)")
            {
                ApplicationArea = All;
            }
        }
        //modify(inwa)
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
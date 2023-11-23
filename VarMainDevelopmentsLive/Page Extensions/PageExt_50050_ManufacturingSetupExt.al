pageextension 50050 ManufacturingSetupExt extends "Manufacturing Setup"
{
    layout
    {
        addlast(General)
        {
            field("Attachment Path"; Rec."Attachment Path")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Attachment Path field.';
            }
            field("Time Based On Output Qty"; Rec."Time Based On Output Qty")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Time Based On Output Qty field.';
            }
        }
        addlast(Numbering)
        {

            field("Planning Orders(DOM)"; Rec."Planning Orders(DOM)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Planning Orders(DOM) field.';
            }
            field("Planning Orders(EOU)"; Rec."Planning Orders(EOU)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Planning Orders(EOU) field.';
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
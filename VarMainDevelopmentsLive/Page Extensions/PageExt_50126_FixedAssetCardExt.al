pageextension 50126 FixedAssetCardExte extends "Fixed Asset Card"
{
    layout
    {
        addlast(General)
        {
            field("QC Status"; Rec."QC Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the QC Status field.';
            }
            field("FA Posting Group"; "FA Posting Group")
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
        myInt: Integer;
}
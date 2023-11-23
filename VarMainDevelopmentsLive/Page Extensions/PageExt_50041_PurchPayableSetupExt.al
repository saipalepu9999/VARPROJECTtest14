pageextension 50041 "Purch&PayableSetupExt" extends "Purchases & Payables Setup"
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
            field(FolderPathReport; Rec.FolderPathReport)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the FolderPathReport field.';
            }
            field("Acknowledgement Path"; Rec."Acknowledgement Path")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Acknowledgement Path field.';
            }
        }
        addlast("Number Series")
        {
            field("MRV No.Series"; Rec."MRV No.Series")
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
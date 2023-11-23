tableextension 50042 "Purchase&PayableSetupExt" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50003; "Attachment Path"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "FolderPathReport"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Acknowledgement Path"; Text[1024])
        {
            DataClassification = ToBeClassified;
            Caption = 'Acknowledgement Path';
        }
        field(50006;"MRV No.Series";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'MRV No.Series';
            TableRelation = "No. Series";
        }

    }

    var
        myInt: Integer;
}
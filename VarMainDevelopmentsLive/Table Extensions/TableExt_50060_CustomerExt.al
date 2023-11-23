tableextension 50060 "Customer Extension" extends Customer
{
    fields
    {
        field(50000; "L.S.T. No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "C.S.T. No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Approval Status_B2B"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Status';
            OptionMembers = Open,"Pending for Approval",Released;
            OptionCaption = 'Open,Pending for Approval,Released';
            Editable = false;
        }
    }

    var
        myInt: Integer;
}
tableextension 50021 PurchasePriceExt extends "Purchase Price"
{
    fields
    {
        field(50000; "Approval Status_B2B"; Option)
        {
            Caption = 'Approvals Status';
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Released;
        }
    }

    var
        myInt: Integer;
}
tableextension 50082 FixedAssetExte extends "Fixed Asset"
{
    fields
    {
        field(50000; "QC Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Accepted,Rejected,"QC Pending",Rework,Hold;
        }
    }

    var
        myInt: Integer;
}
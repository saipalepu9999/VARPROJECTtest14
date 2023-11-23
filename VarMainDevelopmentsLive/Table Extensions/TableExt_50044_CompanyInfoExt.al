tableextension 50044 CompanyInfoExte extends "Company Information"
{
    fields
    {
        field(50000; "I.E.C.No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'I.E.C.No.';
        }
        field(50001; "Date Of Commencement"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Of Commencement Of Production';
        }
        field(50002; "C.S.T No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "CIN No."; Code[20])
        {
            Caption = 'CIN No.';
            DataClassification = CustomerContent;
        }
    }

    var
        myInt: Integer;
}
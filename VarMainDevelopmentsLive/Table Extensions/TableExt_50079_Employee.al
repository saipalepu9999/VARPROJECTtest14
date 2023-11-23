tableextension 50079 EmplyeeExt extends Employee
{
    fields
    {
        field(50010; "Department"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50011; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        field(50012; "P.A.N.No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'P.A.N.No.';
        }
    }

    var
        myInt: Integer;
}
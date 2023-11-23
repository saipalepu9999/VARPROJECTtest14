tableextension 50072 GateEntryHdrExt extends "Gate Entry Header"
{
    fields
    {
        field(50000; "RDC List"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if ("Entry Type" = filter(Outward)) "Posted Gate Pass Header"."No." where("Document Type" = filter("RGP Out"))
            else
            if ("Entry Type" = filter(Inward)) "Posted Gate Pass Header"."No." where("Document Type" = filter("RGP In"));
        }
        field(50001; "NRDC List"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "NRGP Header"."No." where("Document Type" = filter("RGP Out"), Status = const(Posted));
        }
        field(50002; "Company"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
        re: Record "NRGP Header";
}
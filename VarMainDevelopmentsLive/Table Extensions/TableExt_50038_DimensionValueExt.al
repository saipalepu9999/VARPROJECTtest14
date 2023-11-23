tableextension 50038 DimensionValueExt extends "Dimension Value"
{
    fields
    {
        field(50000; "No Series(PO)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No. Series(PO)';
            TableRelation = "No. Series";
        }
        field(50001; "Posting No Series(PO)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Posting No. Series(PO)';
            TableRelation = "No. Series";
        }
        field(50002; "Receiving No Series(Po)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Receiving No. Series(PO)';
            TableRelation = "No. Series";
        }
        field(50003; "Prepmt No Series(PO)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Prepayment No. Series(PO)';
            TableRelation = "No. Series";
        }
        field(50004; "Prepmt Cr Memo No Ser(PO)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Prepmt. Cr. Memo No. Series(PO)';
            TableRelation = "No. Series";
        }
        field(50005; "Return Shpmt No Series(PO)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Return Shipment No. Series(PO)';
            TableRelation = "No. Series";
        }

    }

    var
        myInt: Integer;
}
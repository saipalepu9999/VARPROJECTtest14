tableextension 50083 TransferShipmentLineExt extends "Transfer Shipment Line"
{
    fields
    {
        field(50005; "Prod. Expected date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Required By Date';
        }
    }

    var
        myInt: Integer;
}
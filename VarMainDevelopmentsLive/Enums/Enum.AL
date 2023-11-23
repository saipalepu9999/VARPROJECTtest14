enum 50000 ApprovalStatus
{
    Extensible = true;
    Value(0; Open)
    {

    }
    value(1; "Pending for Approval")
    {

    }
    value(2; Released)
    {

    }
}

enum 50003 PurchaseType
{
    Extensible = true;

    value(0; Import)
    {

    }
    value(1; "Local")
    {

    }
    value(2; "PMS")
    {

    }
    value(3; "Import File")
    {

    }
    value(4; "Service")
    {

    }
    Value(5; " ")
    {

    }
    value(6; "Import Charge")
    {

    }
}

enum 50020 VehicleStatus
{
    Extensible = true;
    value(0; Open)
    {

    }
    Value(1; Release)
    {

    }
    Value(2; Close)
    {

    }
    value(3; "Pending For Approval")
    {

    }
}


enum 50028 GateEntryInOutWard
{
    Extensible = true;
    value(0; Inward)
    {

    }
    value(1; Outward)
    {

    }
}

enum 50038 GateEntryType
{
    Extensible = true;
    value(0; " ")
    {

    }
    value(1; RGP)
    {

    }
    value(2; NRGP)
    {

    }
}



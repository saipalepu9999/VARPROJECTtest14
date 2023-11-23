tableextension 50078 CurrenciesExt extends Currency
{
    fields
    {
        field(50000; "Currency Numeric Description"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Currency Decimal Description"; Code[10])
        {
            DataClassification = CustomerContent;
        }
    }
    
    var
        myInt: Integer;
}
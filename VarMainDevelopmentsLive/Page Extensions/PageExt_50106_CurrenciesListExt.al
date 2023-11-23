pageextension 50106 CurrenciesExt extends Currencies
{
    layout
    {
        addafter(Description)
        {
            field("Currency Numeric Description"; Rec."Currency Numeric Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency Numeric Description field.';
            }
            field("Currency Decimal Description"; Rec."Currency Decimal Description")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency Decimal Description field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
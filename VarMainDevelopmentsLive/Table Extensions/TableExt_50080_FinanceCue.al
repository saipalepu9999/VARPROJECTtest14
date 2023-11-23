tableextension 50080 FinanceCue extends "Finance Cue"
{
    fields
    {
        field(50010; "BG Expiry Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50011; "BG Expiry Today"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Bank Guarantee" where("Expiry Date" = field("BG Expiry Date Filter")));
            Editable = false;
        }
        field(50012; "FDR Maturity Today"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Fixed Deposit_B2B" where("Maturity Date" = field("BG Expiry Date Filter")));
            Editable = false;
        }
        field(50013; "TDS DateFilter"; Date)
        {
            FieldClass = FlowFilter;
        }

        field(50014; "TDS Liability for the Month"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("TDS Entry"."TDS Amount" where("TDS Paid" = const(false)));
        }

    }

    var

}
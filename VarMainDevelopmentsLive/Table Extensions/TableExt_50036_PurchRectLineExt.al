tableextension 50036 "Purchase Rect Line Ext" extends "Purch. Rcpt. Line"
{
    fields
    {
        //4.12 >>
        field(50011; ShortClosed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50012; "Original Qty"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50013; "Short Close Diff Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        //4.12 <<
        field(50014; "Tolerance Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50015; "Original Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50016; "Vendor Test Certificate_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Test Certificate Required';
        }
        field(50017; "Warranty Certificate_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Warranty Certificate Required';
        }
        field(50018; "Open Indent Qty"; Decimal)
        {
            //DataClassification = ToBeClassified;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Indent Line"."Req.Quantity" where("Indent Status" = const(Indent)));
        }
        field(50019; "Printable UOM"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Printable UOM';
            Editable = false;
        }
        field(50026; "Printable Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Printable Qty';
            Editable = false;
        }
        field(50027; "Printable unit rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Printable unit rate';
            Editable = false;

        }
        field(50028; "Printable amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Printable amount';
            Editable = false;
        }
       
    }


}
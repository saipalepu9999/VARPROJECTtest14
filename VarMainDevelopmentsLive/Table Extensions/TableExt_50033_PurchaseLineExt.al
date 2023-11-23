tableextension 50033 "Purchase Line Ext" extends "Purchase Line"
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
            trigger OnValidate()
            begin
                if "Tolerance Quantity" < 0 then
                    Error('Tolerance Quantity Must be greater than 0');
                if xRec."Tolerance Quantity" = 0 then
                    "Original Quantity" := Quantity;
                if "Tolerance Quantity" <> 0 then begin
                    if xRec."Tolerance Quantity" = 0 then
                        Validate(Quantity, (Quantity + "Tolerance Quantity"))
                    else
                        Validate(Quantity, ("Tolerance Quantity"));
                end else
                    Validate(Quantity, "Original Quantity");
            end;
        }
        field(50015; "Original Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50016; "Vendor Test Certificate_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Test Certificate Required';
            Editable = false;
        }
        field(50017; "Warranty Certificate_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Warranty Certificate Required';
            Editable = false;
        }
        field(50019; "Printable UOM"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Printable UOM';
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50026; "Printable Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Printable Qty';
            trigger OnValidate()
            begin
                TestStatusOpen();
                SetCurrency();
                Validate("Printable amount", Round("Printable Qty" * "Printable unit rate", Currency."Amount Rounding Precision"));
            end;
        }
        field(50027; "Printable unit rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Printable unit rate';
            //Editable = false;
            trigger OnValidate()
            begin
                TestStatusOpen();
                SetCurrency();
                Validate("Printable amount", Round("Printable Qty" * "Printable unit rate", Currency."Amount Rounding Precision"));
            end;
        }
        field(50028; "Printable amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Printable amount';
            //Editable = false;
            trigger OnValidate()
            begin
                if ("Printable Qty" <> 0) and ("Printable unit rate" <> 0) then
                    if "Printable amount" <> "Line Amount" then
                        Error('Printable amount must be equal to Line Amount');
            end;
        }
        //B2BSPON05JUNE23
        field(50030; "Short Close Status "; Option)
        {
            OptionMembers = Open,"Short Close";
            DataClassification = ToBeClassified;
        }
        field(65000; "Short Close Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50031; "Short Closed by"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50032; "Short Closed Date & Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(50033; "Short Close"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                PurchHdr: Record "Purchase Header";
                PurcPaySetup: Record "Purchases & Payables Setup";
            begin
                if type = Type::"G/L Account" then
                    "Unit of Measure Code" := 'NOS';
                if type = Type::"G/L Account" then
                    "GST Group Type" := "GST Group Type"::Service;


            end;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnBeforeValidate()
            var
                PurchHeader: Record "Purchase Header";
            begin
                if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                    if CopyStr("Shortcut Dimension 1 Code", 1, 1) <> CopyStr(PurchHeader."No. Series", 1, 1) then
                        Error('Please Select The Correct Division');
                end;
            end;
        }
    }

    local procedure SetCurrency()
    var
        PurchHeader: Record "Purchase Header";
    begin
        Clear(Currency);
        if PurchHeader.Get(Rec."Document Type", Rec."Document No.") then
            if PurchHeader."Currency Code" = '' then
                Currency.InitRoundingPrecision()
            else begin
                PurchHeader.TestField("Currency Factor");
                Currency.Get(PurchHeader."Currency Code");
                Currency.TestField("Amount Rounding Precision");
            end;
    end;

    var
        Currency: Record Currency;
}
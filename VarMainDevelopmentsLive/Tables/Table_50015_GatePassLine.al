table 50015 "Gate Pass Line"
{
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionMembers = "RGP Out","RGP In";
            DataClassification = CustomerContent;
        }
        field(2; "Document No.";
        Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; Type; Option)
        {
            OptionMembers = " ",Item,"Fixed Asset","Non-Stock Item","G/L Account";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "No." := '';
                Description := '';
                "Unit of Measure" := '';
            end;
        }
        field(5; "No."; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) Item."No."
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"."No."
            else
            if (Type = const("G/L Account")) "G/L Account"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                CASE Type OF
                    Type::Item:
                        BEGIN
                            IF Item.GET("No.") THEN BEGIN
                                Description := Item.Description;
                                "Unit of Measure" := Item."Base Unit of Measure";
                                VALIDATE("Unit Rate", Item."Unit Cost");
                            END;
                        END;
                    Type::"Fixed Asset":
                        BEGIN
                            IF FixedAsset.GET("No.") THEN BEGIN
                                Description := FixedAsset.Description;
                                "Unit of Measure" := '';
                            END;
                        END;
                    type::"G/L Account":
                        begin
                            if GlAccount.Get("No.") then begin
                                Description := GlAccount.Name;
                                "Unit of Measure" := '';
                            end;
                        end;
                END;
            end;
        }
        field(6; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Unit of Measure"; Code[20])
        {
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            IF (Type = CONST("Non-Stock Item")) "Unit of Measure".Code;
            DataClassification = CustomerContent;
        }
        field(10; Quantity; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //VALIDATE("Quantity to Receive",Quantity);
                "Remaining Quantity" := Quantity - "Quantity to Receive";
                "Total Value" := ("Unit Rate" * Quantity);
                "Outstanding Amount" := ("Unit Rate" * "Remaining Quantity");
            end;
        }
        field(11; "Quantity to Receive"; Decimal)
        {
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                IF ("Quantity to Receive" < 0) THEN
                    ERROR('Quantity is less than Zero');

                IF "Remaining Quantity" > Quantity THEN
                    ERROR(' Remaining Quantity should not be greater than Quantity');

                // IF "Remaining Quantity" < "Quantity to Receive" THEN
                //     ERROR('Quantity to Receive should not be greater than Remaining Quantity');

                CalcFields("Quantity Received");
                if "Quantity to Receive" > (Quantity - "Quantity Received") then
                    Error('quantity to receive should not be Greater Than %1', Quantity - "Quantity Received");

                //"Outstanding Quantity" := ("Quantity to Receive" * "Unit Rate");
                "Outstanding Amount" := ("Unit Rate" * "Remaining Quantity");

            end;
        }
        field(12; "Quantity Received"; Decimal)
        {
            CalcFormula = Sum("GP Ledger Entry"."Quantity Received" WHERE("Source Type" = CONST("RGP In"),
                                                                            Type = FIELD(Type),
                                                                           "Posted RDC No." = field("Document No."),
                                                                           "No." = FIELD("No."),
                                                                           // "Applied Entries" = FIELD("Applies GP No"),
                                                                           "Line No." = FIELD("Line No.")));
            Description = 'Flow field';
            Editable = false;
            Enabled = true;
            FieldClass = FlowField;
        }
        field(13; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Outstanding Amount" := ("Unit Rate" * "Remaining Quantity");
            end;
        }
        field(20; Status; Option)
        {
            Description = 'If poseted then Posted Rgph';
            OptionMembers = "Not Posted",Posted;
            DataClassification = CustomerContent;
        }
        field(25; "Expected Return Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Applies GP No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(39; "Calibration Status"; Option)
        {
            Description = 'Calibration';
            OptionCaption = 'Not Posted,Posted';
            OptionMembers = "Not Posted",Posted;
            DataClassification = CustomerContent;
        }
        field(40; Remarks; Text[100])
        {
            Caption = 'Purpose of';
            DataClassification = CustomerContent;
        }
        field(50; "RGP Out Document No."; Code[20])
        {
            Description = 'For RGP In Calibration';
            DataClassification = CustomerContent;
        }
        field(51; "RGP Out Line No."; Integer)
        {
            Description = 'For RGP In Calibration';
            DataClassification = CustomerContent;
        }
        field(52; "Recieved Qty"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(53; "Unit Rate"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Total Value" := ("Unit Rate" * Quantity);
                "Outstanding Amount" := ("Unit Rate" * "Remaining Quantity");
            end;
        }
        field(54; "Total Value"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(55; "Outstanding Amount"; Decimal)
        {
            Caption = 'Outstanding Amount';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(58; "Expected date of receipt"; Date)
        {
            Caption = 'Expected date of receipt';
            DataClassification = CustomerContent;
        }
        field(59; "Location Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = '//B2B1.0';
            TableRelation = Location;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type, "No.", Status)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Document Type" = "Document Type"::"RGP Out" THEN
            "Applies GP No" := "Document No.";
    end;

    var
        Item: Record 27;
        FixedAsset: Record 5600;
        GlAccount: Record "G/L Account";
        GPHeader: Record "Gate Pass Header";
        GatePassLine: Record "Gate Pass Line";
        GpLedgerEntry: Record "GP Ledger Entry";
}


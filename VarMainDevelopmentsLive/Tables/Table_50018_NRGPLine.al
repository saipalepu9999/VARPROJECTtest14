table 50018 "NRGP Line"
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
                /*//VALIDATE("Quantity to Receive",Quantity);
                "Remaining Quantity":=Quantity-"Quantity to Receive";
                */

            end;
        }
        field(11; "Quantity to Receive"; Decimal)
        {
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                /*IF ((Quantity=0 ) AND ("Quantity to Receive">0)) OR (Quantity < "Quantity to Receive") THEN
                ERROR('Quantity is less than Quantity to Receive.');
                
                "Remaining Quantity":=Quantity-"Quantity to Receive";
                //MODIFY;
                IF "Remaining Quantity" > Quantity THEN
                 ERROR(' Remaining Quantity should not be greater than Quantity');
                */

            end;
        }
        field(12; "Quantity Received"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("GP Ledger Entry"."Quantity Received" WHERE("Source Type" = CONST("RGP In"),
                                                                           "No." = FIELD("No."),
                                                                           "Applied Entries" = FIELD("Applies GP No")));
            Description = 'Flow field';
            Editable = false;
        }
        field(13; "Remaining Quantity"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
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
        field(40; Remarks; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(45; "Unit Rate"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record 27;
        FixedAsset: Record 5600;
        DimMgt: Codeunit 408;
        GlAccount: Record "G/L Account";


    procedure ShowDimensions()
    begin
        TESTFIELD("Document No.");
        TESTFIELD("Line No.");
        //UPG
        /*
        DocDim.SETRANGE("Table ID",DATABASE::"Data Input Table");
        DocDim.SETRANGE("Document Type",DocDim."Document Type"::"10");
        DocDim.SETRANGE("Document No.","Document No.");
        DocDim.SETRANGE("Line No.","Line No.");
        DocDimensions.SETTABLEVIEW(DocDim);
        DocDimensions.RUNMODAL;
        */
        //UPG

    end;

    procedure OpenItemTrackingLines(IsReclass: Boolean);
    var
        ReserveItemJnlLine: Codeunit "Check Codeunit";
    begin
        ReserveItemJnlLine.CallItemTrackingNRGP(Rec, false);
    end;

    trigger OnDelete()
    var
        ReservationEntry3: REcord "Reservation Entry";
    begin
        ReservationEntry3.Reset;
        ReservationEntry3.setrange("Source ID", Rec."Document No.");
        ReservationEntry3.Setrange("Source Type", Database::"NRGP Line");
        ReservationEntry3.setrange("Source Ref. No.", Rec."Line No.");
        IF ReservationEntry3.findset then
            ReservationEntry3.DeleteAll();

    end;
}


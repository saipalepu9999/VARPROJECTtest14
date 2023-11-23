table 50027 "Sales Planning Schedule"
{
    Caption = 'Sales Planning Schedule';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(3; "Sales Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                           "Document No." = FIELD("Sales Order No."));
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                Item.Get("Item No.");
                "Low-Level Code" := Item."Low-Level Code";
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(6; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(7; Available; Decimal)
        {
            Caption = 'Available';
            DecimalPlaces = 0 : 5;
        }
        field(8; "Next Planning Date"; Date)
        {
            Caption = 'Next Planning Date';
        }
        field(9; "Expected Delivery Date"; Date)
        {
            Caption = 'Expected Delivery Date';
        }
        field(10; "Planning Status"; Option)
        {
            Caption = 'Planning Status';
            OptionCaption = 'None,Simulated,Planned,Firm Planned,Released,Inventory';
            OptionMembers = "None",Simulated,Planned,"Firm Planned",Released,Inventory;
        }
        field(11; "Needs Replanning"; Boolean)
        {
            Caption = 'Needs Replanning';
        }
        field(12; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."),
                                                       Code = FIELD("Variant Code"));
        }
        field(13; "Planned Quantity"; Decimal)
        {
            Caption = 'Planned Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Low-Level Code"; Integer)
        {
            Caption = 'Low-Level Code';
            Editable = false;
        }
        field(16; "Carry Out"; Boolean)
        {
            Caption = 'Carry Out';
        }
        field(17; "Production Order No."; Code[20])
        {
            Caption = 'Production Order No.';
        }
        field(18; "Production Order Status"; Enum "Production Order Status")
        {
            Caption = 'Production Order Status';
        }
        field(19; "Unit Of measurement"; Code[20])
        {
            Caption = 'Unit Of measurement';
        }
        field(20; "Production Bom No."; Code[20])
        {
            Caption = 'Unit Of measurement';
        }
        field(21; "Production Bom Vesion No."; Code[20])
        {
            Caption = 'Unit Of measurement';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Low-Level Code")
        {
        }
    }

    fieldgroups
    {
    }
}
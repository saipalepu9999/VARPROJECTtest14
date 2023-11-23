tableextension 50041 TransferLineExt extends "Transfer Line"
{
    fields
    {
        field(50000; "Available Inventory"; Decimal)
        {
            //DataClassification = ToBeClassified;
            Caption = 'Available Inventory';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Item No." = field("Item No."), "Location Code" = field("Transfer-from Code"), "Global Dimension 1 Code" = field("Shortcut Dimension 1 Code"), "Global Dimension 2 Code" = field("Shortcut Dimension 2 Code")));
        }
        field(50001; "Create Indent"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Indent Created" then
                    Error('Indent Has Already Been Created');
            end;
        }
        field(50002; "Indent Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Shortage Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                CalcFields("Available Inventory");
                if ("Quantity (Base)" - "Available Inventory") > 0 then
                    "Shortage Qty" := "Quantity (Base)" - "Available Inventory"
                else
                    "Shortage Qty" := 0;
            end;
        }
        field(50005; "Prod. Expected date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Required By Date';
        }
    }

    var
        EditableGvar: Boolean;
}
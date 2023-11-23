tableextension 50053 "Production Order Ext" extends "Production Order"
{
    fields
    {
        field(50000; "Sales Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        /*field(50001; "Sales Order No(Parent)"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Parent Sales Order No';
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
        }*/
        field(50002; "Purchase Order No."; Code[20])
        {
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ProdorderRoutingLine: Record "Prod. Order Routing Line";
                ProdOrderLine: Record "Prod. Order Line";
            begin
                TestField("Subcontracting Order", true);
                PurchaseLine.Reset();
                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SetRange("Document No.", "Purchase Order No.");
                PurchaseLine.SetFilter("No.", '<>%1', '');
                if PurchaseLine.FindFirst() then
                    PurchaseLine.TestField("Unit Cost");

                ProdOrderLine.Reset();
                ProdOrderLine.SetRange(Status, Status);
                ProdOrderLine.SetRange("Prod. Order No.", "No.");
                if ProdOrderLine.FindSet() then begin
                    repeat
                        ProdOrderLine."Subcontracting Order" := "Subcontracting Order";
                        ProdOrderLine.Validate("Purchase Order No.", "Purchase Order No.");
                        ProdOrderLine.Modify();
                    until ProdOrderLine.Next() = 0;
                end;
            end;
        }
        field(50003; "Subcontracting Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ProdorderRoutingLine: Record "Prod. Order Routing Line";
                ProdOrderLine: Record "Prod. Order Line";
            begin
                if not "Subcontracting Order" then
                    TestField("Purchase Order No.", '');

                ProdOrderLine.Reset();
                ProdOrderLine.SetRange(Status, Status);
                ProdOrderLine.SetRange("Prod. Order No.", "No.");
                if ProdOrderLine.FindSet() then begin
                    repeat
                        ProdOrderLine."Subcontracting Order" := "Subcontracting Order";
                        ProdOrderLine.Modify();
                    until ProdOrderLine.Next() = 0;
                end;
            end;
        }
        field(50004; "Shortcut Dimension 2 Code_B2B"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
             Blocked = CONST(false), "Division Code" = field("Shortcut Dimension 1 Code"));
            trigger OnValidate()
            begin

                Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code_B2B");
            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()
            begin
                "Shortcut Dimension 2 Code_B2B" := "Shortcut Dimension 2 Code";
            end;
        }
        field(50005; "Lot No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Manual Lot No.';
        }
        field(50006; "Sales Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(50008; "RD"; Boolean)
        {
            DataClassification = ToBeClassified;
        //    Caption = 'R&D';
        }
        /*field(50007; "Parent Sales Line No."; Integer)
        {
            Caption = 'Parent Sales Order Line No.';
            DataClassification = ToBeClassified;
            //Editable = false;
            TableRelation = "Sales Line"."Line No." where("Document Type" = const(Order), "Document No." = field("Sales Order No(Parent)"));
        }*/
    }

    var
        myInt: Integer;
}
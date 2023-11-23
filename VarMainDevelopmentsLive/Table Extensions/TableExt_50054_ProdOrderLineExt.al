tableextension 50054 "Production Order Line Ext" extends "Prod. Order Line"
{
    fields
    {
        field(50000; "Sales Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Purchase Order No."; Code[20])
        {
            TableRelation = "Purchase Header"."No." where("Document Type" = const(Order));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ProdorderRoutingLine: Record "Prod. Order Routing Line";
            begin
                TestField("Subcontracting Order", true);
                PurchaseLine.Reset();
                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SetRange("Document No.", "Purchase Order No.");
                PurchaseLine.SetRange("Line No.", "Purchase Order Line No.");
                PurchaseLine.SetFilter("No.", '<>%1', '');
                if PurchaseLine.FindFirst() then begin
                    PurchaseLine.TestField("Unit Cost");
                    ProdorderRoutingLine.Reset();
                    ProdorderRoutingLine.SetRange(Status, Rec.Status);
                    ProdorderRoutingLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
                    ProdorderRoutingLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
                    ProdorderRoutingLine.SetRange("Routing No.", Rec."Routing No.");
                    if ProdorderRoutingLine.FindFirst() then begin
                        ProdorderRoutingLine.Validate("Direct Unit Cost", PurchaseLine."Unit Cost");
                        ProdorderRoutingLine.Modify();
                    end;
                end;

            end;
        }
        field(50002; "Subcontracting Order"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if not "Subcontracting Order" then
                    TestField("Purchase Order No.", '');
            end;
        }
        field(50003; "Purchase Order Line No."; Integer)
        {
            TableRelation = "Purchase Line"."Line No." where("Document Type" = const(Order), "Document No." = field("Purchase Order No."), "No." = filter(<> ''));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
                ProdorderRoutingLine: Record "Prod. Order Routing Line";
            begin
                TestField("Subcontracting Order", true);
                PurchaseLine.Reset();
                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SetRange("Document No.", "Purchase Order No.");
                PurchaseLine.SetRange("Line No.", "Purchase Order Line No.");
                PurchaseLine.SetFilter("No.", '<>%1', '');
                if PurchaseLine.FindFirst() then begin
                    PurchaseLine.TestField("Unit Cost");
                    ProdorderRoutingLine.Reset();
                    ProdorderRoutingLine.SetRange(Status, Rec.Status);
                    ProdorderRoutingLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
                    ProdorderRoutingLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
                    ProdorderRoutingLine.SetRange("Routing No.", Rec."Routing No.");
                    if ProdorderRoutingLine.FindFirst() then begin
                        ProdorderRoutingLine.Validate("Direct Unit Cost", PurchaseLine."Unit Cost");
                        ProdorderRoutingLine.Modify();
                    end;
                end;

            end;
        }
        field(50004; "Create Mrs"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}
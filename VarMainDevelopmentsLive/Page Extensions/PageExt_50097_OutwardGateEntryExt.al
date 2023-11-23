pageextension 50097 OutwardGateEntryExt extends "Outward Gate Entry"
{
    layout
    {
        addlast(General)
        {

            field("RDC List"; Rec."RDC List")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RDC List field.';
                Caption = 'RDC Out List';
                trigger OnValidate()
                var
                    RDCHdr: Record "Posted Gate Pass Header";
                    RDCLine: Record "Posted Gate Pass Line";
                    QuantityVar: Decimal;
                    GateEntryLine: Record "Gate Entry Line";
                    GateEntryLine2: Record "Gate Entry Line";

                begin
                    GateEntryLine.Reset();
                    GateEntryLine.SetRange("Entry Type", Rec."Entry Type");
                    GateEntryLine.SetRange("Gate Entry No.", Rec."No.");
                    if GateEntryLine.FindSet() then
                        GateEntryLine.DeleteAll();

                    RDCHdr.Reset();
                    RDCHdr.SetRange("Document Type", RDCHdr."Document Type"::"RGP Out");
                    RDCHdr.SetFilter("Reference Type", '<>%1', RDCHdr."Reference Type"::"Purchase Order");
                    RDCHdr.SetRange("No.", Rec."RDC List");
                    if RDCHdr.FindFirst() then begin
                        RDCLine.Reset();
                        RDCLine.SetRange("Document Type", RDCLine."Document Type"::"RGP Out");
                        RDCLine.SetRange("Document No.", Rec."RDC List");
                        if RDCLine.FindSet() then begin
                            RDCLine.CalcSums(Quantity);
                            QuantityVar := RDCLine.Quantity;
                            GateEntryLine2.Init();
                            GateEntryLine2."Entry Type" := Rec."Entry Type";
                            GateEntryLine2."Gate Entry No." := Rec."No.";
                            GateEntryLine2."Line No." := 10000;
                            GateEntryLine2.Insert(true);
                            if RDCHdr."Reference Type" = RDCHdr."Reference Type"::"Sales Shipment" then
                                GateEntryLine2.Validate("Source Type", GateEntryLine2."Source Type"::"Sales Shipment")
                            else
                                if RDCHdr."Reference Type" = RDCHdr."Reference Type"::"Purchase Return Shipment" then
                                    GateEntryLine2.Validate("Source Type", GateEntryLine2."Source Type"::"Purchase Return Shipment")
                                else
                                    if RDCHdr."Reference Type" = RDCHdr."Reference Type"::"Transfer Shipment" then
                                        GateEntryLine2.Validate("Source Type", GateEntryLine2."Source Type"::"Transfer Shipment")
                                    else
                                        if RDCHdr."Reference Type" = RDCHdr."Reference Type"::Inspection then
                                            GateEntryLine2.Validate("Source Type", GateEntryLine2."Source Type"::Inspection) else
                                            if RDCHdr."Reference Type" = RDCHdr."Reference Type"::"Posted Purchase Receipt " then
                                                GateEntryLine2.Validate("Source Type", GateEntryLine2."Source Type"::"Posted Purchase Receipt");
                            if GateEntryLine2."Source Type" <> GateEntryLine2."Source Type"::" " then
                                GateEntryLine2.Validate("Source No.", RDCHdr."Reference No.");
                            GateEntryLine2.Validate(Quantity, QuantityVar);
                            GateEntryLine2.Modify(true);
                        end;
                    end;
                end;
            }
            field("NRDC List"; Rec."NRDC List")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the NRDC List field.';
                Caption = 'NRDC List';
                trigger OnValidate()
                var
                    RDCHdr: Record "NRGP Header";
                    RDCLine: Record "NRGP Line";
                    QuantityVar: Decimal;
                    GateEntryLine: Record "Gate Entry Line";
                    GateEntryLine2: Record "Gate Entry Line";

                begin
                    GateEntryLine.Reset();
                    GateEntryLine.SetRange("Entry Type", Rec."Entry Type");
                    GateEntryLine.SetRange("Gate Entry No.", Rec."No.");
                    if GateEntryLine.FindSet() then
                        GateEntryLine.DeleteAll();

                    RDCHdr.Reset();
                    RDCHdr.SetRange("Document Type", RDCHdr."Document Type"::"RGP Out");
                    RDCHdr.SetFilter("Reference Type", '<>%1', RDCHdr."Reference Type"::"Purchase Order");
                    RDCHdr.SetRange("No.", Rec."NRDC List");
                    RDCHdr.SetRange(Status, RDCHdr.Status::Posted);
                    if RDCHdr.FindFirst() then begin
                        RDCLine.Reset();
                        RDCLine.SetRange("Document Type", RDCLine."Document Type"::"RGP Out");
                        RDCLine.SetRange("Document No.", Rec."NRDC List");
                        if RDCLine.FindSet() then begin
                            RDCLine.CalcSums(Quantity);
                            QuantityVar := RDCLine.Quantity;
                            GateEntryLine2.Init();
                            GateEntryLine2."Entry Type" := Rec."Entry Type";
                            GateEntryLine2."Gate Entry No." := Rec."No.";
                            GateEntryLine2."Line No." := 10000;
                            GateEntryLine2.Insert(true);
                            if RDCHdr."Reference Type" = RDCHdr."Reference Type"::"Sales Shipment" then
                                GateEntryLine2.Validate("Source Type", GateEntryLine2."Source Type"::"Sales Shipment")
                            else
                                if RDCHdr."Reference Type" = RDCHdr."Reference Type"::"Purchase Return Shipment" then
                                    GateEntryLine2.Validate("Source Type", GateEntryLine2."Source Type"::"Purchase Return Shipment")
                                else
                                    if RDCHdr."Reference Type" = RDCHdr."Reference Type"::"Transfer Shipment" then
                                        GateEntryLine2.Validate("Source Type", GateEntryLine2."Source Type"::"Transfer Shipment")
                                    else
                                        if RDCHdr."Reference Type" = RDCHdr."Reference Type"::Inspection then
                                            GateEntryLine2.Validate("Source Type", GateEntryLine2."Source Type"::Inspection) else
                                            if RDCHdr."Reference Type" = RDCHdr."Reference Type"::"Posted Purchase Receipt" then
                                                GateEntryLine2.Validate("Source Type", GateEntryLine2."Source Type"::"Posted Purchase Receipt") else

                                                if GateEntryLine2."Source Type" <> GateEntryLine2."Source Type"::" " then
                                                    GateEntryLine2.Validate("Source No.", RDCHdr."Reference No.");
                            GateEntryLine2.Validate(Quantity, QuantityVar);
                            GateEntryLine2.Modify(true);
                        end;
                    end;
                end;
            }
            field(Company; Rec.Company)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Company field.';
            }
        }
    }

    actions
    {
        modify("Po&st")
        {
            trigger OnAfterAction()
            var
                myInt: Integer;
            begin
                Rec.TestField("Location Code");
            end;
        }
        addafter("Po&st")
        {
            action("Posted RDC List")
            {
                ApplicationArea = All;
                Image = List;
                RunObject = page "Posted RGP Out List";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageLink = "No." = field("RDC List"), "Document Type" = const("RGP Out");
                trigger OnAction()
                begin

                end;
            }
            action("Posted NRDC List")
            {
                ApplicationArea = All;
                Image = List;
                RunObject = page "Posted NRGP List";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunPageLink = "No." = field("NRDC List"), Status = const(Posted);
                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}
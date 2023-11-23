pageextension 50101 OutwardGateEntrySubfmExt extends "Outward Gate Entry SubForm"
{
    layout
    {
        addlast(list)
        {



            field(Quantity; Rec.Quantity)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Quantity field.';
                Editable = false;
            }

        }
        addafter("Source Type")
        {
            field("Source Type New"; Rec."Source Type") //B2BSPON21JUNE23
            {
                Caption = 'Source Type';
                ValuesAllowed = " ", "Sales Shipment", "Purchase Return Shipment", "Transfer Shipment", Inspection, "Purchase Order";
                ApplicationArea = all;
            }
        }
       
        modify("Source Type")//B2BSPON21JUNE23
        {
            Visible = false;
        }
        modify("Source No.")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                InspectionHeader: Record "Inspection Receipt Header B2B";
            begin
                GateEntryHeader.Get(Rec."Entry Type", Rec."Gate Entry No.");
                case Rec."Source Type" of
                    Rec."Source Type"::"Sales Shipment":
                        begin
                            SalesShipHeader.Reset();
                            SalesShipHeader.FilterGroup(2);
                            SalesShipHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                            SalesShipHeader.FilterGroup(0);
                            if Page.RunModal(0, SalesShipHeader) = Action::LookupOK then
                                Rec.Validate("Source No.", SalesShipHeader."No.");
                        end;
                    Rec."Source Type"::"Sales Return Order":
                        begin
                            SalesHeader.Reset();
                            SalesHeader.FilterGroup(2);
                            SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Return Order");
                            SalesHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                            SalesHeader.FilterGroup(0);
                            if Page.RunModal(0, SalesHeader) = Action::LookupOK then
                                Rec.Validate("Source No.", SalesHeader."No.");
                        end;
                    Rec."Source Type"::"Purchase Order":
                        begin
                            PurchHeader.Reset();
                            PurchHeader.FilterGroup(2);
                            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                            PurchHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                            PurchHeader.FilterGroup(0);
                            if Page.RunModal(0, PurchHeader) = Action::LookupOK then
                                Rec.Validate("Source No.", PurchHeader."No.");
                        end;
                    Rec."Source Type"::"Purchase Return Shipment":
                        begin
                            ReturnShipHeader.Reset();
                            ReturnShipHeader.FilterGroup(2);
                            ReturnShipHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                            ReturnShipHeader.FilterGroup(0);
                            if Page.RunModal(0, ReturnShipHeader) = Action::LookupOK then
                                Rec.Validate("Source No.", ReturnShipHeader."No.");
                        end;
                    Rec."Source Type"::"Transfer Receipt":
                        begin
                            TransHeader.Reset();
                            TransHeader.FilterGroup(2);
                            TransHeader.SetRange("Transfer-to Code", GateEntryHeader."Location Code");
                            TransHeader.FilterGroup(0);
                            if Page.RunModal(0, TransHeader) = Action::LookupOK then
                                Rec.Validate("Source No.", TransHeader."No.");
                        end;
                    Rec."Source Type"::"Transfer Shipment":
                        begin
                            TransShptHeader.Reset();
                            TransShptHeader.FilterGroup(2);
                            TransShptHeader.SetRange("Transfer-from Code", GateEntryHeader."Location Code");
                            TransShptHeader.FilterGroup(0);
                            if Page.RunModal(0, TransShptHeader) = Action::LookupOK then
                                Rec.Validate("Source No.", TransShptHeader."No.");
                        end;
                    rec."Source Type"::Inspection:
                        begin
                            InspectionHeader.Reset();
                            //InspectionHeader.FilterGroup(2);
                            InspectionHeader.SetFilter("Qty. Rework", '<>%1', 0);
                            InspectionHeader.SetRange(Status, false);
                            //InspectionHeader.FilterGroup(0);
                            if Page.RunModal(Page::"Inspection Receipt List B2B", InspectionHeader) = Action::LookupOK then
                                Rec.Validate("Source No.", InspectionHeader."No.");
                        end;
                end;


            end;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    var
        PurchHeader: Record "Purchase Header";
        SalesShipHeader: Record "Sales Shipment Header";
        TransHeader: Record "Transfer Header";
        SalesHeader: Record "Sales Header";
        ReturnShipHeader: Record "Return Shipment Header";
        TransShptHeader: Record "Transfer Shipment Header";
        GateEntryHeader: Record "Gate Entry Header";
        InspectionReceipt: Record "Inspection Receipt Header B2B";

}
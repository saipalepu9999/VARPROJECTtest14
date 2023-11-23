report 50045 "Posted Gate Entry Modification"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Posted Gate Entry Header"; "Posted Gate Entry Header")
        {
            //RequestFilterFields = "Entry Type", "No.";

            dataitem("Posted Gate Entry Line"; "Posted Gate Entry Line")
            {
                DataItemLinkReference = "Posted Gate Entry Header";
                DataItemLink = "Entry Type" = field("Entry Type"), "Gate Entry No." = field("No.");
                trigger OnAfterGetRecord()
                begin
                    if SourceTypeGvar = SourceTypeGvar::" " then
                        Validate("Source Type", "Source Type"::" ")
                    else
                        if SourceTypeGvar = SourceTypeGvar::"Purchase Order" then
                            Validate("Source Type", "Source Type"::"Purchase Order")
                        else
                            if SourceTypeGvar = SourceTypeGvar::"Purchase Return Shipment" then
                                Validate("Source Type", "Source Type"::"Purchase Return Shipment")
                            else
                                if SourceTypeGvar = SourceTypeGvar::"Sales Return Order" then
                                    Validate("Source Type", "Source Type"::"Sales Return Order")
                                else
                                    if SourceTypeGvar = SourceTypeGvar::"Sales Shipment" then
                                        Validate("Source Type", "Source Type"::"Sales Shipment")
                                    else
                                        if SourceTypeGvar = SourceTypeGvar::"Transfer Receipt" then
                                            Validate("Source Type", "Source Type"::"Transfer Receipt")
                                        else
                                            if SourceTypeGvar = SourceTypeGvar::"Transfer Shipment" then
                                                Validate("Source Type", "Source Type"::"Transfer Shipment");
                    Validate("Source No.", SourceNoGvar);
                    Validate(Description, DescriptionGvar);
                    Validate(Quantity, QuantityGvar);
                    Modify();
                end;
            }
            trigger OnPreDataItem()
            begin
                if EntryTypeGvar = EntryTypeGvar::Inward then
                    SetRange("Entry Type", "Entry Type"::Inward)
                else
                    if EntryTypeGvar = EntryTypeGvar::OutWard then
                        SetRange("Entry Type", "Entry Type"::Outward);
                SetRange("No.", GateEntryNo);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(EntryTypeGvar; EntryTypeGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Entry Type';
                    }
                    field(GateEntryNo; GateEntryNo)
                    {
                        ApplicationArea = all;
                        Caption = 'Gate Entry No.';
                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            if EntryTypeGvar = EntryTypeGvar::OutWard then begin
                                PostedGateEntryHeader.Reset();
                                PostedGateEntryHeader.SetRange("Entry Type", PostedGateEntryHeader."Entry Type"::Outward);
                                if PostedGateEntryHeader.FindSet() then begin
                                    if Page.RunModal(Page::"Posted Outward Gate Entry List", PostedGateEntryHeader) = Action::LookupOK then
                                        GateEntryNo := PostedGateEntryHeader."No.";
                                end;
                            end else
                                if EntryTypeGvar = EntryTypeGvar::Inward then begin
                                    PostedGateEntryHeader.Reset();
                                    PostedGateEntryHeader.SetRange("Entry Type", PostedGateEntryHeader."Entry Type"::Inward);
                                    if PostedGateEntryHeader.FindSet() then begin
                                        if Page.RunModal(Page::"Posted Inward Gate Entry List", PostedGateEntryHeader) = Action::LookupOK then
                                            GateEntryNo := PostedGateEntryHeader."No.";
                                    end;
                                end;
                        end;

                    }
                    field(SourceTypeGvar; SourceTypeGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Source Type';
                    }
                    field(SourceNoGvar; SourceNoGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Source No.';
                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            case SourceTypeGvar of
                                SourceTypeGvar::"Sales Shipment":
                                    begin
                                        SalesShipHeader.Reset();
                                        //SalesShipHeader.FilterGroup(2);
                                        //SalesShipHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                                        //SalesShipHeader.FilterGroup(0);
                                        if Page.RunModal(0, SalesShipHeader) = Action::LookupOK then
                                            SourceNoGvar := SalesShipHeader."No.";
                                    end;
                                SourceTypeGvar::"Sales Return Order":
                                    begin
                                        SalesHeader.Reset();
                                        SalesHeader.FilterGroup(2);
                                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Return Order");
                                        //SalesHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                                        SalesHeader.FilterGroup(0);
                                        if Page.RunModal(0, SalesHeader) = Action::LookupOK then
                                            SourceNoGvar := SalesHeader."No.";
                                    end;
                                SourceTypeGvar::"Purchase Order":
                                    begin
                                        PurchHeader.Reset();
                                        PurchHeader.FilterGroup(2);
                                        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
                                        //PurchHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                                        PurchHeader.FilterGroup(0);
                                        if Page.RunModal(0, PurchHeader) = Action::LookupOK then
                                            SourceNoGvar := PurchHeader."No.";
                                    end;
                                SourceTypeGvar::"Purchase Return Shipment":
                                    begin
                                        ReturnShipHeader.Reset();
                                        //ReturnShipHeader.FilterGroup(2);
                                        //ReturnShipHeader.SetRange("Location Code", GateEntryHeader."Location Code");
                                        //ReturnShipHeader.FilterGroup(0);
                                        if Page.RunModal(0, ReturnShipHeader) = Action::LookupOK then
                                            SourceNoGvar := ReturnShipHeader."No.";
                                    end;
                                SourceTypeGvar::"Transfer Receipt":
                                    begin
                                        TransHeader.Reset();
                                        //TransHeader.FilterGroup(2);
                                        //TransHeader.SetRange("Transfer-to Code", GateEntryHeader."Location Code");
                                        //TransHeader.FilterGroup(0);
                                        if Page.RunModal(0, TransHeader) = Action::LookupOK then
                                            SourceNoGvar := TransHeader."No.";
                                    end;
                                SourceTypeGvar::"Transfer Shipment":
                                    begin
                                        TransShptHeader.Reset();
                                        //TransShptHeader.FilterGroup(2);
                                        //TransShptHeader.SetRange("Transfer-from Code", GateEntryHeader."Location Code");
                                        //TransShptHeader.FilterGroup(0);
                                        if Page.RunModal(0, TransShptHeader) = Action::LookupOK then
                                            SourceNoGvar := TransShptHeader."No.";
                                    end
                            end;
                        end;

                    }
                    field(DescriptionGvar; DescriptionGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Description';
                    }
                    field(QuantityGvar; QuantityGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Quantity';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        SourceTypeGvar: Option " ","Sales Shipment","Sales Return Order","Purchase Order","Purchase Return Shipment","Transfer Receipt","Transfer Shipment";
        SourceNoGvar: code[20];
        DescriptionGvar: Text[80];
        QuantityGvar: Decimal;
        pa: page 18607;
        PurchHeader: Record "Purchase Header";
        SalesShipHeader: Record "Sales Shipment Header";
        TransHeader: Record "Transfer Header";
        SalesHeader: Record "Sales Header";
        ReturnShipHeader: Record "Return Shipment Header";
        TransShptHeader: Record "Transfer Shipment Header";
        GateEntryHeader: Record "Gate Entry Header";
        GateEntry: Record "Gate Entry Header";
        EntryTypeGvar: Option OutWard,Inward;
        GateEntryNo: Code[20];
        PuLine: Record "Purchase Line";
        PostedGateEntryHeader: Record "Posted Gate Entry Header";
        PostedInwardPage: Page "Posted Inward Gate Entry List";
        PostedOutwardPage: Page "Posted Outward Gate Entry List";
}
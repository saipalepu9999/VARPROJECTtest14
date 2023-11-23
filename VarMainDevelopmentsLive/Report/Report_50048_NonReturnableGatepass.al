report 50048 NonReturnableGatepass
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Non Returnable Gate Pass';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\NonReturnable.rdl';
    dataset
    {
        dataitem("Gate Entry Header_B2B"; "NRGP Header")
        {
            DataItemTableView = where(Status = const(Posted));
            column(VEPLFCapLbl; VEPLFCapLbl) { }
            column(Address_GateEntryHeader_B2B; Address)
            {
            }
            column(WayBillNo_GateEntryHeader_B2B; "Way Bill No.")
            {
            }
            column(ConsigneeName_GateEntryHeader_B2B; "Consignee Name")
            {
            }
            column(NameGvar; NameGvar)
            { }
            column(AddressGvar; AddressGvar)
            { }
            column(No_GateEntryHeader_B2B; "No.")
            {
            }
            column(PostingDate_GateEntryHeader_B2B; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(ReferenceNo_GateEntryHeader_B2B; PurchGvar)
            {
            }
            column(Excise_Challan_Date; format("Excise Challan Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            /* column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
             { }*/
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
            { }
            column(CompanyInfoGrec; CompanyInfoGrec."State Code")
            { }
            column(LocationGrecAddress_Address; LocationGrec.Address)
            {

            }
            column(LocationGrec_Address2; LocationGrec."Address 2")
            { }
            column(LocationGrec_PostCode; LocationGrec."Post Code")
            { }
            column(LocationGrec_City; LocationGrec.City)
            { }
            column(LocationGrec_Country; LocationGrec."Country/Region Code")
            { }
            column(LocationGrec_state; LocationGrec."State Code")
            { }
            column(LocationGrec_PhoneNo; LocationGrec."Phone No.")
            { }
            column(LocationGrec_GstNo; LocationGrec."GST Registration No.")
            { }


            column(CompanyInfoGrec_Picture; CompanyInfoGrec.Picture)
            { }
            column(DeliverCapLbl; DeliverCapLbl)
            { }
            column(ReturnaCapLbl; ReturnaCapLbl)
            { }
            column(DCCapLbl; DCCapLbl)
            { }
            column(ToCapLbl; ToCapLbl)
            { }
            column(MsCapLbl; MsCapLbl)
            { }
            column(AgainstCapLbl; AgainstCapLbl)
            { }
            column(DateCapLbl; DateCapLbl)
            { }
            column(PleaseConveyCapLbl; PleaseConveyCapLbl)
            { }
            column(SLCapLbl; SLCapLbl)
            { }
            column(DescCapLbl; DescCapLbl)
            { }
            column(QuantCapLbl; QuantCapLbl)
            { }
            column(RemarksCapLbl; RemarksCapLbl)
            { }
            column(GSTINCapLbl; GSTINCapLbl)
            { }
            column(FORCapLbl; FORCapLbl) { }
            column(ReceiverSigCapLbl; ReceiverSigCapLbl)
            { }
            column(StoresCapLbl; StoresCapLbl)
            { }
            column(AuthSigCapLbl; AuthSigCapLbl)
            { }
            column(RetNonRetCap; RetNonRetCap)
            { }
            column(RemarksB2B; RemarksText)
            {

            }
            column(OrderDateGvar; format(OrderDateGvar, 0, '<Day,2>-<Month,2>-<Year4>'))

            { }
            column(GstNo; GstNo)
            { }
            column(CountryGrec_Name; countryName)
            { }
            column(StateGrec_Description; StateName)
            { }
            dataitem("Gate Entry Line_B2B"; "NRGP Line")
            {
                //DataItemLinkReference = "Gate Pass Header";
                //DataItemLink = "Entry Type" = FIELD("Entry Type"),
                //"type" = field("Type"),
                //              "Gate Entry No." = FIELD("No.");
                DataItemLinkReference = "Gate Entry Header_B2B";
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(Quantity_Received; "Quantity Received")
                { }
                column(Quantity; Quantity)
                { }
                column(Remarks; Remarks)
                { }
                column(No_; "No.")
                { }
                column(Description; Description)
                { }
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    //Clear(LocationGrec);
                    Clear(StateGrec);
                    Clear(CountryGrec);
                    //if LocationGrec.Get("Location Code") then;
                    GstNo := LocationGrec."GST Registration No.";

                end;
            }
            trigger OnAfterGetRecord()
            var
                TransferShipment: Record "Transfer Shipment Header";
                PurchaseReceipt: Record "Purch. Rcpt. Header";
                ProdLine: Record "Prod. Order Line";
            begin
                //B2BSSD09Jan2023<<
                Clear(LocationGrec);
                Clear(StateGrec);
                Clear(CountryGrec);
                Clear(CountryName);
                Clear(StateName);
                if LocationGrec.Get("Location Code") then;
                if CountryGrec.Get(LocationGrec."Country/Region Code") then
                    CountryName := CountryGrec.Name;
                if StateGrec.Get(LocationGrec."State Code") then
                    StateName := StateGrec.Description;
                //B2BSSD09Jan2023>>
                //if Type = Type::RGP then
                //    RetNonRetCap := 'RETURNABLE'
                //else
                //    if Type = Type::NRGP then
                if ("Reference Type" = "Reference Type"::"Transfer Shipment") and ("Consignee Type" = "Consignee Type"::Vendor) then begin
                    RemarksText := RemarksLabel;
                    RetNonRetCap := JobWorkdCCap
                end ELSE
                    RetNonRetCap := NonRetrunCap;
                if "Reference Type" = "Reference Type"::"Purchase Order" then begin
                    if PurchaseHedaer.get(PurchaseHedaer."Document Type"::Order, "Reference No.") then
                        OrderDateGvar := PurchaseHedaer."Posting Date";

                end else
                    if "Reference Type" = "Reference Type"::"Purchase Return Shipment" then begin
                        if ReturnShipHr.Get("Reference No.") then
                            OrderDateGvar := ReturnShipHr."Posting Date";
                    end else
                        if "Reference Type" = "Reference Type"::"Sales Shipment" then begin
                            if SalesShipHdr.Get("Reference No.") then
                                OrderDateGvar := SalesShipHdr."Posting Date";
                        end else
                            if "Reference Type" = "Reference Type"::"Transfer Shipment" then begin
                                if TransferShipment.Get("Reference No.") then
                                    OrderDateGvar := TransferShipment."Posting Date";
                            end else
                                if "Reference Type" = "Reference Type"::"Posted Purchase Receipt" then begin
                                    if PurchaseReceipt.Get("Reference No.") then
                                        OrderDateGvar := PurchaseReceipt."Posting Date";
                                end;
                if LocationGrec.Get("Location Code") then begin
                    GstNo := LocationGrec."GST Registration No.";
                    AddressVar := LocationGrec."Address 2"
                end;
                if ("Reference Type" = "Reference Type"::"Transfer Shipment") and ("Consignee Type" = "Consignee Type"::Vendor) then begin
                    TransferShipment.Reset();
                    TransferShipment.SetRange("No.", "Gate Entry Header_B2B"."Reference No.");
                    TransferShipment.SetFilter("Production Order No.", '<>%1', '');
                    if TransferShipment.FindFirst() then begin
                        ProdLine.Reset();
                        ProdLine.SetRange(Status, ProdLine.Status::Released);
                        ProdLine.SetRange("Prod. Order No.", TransferShipment."Production Order No.");
                        ProdLine.SetFilter("Purchase Order No.", '<>%1', '');
                        if ProdLine.FindFirst() then
                            PurchGvar := ProdLine."Purchase Order No."


                        else
                            PurchGvar := "Gate Entry Header_B2B"."Reference No.";
                    end;

                end else
                    PurchGvar := "Reference No.";

                if ("Reference Type" = "Reference Type"::"Sales Shipment") and ("Consignee Type" = "Consignee Type"::Customer) then begin

                    RetNonRetCap := '';
                    if SalesShipHdr.Get("Reference No.") then
                        PurchGvar := SalesShipHdr."Customer Po No."
                    else
                        PurchGvar := '';

                    if (SalesShipHdr."Bill-to Name" <> '') and (SalesShipHdr."Bill-to Address" <> '') then begin
                        NameGvar := SalesShipHdr."Ship-to Name";
                        AddressGvar := SalesShipHdr."Ship-to Address";
                    end;
                end;

            end;

        }
    }
    trigger OnPreReport()
    begin
        CompanyInfoGrec.Get();
        CompanyInfoGrec.CalcFields(Picture);
    end;
    /*requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

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
    }*/
    var

        PurchaseHedaer: Record "Purchase Header";
        OrderDateGvar: Date;
        SalesShipHdr: Record "Sales Shipment Header";
        TransferShipment: Record "Transfer Shipment Header";
        ReturnShipHr: Record "Return Shipment Header";
        CompanyInfoGrec: Record "Company Information";
        NameGvar: Text;
        AddressGvar: Text;
        VEPLFCapLbl: Label 'VEPLF\STR\MDC';
        DeliverCapLbl: Label 'DELIVERY CHALLAN';
        ReturnaCapLbl: Label 'RETURNABLE';
        DCCapLbl: Label 'D.C. No.:';
        ToCapLbl: Label 'TO,';
        MsCapLbl: Label 'M/S.';
        AgainstCapLbl: Label 'Against Order No.';
        DateCapLbl: Label 'Date';
        PleaseConveyCapLbl: Label 'Please receive the following goods in good order and condition and return the duplicate duly signed with Company’s Stamp.';
        SLCapLbl: Label 'SNO.';
        DescCapLbl: Label 'Description';
        QuantCapLbl: Label 'Quantity';
        RemarksCapLbl: Label 'Remarks';
        GSTINCapLbl: Label 'GSTIN';
        FORCapLbl: Label 'FOR VAR ELECTROCHEM PVT. LTD';
        ReceiverSigCapLbl: Label 'Receivers Signature';
        StoresCapLbl: Label 'Stores Copy';
        AuthSigCapLbl: Label 'Authorised Signature';
        RetNonRetCap: Text;
        gate: Record 18607;
        //LocationGrec: Record Location;
        GstNo: Text;
        LocationGrec: Record Location;
        // GstNo: Text;
        CountryGrec: Record "Country/Region";
        StateGrec: Record State;
        PurchGvar: Code[50];
        JobWorkdCCap: Label 'JOB WORK-NRDC';
        NonRetrunCap: Label 'NON RETURNABLE';
        RemarksLabel: Label 'Remarks:-  NRDC is  being raised Since the material recived after Process is another form';
        RemarksText: text;
        AddressVar: text;
        CountryName: Text;
        StateName: Text;
        SalesShpmntHdr: Record "Sales Shipment Header";



}
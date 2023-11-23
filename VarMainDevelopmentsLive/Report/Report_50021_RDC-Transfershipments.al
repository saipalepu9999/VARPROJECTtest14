report 50021 RdcPostedTransferShipments
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'RDC-Posted Transfer Shipments';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\PostedTransShipRdc.rdl';
    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            //DataItemTableView = where(Status = const(Posted));
            column(VEPLFCapLbl; VEPLFCapLbl) { }

            column(No_GateEntryHeader_B2B; "No.")
            {
            }
            /*column(ReturnOrderNo_ReturnShipmentHeader; "Return Order No.")
            {
            }
            column(BuyfromVendorNo_ReturnShipmentHeader; "Buy-from Vendor No.")
            {
            }*/
            column(PostingDate_GateEntryHeader_B2B; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(TransferOrderNo_TransferShipmentHeader; "Transfer Order No.")
            {
            }
            /*column(BuyfromAddress_ReturnShipmentHeader; "Buy-from Address")
            {
            }
            column(BuyfromVendorName_ReturnShipmentHeader; "Buy-from Vendor Name")
            {
            }*/

            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
            { }
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
            { }
            //B2BSSD09Jan2023<<
            column(Location_Address; LocationGrec.Address)
            { }
            column(Location_Address2; LocationGrec."Address 2")
            { }
            column(LocationGrec_PostCode; LocationGrec."Post Code")
            { }
            //B2Bspon1jube2023>>
            column(ToName; ToName)
            {

            }
            column(ToAddress1; ToAddress1)
            {

            }
            column(ToAddress2; ToAddress2)
            {

            }
            //B2Bspon1jube2023<<
            //B2BSSD09Jan2023>>
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
            column(OrderDateGvar; OrderDateGvar)
            { }
            column(GstNo; GstNo)
            { }
            column(CountryGrec_Name; CountryGrec.Name)
            { }
            column(StateGrec_Description; StateGrec.Description)
            { }
            column(BuyFromAddress1; BuyFromAddress1)
            { }
            column(BuyFromAddress2; BuyFromAddress2)
            { }
            column(BuyFromCity; BuyFromCity)
            { }
            column(DC_Number_For_Subcon; "DC Number For Subcon")
            { }
            column(JobWorkCap; JobWorkCap)
            { }
            column(EwaybillnoCap; EwaybillnoCap)
            { }
            column(EwaybillDateCap; EwaybillDateCap)
            { }
            column(AuthorizedSigCap; AuthorizedSigCap)
            { }
            column(PoNoGVar; PoNoGVar)
            { }
            column(PoDateGvar; format(PoDateGvar, 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                //DataItemLinkReference = "Gate Pass Header";
                //DataItemLink = "Entry Type" = FIELD("Entry Type"),
                //"type" = field("Type"),
                //              "Gate Entry No." = FIELD("No.");
                DataItemLinkReference = "Transfer Shipment Header";
                DataItemLink = "Document No." = field("No.");
                //DataItemTableView = WHERE(Type=CONST("Item"));
                column(Quantity; Quantity)
                { }


                column(No_; "Item No.")
                {
                }
                column(Description; Description)
                { }
                trigger OnPreDataItem()
                begin
                    // SetRange(Type, Type::Item);
                end;

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
            begin
                //B2BSSD09Jan2023<<
                Clear(LocationGrec);
                Clear(StateGrec);
                Clear(CountryGrec);
                Clear(VendorGrec);
                clear(BuyFromAddress1);
                Clear(BuyFromAddress2);
                Clear(BuyFromCity);
                Clear(LocationGrec1);

                if LocationGrec.Get("Transfer-from Code") then;
                if CountryGrec.Get(LocationGrec."Country/Region Code") then;
                if StateGrec.Get(LocationGrec."State Code") then;
                //if VendorGrec.get("Buy-from Vendor No.") then;
                //B2BSSD09Jan2023>>
                //if Type = Type::RGP then
                //    RetNonRetCap := 'RETURNABLE'
                //else
                //    if Type = Type::NRGP then
                RetNonRetCap := 'NON RETURNABLE';

                if LocationGrec.Get("Transfer-from Code") then
                    GstNo := LocationGrec."GST Registration No.";
                //CHB2B20MAR2023<<          
                if LocationGrec1.get("Transfer-to Code") then begin
                    ToName := LocationGrec.Name;
                    ToAddress1 := LocationGrec1.Address;
                    ToAddress2 := LocationGrec1."Address 2";
                end;

                if ("DC Number For Subcon" = '') and ("Subcon Order No." <> '') then begin
                    InventorySetup.Get();
                    InventorySetup.TestField("EOU_DOM Nos.");
                    NoSeries.Reset();
                    NoSeriesRelationship.SetRange(Code, InventorySetup."EOU_DOM Nos.");
                    NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", "Shortcut Dimension 1 Code");
                    if NoSeriesRelationship.FindSet() then
                        repeat
                            NoSeries.Code := NoSeriesRelationship."Series Code";
                            NoSeries.Mark := true;
                        until NoSeriesRelationship.Next() = 0;
                    if NoSeries.Get(InventorySetup."EOU_DOM Nos.") then
                        if NoSeries."Shortcut Dimension 1 Code_B2B" = "Shortcut Dimension 1 Code" then
                            NoSeries.Mark := true;
                    NoSeries.MarkedOnly := true;
                    //if PAGE.RunModal(0, NoSeries) = ACTION::LookupOK then begin
                    //Noseries.SETRANGE(Code, PurchaseSetup."Quote Nos.");
                    //IF PAGE.RUNMODAL(458, Noseries) = ACTION::LookupOK THEN
                    if NoSeries.FindSet() then
                        NextNumber := NoSeriesMgt.GetNextNo(NoSeries.Code, WorkDate(), true);
                    "DC Number For Subcon" := NextNumber;
                    Modify();
                end;

                //CHB2B13MAR2023<<
                ReleasedProductionGre.Reset();
                ReleasedProductionGre.SetRange("No.", "Transfer Shipment Header"."Subcon Order No.");
                if ReleasedProductionGre.FindFirst() then begin
                    ReleaseProductionlineGrec.Reset();
                    ReleaseProductionlineGrec.SetRange("Prod. Order No.", ReleasedProductionGre."No.");
                    ReleaseProductionlineGrec.SetRange("Subcontracting Order", true);
                    if ReleaseProductionlineGrec.FindFirst() then begin

                        PurchaseHeaderGre.Reset();
                        PurchaseHeaderGre.SetRange("Document Type", PurchaseHeaderGre."Document Type"::Order);
                        PurchaseHeaderGre.SetRange("No.", ReleaseProductionlineGrec."Purchase Order No.");
                        if PurchaseHeaderGre.FindFirst() then begin
                            PoDateGvar := PurchaseHeaderGre."Document Date";
                            PoNoGVar := PurchaseHeaderGre."No.";
                            BuyFromAddress1 := PurchaseHeaderGre."Buy-from Address";
                            BuyFromAddress2 := PurchaseHeaderGre."Buy-from Address 2";
                            BuyFromCity := PurchaseHeaderGre."Buy-from City";
                        end;
                    end;
                end;

            end;


            //CHB2B13MAR2023>>
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
        myInt: Integer;
        VEPLFCapLbl: Label 'VEPLF\STR\MDC';
        DeliverCapLbl: Label 'DELIVERY CHALLAN';
        ReturnaCapLbl: Label 'RETURNABLE';
        DCCapLbl: Label 'D.C. No.:';
        ToCapLbl: Label 'TO,';
        MsCapLbl: Label 'M/S.';
        AgainstCapLbl: Label 'Against Order No :';
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
        VendorGrec: Record Vendor;
        ReleasedProductionGre: Record "Production Order";
        ReleaseProductionlineGrec: record "Prod. Order Line";
        PurchaseHeaderGre: record "Purchase Header";

        BuyFromAddress1: Text[100];
        BuyFromAddress2: Text[100];
        BuyFromCity: Text[30];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InventorySetup: Record "Inventory Setup";
        NoSeries: Record "No. Series";
        NoSeriesRelationship: Record "No. Series Relationship";
        NextNumber: code[20];
        JobWorkCap: Label 'JOB WORK';
        EwaybillnoCap: Label 'E Way Bill No:';
        EwaybillDateCap: Label 'E Way Bill Date:';
        AuthorizedSigCap: Label 'Authorized Signature';
        PoNoGVar: Text;
        PoDateGvar: Date;
        LocationGrec1: Record Location;
        ToName: Code[20];
        ToAddress1: Text[100];
        ToAddress2: Text[100];



}
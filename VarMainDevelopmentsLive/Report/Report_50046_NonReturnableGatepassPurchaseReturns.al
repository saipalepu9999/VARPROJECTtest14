report 50046 NonReturnableGatepassPro
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'NRDC-Purchase Return Shipments';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\NonReturnablePRO.rdl';
    dataset
    {
        dataitem("Return Shipment Header"; "Return Shipment Header")
        {
            //DataItemTableView = where(Status = const(Posted));
            column(VEPLFCapLbl; VEPLFCapLbl) { }

            column(No_GateEntryHeader_B2B; "No.")
            {
            }
            column(ReturnOrderNo_ReturnShipmentHeader; "Return Order No.")
            {
            }
            column(BuyfromVendorNo_ReturnShipmentHeader; "Buy-from Vendor No.")
            {
            }
            column(PostingDate_GateEntryHeader_B2B; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(BuyfromAddress_ReturnShipmentHeader; "Buy-from Address")
            {
            }
            column(BuyfromVendorName_ReturnShipmentHeader; "Buy-from Vendor Name")
            {
            }

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
            dataitem("Return Shipment Line"; "Return Shipment Line")
            {
                //DataItemLinkReference = "Gate Pass Header";
                //DataItemLink = "Entry Type" = FIELD("Entry Type"),
                //"type" = field("Type"),
                //              "Gate Entry No." = FIELD("No.");
                DataItemLinkReference = "Return Shipment Header";
                DataItemLink = "Document No." = field("No.");
                //DataItemTableView = WHERE(Type=CONST("Item"));
                column(Quantity; Quantity)
                { }

                column(No_; "No.")
                { }
                column(Description; Description)
                { }
                trigger OnPreDataItem()
                begin
                    SetRange(Type, Type::Item);
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
                if LocationGrec.Get("Location Code") then;
                if CountryGrec.Get(LocationGrec."Country/Region Code") then;
                if StateGrec.Get(LocationGrec."State Code") then;
                if VendorGrec.get("Buy-from Vendor No.") then;
                //B2BSSD09Jan2023>>
                //if Type = Type::RGP then
                //    RetNonRetCap := 'RETURNABLE'
                //else
                //    if Type = Type::NRGP then
                RetNonRetCap := 'NON RETURNABLE';

                if LocationGrec.Get("Location Code") then
                    GstNo := LocationGrec."GST Registration No.";
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
        myInt: Integer;
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
        VendorGrec: Record Vendor;
}
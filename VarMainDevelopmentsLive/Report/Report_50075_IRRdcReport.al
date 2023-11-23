report 50075 IRRdcReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Returnable Gate Pass';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\IRRDC.rdl';
    dataset
    {
        dataitem("Inspection Receipt Header B2B"; "Inspection Receipt Header B2B")
        {
            column(Address_InspectionReceiptHeaderB2B; Address)
            { }
            column(Address2_InspectionReceiptHeaderB2B; "Address 2")
            { }
            column(DocumentDate_InspectionReceiptHeaderB2B; format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(ItemDescription_InspectionReceiptHeaderB2B; "Item Description")
            { }
            column(ItemNo_InspectionReceiptHeaderB2B; "Item No.")
            { }
            column(LocationCode_InspectionReceiptHeaderB2B; "Location Code")
            { }
            column(No_InspectionReceiptHeaderB2B; "No.")
            { }
            column(Quantity_InspectionReceiptHeaderB2B; Quantity)
            { }
            column(ReceiptNo_InspectionReceiptHeaderB2B; "Receipt No.")
            { }
            column(OrderNo_InspectionReceiptHeaderB2B; "Order No.")
            { }
            column(VendorNo_InspectionReceiptHeaderB2B; "Vendor No.")
            { }
            column(VendorName_InspectionReceiptHeaderB2B; "Vendor Name")
            { }
            column(QtysenttoVendorRework_InspectionReceiptHeaderB2B; "Qty. sent to Vendor(Rework)")
            { }
            column(QualityRemarks_InspectionReceiptHeaderB2B; "Quality Remarks")
            { }
            column(VEPLFCapLbl; VEPLFCapLbl)
            { }
            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
            { }
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
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
            column(FORCapLbl; FORCapLbl)
            { }
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
            column(LocationGrec_Name; LocationGrec.Name)
            { }
            column(LocationGrec_Address; LocationGrec.Address)
            { }
            column(LocationGrec_Address2; LocationGrec."Address 2")
            { }
            /*dataitem("Gate Entry Line_B2B"; "Posted Gate Pass Line")
            {
                //DataItemLinkReference = "Posted Gate Pass Header";
                //DataItemLink = "Entry Type" = FIELD("Entry Type"),
                //"type" = field("Type"),
                //              "Gate Entry No." = FIELD("No.");
                DataItemLinkReference = "Gate Entry Header_B2B";
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(No_GateEntryLine_B2B; "No.")
                {
                }
                column(Quantity_GateEntryLine_B2B; Quantity)
                {
                }
                column(QuantityReceived_GateEntryLine_B2B; "Quantity Received")
                {
                }
                column(Remarks_GateEntryLine_B2B; Remarks)
                {
                }
                column(Description_GateEntryLine_B2B; Description)
                {
                }
                column(GstNo;GstNo)
                { }
                trigger OnAfterGetRecord()
                begin
                    if LocationGrec.Get("Location Code") then
                        GstNo := LocationGrec."GST Registration No.";
                end;
            }*/
            trigger OnAfterGetRecord()
            begin
                // if Type = Type::RGP then
                // Clear(OrderDateGvar);
                // RetNonRetCap := 'RETURNABLE';
                // if "Reference Type" = "Reference Type"::"Purchase Order" then begin
                //     if PurchaseHedaer.get(PurchaseHedaer."Document Type"::Order, "Reference No.") then
                //         OrderDateGvar := PurchaseHedaer."Posting Date";

                // end else
                //     if "Reference Type" = "Reference Type"::"Purchase Return Shipment" then begin
                //         if ReturnShipHr.Get("Reference No.") then
                //             OrderDateGvar := ReturnShipHr."Posting Date";
                //     end else
                //         if "Reference Type" = "Reference Type"::"Sales Shipment" then begin
                //             if SalesShipHdr.Get("Reference No.") then
                //                 OrderDateGvar := SalesShipHdr."Posting Date";
                //         end else
                //             if "Reference Type" = "Reference Type"::"Transfer Shipment" then begin
                //                 if TransferShipment.Get("Reference No.") then
                //                     OrderDateGvar := TransferShipment."Posting Date";
                //             end;
                // else
                //   if Type = Type::NRGP then
                //      RetNonRetCap := 'NON RETURNABLE';
                PurchaseHedaer.Reset();
                PurchaseHedaer.SetRange("Document Type", PurchaseHedaer."Document Type"::Order);
                PurchaseHedaer.SetRange("No.", "Order No.");
                if PurchaseHedaer.FindFirst() then begin
                    OrderDateGvar := PurchaseHedaer."Order Date";
                end;
                Clear(LocationGrec);
                if LocationGrec.Get("Location Code") then;
                //com  
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
       
        LocationGrec: Record Location;
        GstNo: Text;
       

}
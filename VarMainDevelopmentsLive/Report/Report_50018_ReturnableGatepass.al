report 50018 ReturnableGatepass
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Returnable Gate Pass';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\Returnable.rdl';
    dataset
    {
        dataitem("Gate Entry Header_B2B"; "Posted Gate Pass Header")
        {
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
            column(ConsigneeNo_GateEntryHeader_B2B; "Consignee No.")
            {
            }
            column(DocReceiptDate_GateEntryHeader_B2B; format("Doc. Receipt Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(No_GateEntryHeader_B2B; "No.")
            {
            }
            column(PostingDate_GateEntryHeader_B2B; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(ReferenceNo_GateEntryHeader_B2B; PostingOrderno)
            {
            }
            column(PostingOrderDate; format(PostingOrderDate, 0, '<Day,2>-<Month,2>-<Year4>'))

            {

            }
            column(CompanyInfoGrec_Picture; CompanyInfoGrec.Picture)
            { }


            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
            { }
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
            { }
            column(CompanyInfoGrec_Statecode; CompanyInfoGrec."State Code")
            { }
            column(CompanyInfoGrec; CompanyInfoGrec."Country/Region Code")
            { }

            column(CompanyInfoGrec_City; CompanyInfoGrec.City)
            { }
            column(CompanyInfoGrec_Country; CompanyInfoGrec."Country/Region Code")
            { }
            column(CompanyInfoGrec_FaxNo; Format('Tel/Fax.') + CompanyInfoGrec."Fax No.")
            { }
            column(CompanyInfoGrec_GstNo; CompanyInfoGrec."GST Registration No.")
            { }

            column(DeliverCapLbl; DeliverCapLbl)
            { }
            column(LocationGrec_Address; LocationGrec.Address)
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
            column(CountryGrec_Name; CountryName)
            { }
            column(StateGrec_Description; StateName)
            { }
            dataitem("Gate Entry Line_B2B"; "Posted Gate Pass Line")
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
                column(Unit_of_Measure; "Unit of Measure")
                {

                }
                column(GstNo; GstNo)
                { }
                trigger OnAfterGetRecord()
                begin
                    Clear(LocationGrec);
                    Clear(StateGrec);
                    Clear(CountryGrec);
                    if LocationGrec.Get("Location Code") then;
                    GstNo := LocationGrec."GST Registration No.";
                    if CountryGrec.Get(LocationGrec."Country/Region Code") then;
                    if StateGrec.Get(LocationGrec."State Code") then;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(PostingOrderno);
                Clear(PostingOrderDate);
                // if Type = Type::RGP then
                Clear(OrderDateGvar);
                Clear(LocationGrec);
                Clear(StateGrec);
                Clear(CountryGrec);
                Clear(CountryName);
                Clear(StateName);
                // if CountryGrec.Get(LocationGrec."Country/Region Code") then

                // if StateGrec.Get(LocationGrec."State Code") then

                if LocationGrec.Get("Gate Entry Header_B2B"."Location Code") then;
                GstNo := LocationGrec."GST Registration No.";
                if CountryGrec.Get(LocationGrec."Country/Region Code") then
                    CountryName := CountryGrec.Name;

                if StateGrec.Get(LocationGrec."State Code") then
                    StateName := StateGrec.Description;
                RetNonRetCap := 'RETURNABLE';
                if "Reference Type" = "Reference Type"::"Purchase Order" then begin
                    if PurchaseHedaer.get(PurchaseHedaer."Document Type"::Order, "Reference No.") then
                        // OrderDateGvar := PurchaseHedaer."Posting Date";
                        PostingOrderDate := PurchaseHedaer."Posting Date";
                    PostingOrderno := "Reference No.";

                end else
                    if "Reference Type" = "Reference Type"::"Purchase Return Shipment" then begin
                        if ReturnShipHr.Get("Reference No.") then
                            //   OrderDateGvar := ReturnShipHr."Posting Date";
                            PostingOrderDate := ReturnShipHr."Posting Date";
                        PostingOrderno := "Reference No.";
                    end else
                        if "Reference Type" = "Reference Type"::"Sales Shipment" then begin
                            if SalesShipHdr.Get("Reference No.") then
                                // OrderDateGvar := SalesShipHdr."Posting Date";
                                PostingOrderno := "Reference No.";
                            PostingOrderDate := SalesShipHdr."Posting Date";
                        end else
                            if "Reference Type" = "Reference Type"::"Transfer Shipment" then begin
                                if TransferShipment.Get("Reference No.") then
                                    // OrderDateGvar := TransferShipment."Posting Date";
                                    PostingOrderno := "Reference No.";
                                PostingOrderDate := TransferShipment."Posting Date";
                            end else
                                if "Reference Type" = "Reference Type"::Inspection then begin
                                    PostedInspection.Reset();
                                    PostedInspection.SetRange("No.", "Reference No.");
                                    if PostedInspection.FindFirst() then begin
                                        PostingOrderno := PostedInspection."Order No.";
                                        PostingOrderDate := PostedInspection."Posting Date";
                                    end;

                                    // else
                                    //   if Type = Type::NRGP then
                                    //      RetNonRetCap := 'NON RETURNABLE';
                                end else
                                    if "Reference Type" = "Reference Type"::"Posted Purchase Receipt " then begin
                                        PurchReceiptHdr.Reset();
                                        PurchReceiptHdr.SetRange("No.", "Reference No.");
                                        if PurchReceiptHdr.FindFirst() then begin
                                            PostingOrderno := PurchReceiptHdr."Order No.";
                                            PostingOrderDate := PurchReceiptHdr."Posting Date";
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
        PostingOrderno: Code[20];
        PostingOrderDate: Date;
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
        Pa: Page 18607;
        LocationGrec: Record Location;
        GstNo: Text;
        CountryGrec: Record "Country/Region";
        StateGrec: Record State;
        PostedInspection: Record "Inspection Receipt Header B2B";
        PurchReceiptHdr: Record "Purch. Rcpt. Header";
        StateName: Text;
        CountryName: Text;
}
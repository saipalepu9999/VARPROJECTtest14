report 50093 "Purchase Order Short Close New"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    //RDLCLayout = 'Report\Layouts\PurchaseOrder - Copy.rdl';
    RDLCLayout = 'Report\Layouts\PurchaseOrderShortCloseNew.rdl';
    Caption = 'Purchase Order-Short Close New';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "No.";
            CalcFields = "No. of Archived Versions";
            column(No_PurchHdr; "No.")
            { }
            column(FormatNoCap; FormatNoCapLbl)
            { }
            column(PoCap; PurChaseOrderCapLbl)
            { }
            column(PoNoCap; PoNoCapLbl)
            { }
            column(YourRefCap; YourRefCapLbl)
            { }
            column(DateCap; DateCapLbl)
            { }
            column(AmendmentDateGvar; Format(AmendmentDateGvar, 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(GstNoCap; GstNoCapLbl)
            { }
            column(PleaseArrangeCap; PleaseArrangeCapLbl)
            { }
            column(SNoCap; SNoCapLbl)
            { }
            column(DescriptionCapLbl; DescriptionCapLbl)
            { }
            column(UomCapLbl; UomCapLbl)
            { }
            column(ItemDrawings_PurchaseHeader; "Item Drawings")
            { }
            column(QuantityCapLbl; QuantityCapLbl)
            { }
            column(RateInRsCapLbl; RateInRsCapLbl)
            { }
            column(TaxableValueInRsCapLbl; TaxableValueInRsCapLbl)
            { }
            column(TotalTaxAmountCapLbl; TotalTaxAmountCapLbl)
            { }
            column(TotalAmountBeforeTaxCapLbl; TotalAmountBeforeTaxCapLbl)
            { }
            column(TotalAmountAfterTaxCapLbl; TotalAmountAfterTaxCapLbl)
            { }
            column(ForVarElectroChePrvLimitedCapLbl; ForVarElectroChePrvLimitedCapLbl)
            { }
            column(TermsAndConditionsCapLbl; TermsAndConditionsCapLbl)
            { }
            column(AuthorisedSignatoryCapLbl; AuthorisedSignatoryCapLbl)
            { }
            column(AddCgstCapLbl; AddCgstCapLbl)
            { }
            column(AddSgstCapLbl; AddSgstCapLbl)
            { }
            column(AddIgstCapLbl; AddIgstCapLbl)
            { }
            column(CompanyInfoGrec_Picture; CompanyInfoGrec.Picture)
            { }
            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
            { }
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
            { }
            column(CompanyInfoGrec_City; CompanyInfoGrec.City)
            { }
            column(CompanyInfoGrec_Country; CompanyInfoGrec."Country/Region Code")
            { }
            column(CompanyInfoGrec_FaxNo; Format('Tel/Fax.') + CompanyInfoGrec."Fax No.")
            { }
            column(CompanyInfoGrec_GstNo; CompanyInfoGrec."GST Registration No.")
            { }
            column(Order_Date_PH; format("Order Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Posting_Date_PH; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(VendorGRec_Name; VendorGRec.Name)
            { }
            column(VendorGRec_Address; VendorGRec.Address)
            { }
            column(VendorGRec_Address2; VendorGRec."Address 2")
            { }
            column(VendorGRec_City; VendorGRec.City)
            { }
            column(RemarksGvar; RemarksGvar)
            { }
            column(VendorGRec_PostCode; VendorGRec."Post Code")
            { }
            column(VendorGRec_GstNo; VendorGRec."GST Registration No.")
            { }
            column(VendorGRec_PhoneNo; VendorGRec."Phone No.")
            { }
            column(VendorGRec_Email; VendorGRec."E-Mail")
            { }
            column(NoText_1; NoText[1])
            { }
            column(PrintDrawings; PrintDrawings)
            { }
            column(PrintPaymentTerms; PrintPaymentTerms)
            { }
            column(ItemNoCapLbl; ItemNoCapLbl)
            { }
            column(ItemDrawingNoCapLbl; ItemDrawingNoCapLbl)
            { }
            column(Your_Reference; "Your Reference")
            { }
            column(ReferenceNoGvar; ReferenceNoGvar)
            { }
            column(LocationGrec_Address; LocationGrec.Address)
            { }
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
            column(No_New; "No." + ' -R' + Format("No. of Archived Versions"))
            { }
            column(StateGrec_Description; StateGrec.Description)
            { }
            column(CountryGrec_Name; CountryGrec.Name)
            { }
            column(Taxableext; Taxableext)
            { }
            column(RateText; RateText)
            { }
            column(TotalAmountBeforeTaxText; TotalAmountBeforeTaxText)
            { }
            column(TotalAmountAfterTaxText; TotalAmountAfterTaxText)
            { }
            column(TotalTaxAmountText; TotalTaxAmountText)
            { }
            column(sd2; "Shortcut Dimension 2 Code")
            { }
            column(Pcap; ProjectCapLbl)
            { }
            column(ReferenceDate_PurchaseHeader; format("Reference Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(Var1; Var1)
            { }
            column(Var2; Var2)
            { }
            column(DN; DimensionNameGvar)
            { }
            column(ArchievedDateCapLbl; ArchievedDateCapLbl)
            { }
            column(GstGroupCodeCapLbl; GstGroupCodeCapLbl)
            {

            }
            column(LineCapLbl; LineCapLbl)
            { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = "Purchase Header";
                //UseTemporary
                DataItemLink = "Document No." = FIELD("No."), "Document Type" = field("Document Type");
                DataItemTableView = sorting("Document No.", "Line No.", "Document Type") where("No." = filter(<> ''));

                column(Document_No_PL; "Document No.")
                { }
                column(Line_No_PL; "Line No.")
                { }
                column(Type; Type)
                { }
                column(No_PurchLine_PL; "No.")
                { }
                column(Description_PL; Description)
                { }
                column(Description_2_PL; "Description 2")
                { }
                column(Quantity_PL; Quantity)
                { }
                column(Unit_Price__LCY_PL; "Unit Price (LCY)")
                { }
                column(Direct_Unit_Cost_PL; "Direct Unit Cost")
                { }
                column(Line_Amount; "Line Amount")
                { }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                { }
                column(GSTGroupCode_PurchaseLine; "GST Group Code")
                {
                }
                column(HSNSACCode_PurchaseLine; "HSN/SAC Code")
                {
                }
                column(SNoNewGvar; SNoNewGvar)
                { }
                column(QtyNewGvar; QtyNewGvar)
                { }
                column(UomNewGvar; UomNewGvar)
                { }
                column(DescNewGvar; DescNewGvar)
                { }
                column(RateNewGvar; RateNewGvar)
                { }
                column(HSNCodeNewGvar; HSNCodeNewGvar)
                { }
                column(GstGroupCodeNewGvar; GstGroupCodeNewGvar)
                { }
                column(CGSTAmt; CGSTAmt)
                { }
                column(SGSTAmt; SGSTAmt)
                { }
                column(IGSTAmt; IGSTAmt)
                { }
                column(CGSTPer; CGSTPer)
                { }
                column(IGSTPer; IGSTPer)
                { }
                column(SGSTPer; SGSTPer)
                { }
                column(AmountVendor1; AmountVendor1)
                { }
                column(ItemDrawingNo; ItemDrawingNo)
                { }
                column(SNo; SNo)
                { }
                column(AmendedDescription; AmendedDescription)
                { }
                column(ExistingDescription; ExistingDescription)
                { }

                trigger OnAfterGetRecord()
                begin
                    Clear(SNoNewGvar);
                    clear(DescNewGvar);
                    clear(UomNewGvar);
                    Clear(QtyNewGvar);
                    clear(RateNewGvar);
                    Clear(HSNCodeNewGvar);
                    Clear(GstGroupCodeNewGvar);
                    Clear(ExistingDescription);
                    Clear(AmendedDescription);
                    ExistingDescription := 'Existing';
                    AmendedDescription := 'Amended';
                    if Type In [Type::Item, Type::"G/L Account", Type::"Charge (Item)", Type::"Fixed Asset", Type::Resource] then begin
                        SNo1 += 1;
                        sno := SNo1;
                    end else
                        SNo := 0;
                    PurchaseHeaderArchieveGrec.Reset();
                    PurchaseHeaderArchieveGrec.SetRange("Document Type", "Document Type");
                    PurchaseHeaderArchieveGrec.SetRange("No.", "Document No.");
                    PurchaseHeaderArchieveGrec.SetRange("Doc. No. Occurrence", "Purchase Header"."Doc. No. Occurrence");
                    PurchaseHeaderArchieveGrec.SetCurrentKey("Version No.");
                    if PurchaseHeaderArchieveGrec.FindLast() then begin
                        PurchaseLineArchieveGrec.Reset();
                        PurchaseLineArchieveGrec.SetRange("Document Type", "Document Type");
                        PurchaseLineArchieveGrec.SetRange("Document No.", "Document No.");
                        PurchaseLineArchieveGrec.SetRange("Doc. No. Occurrence", "Purchase Header"."Doc. No. Occurrence");
                        PurchaseLineArchieveGrec.SetRange("Version No.", PurchaseHeaderArchieveGrec."Version No.");
                        PurchaseLineArchieveGrec.SetRange("Line No.", "Line No.");
                        if PurchaseLineArchieveGrec.FindFirst() then begin
                            if (Description <> PurchaseLineArchieveGrec.Description) or (Quantity <> PurchaseLineArchieveGrec.Quantity)
                            or ("Direct Unit Cost" <> PurchaseLineArchieveGrec."Direct Unit Cost") or ("Unit of Measure Code" <> PurchaseLineArchieveGrec."Unit of Measure Code") or
                            ("GST Group Code" <> PurchaseLineArchieveGrec."GST Group Code") or ("HSN/SAC Code" <> PurchaseLineArchieveGrec."HSN/SAC Code") then begin
                                SNoNewGvar := SNo;
                                DescNewGvar := PurchaseLineArchieveGrec.Description;
                                QtyNewGvar := PurchaseLineArchieveGrec.Quantity;
                                UomNewGvar := PurchaseLineArchieveGrec."Unit of Measure Code";
                                RateNewGvar := PurchaseLineArchieveGrec."Direct Unit Cost";
                                GstGroupCodeNewGvar := PurchaseLineArchieveGrec."GST Group Code";
                                HSNCodeNewGvar := PurchaseLineArchieveGrec."HSN/SAC Code";
                            end else begin
                                CurrReport.Skip();
                            end;
                        end;
                    end;


                    Clear(CGSTAmt);
                    Clear(SGSTAmt);
                    Clear(IGSTAmt);
                    Clear(SGSTPer);
                    Clear(IGSTPer);
                    Clear(CGSTPer);
                    GSTSetup.get();
                    GetGSTAmounts(TaxTransactionValue, "Purchase Line", GSTSetup);
                    Clear(GstTotal);

                    GstTotal := CGSTAmt + SGSTAmt + IGSTAmt;
                    GstTotalSum := GstTotalSum + GstTotal;
                    //GSTPerQTY := GstTotal / Quantity;
                    //GSTPertotal := CGSTPer + SGSTPer + IGSTPer;
                    //Message('%1', GstTotal);
                    Clear(AmountVendor1);
                    AmountVendor += "Line Amount";
                    AmountVendor1 := AmountVendor + GstTotalSum;
                    ReportCheck.InitTextVariable;
                    ReportCheck.FormatNoText(NoText, AmountVendor1, "Purchase Header"."Currency Code");
                    if type = Type::Item then begin
                        DocumentAttachment.Reset();
                        DocumentAttachment.SetRange("Table ID", 27);
                        DocumentAttachment.SetRange("No.", "No.");
                        DocumentAttachment.SetCurrentKey("Drawing Revision No._B2B");
                        if DocumentAttachment.FindLast() then begin
                            ItemDrawingNo := DocumentAttachment."Drawing No_B2B";
                        end;


                    end;

                end;
            }
            dataitem("Payment Terms And Conditions"; "Payment Terms And Conditions")
            {
                DataItemLinkReference = "Purchase Header";
                // DataItemTableView = WHERE(DocumentType = CONST(Order));
                DataItemLink = "Document No." = FIELD("No.");
                column(DocumentNo_PTC; "Document No.")
                { }
                column(Code_PTC; "Code")
                { }

                column(Description_PTC; Description)
                { }

                column(LineNo_PTC; LineNo)
                { }
                column(CodePtcGvar; CodePtcGvar)
                { }
                column(DescriptionPtcGvar; DescriptionPtcGvar)
                { }
                column(AmendedDescription1; AmendedDescription1)
                { }
                column(ExistingDescription1; ExistingDescription1)
                { }


                trigger OnPreDataItem()
                begin
                    SetRange("Doc. No. Occurrence", 0);
                    SetRange("Version No.", 0);
                end;

                trigger OnAfterGetRecord()
                begin
                    Clear(CodePtcGvar);
                    Clear(DescriptionPtcGvar);
                    ExistingDescription1 := 'Existing';
                    AmendedDescription1 := 'Amended';
                    PurchaseHeaderArchieveGrec.Reset();
                    PurchaseHeaderArchieveGrec.SetRange("Document Type", PurchaseHeaderArchieveGrec."Document Type"::Order);
                    PurchaseHeaderArchieveGrec.SetRange("No.", "Document No.");
                    PurchaseHeaderArchieveGrec.SetRange("Doc. No. Occurrence", "Purchase Header"."Doc. No. Occurrence");
                    PurchaseHeaderArchieveGrec.SetCurrentKey("Version No.");
                    if PurchaseHeaderArchieveGrec.FindLast() then begin
                        PaymenttemscondArchGrecArch.Reset();
                        PaymenttemscondArchGrecArch.SetRange(DocumentType, PaymenttemscondArchGrecArch.DocumentType::Order);
                        PaymenttemscondArchGrecArch.SetRange("Document No.", "Document No.");
                        PaymenttemscondArchGrecArch.SetRange("Doc. No. Occurrence", "Purchase Header"."Doc. No. Occurrence");
                        PaymenttemscondArchGrecArch.SetRange("Version No.", PurchaseHeaderArchieveGrec."Version No.");
                        PaymenttemscondArchGrecArch.SetRange(LineNo, LineNo);
                        if PaymenttemscondArchGrecArch.FindFirst() then begin
                            if (Code <> PaymenttemscondArchGrecArch.Code) or (Description <> PaymenttemscondArchGrecArch.Description) then begin
                                CodePtcGvar := PaymenttemscondArchGrecArch.Code;
                                DescriptionPtcGvar := PaymenttemscondArchGrecArch.Description;
                            end else begin
                                CurrReport.Skip();
                            end;
                        end;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(LocationGrec);
                Clear(StateGrec);
                Clear(CountryGrec);
                Clear(DimensionNameGvar);
                Clear(Var1);
                Clear(var2);
                Clear(GstTotalSum);
                Clear(SNo1);
                DimensionValue.Reset();
                DimensionValue.SetRange(Code, "Shortcut Dimension 2 Code");
                if DimensionValue.FindFirst() then
                    DimensionNameGvar := DimensionValue.Name;
                if Status <> Status::Released then begin
                    Var1 := 'Draft Purchase Order';
                    var2 := 'Not Valid for Printing';
                end else begin
                    Var1 := '';
                    var2 := '';
                end;
                if VendorGRec.get("Purchase Header"."Buy-from Vendor No.") then;
                if "Indent No." <> '' then
                    ReferenceNoGvar := "Indent No."
                else
                    ReferenceNoGvar := "Your Reference";
                if LocationGrec.Get("Location Code") then;
                if StateGrec.Get(LocationGrec."State Code") then;
                if CountryGrec.Get(LocationGrec."Country/Region Code") then;
                if "Currency Code" = '' then begin
                    Taxableext := StrSubstNo(TaxableValueInRsCapLbl, 'Rs');
                    RateText := StrSubstNo(RateInRsCapLbl, 'Rs');
                    TotalAmountBeforeTaxText := StrSubstNo(TotalAmountBeforeTaxCapLbl, 'Rs');
                    TotalTaxAmountText := StrSubstNo(TotalTaxAmountCapLbl, 'Rs');
                    TotalAmountAfterTaxText := StrSubstNo(TotalAmountAfterTaxCapLbl, 'Rs');
                end else begin
                    Taxableext := StrSubstNo(TaxableValueInRsCapLbl, "Currency Code");
                    RateText := StrSubstNo(RateInRsCapLbl, "Currency Code");
                    TotalAmountBeforeTaxText := StrSubstNo(TotalAmountBeforeTaxCapLbl, "Currency Code");
                    TotalTaxAmountText := StrSubstNo(TotalTaxAmountCapLbl, "Currency Code");
                    TotalAmountAfterTaxText := StrSubstNo(TotalAmountAfterTaxCapLbl, "Currency Code");
                end;
                Clear(AmendmentDateGvar);
                PurchaseHeaderArchieveGrec.Reset();
                PurchaseHeaderArchieveGrec.SetRange("Document Type", "Document Type");
                PurchaseHeaderArchieveGrec.SetRange("No.", "No.");
                PurchaseHeaderArchieveGrec.SetRange("Doc. No. Occurrence", "Purchase Header"."Doc. No. Occurrence");
                PurchaseHeaderArchieveGrec.SetCurrentKey("Version No.");
                if PurchaseHeaderArchieveGrec.FindLast() then begin
                    AmendmentDateGvar := PurchaseHeaderArchieveGrec."Date Archived";
                end;
            end;

            trigger OnPreDataItem()
            begin
                Clear(SNo);
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
                    /* field(PrintPaymentTerms; PrintPaymentTerms)
                     {
                         ApplicationArea = All;
                         trigger OnValidate()
                         begin
                             if PrintDrawings then
                                 Error('You Cannot select more than one');
                         end;

                     }
                     field(PrintDrawings; PrintDrawings)
                     {
                         ApplicationArea = all;
                         Caption = 'Print Drawing Nos';
                         trigger OnValidate()
                         begin
                             if PrintPaymentTerms then
                                 Error('You Cannot select more than one');
                         end;
                     }*/
                    field(RemarksGvar; RemarksGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Remarks';
                    }
                }
            }
        }
    }

    /*    actions
       {
           area(processing)
           {
               action(ActionName)
               {
                   ApplicationArea = All;
               }
           }
       }
   } */
    trigger OnPreReport()
    begin
        CompanyInfoGrec.get;
        CompanyInfoGrec.CalcFields(Picture);
    end;

    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
   PurchaseLine: Record "Purchase Line";
   GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];
    begin

        ComponentName := GetComponentName("Purchase Line", GSTSetup);

        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                SGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                SGSTPer := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                CGSTPer := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                IGSTPer := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;
    end;

    local procedure GetComponentName(PurchaseLine: Record "Purchase Line";
       GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if PurchaseLine."GST Jurisdiction Type" = PurchaseLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup.Get() then
            exit;
        GSTSetup.TestField("GST Tax Type");
        TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;


    var
        SNo: Integer;
        SNo1: Integer;
        ReportCheck: Codeunit "Check Codeunit";
        DocumentAttachment: Record "Document Attachment";
        NoText: array[2] of text;
        VendorGRec: Record Vendor;
        CompanyInfoGrec: Record "Company Information";
        FormatNoCapLbl: Label 'Format No:';
        PurChaseOrderCapLbl: Label 'SHORT CLOSE OF PURCHASE ORDER';
        RemarksGvar: Text;
        PoNoCapLbl: Label 'PO.No.';
        DateCapLbl: Label 'Date';
        YourRefCapLbl: Label 'Your Ref';
        GstNoCapLbl: Label 'GST No.';
        PleaseArrangeCapLbl: Label 'Please arrange to supply the following against this order in accordance with the terms and conditions stated below,';
        SNoCapLbl: Label 'S.No';
        DescriptionCapLbl: Label 'Description';
        UomCapLbl: Label 'UOM';
        QuantityCapLbl: Label 'Qty';
        RateInRsCapLbl: Label 'Rate In %1';
        RateText: Text;
        TaxableValueInRsCapLbl: Label 'Taxable Value In %1';
        Taxableext: Text;
        TotalAmountBeforeTaxCapLbl: Label 'Total Amount Before Tax in %1.';
        TotalAmountBeforeTaxText: Text;
        AddCgstCapLbl: Label 'Add : CGST @';
        AddSgstCapLbl: Label 'Add : SGST @';
        AddIgstCapLbl: Label 'Add : IGST @';
        TotalTaxAmountCapLbl: Label 'Total Tax Amount In %1.';
        TotalTaxAmountText: Text;
        TotalAmountAfterTaxCapLbl: Label 'Total Amount After Tax In %1.';
        TotalAmountAfterTaxText: Text;
        ForVarElectroChePrvLimitedCapLbl: Label 'For VAR ELECTROCHEM PRIVATE LIMITED';
        AuthorisedSignatoryCapLbl: Label 'AUTHORISED SIGNATORY';
        TermsAndConditionsCapLbl: Label 'Terms & Conditions';
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        CGSTPer: Decimal;
        GstTotal: decimal;
        GstTotalSum: Decimal;
        AmountVendor1: Decimal;
        AmountVendor: Decimal;
        GSTSetup: Record "GST Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
        ItemDrawingsCapLbl: Label 'Item Drawings';
        PrintPaymentTerms: Boolean;
        PrintDrawings: Boolean;
        ItemDrawingNo: Code[100];
        ItemNoCapLbl: Label 'Item No.';
        ItemDrawingNoCapLbl: Label 'Item Drawing No.';
        SalesOrderPlanning: Page "Sales Order Planning";
        ReferenceNoGvar: Text;
        LocationGrec: Record Location;
        StateGrec: Record State;
        CountryGrec: Record "Country/Region";
        Var1: text;
        Var2: Text;
        ProjectCapLbl: Label 'PROJECT :';
        DimensionNameGvar: Text;
        DimensionValue: Record "Dimension Value";
        PurchaseHeaderArchieveGrec: Record "Purchase Header Archive";
        PurchaseLineArchieveGrec: Record "Purchase Line Archive";
        PaymenttemscondArchGrecArch: Record "Payment Terms And Conditions";
        PaymenttemscondArchGrec: Record "Payment Terms And Conditions";

        repo: Report 18021;
        DescNewGvar: Text;
        SNoNewGvar: Integer;
        UomNewGvar: Text;
        QtyNewGvar: Decimal;
        RateNewGvar: Decimal;
        GstGroupCodeNewGvar: Text;
        HSNCodeNewGvar: Text;
        AmendmentDateGvar: Date;
        CodePtcGvar: Text;
        DescriptionPtcGvar: Text;
        ArchievedDateCapLbl: Label 'Amended Date';
        AmendedDescription: Text;
        ExistingDescription: Text;
        AmendedDescription1: Text;
        ExistingDescription1: Text;
        LineCapLbl: Label 'Line';
        GstGroupCodeCapLbl: Label 'Gst Group Code';
}
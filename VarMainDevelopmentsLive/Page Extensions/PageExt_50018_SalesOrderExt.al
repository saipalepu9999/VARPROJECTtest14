pageextension 50018 SalesOrderExt extends "Sales Order"
{
    layout
    {

        addafter(Control1900201301)
        {
            group("Sales Information")
            {

                field("Tender/Project"; Rec."Tender/Project")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender/Project Conformation By Customer field.';
                }
                field("Liquidated Damages"; Rec."Liquidated Damages")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Liquidated Damages field.';
                }
                field("Green Card Applicable"; Rec."Green Card Applicable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Applicable field.';
                    trigger OnValidate()
                    begin
                        if Rec."Green Card Applicable" = Rec."Green Card Applicable"::Yes then
                            EditableGvar := true
                        else
                            EditableGvar := false;
                    end;
                }
                field("Green Card Type"; Rec."Green Card Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Type field.';
                    Editable = EditableGvar;
                }
                field("Green Card Received"; Rec."Green Card Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Received field.';
                    trigger OnValidate()
                    begin
                        if Rec."Green Card Received" = Rec."Green Card Received"::Yes then
                            EditableGvar1 := true
                        else
                            EditableGvar := false;
                    end;
                }

                field("Green Card Receipt Date"; Rec."Green Card Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Receipt Date field.';
                    Editable = EditableGvar1;
                }
                field("Cluster Munition"; Rec."Cluster Munition")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cluster Munition field.';
                }
                field("Receipt Of Customer Po"; Rec."Receipt Of Customer Po")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Of Customer Declaration Form(Cluster Munition) field.';
                }
                field("Receipt Of Cust Drawings"; Rec."Receipt Of Cust Drawings")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receipt Of Customer Drawings field.';
                }

                field("BG/FDR"; Rec."BG/FDR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BG/FDR field.';
                    trigger OnValidate()
                    begin
                        if Rec."BG/FDR" = Rec."BG/FDR"::Required then
                            BGFDREditableGvar := true
                        else
                            BGFDREditableGvar := false;
                    end;
                }
                field("Type Of BG"; Rec."Type Of BG")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type Of BG field.';
                }
                field("BG/FDR Availability"; Rec."BG/FDR Availability")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BG/FDR Availability field.';
                    Editable = BGFDREditableGvar;
                    trigger OnValidate()
                    begin
                        if Rec."BG/FDR Availability" = Rec."BG/FDR Availability"::Available then
                            BGFDRAvailEditableGvar := true
                        else
                            BGFDRAvailEditableGvar := false;
                    end;
                }
                field("BG/FDR No."; Rec."BG/FDR No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BG/FDR No. field.';
                    Editable = BGFDRAvailEditableGvar;
                }
                field("SBG FDR No."; Rec."SBG FDR No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SBG FDR No. field.';
                }
                field("SBG Start Date"; Rec."SBG Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SBG Start Date field.';
                }
                field("SBG EndDate"; Rec."SBG EndDate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SBG End Date field.';
                }
                field("PBG FDR No."; Rec."PBG FDR No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PBG FDR No. field.';
                }
                field("PBG Start Date"; Rec."PBG Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PBG Start Date field.';
                }
                field("PBG EndDate"; Rec."PBG EndDate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the PBG End Date field.';
                }
                field("SPBG FDR No."; Rec."SPBG FDR No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SPBG FDR No. field.';
                }
                field("SPBG Start Date"; Rec."SPBG Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SPBG Start Date field.';
                }
                field("SPBG EndDate"; Rec."SPBG EndDate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SPBG End Date field.';
                }
                field("Extended Date"; Rec."Extended Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Extended End Date field.';
                }
                /*field("BG/FDR Creation Date"; Rec."BG/FDR Creation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BG/FDR Creation Date field.';
                    Editable = BGFDRAvailEditableGvar;
                }
                field("BG/FDR Closure Date"; Rec."BG/FDR Closure Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BG/FDR Closure Date field.';
                    Editable = BGFDRAvailEditableGvar;
                }*/
                field("Acceptance Letter"; Rec."Acceptance Letter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acceptance Letter field.';
                }
                field("QAP document"; Rec."QAP document")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the QAP Document Delivery & Customer Acknowledgment field.';
                }
            }
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        addlast("Foreign Trade")
        {

            field("Port Of Discharge"; Rec."Port Of Discharge")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Port Of Discharge field.';
            }
        }
        addlast(General)
        {
            field("Posting No."; Rec."Posting No.")
            {
                ApplicationArea = all;
            }
        }
        //B2BPROn04Jul2023<<<
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                if CopyStr(Rec."Location Code", 1, 1) <> CopyStr(Rec."No. Series", 1, 1) then
                    Error('Please Select The Correct Location Code');
            end;
        } //B2BPROn04Jul2023<<<

        modify("VAT Reporting Date")
        {
            Visible = false;
        }

        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 2 Code_B2B"; Rec."Shortcut Dimension 2 Code_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
            }
        }
        modify("Your Reference")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Caption = 'Shipment Terms';
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
        addlast(General)
        {
            field("BG No."; Rec."BG No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the BG No. field.';
            }
            //B2BPROn24JUN2023<<<
            field("BG Margin"; "BG Margin")
            {
                ApplicationArea = all;
            }
            field("BG Margin %"; "BG Margin %")
            {
                ApplicationArea = all;
            }
            field("GCA Exports"; "GCA Exports")
            {
                ApplicationArea = all;
            }
            field("RPA Exports"; "RPA Exports")
            {
                ApplicationArea = all;
            }
            //B2BPROn24JUN2023<<<
            field("Customer Po No."; Rec."Customer Po No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Po No. field.';
            }
            field("Customer Po Date"; Rec."Customer Po Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Customer Po Date field.';
            }
            field(Remarks1; Rec.Remarks1)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks1 field.';
            }
            field(Remarks2; Rec.Remarks2)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Remarks2 field.';
            }
            field("Final Destintion"; Rec."Final Destintion")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Final Destintion field.';
            }
            field("Amendment No."; Rec."Amendment No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Amendment No. field.';
            }
            field("Amendment Date"; Rec."Amendment Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Amendment Date field.';
            }
        }

    }


    actions
    {
        addafter("Co&mments")
        {
            action(SalesCheckList)
            {
                ApplicationArea = Comments;
                Caption = 'QAP CheckList';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Category8;
                RunObject = Page "Sales Check List";
                RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                ToolTip = 'View or add comments for the record.';
            }
        }
        addlast("&Print")
        {
            action("Invoice For Advance")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Invoice For Advance';
                //Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() then
                        Report.RunModal(Report::"Proforma Invoice", true, true, SalesHeader);
                end;
            }
            action("Proforma Invoice")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Proforma Invoice';
                //Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() then
                        Report.RunModal(Report::"Proforma Invoice New", true, true, SalesHeader);
                end;
            }
        }
        addafter("Pla&nning")
        {
            action("Calculate Planning")
            {
                ApplicationArea = Planning;
                Caption = 'Pla&nning';
                Visible = false;
                Image = Planning;
                ToolTip = 'Open a tool for manual supply planning that displays all new demand along with availability information and suggestions for supply. It provides the visibility and tools needed to plan for demand from sales lines and component lines and then create different types of supply orders directly.';
                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    PlanningSechdule: Codeunit EventsSubscribers;
                begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetRange(Type, SalesLine.Type::Item);
                    SalesLine.SetRange("No.", '<>%1', '');
                    if SalesLine.FindSet() then
                        repeat
                            PlanningSechdule.PlanningShecdule(SalesLine);
                        until SalesLine.Next() = 0;
                end;
            }
            action("Planning Lines")
            {
                ApplicationArea = Planning;
                Caption = 'Planning Lines';
                Image = Planning;
                ToolTip = 'Open a tool for manual supply planning that displays all new demand along with availability information and suggestions for supply. It provides the visibility and tools needed to plan for demand from sales lines and component lines and then create different types of supply orders directly.';
                trigger OnAction()
                var
                    salesPlanningSchedule: Record "Sales Planning Schedule";
                    salesPlanningSchedulePage: Page "Sales Planning Schedule Line";
                begin
                    salesPlanningSchedule.Reset();
                    salesPlanningSchedule.SetRange("Sales Order No.", Rec."No.");
                    if salesPlanningSchedule.FindSet() then
                        Page.RunModal(Page::"Sales Planning Schedule Line", salesPlanningSchedule)
                end;
            }
        }
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                BankGuaranteeLRec: Record "Bank Guarantee";
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                Rec.TestField("Tender/Project");
                Rec.TestField("Location Code");
                //Rec.TestField("Liquidated Damages");
                if (Rec."Liquidated Damages" = Rec."Liquidated Damages"::" ") or
                (Rec."Green Card Applicable" = Rec."Green Card Applicable"::" ") or (Rec."Green Card Received" = Rec."Green Card Received"::" ")
                or (Rec."Receipt Of Customer Po" = Rec."Receipt Of Customer Po"::" ") or
                (Rec."Receipt Of Cust Drawings" = Rec."Receipt Of Cust Drawings"::" ") or (Rec."BG/FDR" = Rec."BG/FDR"::" ")
                or (Rec."Acceptance Letter" = Rec."Acceptance Letter"::" ") or (Rec."QAP document" = Rec."QAP document"::" ") then
                    Error('Please Fill All Mandatory Fields in Sales Information');
                if Rec."BG No." <> '' then begin
                    if BankGuaranteeLRec.Get(Rec."BG No.") then begin
                        GSTSetup.get();
                        /*GetGSTAmounts(TaxTransactionValue, "Purchase Line", GSTSetup);
                        Clear(GstTotal);

                        GstTotal += CGSTAmt + SGSTAmt + IGSTAmt;
                        GstTotalSum := GstTotalSum + GstTotal;
                        //GSTPerQTY := GstTotal / Quantity;
                        //GSTPertotal := CGSTPer + SGSTPer + IGSTPer;
                        //Message('%1', GstTotal);
                        Clear(AmountVendor1);
                        AmountVendor += "Line Amount";
                        AmountVendor1 := AmountVendor + GstTotalSum;*/
                    end;
                end;
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                Rec.TestField("Location Code");
            end;
        }
        modify("Post and Print Prepmt. Cr. Mem&o")
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify("Post and Print Prepmt. Invoic&e")
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(PostPrepaymentCreditMemo)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(PostPrepaymentInvoice)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(PreviewPosting)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify("Create &Warehouse Shipment")
        {
            Visible = false;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        /* modify("Pla&nning")
         {
             Visible = false;
         }*/
        modify(Warehouse)
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                Rec.TestField("Tender/Project");
                Rec.TestField("Location Code");
            end;
        }
        //B2BPROn06Jul2023<<<
        addafter("Update Reference Invoice No.")
        {
            action("Update Posting No. Series")
            {
                ApplicationArea = all;
                Image = UpdateDescription;
                Caption = 'Update Posting No. Series';
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    PostingNoSeries: Record "Posting No. Series";
                    NoseriesMgt: Codeunit NoSeriesManagement;
                    TableID: Integer;
                    NoSeriesCode: Code[20];
                    PostingNoSeriesMgmt: Codeunit "Posting No. Series Mgmt.";
                begin
                    Rec.TestField("Posting No.", '');
                    Rec.TestField("Shortcut Dimension 1 Code");
                    TableID := Database::"Sales Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Sales Invoice Header");
                    if NoSeriesCode <> '' then
                        Rec."Posting No." := NoseriesMgt.GetNextNo(NoSeriesCode, WorkDate(), true);
                    Rec.Modify();
                end;
            }
        }//B2BPROn06Jul2023<<<
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Shortcut Dimension 2 Code_B2B" = '' then
            Rec."Shortcut Dimension 2 Code_B2B" := Rec."Shortcut Dimension 2 Code";
        if Rec."BG/FDR" = Rec."BG/FDR"::Required then
            BGFDREditableGvar := true
        else
            BGFDREditableGvar := false;
        if Rec."BG/FDR Availability" = Rec."BG/FDR Availability"::Available then
            BGFDRAvailEditableGvar := true
        else
            BGFDRAvailEditableGvar := false;
    end;

    var
        EditableGvar: Boolean;
        EditableGvar1: Boolean;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        BGFDREditableGvar: Boolean;
        BGFDRAvailEditableGvar: Boolean;
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

    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
SalesLine: Record "Sales Line";
GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];
    begin
        ComponentName := GetComponentName(SalesLine, GSTSetup);

        if (SalesLine.Type <> SalesLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", SalesLine.RecordId);
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

    local procedure GetComponentName(SalesLine: Record "Sales Line";
       GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if SalesLine."GST Jurisdiction Type" = SalesLine."GST Jurisdiction Type"::Interstate then
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
}
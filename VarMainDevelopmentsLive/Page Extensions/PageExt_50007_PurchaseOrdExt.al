pageextension 50007 "Purchase Order Extension" extends "Purchase Order"
{
    layout
    {

        addafter(PurchLines)
        {
            part(PaymentConditions; "Payment Terms and Condition")
            {

                ApplicationArea = all;
                SubPageLink = "Document No." = field("No."), "Doc. No. Occurrence" = const(0), "Version No." = const(0);
                UpdatePropagation = Both;
            }
        }
        //B2BPR04Jul2023<<<
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                if CopyStr("Location Code", 1, 1) <> CopyStr("No. Series", 1, 1) then
                    Error('Please Select The Correct Location Code');
            end;
        } //B2BPR04Jul2023<<<

        addlast(General)
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Order Type field.';
            }
            field("MSME Certificate No."; Rec."MSME Certificate No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the MSME Certificate No. field.';
            }
            field("MSME Validity Date"; Rec."MSME Validity Date")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the MSME Validity Date field.';
            }
            //4.12 >>
            field("Short Close Status"; Rec."Short Close Status")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Short Close Status field.';
            }
            field("Short Closed By"; Rec."Short Closed By")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Short Closed By field.';
            }
            field("Short Closed DateTime"; Rec."Short Closed DateTime")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Short Closed DateTime field.';
            }
            field(POAckValueVar; POAckValueVar)
            {
                ApplicationArea = All;
                Visible = false;
            }
            //4.12 <<
            field("Pc No."; Rec."Pc No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Pc No. field.';
                Visible = false;
            }
            field("Pc Date"; Rec."Pc Date")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Pc Date field.';
            }
            field("Dc No."; Rec."Dc No.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Dc No. field.';
            }
            field("Dc Date"; Rec."Dc Date")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Dc Date field.';
            }
            field("Duty Involved_B2B"; Rec."Duty Involved_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Duty Involved For Cleared field.';
            }
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Your Reference field.';
            }
            field("Service MRV"; Rec."Service MRV")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Service MRV field.';
            }
            field("PO Ack.Date"; Rec."PO Ack.Date")
            {
                ApplicationArea = all;
                Editable = POAckValueVar;
            }
            field("Ack.Val"; Rec."Ack.Val")
            {
                ApplicationArea = all;
            }
            group("Print Options")
            {

                field("Item Drawings"; Rec."Item Drawings")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Drawings field.';
                    trigger OnValidate()
                    begin
                        if ((Rec."Terms & Conditions") or (Rec."Test Certificate")) then
                            Error('Multiple options cannot be selected');
                    end;
                }
                field("Terms & Conditions"; Rec."Terms & Conditions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Terms & Conditions field.';
                    trigger OnValidate()
                    begin
                        if ((Rec."Item Drawings") or (Rec."Test Certificate")) then
                            Error('Multiple options cannot be selected');
                    end;
                }
                field("Test Certificate"; Rec."Test Certificate")
                {
                    ApplicationArea = All;
                    Caption = 'Special Instructions';
                    ToolTip = 'Specifies the value of the Test Certificate field.';
                    trigger OnValidate()
                    begin
                        if ((Rec."Terms & Conditions") or (Rec."Item Drawings")) then
                            Error('Multiple options cannot be selected');
                    end;
                }
                field(Printable; Rec.Printable)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Printable field.';
                }

            }

        }
        moveafter("Dc Date"; "Bill of Entry No.", "Bill of Entry Date")
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }

        modify("VAT Reporting Date")

        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 2 Code_B2B"; Rec."Shortcut Dimension 2 Code_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                trigger OnValidate()
                var
                    PostingNoSeries: Record "Posting No. Series";
                    TableID: Integer;
                    NoSeriesCode: Code[20];
                    PostingNoSeriesMgmt: Codeunit "Posting No. Series Mgmt.";
                begin
                    TableID := Database::"Purchase Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Purch. Rcpt. Header");
                    if NoSeriesCode <> '' then
                        Rec."Receiving No. Series" := NoSeriesCode;
                end;
            }
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        addafter("Your Reference")
        {
            field("Reference Date"; Rec."Reference Date")
            {
                ApplicationArea = all;
            }
            field("Old Po No."; Rec."Old Po No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Old Purchase Order No. field.';
            }
            field("Old Po Date"; Rec."Old Po Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Old PUrchase Order Date field.';
            }

        }
        addafter("Vendor Invoice No.")
        {
            field("Vendor Invoice Date"; Rec."Vendor Invoice Date")
            {
                ApplicationArea = All;
            }
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                PostingNoSeries: Record "Posting No. Series";
                TableID: Integer;
                NoSeriesCode: Code[20];
                PostingNoSeriesMgmt: Codeunit "Posting No. Series Mgmt.";
            begin
                /* TableID := Database::"Purchase Header";
                 NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Purch. Rcpt. Header");
                 if NoSeriesCode <> '' then
                     Rec."Receiving No. Series" := NoSeriesCode;*/
            end;
        }
    }
    actions
    {
        addbefore(Post)
        {
            //4.12 
            action("Short Close")
            {
                ApplicationArea = All;
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Short Close the order based on Qty Received and Invoiced';

                trigger OnAction()
                var
                    PurchLine: Record "Purchase Line";
                    ConfirmText: Label 'Do you want to Short Close the Purchase Order %1 ?';
                    NotApplicableErr: Label 'Qty Received and Qty Invoiced should be matching for Line %1';
                    SuccessMsg: Label 'Purchase Order %1 is Short Closed';
                    ShortClosed: Boolean;
                    ErrorMsg: Label 'Short close can be done only  if status is open';
                    ArchiveManagement: Codeunit ArchiveManagement;
                begin
                    //B2BESGOn20Apr2023>>
                    If Rec.Status <> Rec.Status::Open then
                        Error(ErrorMsg);
                    //B2BESGOn20Apr2023<<
                    PurchLine.Reset();
                    PurchLine.SetRange("Document Type", Rec."Document Type");
                    PurchLine.SetRange("Document No.", Rec."No.");
                    PurchLine.SetFilter("No.", '<>%1', '');
                    PurchLine.SetFilter(Quantity, '<>%1', 0);
                    PurchLine.SetRange(ShortClosed, false);
                    if PurchLine.FindSet() then
                        repeat
                            if PurchLine."Quantity Invoiced" <> PurchLine."Quantity Received" then
                                Error(NotApplicableErr, PurchLine."Line No.");
                        until PurchLine.Next() = 0;


                    if not Confirm(StrSubstNo(ConfirmText, Rec."No."), false) then
                        exit;
                    ArchiveManagement.ArchivePurchDocument(Rec);
                    Clear(ShortClosed);
                    PurchLine.Reset();
                    PurchLine.SetRange("Document Type", Rec."Document Type");
                    PurchLine.SetRange("Document No.", Rec."No.");
                    PurchLine.SetFilter("No.", '<>%1', '');
                    PurchLine.SetFilter(Quantity, '<>%1', 0);
                    PurchLine.SetRange(ShortClosed, false);
                    if PurchLine.FindSet() then begin
                        repeat
                            if PurchLine."Quantity Invoiced" = PurchLine."Quantity Received" then begin
                                PurchLine.ShortClosed := true;
                                PurchLine."Original Qty" := PurchLine.Quantity;
                                PurchLine.Quantity := PurchLine."Quantity Invoiced";
                                PurchLine."Short Close Diff Qty" := PurchLine."Original Qty" - PurchLine.Quantity;
                                PurchLine."Outstanding Quantity" := 0;
                                PurchLine.Modify();
                                ShortClosed := true;
                            end;
                        until PurchLine.Next() = 0;
                        if ShortClosed then begin
                            Rec.Validate("Short Close Status", Rec."Short Close Status"::ShortClosed);
                            Rec.Validate("Short Closed By", UserId);
                            Rec.Validate("Short Closed DateTime", CurrentDateTime);
                            Rec.Modify();
                            //ArchiveManagement.ArchivePurchDocument(Rec);
                        end;

                    end;
                end;
            }
            //4.12 <<
        }
        modify("&Print")
        {
            Visible = false;
        }
        /*modify("P&osting")
        {
            Visible = false;
        }*/

        modify("Post &Batch")
        {
            Visible = false;
        }
        modify("Post and &Print")
        {
            Visible = false;
        }
        modify(PostAndNew)
        {
            Visible = false;
        }
        addlast(Print)
        {
            action("Print Order")
            {
                ApplicationArea = All;
                Caption = 'Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';


                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", Rec."No.");
                    if PurchaseHeader.FindFirst() then
                        Report.RunModal(Report::"Purchase Order Report", true, true, PurchaseHeader);
                end;
            }
            action("Print Order New")
            {
                ApplicationArea = All;
                Caption = 'Printable Purchase Order';
                Ellipsis = true;
                Enabled = Printable = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';


                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", Rec."No.");
                    if PurchaseHeader.FindFirst() then
                        Report.RunModal(Report::"Purchase Order Printable", true, true, PurchaseHeader);
                end;
            }
            action("Print Amendment")
            {
                ApplicationArea = All;
                Caption = 'Print Amendment';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", Rec."No.");
                    if PurchaseHeader.FindFirst() then
                        Report.RunModal(Report::"Purchase Order Report Archieve", true, true, PurchaseHeader);
                end;
            }

            action("Print Short Close")
            {
                ApplicationArea = All;
                Caption = 'Print Short Close';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                ToolTip = 'Prepare to print the document. The report request window for the document opens where you can specify what to include on the print-out.';
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                begin
                    PurchaseHeader.Reset();
                    PurchaseHeader.SetRange("No.", Rec."No.");
                    if PurchaseHeader.FindFirst() then
                        Report.RunModal(Report::"Purchase Order Short Close", true, true, PurchaseHeader);
                    Report.RunModal(Report::"Purchase Order Report Archieve", true, true, PurchaseHeader);
                end;
            }
            action("Print Pdf")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print PDF';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Executes the Print PDF action.';
                trigger OnAction()
                var
                    Window: Dialog;
                    FileDirectory: Text[250];
                    PurchaseHeader: Record "Purchase Header";
                    PurchaseHeaderGRecGRec: Record "Purchase Header";
                    FileName: Text[250];
                    ReportPdf: Text;
                    PurchaseOrderReport: Report "Purchase Order Report";
                    //PurchaseOrderReportNonSez: Report "Purchase Order Report";
                    FileName1: Text;
                    TempFile: File;
                    PDFMergeMgt4: Codeunit "PDFMerge Mgt 4";
                    FileManagement: Codeunit "File Management";
                    InStr: InStream;
                    PurchPayableSetup: Record "Purchases & Payables Setup";
                    DocumentAttachment: Record "Document Attachment";
                begin
                    if (Rec."Item Drawings") or (Rec."Terms & Conditions") or (Rec."Test Certificate") then begin
                        PurchPayableSetup.Get();
                        CLEAR(FileDirectory);
                        Window.OPEN('Creating Pdf -------#1############');



                        PurchaseHeaderGRecGRec.RESET;
                        PurchaseHeaderGRecGRec.SETRANGE("No.", rec."No.");
                        PurchaseHeaderGRecGRec.SETRANGE("Document Type", PurchaseHeaderGRecGRec."Document Type"::Order);
                        IF PurchaseHeaderGRecGRec.FINDFIRST THEN BEGIN
                            //FileDirectory := 'D:\New folder (2)\';
                            FileDirectory := PurchPayableSetup.FolderPathReport;
                            FileName := PurchaseHeaderGRecGRec."No." + '.pdf';
                            ReportPdf := FileDirectory + FileName;
                            CLEAR(PurchaseOrderReport);
                            PurchaseOrderReport.SETTABLEVIEW(PurchaseHeaderGRecGRec);
                            PurchaseOrderReport.SAVEASPDF(ReportPdf);
                            Window.UPDATE(1, ReportPdf);
                            //FileName1 := FileDirectory + 'scan.pdf';
                            DocumentAttachment.Reset();
                            DocumentAttachment.SetRange("Document Type", DocumentAttachment."Document Type"::Order);
                            DocumentAttachment.SetRange("No.", Rec."No.");
                            if "Terms & Conditions" then
                                DocumentAttachment.SetRange(Type_B2B, DocumentAttachment.Type_B2B::"Terms & Condition");
                            if "Test Certificate" then
                                DocumentAttachment.SetRange(Type_B2B, DocumentAttachment.Type_B2B::"Special Instructions");
                            if DocumentAttachment.FindLast() then begin
                                FileName1 := PurchPayableSetup."Attachment Path" + DocumentAttachment."File Name" + DelChr(Rec."No.", '=', ' _!@#$%^&*(){}[]:.,/|\') + '.' + DocumentAttachment."File Extension";
                                //FileName1 := FileDirectory + PurchPayableSetup.FolderPathTerms + '.pdf';
                                PDFMergeMgt4.MergePDFFilesForAttachment(ReportPdf, FileName1, '', '', '', ReportPdf);
                                Window.CLOSE;
                                //Exprot the Merged PDF
                                TempFile.Open(ReportPdf);
                                TempFile.CreateInStream(InStr);
                                DownloadFromStream(InStr, '', '', '', FileName);
                                TempFile.Close();
                            end Else
                                Window.Close();
                        end;
                    end else begin
                        PurchaseHeader.Reset();
                        PurchaseHeader.SetRange("No.", Rec."No.");
                        if PurchaseHeader.FindFirst() then
                            Report.RunModal(Report::"Purchase Order Report", true, true, PurchaseHeader);
                    end;
                end;
            }
        }
        /*modify("Attached Gate Entry")
        {
            Visible = false;
        }
        modify("Get Gate Entry Lines")
        {
            Visible = false;
        }*/
        modify(Release)
        {
            trigger OnBeforeAction()
            var
                PurchLine: Record "Purchase Line";
                PurchLineLrec: Record "Purchase Line";
                CountLrcec: Integer;
                CountLrec2: Integer;

                PostingNoSeries: Record "Posting No. Series";
                TableID: Integer;
                NoSeriesCode: Code[20];
                PostingNoSeriesMgmt: Codeunit "Posting No. Series Mgmt.";
                EmialMessage: Codeunit "Email Message";
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                // Rec.TestField("Order Type",<>"Order Type"::" ");
                if "Order Type" = "Order Type"::" " then
                    Error('Please Select The Order Type');
                if Printable then begin
                    PurchLine.Reset();
                    PurchLine.SetRange("Document Type", Rec."Document Type");
                    PurchLine.SetRange("Document No.", Rec."No.");
                    PurchLine.SetFilter(Type, '<>%1', PurchLine.Type::" ");
                    if PurchLine.FindSet() then
                        repeat
                            if PurchLine."Line Amount" <> PurchLine."Printable amount" then
                                Error('Line Amount And Printable Amount Mismatched');
                        until PurchLine.Next() = 0;
                end;
                Clear(CountLrcec);
                Clear(CountLrec2);
                PurchLineLrec.Reset();
                PurchLineLrec.SetRange("Document Type", "Document Type");
                PurchLineLrec.SetRange("Document No.", "No.");
                PurchLineLrec.SetFilter(Type, '<>%1', PurchLineLrec.Type::" ");
                if PurchLineLrec.FindSet() then begin
                    CountLrcec := PurchLineLrec.Count;
                    PurchLineLrec.Reset();
                    PurchLineLrec.SetRange("Document Type", "Document Type");
                    PurchLineLrec.SetRange("Document No.", "No.");
                    PurchLineLrec.SetRange(Type, PurchLineLrec.Type::"G/L Account");
                    PurchLineLrec.SetRange("Gen. Prod. Posting Group", 'SER');
                    if PurchLineLrec.FindSet() then
                        CountLrec2 := PurchLineLrec.Count;

                end;

                Clear(NoSeriesCode);
                if "Document Type" = "Document Type"::Order then begin
                    TableID := Database::"Purchase Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Purch. Rcpt. Header");
                    if NoSeriesCode <> '' then begin
                        // Rec."Posting No. Series" := NoSeriesCode;
                        Rec."Receiving No. Series" := NoSeriesCode;
                        if CountLrcec = CountLrec2 then
                            Rec."Service MRV" := true;
                        Rec.Modify();
                    end else
                        if CountLrcec = CountLrec2 then begin
                            Rec."Service MRV" := true;
                            Rec.Modify();
                        end;
                end;
            end;
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                PurchLine: Record "Purchase Line";
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                if "Order Type" = "Order Type"::" " then
                    Error('Please Select The Order Type');
                if Printable then begin
                    PurchLine.Reset();
                    PurchLine.SetRange("Document Type", Rec."Document Type");
                    PurchLine.SetRange("Document No.", Rec."No.");
                    PurchLine.SetFilter(Type, '<>%1', PurchLine.Type::" ");
                    if PurchLine.FindSet() then
                        repeat
                            if PurchLine."Line Amount" <> PurchLine."Printable amount" then
                                Error('Line Amount And Printable Amount Mismatched');
                        until PurchLine.Next() = 0;
                end;
            end;
        }
        /*modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }*/
        //modify(pr)
        modify(PostPrepaymentInvoice)
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
        modify(Post)
        {
            Visible = false;
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                if "Order Type" = "Order Type"::" " then
                    Error('Please Select The Order Type');
            end;
        }
        modify(Preview)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        addlast("F&unctions")
        {

            group("Delivery Challan")
            {
                action("RDC Out List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = InwardEntry;
                    RunObject = page "Posted RGP Out List";
                    RunPageLink = "Reference No." = field("No.");
                    ToolTip = 'View attached gate entry list.';
                    Caption = 'RDC Out List';
                }
                action("RDC IN List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = InwardEntry;
                    RunObject = page "Posted RGP IN List";
                    RunPageLink = "Reference No." = field("No.");
                    ToolTip = 'View attached gate entry list.';
                    Caption = 'RDC In List';
                }
                action("NRDC List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = InwardEntry;
                    RunObject = page "Posted NRGP List";
                    RunPageLink = "Reference No." = field("No.");
                    ToolTip = 'View attached gate entry list.';
                    Caption = 'NRDC List';
                }

            }
        }
        modify(Reopen)
        {
            trigger OnBeforeAction()
            var
                UserSetup: Record "User Setup";
                ArchiveManagement: Codeunit ArchiveManagement;//B2BESGOn20Apr2023
            begin
                if (UserSetup.Get(UserId)) and (not UserSetup."Purchase Department Access") then
                    Error('You dont have permissions to open the document');
                //B2BESGOn20Apr2023>>
                ArchiveManagement.ArchivePurchDocument(Rec);
                CurrPage.Update(false);
                Rec."Service MRV" := false;
                //B2BESGOn20Apr2023<<
            end;
        }

        modify("Create &Whse. Receipt")
        {
            Visible = false;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Visible = false;
        }
        modify("Send Intercompany Purchase Order")
        {
            Visible = false;
        }
        modify("Dr&op Shipment")
        {
            Visible = false;
        }
        modify("Speci&al Order")
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        addafter(Release)
        {
            action("Purchase Order Acknowledgement")
            {
                ApplicationArea = Basic, Suite;
                Image = PrintAcknowledgement;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'View Purchase Order Acknowledgement';
                Caption = 'Purchase Order Acknowledgement';
                trigger OnAction()
                begin
                    POAckValueVar := true;
                end;
            }
        }

    }
    /* trigger OnNewRecord(BelowxRec: Boolean)
     var
         DimensionRec: Record "Dimension Value";
         NoSeriesMgmt: Codeunit NoSeriesManagement;
     begin
         DimensionRec.Reset();
         DimensionRec.SetRange("Global Dimension No.", 1);
         if DimensionRec.FindSet() then begin
             if Page.RunModal(Page::"Dimension Values", DimensionRec) = Action::LookupOK then begin
                 DimensionRec.TestField("No Series(PO)");
                 //DimensionRec.TestField("Receiving No Series(Po)");
                 //DimensionRec.TestField("Posting No Series(PO)");
                 //DimensionRec.TestField("Prepmt No Series(PO)");
                 //DimensionRec.TestField("Prepmt Cr Memo No Ser(PO)");
                 "No." := NoSeriesMgmt.GetNextNo(DimensionRec."No Series(PO)", WorkDate, true);
                 "No. Series" := DimensionRec."No Series(PO)";
                 //Insert;
             end;
         end;
     end;*/
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Shortcut Dimension 2 Code_B2B" = '' then
            Rec."Shortcut Dimension 2 Code_B2B" := Rec."Shortcut Dimension 2 Code";
    end;

    trigger OnOpenPage()
    begin
        POAckValueVar := false;
    end;

    var
        POAckValueVar: Boolean;
}
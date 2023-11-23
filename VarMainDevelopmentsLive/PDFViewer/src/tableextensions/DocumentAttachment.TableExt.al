tableextension 50016 DocumentAttachmentExt extends "Document Attachment"
{
    fields
    {
        field(50000; "Drawing No_B2B"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Drawing No.';
        }
        field(50001; "Drawing Revision No._B2B"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Drawing Revision No.';
        }
        field(50002; "Production Bom Version_B2B"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Production Bom Version';
            trigger OnLookup()
            var
                ProductionBomHdrLrec: record "Production BOM Header";
                ProductionBomVersionLrec: Record "Production BOM Version";
                ItemLrec: Record Item;
            begin
                if (Rec."Table ID" = 27) and (Rec."No." <> '') then begin
                    if ItemLrec.Get(Rec."No.") then begin
                        if ProductionBomHdrLrec.Get(ItemLrec."Production BOM No.") then begin
                            ProductionBomVersionLrec.Reset();
                            ProductionBomVersionLrec.SetRange("Production BOM No.", ProductionBomHdrLrec."No.");
                            if ProductionBomVersionLrec.FindSet() then begin
                                if Page.RunModal(99000800, ProductionBomVersionLrec) = Action::LookupOK then
                                    Rec."Production Bom Version_B2B" := ProductionBomVersionLrec."Version Code";

                            end;
                        end;
                    end;
                end;

            end;
        }
        field(50003; "File Path"; Text[1024])
        {
            DataClassification = ToBeClassified;
            Caption = 'File Path';
        }
        field(50004; "Flow To Sales"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Flow to Sales. Trx';
        }
        field(50005; "Flow To Purchase"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Flow to Purch. Trx';
        }
        field(50006; "Type_B2B"; Option)
        {
            OptionMembers = " ","Terms & Condition","Test Certificate",Drawing,"Warrenty Certificate","Special Instructions","PO Acknowledgement";
            Caption = 'Type';
        }
    }
    procedure ViewAttachment(Popup: Boolean)
    begin
        if ID = 0 then
            exit;

        case Rec."File Type" of
            Rec."File Type"::PDF:
                ViewInPdfViewer(Popup);
        end

    end;

    local procedure ViewInPdfViewer(Popup: Boolean)
    var
        OpenPdfViewerMeth: Codeunit GetPDFDataMeth;
    begin
        OpenPdfViewerMeth.OpenPdfViewer(Rec, Rec.FieldNo("File Path"), Popup);
    end;

    procedure SaveAttachment1(RecRef: RecordRef; FileName: Text; TempBlob: Codeunit "Temp Blob")
    var
        DocStream: InStream;
    begin

        if FileName = '' then
            Error(EmptyFileNameErr);
        // Validate file/media is not empty
        if not TempBlob.HasValue then
            Error(NoContentErr);

        TempBlob.CreateInStream(DocStream);
        InsertAttachment1(DocStream, RecRef, FileName);
    end;

    procedure SaveAttachmentFromStream1(DocStream: InStream; RecRef: RecordRef; FileName: Text)
    begin

        if FileName = '' then
            Error(EmptyFileNameErr);

        InsertAttachment1(DocStream, RecRef, FileName);
    end;

    local procedure InsertAttachment1(DocStream: InStream; RecRef: RecordRef; FileName: Text)
    var
        PurchPaySetup: Record "Purchases & Payables Setup";
        InventorySetup: Record "Inventory Setup";
        SalesReceievablesSetup: Record "Sales & Receivables Setup";
        ManufacturingSetup: Record "Manufacturing Setup";
        QualityControlSetup: Record "Quality Control Setup B2B";
        TempDocumentAttachment: Record "Document Attachment" temporary;
        TempBlob: Codeunit "Temp Blob";
        DocOutStream: OutStream;
    begin

        IncomingFileName := FileName;
        Validate("File Extension", FileManagement.GetExtension(IncomingFileName));
        Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(IncomingFileName), 1, MaxStrLen("File Name")));

        // IMPORTSTREAM(stream,description, mime-type,filename)
        // description and mime-type are set empty and will be automatically set by platform code from the stream
        //TempDocumentAttachment."Document Reference ID".ImportStream(DocStream, '');
        //if not TempDocumentAttachment."Document Reference ID".HasValue then
        //   Error(NoDocumentAttachedErr);
        Clear(TempDocumentAttachment."Document Reference ID");
        InitFieldsFromRecRef(RecRef);
        // if "Table ID" = Database::Vendor then
        //   PurchPaySetup.TestField("Attachment Path");
        //IF TempDocumentAttachment."Document Reference ID".HasValue THEN BEGIN
        //if "Table ID" = Database::Vendor then
        //  "File Path" := PurchPaySetup."Attachment Path" + "File Name" + '.' + "File Extension"
        //else
        if "Table ID" in [Database::Item, Database::"Transfer Header", Database::"Transfer Receipt Header",
                            Database::"Transfer Shipment Header", Database::"Transfer Line", Database::"Transfer Receipt Line"
                            , Database::"Transfer Shipment Line"] then begin
            InventorySetup.Get();
            InventorySetup.TestField("Attachment Path");
            "File Path" := InventorySetup."Attachment Path" + "File Name" + DelChr("No.", '=', ' _!@#$%^&*(){}[]:.,/|\') + '.' + "File Extension";
        end else
            if "Table ID" in [Database::"Purchase Header", Database::"Purch. Rcpt. Header", Database::"Purch. Inv. Header",
                              Database::"Purch. Cr. Memo Hdr.", Database::"Indent Header", Database::"Purchase Line",
                              Database::"Purch. Inv. Line", Database::"Purch. Rcpt. Line", Database::"Purch. Cr. Memo Line"] then begin
                PurchPaySetup.Get();
                PurchPaySetup.TestField("Attachment Path");
                "File Path" := PurchPaySetup."Attachment Path" + "File Name" + DelChr("No.", '=', ' _!@#$%^&*(){}[]:.,/|\') + '.' + "File Extension";
                //B2BPROn06Jul2023<<<
                if "Table ID" in [Database::"Purchase Header"] then begin
                    PurchHeaderGRec.Reset();
                    PurchHeaderGRec.SetRange("No.", Rec."No.");
                    PurchHeaderGRec.SetRange("Document Type", PurchHeaderGRec."Document Type"::Order);
                    if PurchHeaderGRec.FindFirst() then begin
                        if PurchHeaderGRec."Ack.Val" then begin
                            PurchPaySetup.Get();
                            PurchPaySetup.TestField("Acknowledgement Path");
                            "File Path" := PurchPaySetup."Acknowledgement Path" + "File Name" + DelChr("No.", '=', ' _!@#$%^&*(){}[]:.,/|\') + '.' + "File Extension";
                        end;
                    end;
                end;
                //B2BPROn06Jul2023<<<
            end else
                if "Table ID" in [Database::"Sales Header", Database::"Sales Cr.Memo Header",
                                  Database::"Sales Invoice Header", Database::"Sales Shipment Header",
                                  Database::"Sales Line", Database::"Sales Cr.Memo Line", Database::"Sales Invoice Line",
                                  Database::"Sales Shipment Line"] then begin
                    SalesReceievablesSetup.Get();
                    SalesReceievablesSetup.TestField("Attachment Path");
                    "File Path" := SalesReceievablesSetup."Attachment Path" + "File Name" + DelChr("No.", '=', ' _!@#$%^&*(){}[]:.,/|\') + '.' + "File Extension";
                end else
                    if "Table ID" in [Database::"Production Order", Database::"Production BOM Header",
                                      database::"Production BOM Version", Database::"Routing Header", Database::"Routing Version"] then begin
                        ManufacturingSetup.Get();
                        ManufacturingSetup.TestField("Attachment Path");
                        "File Path" := ManufacturingSetup."Attachment Path" + "File Name" + DelChr("No.", '=', ' _!@#$%^&*(){}[]:.,/|\') + '.' + "File Extension";
                    end else
                        if "Table ID" in [Database::"Specification Header B2B", Database::"Ins Datasheet Header B2B",
                           Database::"Posted Ins DatasheetHeader B2B", Database::"Inspection Receipt Header B2B"] then begin
                            QualityControlSetup.Get();
                            QualityControlSetup.TestField("Attachment Path");
                            "File Path" := QualityControlSetup."Attachment Path" + "File Name" + DelChr("No.", '=', ' _!@#$%^&*(){}[]:.,/|\') + '.' + "File Extension";
                        end;

        TempBlob.CreateOutStream(DocOutStream);
        CopyStream(DocOutStream, DocStream);
        FileManagement.BLOBExportToServerFile(TempBlob, "File Path");
        //FileManagement.InstreamExportToServerFile(DocStream, "File Path");
        //"Document Reference ID".ExportFile("File Path");
        //CLEAR("Document Reference ID");
        //END;
        if IncomingFileName <> '' then begin
            Validate("File Extension", FileManagement.GetExtension(IncomingFileName));
            Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(IncomingFileName), 1, MaxStrLen("File Name")));
        end;

        Validate("Attached Date", CurrentDateTime);
        if IsNullGuid("Attached By") then
            "Attached By" := UserSecurityId;
        Insert;
    end;

    trigger OnBeforeDelete()
    begin
        if Exists("File Path") then
            Erase("File Path")
    end;


    var
        NoDocumentAttachedErr: Label 'Please attach a document first.';
        EmptyFileNameErr: Label 'Please choose a file to attach.';
        NoContentErr: Label 'The selected file has no content. Please choose another file.';
        FileManagement: Codeunit "File Management";
        //Path : DotNet pat
        IncomingFileName: Text;
        //ta : Record docum
        DuplicateErr: Label 'This file is already attached to the document. Please choose another file.';
        PurchHeaderGRec: Record "Purchase Header";
        re: Record 1173;
}
/*tableextension 50016 "Document Attachment Ext" extends "Document Attachment"
{
    fields
    {
        field(50000; "Drawing No_B2B"; Code[20])
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

    procedure SaveAttachmentNew(RecRef: RecordRef; FileName: Text; TempBlob: Codeunit "Temp Blob")
    var
        DocStream: InStream;
    begin
        //OnBeforeSaveAttachment(Rec, RecRef, FileName, TempBlob);

        if FileName = '' then
            Error(EmptyFileNameErr);
        // Validate file/media is not empty
        if not TempBlob.HasValue then
            Error(NoContentErr);

        TempBlob.CreateInStream(DocStream);
        InsertAttachment(DocStream, RecRef, FileName);
    end;

    local procedure InsertAttachment(DocStream: InStream; RecRef: RecordRef; FileName: Text)
    var
        TempDocumentAttachment: Record "Document Attachment" temporary;
        TempBlob: Codeunit "Temp Blob";
        DocOutStream: OutStream;
        PurchasePayableSetup: Record "Purchases & Payables Setup";

    begin
        PurchasePayableSetup.Get();
        PurchasePayableSetup.TestField("Attachment Path");
        IncomingFileName := FileName;

        Validate("File Extension", FileManagement.GetExtension(IncomingFileName));
        Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(IncomingFileName), 1, MaxStrLen("File Name")));
        // IMPORTSTREAM(stream,description, mime-type,filename)
        // description and mime-type are set empty and will be automatically set by platform code from the stream
        //"Document Reference ID".ImportStream(DocStream, '');
        // if not "Document Reference ID".HasValue then
        //   Error(NoDocumentAttachedErr);
        InitFieldsFromRecRef(RecRef);
        "File Path" := PurchasePayableSetup."Attachment Path" + "File Name" + DelChr("No.", '=', ' _!@#$%^&*(){}[]:.,/|\') + '.' + "File Extension";

        TempBlob.CreateOutStream(DocOutStream);
        CopyStream(DocOutStream, DocStream);
        FileManagement.BLOBExportToServerFile(TempBlob, "File Path");
        if IncomingFileName <> '' then begin
            Validate("File Extension", FileManagement.GetExtension(IncomingFileName));
            Validate("File Name", CopyStr(FileManagement.GetFileNameWithoutExtension(IncomingFileName), 1, MaxStrLen("File Name")));
        end;
        //OnBeforeInsertAttachment(Rec, RecRef);
        // Insert(true);
        Insert();
    end;

    trigger OnBeforeDelete()
    begin
        if Exists("File Path") then
            Erase("File Path")
    end;

    var
        EmptyFileNameErr: Label 'Please choose a file to attach.';
        NoContentErr: Label 'The selected file has no content. Please choose another file.';
        FileManagement: Codeunit "File Management";
        IncomingFileName: Text;
        NoDocumentAttachedErr: Label 'Please attach a document first.';
    //Cu : Codeunit 5750;
}*/
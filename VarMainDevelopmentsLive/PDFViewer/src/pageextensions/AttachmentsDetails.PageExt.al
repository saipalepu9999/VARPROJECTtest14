pageextension 50010 DocumentAttachmentDetailsExt extends "Document Attachment Details"
{
    layout
    {
        addafter("Document Flow Sales")
        {
            field("Drawing No_B2B"; Rec."Drawing No_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Drawing No. field.';
            }
            field("Drawing Revision No._B2B"; Rec."Drawing Revision No._B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Drawing Revision No. field.';
            }
            field("Production Bom Version_B2B"; Rec."Production Bom Version_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Production Bom Version field.';
            }
            
            field(Type_B2B; Rec.Type_B2B)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Type field.';
            }
            field("Flow To Sales"; Rec."Flow To Sales")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Flow to Sales. Trx field.';

                trigger OnValidate()
                begin
                    /*//if not (FromRecRef.Number = Database::Item) then begin
                    if "Flow To Sales" then
                        "Document Flow Sales" := true
                    else
                        "Document Flow Sales" := false;
                    //end;*/

                end;
            }
            field("Flow To Purchase"; Rec."Flow To Purchase")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Flow to Purch. Trx field.';
                trigger OnValidate()
                begin
                    /*//if not (FromRecRef.Number = Database::Item) then begin
                    if "Flow To Purchase" then
                        "Document Flow Purchase" := true
                    else
                        "Document Flow Purchase" := false;
                    //end;*/

                end;
            }
        }
        modify(Name)
        {
            Visible = false;
        }
        modify("Document Flow Purchase")
        {
            Visible = false;
        }
        modify("Document Flow Sales")
        {
            Visible = false;
        }
        addafter(name)
        {
            field(Name2; Rec."File Name")
            {
                Caption = 'Name';
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the filename of the attachment.';

                trigger OnDrillDown()
                var
                    TempBlob: Codeunit "Temp Blob";
                    FileName: Text;
                begin
                    if Rec."File Path" <> '' then
                        Rec.ViewAttachment(false)
                    else begin
                        ImportWithFilter1(TempBlob, FileName);
                        if FileName <> '' then
                            Rec.SaveAttachment1(FromRecRef, FileName, TempBlob);
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }
    actions
    {
        addlast(Processing)
        {
            action(ViewPDF)
            {
                ApplicationArea = All;
                Caption = 'View';
                Image = View;
                Enabled = Rec."File Type" = Rec."File Type"::PDF;
                Scope = "Repeater";
                ToolTip = 'Executes the View action.';

                trigger OnAction()
                begin
                    Rec.ViewAttachment(false);
                end;
            }
            action(ViewPDFPopup)
            {
                ApplicationArea = All;
                Caption = 'View in new window';
                Image = View;
                Enabled = Rec."File Type" = Rec."File Type"::PDF;
                Scope = "Repeater";
                ToolTip = 'Executes the View in new window action.';

                trigger OnAction()
                begin
                    Rec.ViewAttachment(true);
                end;
            }
        }
    }
    local procedure ImportWithFilter1(var TempBlob: Codeunit "Temp Blob"; var FileName: Text)
    var
        FileManagement: Codeunit "File Management";
        IsHandled: Boolean;
    begin
        FileName := FileManagement.BLOBImportWithFilter(
            TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
    end;

    procedure CopyAttachmentsNew(var FromRecRef: RecordRef; var ToRecRef: RecordRef)
    var
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
        FromFieldRef: FieldRef;
        ToFieldRef: FieldRef;
        FromDocumentType: Enum "Incoming Document Type";
        FromLineNo: Integer;
        FromNo: Code[20];
        ToNo: Code[20];
        ToDocumentType: Enum "Incoming Document Type";
        ToLineNo: Integer;
    begin
        FromDocumentAttachment.SetRange("Table ID", FromRecRef.Number);
        if FromDocumentAttachment.IsEmpty() then
            exit;
        case FromRecRef.Number() of
            DATABASE::Customer,
            DATABASE::Vendor,
            DATABASE::Item:
                begin
                    FromFieldRef := FromRecRef.Field(1);
                    FromNo := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("No.", FromNo);
                end;
            DATABASE::"Sales Header",
            DATABASE::"Purchase Header":
                begin
                    FromFieldRef := FromRecRef.Field(1);
                    FromDocumentType := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("Document Type", FromDocumentType);
                    FromFieldRef := FromRecRef.Field(3);
                    FromNo := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("No.", FromNo);
                end;
            DATABASE::"Sales Line",
            DATABASE::"Purchase Line":
                begin
                    FromFieldRef := FromRecRef.Field(1);
                    FromDocumentType := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("Document Type", FromDocumentType);
                    FromFieldRef := FromRecRef.Field(3);
                    FromNo := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("No.", FromNo);
                    FromFieldRef := FromRecRef.Field(4);
                    FromLineNo := FromFieldRef.Value();
                    FromDocumentAttachment.SetRange("Line No.", FromLineNo);
                end
        end;

        case ToRecRef.Number() of
            DATABASE::"Sales Line":
                if FromRecRef.Number() <> DATABASE::"Sales Line" then
                    FromDocumentAttachment.SetRange("Document Flow Sales", true);
            DATABASE::"Sales Header":
                if FromRecRef.Number() <> DATABASE::"Sales Header" then
                    FromDocumentAttachment.SetRange("Document Flow Sales", true);
            DATABASE::"Purchase Line":
                if FromRecRef.Number() <> DATABASE::"Purchase Line" then
                    FromDocumentAttachment.SetRange("Document Flow Purchase", true);
            DATABASE::"Purchase Header":
                if FromRecRef.Number() <> DATABASE::"Purchase Header" then
                    FromDocumentAttachment.SetRange("Document Flow Purchase", true);
        end;

        if FromDocumentAttachment.FindSet() then
            repeat
                Clear(ToDocumentAttachment);
                ToDocumentAttachment.Init();
                ToDocumentAttachment.TransferFields(FromDocumentAttachment);
                ToDocumentAttachment.Validate("Table ID", ToRecRef.Number);

                ToFieldRef := ToRecRef.Field(3);
                ToNo := ToFieldRef.Value();
                ToDocumentAttachment.Validate("No.", ToNo);

                case ToRecRef.Number() of
                    DATABASE::"Sales Header",
                    DATABASE::"Purchase Header":
                        begin
                            ToFieldRef := ToRecRef.Field(1);
                            ToDocumentType := ToFieldRef.Value();
                            ToDocumentAttachment.Validate("Document Type", ToDocumentType);
                        end;
                    DATABASE::"Sales Line",
                    DATABASE::"Purchase Line":
                        begin
                            ToFieldRef := ToRecRef.Field(1);
                            ToDocumentType := ToFieldRef.Value();
                            ToDocumentAttachment.Validate("Document Type", ToDocumentType);

                            ToFieldRef := ToRecRef.Field(4);
                            ToLineNo := ToFieldRef.Value();
                            ToDocumentAttachment.Validate("Line No.", ToLineNo);
                        end;
                end;

                //if not ToDocumentAttachment.Insert(true) then;
                if not ToDocumentAttachment.Insert then;
                ToDocumentAttachment."Attached Date" := FromDocumentAttachment."Attached Date";
                ToDocumentAttachment.Modify();

            until FromDocumentAttachment.Next() = 0;

        // Copies attachments for header and then calls CopyAttachmentsForPostedDocsLines to copy attachments for lines.
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) and UserSetup."Attachment Access" then
            CurrPage.Editable(true)
        else
            CurrPage.Editable(false);
    end;



    var
        FileExtensionLbl: Label '.%1', Locked = true;
        FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
        ImportTxt: Label 'Attach a document.';
        SelectFileTxt: Label 'Select File...';
        PurchInvSubform: Page "Purch. Invoice Subform";
        purchline: Record "Purchase Line";
        DocAttMgmt: Codeunit "Document Attachment Mgmt";
}
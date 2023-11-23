report 50056 "Permissions Import"
{
    Caption = 'Permission Import';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {


    }

    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            Ext: Text;
            Text100: Label 'Permission Import';
        begin

            if CloseAction = Action::OK then begin
                DialogCaption := 'Select File to upload';
                UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);
                If Name <> '' then
                    Sheetname := ExcelBuffer.SelectSheetsNameStream(NVInStream)
                else
                    exit;

            end;
        end;
    }

    var

        ExcelBuffer1: Record "Excel Buffer" temporary;
        SheetName: Text;
        FileMgmt: Codeunit "File Management";
        ExcelBuffer: Record "Excel Buffer";
        DialogCaption: Text;
        Name: Text;
        NVInStream: InStream;
        UploadResult: Boolean;

    trigger OnPostReport()
    begin
        ImportLines();
    end;


    PROCEDURE GetValueAtCell(RowNo: Integer; ColumnNo: Integer): Text;
    BEGIN
        IF ExcelBuffer1.GET(RowNo, ColumnNo) THEN
            EXIT(ExcelBuffer1."Cell Value as Text");
    END;

    procedure ImportLines()
    var
        I: Integer;

        Permission: Record "Tenant Permission";
        f: XmlPort "Import Permission Sets";
        PermissionSetBuf: Record "Tenant Permission Set";
    begin
        Clear(I);
        ExcelBuffer1.OpenBookStream(NVInStream, Sheetname);
        ExcelBuffer1.ReadSheet();
        ExcelBuffer1.SETRANGE("Column No.", 1);
        IF ExcelBuffer1.FINDSET THEN BEGIN
            FOR I := 1 TO ExcelBuffer1.Count() DO BEGIN
                if I <> 1 then begin

                    PermissionSetBuf.Reset();
                    PermissionSetBuf.SetRange("Role ID", GetValueAtCell(I, 1));
                    if PermissionSetBuf.FindFirst() then;

                    Permission.Init();
                    Permission."App ID" := PermissionSetBuf."App ID";
                    Permission."Role ID" := GetValueAtCell(I, 1);
                    Permission.Type := Permission.Type::Include;
                    evaluate(Permission."Object Type", GetValueAtCell(I, 2));
                    Evaluate(Permission."Object ID", GetValueAtCell(I, 3));
                    Permission.Validate("Object ID");
                    Evaluate(Permission."Read Permission", GetValueAtCell(I, 4));
                    Evaluate(Permission."Insert Permission", GetValueAtCell(I, 5));
                    Evaluate(Permission."Modify Permission", GetValueAtCell(I, 6));
                    Evaluate(Permission."Delete Permission", GetValueAtCell(I, 7));
                    Evaluate(Permission."Execute Permission", GetValueAtCell(I, 8));
                    Permission.Insert(true);

                end;
            end;
        end;
    end;


}
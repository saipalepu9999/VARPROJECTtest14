//B2BJK On 02May2023 >>

report 50081 "Update Cheque No"
{
    Caption = 'Update Cheque No Bank Ledger Entries';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    UseRequestPage = false;
    Permissions = tabledata "Bank Account Ledger Entry" = RM;
    dataset
    {
        /*dataitem(Integer;Integer)
        {
            trigger OnPreDataItem()
            begin
                ReadExcelSheet();
                ImportExcelData();
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                Message('Data imported successfully');
            end;
        }*/

    }
    trigger OnPreReport()
    begin
        ReadExcelSheet();
        ImportExcelData();
        Window.Close();
        Message('Data imported successfully');
    end;

    /* requestpage
     {

         layout
         {

             area(Content)
             {
                 group(Options)
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
        TempBuffer: Record "Excel Buffer" temporary;

        ExcelBuffer: Record "Excel Buffer";
        ServerFileName: Text[100];
        SheetName: Text[100];
        FileMgt: Codeunit "File Management";

        Window: Dialog;
        Text000: Label 'Updating Lines.....';
        Text002: Label 'No %1,RowNo %2';
        Text001: Label 'Do you want To Update Lines...?';



    local procedure ReadExcelSheet()
    var
        FileMgmt: Codeunit "File Management";
        Istream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream('', '', '', FromFile, Istream);
        if FromFile <> '' then begin
            ServerFileName := FileMgmt.GetFileName(FromFile);
            SheetName := TempBuffer.SelectSheetsNameStream(Istream);
        end else
            Error('File not Found');

        TempBuffer.Reset();
        TempBuffer.DeleteAll();
        TempBuffer.OpenBookStream(Istream, SheetName);
        TempBuffer.ReadSheet();
    end;

    local procedure ImportExcelData()
    var

        RowNo: Integer;
        ColNo: Integer;
        BankLdegEntryGrec: Record "Bank Account Ledger Entry";
        MaxRowNo: Integer;
    begin
        if not Confirm(Text001) then
            exit;
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        // LineNo := 0;
        // if UserSetup.Get(UserId) then;
        // SalesLine.Reset();
        //if SalesLine.FindLast() then
        //    LineNo := SalesLine."Line No.";
        TempBuffer.Reset();
        if TempBuffer.FindLast() then begin
            MaxRowNo := TempBuffer."Row No.";
        end;

        for RowNo := 2 to MaxRowNo do begin


            Window.OPEN('#1#################################\\' + Text000);
            BankLdegEntryGrec.Reset();
            BankLdegEntryGrec.SetRange("Document No.", GetValueAtCell(RowNo, 1));
            if BankLdegEntryGrec.FindSet() then
                BankLdegEntryGrec.ModifyAll("Cheque No.", GetValueAtCell(RowNo, 2));
        end;
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        TempBuffer.Reset();
        if TempBuffer.get(RowNo, ColNo) then
            exit(TempBuffer."Cell Value as Text")
        else
            exit('');
    end;


}
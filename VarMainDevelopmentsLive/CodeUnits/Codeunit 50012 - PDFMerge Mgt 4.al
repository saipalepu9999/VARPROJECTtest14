
codeunit 50013 "PDFMerge Mgt 4"
{
    // version B2BQTO


    trigger OnRun();
    begin
        //POandTermsPrint_gFnc;

        //MergePDFFiles(String,'D:\Images\3.pdf');
    end;

    var
        Text50000_gCtx: Label 'Purchase Order %1 Must be Authorized to Print.';
        Text000: TextConst ENU = '%1\PdfMerge output=%2 input=%3,%4';

    procedure MergePDFFiles(PDFFile1: Text; PDFFile2: Text; PDFFile3: Text; PDFFile4: Text; PDFFile5: Text; NewPDFFile: Text);
    var
        PDFDocOut: DotNet PdfDocument;
    begin
        PDFDocOut := PDFDocOut.PdfDocument;

        IF PDFFile1 <> '' THEN
            AddPages(PDFFile1, PDFDocOut);
        IF PDFFile2 <> '' THEN
            AddPages(PDFFile2, PDFDocOut);
        IF PDFFile3 <> '' THEN
            AddPages(PDFFile3, PDFDocOut);
        IF PDFFile4 <> '' THEN
            AddPages(PDFFile4, PDFDocOut);
        IF PDFFile5 <> '' THEN
            AddPages(PDFFile5, PDFDocOut);

        IF EXISTS(NewPDFFile) THEN
            ERASE(NewPDFFile);

        PDFDocOut.Save(NewPDFFile);
        PDFDocOut.Close;
        PDFDocOut.Dispose;
    end;

    local procedure AddPages(PDFFileName: Text; var DestPDF: DotNet PdfDocument); //RUNONCLIENT);
    var
        FromPDF: DotNet PdfDocument;
        PDFReader: DotNet PdfReader;
        PDFOpenDocMode: DotNet PdfDocumentOpenMode;
        i: Integer;
        cu22: Codeunit 22;
    begin
        FromPDF := PDFReader.Open(PDFFileName, PDFOpenDocMode.Import);

        FOR i := 0 TO FromPDF.PageCount - 1 DO
            DestPDF.AddPage(FromPDF.Pages.Item(i));

        FromPDF.Close;
        FromPDF.Dispose;
    end;

    procedure MergePDFFilesForAttachment(PDFFile1: Text; PDFFile2: Text; PDFFile3: Text; PDFFile4: Text; PDFFile5: Text; NewPDFFile: Text);
    var
        PDFDocOut: DotNet PdfDocument;
    begin
        PDFDocOut := PDFDocOut.PdfDocument;

        IF PDFFile1 <> '' THEN
            AddPages(PDFFile1, PDFDocOut);
        IF PDFFile2 <> '' THEN
            AddPages(PDFFile2, PDFDocOut);
        IF PDFFile3 <> '' THEN
            AddPages(PDFFile3, PDFDocOut);
        IF PDFFile4 <> '' THEN
            AddPages(PDFFile4, PDFDocOut);
        IF PDFFile5 <> '' THEN
            AddPages(PDFFile5, PDFDocOut);

        IF EXISTS(NewPDFFile) THEN
            ERASE(NewPDFFile);

        PDFDocOut.Save(NewPDFFile);
        PDFDocOut.Close;
        PDFDocOut.Dispose;
    end;
}

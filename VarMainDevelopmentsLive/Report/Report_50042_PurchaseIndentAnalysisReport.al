report 50042 "PurchaseIndentAnalysisReport"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    //DefaultLayout = RDLC;
    //RDLCLayout = 'Report\Layouts\InwardRegister.rdl';

    dataset
    {
        dataitem("Indent Line"; "Indent Line")
        {
            //DataItemTableView = where("Indent Status" = const(Order));
            CalcFields = "Available Inventory";
            trigger OnAfterGetRecord()
            begin
                LinesPrintedGvar := false;
                Clear(ItemDrawingNoGvar);
                DocAttachment.Reset();
                DocAttachment.SetRange("Table ID", 27);
                DocAttachment.SetRange("No.", "Indent Line"."No.");
                DocAttachment.SetRange(Type_B2B, DocAttachment.Type_B2B::Drawing);
                if DocAttachment.FindLast() then
                    ItemDrawingNoGvar := DocAttachment."Drawing No_B2B";
                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(ItemDrawingNoGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Model, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(Make, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Unit of Measure", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Req.Quantity", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(format("Due Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn("Available Inventory", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn("Shortage Qty", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                PurchaseHeaderGrec.Reset();
                PurchaseHeaderGrec.SetRange("Indent No.", "Document No.");
                if PurchaseHeaderGrec.FindFirst() then begin
                    PurchaseLineGrec.Reset();
                    PurchaseLineGrec.SetRange("Document No.", PurchaseHeaderGrec."No.");
                    PurchaseLineGrec.SetRange(Type, PurchaseLineGrec.Type::Item);
                    if PurchaseLineGrec.FindFirst() then begin
                        ExcelBuffer.AddColumn(PurchaseLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(format(PurchaseLineGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn(PurchaseLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        PurchRcptLineGrec.Reset();
                        PurchRcptLineGrec.SetRange("Order No.", PurchaseLineGrec."Document No.");
                        PurchRcptLineGrec.SetRange("Order Line No.", PurchaseLineGrec."Line No.");
                        if PurchRcptLineGrec.FindSet() then begin
                            repeat
                                if not LinesPrintedGvar then begin
                                    Clear(IRNoGvar);
                                    Clear(IRDateGvar);
                                    ExcelBuffer.AddColumn(PurchRcptLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn(format(PurchRcptLineGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                    ExcelBuffer.AddColumn(PurchRcptLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    InspectRcptHdr.Reset();
                                    InspectRcptHdr.SetCurrentKey("Rework Level");
                                    InspectRcptHdr.SetRange("Receipt No.", PurchRcptLineGrec."Document No.");
                                    if InspectRcptHdr.FindLast() then begin
                                        IRNoGvar := InspectRcptHdr."No.";
                                        IRDateGvar := InspectRcptHdr."Posting Date";
                                    end;
                                    Clear(IndentLineGrec);
                                    if IndentLineGrec.Get("Document No.") then;
                                    ExcelBuffer.AddColumn(IRNoGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn(IRDateGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    LinesPrintedGvar := true;
                                end else begin
                                    Clear(IRNoGvar);
                                    Clear(IRDateGvar);
                                    ExcelBuffer.NewRow();
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn(PurchRcptLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn(format(PurchRcptLineGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                    ExcelBuffer.AddColumn(PurchRcptLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    InspectRcptHdr.Reset();
                                    InspectRcptHdr.SetCurrentKey("Rework Level");
                                    InspectRcptHdr.SetRange("Receipt No.", PurchRcptLineGrec."Document No.");
                                    if InspectRcptHdr.FindLast() then begin
                                        IRNoGvar := InspectRcptHdr."No.";
                                        IRDateGvar := InspectRcptHdr."Posting Date";
                                    end;
                                    ExcelBuffer.AddColumn(IRNoGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn(IRDateGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                end;
                            until PurchRcptLineGrec.Next() = 0;
                        end else begin
                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        end;
                    end else begin
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                    end;
                end else begin
                    //no
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                end;
            end;
        }
    }

    /* requestpage
     {
         layout
         {
             area(Content)
             {
                 group(GroupName)
                 {
                     field(Name; SourceExpression)
                     {
                         ApplicationArea = All;

                     }
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
    local Procedure CreateBook()
    begin
        ExcelBuffer.CreateBookAndOpenExcel('', 'Purchase Indent Analysis', '', '', USERID);
    end;

    trigger OnPreReport()
    begin
        CLEAR(ExcelBuffer);
        ExcelBuffer.DELETEALL;
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Item Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Drawing Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Model', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Make', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Unit of Measure', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Required Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Required Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Inventory Available Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Pending Indent Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('PO Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PO Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('PO Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Receipt No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Receipt Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Receipt Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Last IR No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Last IR Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Delay Days for Conversion from Indent to PO', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Delay Days for Material Receipt', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Delay Days for Material Issue after QC', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
    end;

    trigger OnPostReport()
    begin
        CreateBook();
    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        IndentHedaerGrec: Record "Indent Header";
        IndentLineGrec: Record "Indent Line";
        PurchaseRcptHdrGrec: Record "Purch. Rcpt. Header";
        PurchRcptLineGrec: Record "Purch. Rcpt. Line";
        PurchaseHeaderGrec: Record "Purchase Header";
        PurchaseLineGrec: Record "Purchase Line";
        ItemDrawingNoGvar: Text;
        DocAttachment: Record "Document Attachment";
        LinesPrintedGvar: Boolean;
        InspectRcptHdr: Record "Inspection Receipt Header B2B";
        IRNoGvar: Text;
        //Purcha
        IRDateGvar: Date;


}
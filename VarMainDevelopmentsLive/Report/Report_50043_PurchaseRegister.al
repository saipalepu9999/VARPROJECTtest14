report 50043 "PurchaseRegister"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Purchase Register';
    //DefaultLayout = RDLC;
    //RDLCLayout = 'Report\Layouts\InwardRegister.rdl';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = const(order));
            RequestFilterFields = "No.", "Order Date";
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLinkReference = "Purchase Header";
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                DataItemTableView = where("No." = filter(<> ''));
                trigger OnAfterGetRecord()
                begin

                    if not HeaderPrinted then begin
                        Clear(PurchaseLineGvar);
                        PurchaseLineGvar.Reset();
                        PurchaseLineGvar.SetRange("Document Type", "Purchase Header"."Document Type");
                        PurchaseLineGvar.SetRange("Document No.", "Purchase Header"."No.");
                        if PurchaseLineGvar.FindSet() then begin
                            PurchaseLineGvar.CalcSums("Quantity Received", "Quantity Invoiced", "Line Amount", Quantity);
                            //TotalPoQtyGvar:= PurchaseLineGvar.quan
                        end;
                        ExcelBuffer.NewRow();
                        ExcelBuffer.AddColumn("Purchase Header"."No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(format("Purchase Header"."Order Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn("Purchase Header"."Shortcut Dimension 1 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Purchase Header"."Shortcut Dimension 2 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Purchase Header"."Buy-from Vendor No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Purchase Header"."Buy-from Vendor Name", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Purchase Header".Status, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        //ExcelBuffer.AddColumn(PurchaseLineGvar.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(PurchaseLineGvar."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        //ExcelBuffer.AddColumn(PurchaseLineGvar."Quantity Received", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        //ExcelBuffer.AddColumn(PurchaseLineGvar."Quantity Invoiced", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(TotalInvoiceAmountGvar, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        HeaderPrinted := true;
                    end else begin
                        ExcelBuffer.NewRow();
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        //ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        //ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        //ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    end;
                    PurchaseReceiptLinesPrinted := false;
                    PurchaseReceiptLineGrec.Reset();
                    PurchaseReceiptLineGrec.SetRange("Order No.", "Purchase Line"."Document No.");
                    PurchaseReceiptLineGrec.SetRange("Order Line No.", "Purchase Line"."Line No.");
                    if PurchaseReceiptLineGrec.FindSet() then begin
                        repeat
                            if not PurchaseReceiptLinesPrinted then begin
                                ExcelBuffer.AddColumn("Purchase Line"."Line No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn("Purchase Line"."No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("Purchase Line".Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("Purchase Line"."Unit of Measure Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("Purchase Line"."Quantity (Base)", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn("Purchase Line"."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(format(PurchaseReceiptLineGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                ExcelBuffer.AddColumn(PurchaseReceiptLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Accepted B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Rework B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Rejected B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                Clear(PurchaseReceiptHdrGrec);
                                if PurchaseReceiptHdrGrec.Get(PurchaseReceiptLineGrec."Document No.") then;
                                ExcelBuffer.AddColumn(PurchaseReceiptHdrGrec."Dc No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(format(PurchaseReceiptHdrGrec."Dc Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                PurchaseReceiptLinesPrinted := true;
                                PurchInvLinesPrinted := false;
                                PurchInvLineGrec.Reset();
                                PurchInvLineGrec.SetRange("Receipt No.", PurchaseReceiptLineGrec."Document No.");
                                PurchInvLineGrec.SetRange("Receipt Line No.", PurchaseReceiptLineGrec."Line No.");
                                if PurchInvLineGrec.FindSet() then begin
                                    repeat
                                        if not PurchInvLinesPrinted then begin
                                            ExcelBuffer.AddColumn(PurchInvLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchInvLineGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            clear(PurchInvHdrGrec);
                                            if PurchInvHdrGrec.Get(PurchInvLineGrec."Document No.") then;
                                            ExcelBuffer.AddColumn(PurchInvHdrGrec."Vendor Invoice No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchInvHdrGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            GetGSTAmount(PurchInvHdrGrec, PurchInvLineGrec);
                                            ExcelBuffer.AddColumn(SGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            PurchInvLinesPrinted := true;
                                        end else begin
                                            ExcelBuffer.NewRow();
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            //ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            //ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            //ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchaseReceiptLineGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            ExcelBuffer.AddColumn(PurchaseReceiptLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Accepted B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Rework B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Rejected B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            Clear(PurchaseReceiptHdrGrec);
                                            if PurchaseReceiptHdrGrec.Get(PurchaseReceiptLineGrec."Document No.") then;
                                            ExcelBuffer.AddColumn(PurchaseReceiptHdrGrec."Dc No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchaseReceiptHdrGrec."Dc Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchInvLineGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            clear(PurchInvHdrGrec);
                                            if PurchInvHdrGrec.Get(PurchInvLineGrec."Document No.") then;
                                            ExcelBuffer.AddColumn(PurchInvHdrGrec."Vendor Invoice No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchInvHdrGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            GetGSTAmount(PurchInvHdrGrec, PurchInvLineGrec);
                                            ExcelBuffer.AddColumn(SGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        end;
                                    until PurchInvLineGrec.Next() = 0;
                                end else begin
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                end;
                            end else begin
                                ExcelBuffer.NewRow();
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                //ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                // ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                // ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(format(PurchaseReceiptLineGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                ExcelBuffer.AddColumn(PurchaseReceiptLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Accepted B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Rework B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Rejected B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                Clear(PurchaseReceiptHdrGrec);
                                if PurchaseReceiptHdrGrec.Get(PurchaseReceiptLineGrec."Document No.") then;
                                ExcelBuffer.AddColumn(PurchaseReceiptHdrGrec."Dc No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(format(PurchaseReceiptHdrGrec."Dc Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                PurchInvLinesPrintedAfreceipts := false;
                                PurchInvLineGrec.Reset();
                                PurchInvLineGrec.SetRange("Receipt No.", PurchaseReceiptLineGrec."Document No.");
                                PurchInvLineGrec.SetRange("Receipt Line No.", PurchaseReceiptLineGrec."Line No.");
                                if PurchInvLineGrec.FindSet() then begin
                                    repeat
                                        if not PurchInvLinesPrintedAfreceipts then begin
                                            ExcelBuffer.AddColumn(PurchInvLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec."Posting Date", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            clear(PurchInvHdrGrec);
                                            if PurchInvHdrGrec.Get(PurchInvLineGrec."Document No.") then;
                                            ExcelBuffer.AddColumn(PurchInvHdrGrec."Vendor Invoice No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchInvHdrGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            GetGSTAmount(PurchInvHdrGrec, PurchInvLineGrec);
                                            ExcelBuffer.AddColumn(SGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            PurchInvLinesPrintedAfreceipts := true;
                                        end else begin
                                            ExcelBuffer.NewRow();
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            //ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            //ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            //ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchaseReceiptLineGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            ExcelBuffer.AddColumn(PurchaseReceiptLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Accepted B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Rework B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchaseReceiptLineGrec."Quantity Rejected B2B", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            Clear(PurchaseReceiptHdrGrec);
                                            if PurchaseReceiptHdrGrec.Get(PurchaseReceiptLineGrec."Document No.") then;
                                            ExcelBuffer.AddColumn(PurchaseReceiptHdrGrec."Dc No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchaseReceiptHdrGrec."Dc Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec."Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchInvLineGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            clear(PurchInvHdrGrec);
                                            if PurchInvHdrGrec.Get(PurchInvLineGrec."Document No.") then;
                                            ExcelBuffer.AddColumn(PurchInvHdrGrec."Vendor Invoice No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                            ExcelBuffer.AddColumn(format(PurchInvHdrGrec."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(PurchInvLineGrec."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            GetGSTAmount(PurchInvHdrGrec, PurchInvLineGrec);
                                            ExcelBuffer.AddColumn(SGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                            ExcelBuffer.AddColumn(IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        end;
                                    until PurchInvLineGrec.Next() = 0;
                                end else begin
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                    //clear(PurchInvHdrGrec);
                                    //if PurchInvHdrGrec.Get(PurchInvLineGrec."Document No.") then;
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                end;
                            end;
                        until PurchaseReceiptLineGrec.Next() = 0;
                    end else begin
                        //ExcelBuffer.NewRow();
                        ExcelBuffer.AddColumn("Purchase Line"."Line No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn("Purchase Line"."No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Purchase Line".Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Purchase Line"."Unit of Measure Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Purchase Line"."Quantity (Base)", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn("Purchase Line"."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                HeaderPrinted := false;
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


    trigger OnPreReport()
    begin
        CLEAR(ExcelBuffer);
        ExcelBuffer.DELETEALL;
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('PO Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PO Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Division Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Project Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vendor Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vendor Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PO Status', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        //ExcelBuffer.AddColumn('Total PO Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Total PO Amount (Basic Value)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        //ExcelBuffer.AddColumn('Total MRV Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        //ExcelBuffer.AddColumn('Total Invoice Quantity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Total Invoice Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Item Line No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Item No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('UOM', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('PO Line Quantity  (Base)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('PO Line Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('MRV No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('MRV Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('MRV Quantity (Base)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('QC Accepted Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('QC Rework Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('QC Rejected Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Vendor DC Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vendor DC Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Invoice No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoice Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Vendor Invoice No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vendor Invoice Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Invoice Quantity (Base)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Invoice Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Invoice SGST', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Invoice CGST', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Invoice IGST', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
    end;

    trigger OnPostReport()
    begin
        CreateBook();
    end;

    local Procedure CreateBook()
    begin
        ExcelBuffer.CreateBookAndOpenExcel('', 'Purchase Register', '', '', USERID);
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

    local procedure GetGSTAmount(PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(IGSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(CessAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", PurchInvLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (PurchInvHeader."Currency Code" <> '') then
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (PurchInvHeader."Currency Code" <> '') then
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");

                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (PurchInvHeader."Currency Code" <> '') then
                    IGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then
                        IGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (PurchInvHeader."Currency Code" <> '') then
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then
                        CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
            until DetailedGSTLedgerEntry.Next() = 0;
    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        HeaderPrinted: Boolean;
        PurchaseLineGvar: Record "Purchase Line";
        TotalInvoiceAmountGvar: Decimal;
        PurchaseReceiptLineGrec: Record "Purch. Rcpt. Line";
        PurchaseReceiptHdrGrec: Record "Purch. Rcpt. Header";
        PurchaseReceiptLinesPrinted: Boolean;
        PurchInvHdrGrec: Record "Purch. Inv. Header";
        PurchInvLineGrec: Record "Purch. Inv. Line";
        PurchInvLinesPrinted: Boolean;
        PurchInvLinesPrintedAfreceipts: Boolean;
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

}
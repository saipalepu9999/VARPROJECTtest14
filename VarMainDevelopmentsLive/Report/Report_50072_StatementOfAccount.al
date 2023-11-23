report 50072 StatementOfAccount
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Vendor Statement';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            RequestFilterFields = "Vendor No.", "Posting Date";
            DataItemTableView = sorting("Vendor No.", "Posting Date", "Currency Code") order(ascending);
            CalcFields = Amount;
            trigger OnAfterGetRecord()
            begin
                if "Document Type" = "Document Type"::Invoice then begin
                    if Prepayment then begin
                        PurchInvLine.Reset();
                        PurchInvLine.SetRange("Document No.", "Document No.");
                        PurchInvLine.SetFilter("No.", '<>%1', '');
                        if PurchInvLine.FindSet() then
                            repeat
                                Clear(PurchInvHdr);
                                if PurchInvHdr.Get("Document No.") then;
                                ExcelBuffer.NewRow();
                                ExcelBuffer.AddColumn(Format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                ExcelBuffer.AddColumn("Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("Document Type", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("Global Dimension 1 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("Global Dimension 2 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("External Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(format("Due Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                ExcelBuffer.AddColumn(PurchInvLine.Type, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchInvLine."No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchInvLine.Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchInvLine.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchInvLine."Direct Unit Cost", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchInvLine."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                Clear(IGSTAmt);
                                Clear(CGSTAmt);
                                Clear(SGSTAmt);
                                Clear(CessAmt);
                                Clear(CGSTPer);
                                Clear(SGSTPer);
                                Clear(IGSTPer);
                                GetGSTAmount(PurchInvHdr, PurchInvLine);
                                ExcelBuffer.AddColumn(IGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(CGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(SGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(SGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchInvLine."Line Amount" + IGSTAmt + SGSTAmt + CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchInvLine."Line Amount" + IGSTAmt + SGSTAmt + CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                            until PurchInvLine.Next() = 0;
                        //end;
                    end else begin
                        PurchInvLine.Reset();
                        PurchInvLine.SetRange("Document No.", "Document No.");
                        PurchInvLine.SetFilter("No.", '<>%1', '');
                        if PurchInvLine.FindSet() then
                            repeat
                                Clear(PurchInvHdr);
                                if PurchInvHdr.Get("Document No.") then;
                                ExcelBuffer.NewRow();
                                ExcelBuffer.AddColumn(Format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                ExcelBuffer.AddColumn("Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("Document Type", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("Global Dimension 1 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("Global Dimension 2 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn("External Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(format("Due Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                ExcelBuffer.AddColumn(PurchInvLine.Type, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchInvLine."No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchInvLine.Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                ExcelBuffer.AddColumn(PurchInvLine.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchInvLine."Direct Unit Cost", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchInvLine."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                Clear(IGSTAmt);
                                Clear(CGSTAmt);
                                Clear(SGSTAmt);
                                Clear(CessAmt);
                                Clear(CGSTPer);
                                Clear(SGSTPer);
                                Clear(IGSTPer);
                                GetGSTAmount(PurchInvHdr, PurchInvLine);
                                ExcelBuffer.AddColumn(IGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(CGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(SGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(SGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchInvLine."Line Amount" + IGSTAmt + SGSTAmt + CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                ExcelBuffer.AddColumn(PurchInvLine."Line Amount" + IGSTAmt + SGSTAmt + CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                            until PurchInvLine.Next() = 0;
                    end;
                end else
                    if ("Document Type" = "Document Type"::Payment) or ("Document Type" = "Document Type"::" ") then begin
                        ExcelBuffer.NewRow();
                        ExcelBuffer.AddColumn(format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn("Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn(format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Document Type", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Global Dimension 1 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Global Dimension 2 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("External Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn("Due Date", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        Clear(IGSTAmt);
                        Clear(CGSTAmt);
                        Clear(SGSTAmt);
                        Clear(CessAmt);
                        Clear(CGSTPer);
                        Clear(SGSTPer);
                        Clear(IGSTPer);
                        //GetGSTAmountCrmemo(PurchCrMemoHdr, PurchCreditMemoLine);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(Amount, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn(Amount, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                    end else
                        if "Document Type" = "Document Type"::"Credit Memo" then begin
                            if Prepayment then begin
                                PurchCreditMemoLine.Reset();
                                PurchCreditMemoLine.SetRange("Document No.", "Document No.");
                                PurchCreditMemoLine.SetFilter("No.", '<>%1', '');
                                if PurchCreditMemoLine.FindSet() then
                                    repeat
                                        Clear(PurchCrMemoHdr);
                                        if PurchCrMemoHdr.Get("Document No.") then;
                                        ExcelBuffer.NewRow();
                                        ExcelBuffer.AddColumn(format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                        ExcelBuffer.AddColumn("Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn(format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn("Document Type", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn("Global Dimension 1 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn("Global Dimension 2 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn("External Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn(format("Due Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine.Type, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine."No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine.Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine."Direct Unit Cost", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        Clear(IGSTAmt);
                                        Clear(CGSTAmt);
                                        Clear(SGSTAmt);
                                        Clear(CessAmt);
                                        Clear(CGSTPer);
                                        Clear(SGSTPer);
                                        Clear(IGSTPer);
                                        Clear(IGSTAmt);
                                        Clear(CGSTAmt);
                                        Clear(SGSTAmt);
                                        Clear(CessAmt);
                                        Clear(CGSTPer);
                                        Clear(SGSTPer);
                                        Clear(IGSTPer);
                                        GetGSTAmountCrmemo(PurchCrMemoHdr, PurchCreditMemoLine);
                                        ExcelBuffer.AddColumn(IGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(CGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(SGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(SGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    until PurchCreditMemoLine.Next() = 0;
                            end else begin
                                PurchCreditMemoLine.Reset();
                                PurchCreditMemoLine.SetRange("Document No.", "Document No.");
                                PurchCreditMemoLine.SetFilter("No.", '<>%1', '');
                                if PurchCreditMemoLine.FindSet() then
                                    repeat
                                        Clear(PurchCrMemoHdr);
                                        if PurchCrMemoHdr.Get("Document No.") then;
                                        ExcelBuffer.NewRow();
                                        ExcelBuffer.AddColumn(format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                        ExcelBuffer.AddColumn("Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn(format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn("Document Type", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn("Global Dimension 1 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn("Global Dimension 2 Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn("External Document No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn("Due Date", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine.Type, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine."No.", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine.Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine.Quantity, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine."Direct Unit Cost", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine."Line Amount", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        Clear(IGSTAmt);
                                        Clear(CGSTAmt);
                                        Clear(SGSTAmt);
                                        Clear(CessAmt);
                                        Clear(CGSTPer);
                                        Clear(SGSTPer);
                                        Clear(IGSTPer);
                                        GetGSTAmountCrmemo(PurchCrMemoHdr, PurchCreditMemoLine);
                                        ExcelBuffer.AddColumn(IGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(CGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(CGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(SGSTPer, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(SGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn(PurchCreditMemoLine."Line Amount" + CGSTAmt + SGSTAmt + IGSTAmt, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                                    until PurchCreditMemoLine.Next() = 0;
                            end;
                        end;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
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
    }

    trigger OnPostReport()
    begin
        CreateBook();
    end;

    local Procedure CreateBook()
    begin
        ExcelBuffer.CreateBookAndOpenExcel('', 'Statement Of Account', '', '', USERID);
    end;

    trigger OnPreReport()
    begin
        CLEAR(ExcelBuffer);
        ExcelBuffer.DELETEALL;
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Posting Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Document No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Document Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Document Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Source Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Division Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Project Code', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('External Doc. No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Due Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
        ExcelBuffer.AddColumn('Type', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item No', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qauntity', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Rate', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Invoice Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('IGST%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('IGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('CGST%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('CGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('SGST%', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('SGST Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Debit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Credit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Debit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn('Credit Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
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
        Clear(CGSTPer);
        Clear(SGSTPer);
        Clear(IGSTPer);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", PurchInvLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (PurchInvHeader."Currency Code" <> '') then begin
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    CGSTPer += DetailedGSTLedgerEntry."GST %";

                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then begin
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        CGSTPer += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (PurchInvHeader."Currency Code" <> '') then begin
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    SGSTPer += DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then begin
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        SGSTPer += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (PurchInvHeader."Currency Code" <> '') then begin
                    IGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    IGSTPer += DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then begin
                        IGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        IGSTPer += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (PurchInvHeader."Currency Code" <> '') then
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then
                        CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
            until DetailedGSTLedgerEntry.Next() = 0;
    end;

    local procedure GetGSTAmountCrmemo(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(IGSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        Clear(CessAmt);
        Clear(CGSTPer);
        Clear(SGSTPer);
        Clear(IGSTPer);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", PurchCrMemoLine."Document No.");
        if DetailedGSTLedgerEntry.FindSet() then
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) And (PurchCrMemoHdr."Currency Code" <> '') then begin
                    CGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchCrMemoHdr."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    CGSTPer += DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then begin
                        CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        CGSTPer += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) And (PurchCrMemoHdr."Currency Code" <> '') then begin
                    SGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchCrMemoHdr."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    SGSTPer += DetailedGSTLedgerEntry."GST %";
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then begin
                        SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        SGSTPer += DetailedGSTLedgerEntry."GST %";
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) And (PurchCrMemoHdr."Currency Code" <> '') then begin
                    IGSTAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchCrMemoHdr."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"));
                    IGSTPer += DetailedGSTLedgerEntry."GST %"
                end else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then begin
                        IGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                        IGSTPer += DetailedGSTLedgerEntry."GST %"
                    end;
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (PurchCrMemoHdr."Currency Code" <> '') then
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchCrMemoHdr."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then
                        CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
            until DetailedGSTLedgerEntry.Next() = 0;
    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        PurchInvHdr: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCreditMemoLine: Record "Purch. Cr. Memo Line";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        CGSTLbl: Label 'CGST';
        SGSTLbl: Label 'SGST';
        IGSTLbl: Label 'IGST';
        CessLbl: Label 'CESS';
        IGSTPer: Decimal;
        CGSTPer: Decimal;
        SGSTPer: Decimal;
}
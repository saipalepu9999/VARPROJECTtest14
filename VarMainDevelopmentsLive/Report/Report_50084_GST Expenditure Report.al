report 50101 "GST Expenditure Report"
{
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Income/Balance" = CONST("Income Statement"),
                                      "Account Type" = CONST(Posting));
            RequestFilterFields = "No.", "Date Filter";

            trigger OnAfterGetRecord();
            var
                DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
            begin
                CLEAR(NotaSupply);
                CLEAR(Exempted);
                CLEAR(Registered);
                CLEAR(Unregistered);
                CLEAR(Composition);
                CLEAR(Import);
                CLEAR(TransactionAmount);
                CLEAR(SEZ);
                Window.UPDATE(1, "G/L Account"."No.");
                GLEntry.RESET;
                GLEntry.SETRANGE("G/L Account No.", "G/L Account"."No.");
                IF "G/L Account".GETFILTER("Date Filter") <> '' THEN
                    GLEntry.SETFILTER("Posting Date", "G/L Account".GETFILTER("Date Filter"));
                IF GLEntry.FINDSET THEN
                    REPEAT
                        TransactionAmount += GLEntry.Amount;
                        DetailedGSTLedgerEntry.RESET;
                        DetailedGSTLedgerEntry.SETRANGE("Document No.", GLEntry."Document No.");
                        DetailedGSTLedgerEntry.SETRANGE("Posting Date", GLEntry."Posting Date");
                        DetailedGSTLedgerEntry.SETRANGE("Transaction No.", GLEntry."Transaction No.");
                        IF DetailedGSTLedgerEntry.FINDFIRST THEN
                            CASE DetailedGSTLedgerEntry."GST Vendor Type" OF
                                DetailedGSTLedgerEntry."GST Vendor Type"::Registered:
                                    BEGIN
                                        Registered += GLEntry.Amount;
                                    END;
                                DetailedGSTLedgerEntry."GST Vendor Type"::Unregistered:
                                    BEGIN
                                        Unregistered += GLEntry.Amount;
                                    END;
                                DetailedGSTLedgerEntry."GST Vendor Type"::Composite:
                                    BEGIN
                                        Composition += GLEntry.Amount;
                                    END;
                                DetailedGSTLedgerEntry."GST Vendor Type"::SEZ:
                                    BEGIN
                                        SEZ += GLEntry.Amount;
                                    END;
                                DetailedGSTLedgerEntry."GST Vendor Type"::Import:
                                    BEGIN
                                        Import += GLEntry.Amount;
                                    END;
                                DetailedGSTLedgerEntry."GST Vendor Type"::Exempted:
                                    BEGIN
                                        ExemptedDec += GLEntry.Amount;
                                    END;
                                DetailedGSTLedgerEntry."GST Vendor Type"::" ":
                                    BEGIN
                                        NotaSupply += GLEntry.Amount;
                                    END;
                            END
                        ELSE
                            NotaSupply += GLEntry.Amount;
                    UNTIL GLEntry.NEXT = 0;
                ExcelBuffer.NewRow;
                ExcelBuffer.AddColumn("G/L Account"."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("G/L Account".Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(TransactionAmount, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(NotaSupply, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(ExemptedDec, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Composition, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Registered, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Unregistered, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(Import, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(SEZ, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
                TransactionAmount_Total += TransactionAmount;
                NotaSupply_Total += NotaSupply;
                Registered_Total += Registered;
                Unregistered_Total += Unregistered;
                Exempted_Total += ExemptedDec;
                Composition_Total += Composition;
                Import_Total += Import;
                SEZ_Total += SEZ;
            end;

            trigger OnPostDataItem();
            begin
                //ExcelBuffer.OnlyCreateBook('Details', 'Expenditure', COMPANYNAME, USERID, FALSE);
                CreateExcelSheet('Expenditure Details', true);
            end;

            trigger OnPreDataItem();
            begin
                Window.OPEN('G/L Account No.' + '#1#################################\\');
                ExcelBuffer.DELETEALL;
                ExcelBuffer.AddColumn('G/L Code', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('G/L Name', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Transaction Amount', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Not a Supply', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Exempted', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('composition', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Registered', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Unregistered', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('Import', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('SEZ', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        ExcelBuffer.DELETEALL;
        ExcelBuffer.AddColumn('SN', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total amount of Expenditure incurred during the year', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Relating to goods or services exempt from GST', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Relating to entities falling under composition scheme', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Relating to other registered entities', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total payment to registered entities', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Expenditure relating to entities not registered under GST', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
       // ExcelBuffer.AddColumn('Relating to entities falling under SEZ scheme', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Relating to entities falling under Import scheme', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('1', FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TransactionAmount_Total, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Exempted_Total, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Composition_Total, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(NotaSupply_Total, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Registered_Total, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Unregistered_Total, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
       // ExcelBuffer.AddColumn(SEZ_Total, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        ExcelBuffer.AddColumn(Import_Total, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuffer."Cell Type"::Number);
        // ExcelBuffer.OnlyCreateBook('Expenditure', 'Expenditure', COMPANYNAME, USERID, TRUE);
        // ExcelBuffer.OnlyOpenExcel();
        //ExcelBuffer.CreateBookAndOpenExcel('', 'Expenditure Details For Gst', '', '', USERID);
        CreateExcelSheet('Total Expenditure Details', false);
        CreateExcelBook();
        Window.CLOSE;
    end;

    var
        GLEntry: Record 17;
        NotaSupply: Decimal;
        ExemptedDec: Decimal;
        Composition: Decimal;
        Registered: Decimal;
        Unregistered: Decimal;
        Import: Decimal;
        SEZ: Decimal;
        NotaSupply_Total: Decimal;
        Exempted_Total: Decimal;
        Composition_Total: Decimal;
        Registered_Total: Decimal;
        Unregistered_Total: Decimal;
        Import_Total: Decimal;
        SEZ_Total: Decimal;
        ExcelBuffer: Record 370 temporary;
        TransactionAmount: Decimal;
        TransactionAmount_Total: Decimal;
        Window: Dialog;

    local procedure CreateExcelBook()
    begin
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('Gst Expenditure Details');
        ExcelBuffer.OpenExcel();
    end;

    local procedure CreateExcelSheet(SheetName: Text[250]; NewBook: Boolean)
    begin
        if NewBook then
            ExcelBuffer.CreateNewBook(SheetName)
        else
            ExcelBuffer.SelectOrAddSheet(SheetName);
        ExcelBuffer.WriteSheet(SheetName, CompanyName, UserId);
        ExcelBuffer.DeleteAll();
        ExcelBuffer.ClearNewRow();

    end;

}


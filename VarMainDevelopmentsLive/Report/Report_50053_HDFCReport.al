report 50053 "HDFC Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\HDFCReport.rdl';


    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            column(Description_GenJournalLine; Description)
            { }
            column(Amount_GenJournalLine; Amount)
            { }
            column(Cheque_Date; format("Cheque Date", 0, '<Day,2><Month,2><Year4>'))
            { }
            column(ACpayee; ACpayee)
            { }
            column(NoText_1; NumberText[1])
            { }
            column(Datetext_1; Datetext[1])
            { }
            column(Datetext_2; Datetext[2])
            { }
            column(Datetext_3; Datetext[3])
            { }
            column(Datetext_4; Datetext[4])
            { }
            column(Datetext_5; Datetext[5])
            { }
            column(Datetext_6; Datetext[6])
            { }
            column(Datetext_7; Datetext[7])
            { }
            column(Datetext_8; Datetext[8])
            { }
            column(DescriptionTextGvar; DescriptionTextGvar)
            { }
            column(TotalAmountGvar; TotalAmountGvar)
            { }
            column(TotalLineAmountGvar; TotalLineAmountGvar)
            { }
            column(AcpayeeEnable; AcpayeeEnable)
            { }
            column(TotalAmountNewGvar; TotalAmountNewGvar)
            { }
            trigger OnAfterGetRecord()
            var
                GenTemp: Record "Gen. Journal Template";
                GSTLedger: Record "GST Ledger Entry";
            begin
                //Clear(TotalAmountGvar);
                //Clear(LineAmount);
                //Clear(BankChargesGvar);
                Clear(TDSAmt);
                //Clear(Datetext);
                for I := 1 to 8 do begin
                    Datetext[I] := Copystr(Format("Cheque Date", 0, '<Day,2><Month,2><Year4>'), I, 1);
                end;
                // Clear(DescriptionTextGvar);
                if "Account Type" = "Account Type"::Vendor then
                    DescriptionTextGvar := Description;
                //if ("Account Type" = "Account Type"::"G/L Account") then begin
                GLsetup.Get();
                DimensionSetEntry.Reset();
                DimensionSetEntry.SetRange("Dimension Set ID", "Dimension Set ID");
                DimensionSetEntry.SetRange("Dimension Code", GLsetup."Shortcut Dimension 3 Code");
                if DimensionSetEntry.FindFirst() then
                    if EmployeeGrec.Get(DimensionSetEntry."Dimension Value Code") then
                        DescriptionTextGvar := EmployeeGrec."Last Name" + ' ' + EmployeeGrec."First Name" + EmployeeGrec."Middle Name";
                //end;
                if "Bal. Account No." <> '' then
                    NewAmountGvar += Amount
                else
                    NewAmountGvar += "Credit Amount";
                GetTDSAmount("Gen. Journal Line");
                TotalTdsAmt += TDSAmt;
                Clear(NumberText);
                JournalBankCharges.Reset();
                JournalBankCharges.SetRange("Journal Template Name", "Journal Template Name");
                JournalBankCharges.SetRange("Journal Batch Name", "Journal Batch Name");
                JournalBankCharges.SetRange("Line No.", "Line No.");
                if JournalBankCharges.FindFirst() then
                    BankChargesGvar += JournalBankCharges.Amount;
                Clear(TotalAmountNewGvar);
                TotalAmountNewGvar := NewAmountGvar + BankChargesGvar - TotalTdsAmt;
                CheckGRec.InitTextVariable;
                CheckGRec.FormatNoText(NumberText, Round(TotalAmountNewGvar, 1, '='), "Currency Code");
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(AcpayeeEnable; AcpayeeEnable)
                    {
                        ApplicationArea = all;
                        Caption = 'Enable A/c Payee';
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
    }
    local procedure GetTDSAmount(GenJnlLine: Record "Gen. Journal Line")
    var
        TDSSetup: Record "TDS Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSEntry: Record "TDS Entry";

    begin
        //Clear(AppliesDocNo);
        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", GenJnlLine.RecordId);
        TaxTransactionValue.SetRange("Tax Type", 'TDS');
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then begin
            TaxTransactionValue.CalcSums(Amount);
            TDSAmt := TaxTransactionValue.Amount;
        end;
    end;

    var
        ACpayee: Label 'A/c Payee';
        ReportCheck: Codeunit "Check Codeunit";
        NoText: array[2] of text;
        Datetext: array[10] of Text;
        I: Integer;
        DescriptionTextGvar: Text;
        GLsetup: Record "General Ledger Setup";
        DimensionValues: Record "Dimension Value";
        DimensionSetEntry: Record "Dimension Set Entry";
        EmployeeGrec: Record Employee;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvLine: Record "Purch. Inv. Line";
        LineAmount: Decimal;
        GenProdPosGrp: record "Gen. Product Posting Group";
        GSTLedger: Record "GST Ledger Entry";
        AdvanceAmount: Decimal;
        BalAmt: Decimal;
        TDSAmt: Decimal;
        AppliesDocNo: Text;
        JournalBankCharges: Record "Journal Bank Charges";
        BankChargesGvar: Decimal;
        TotalAmountGvar: Decimal;
        HdrText: Text;
        TotalAmt: Decimal;
        CheckGRec: Codeunit "Check Codeunit";
        NumberText: array[2] of Text;
        GenJournalNarration: Record "Gen. Journal Narration";
        VendorGRec: Record Vendor;
        TdsEntry: Record "TDS Entry";
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        //BalAmt: Decimal;
        BankAccGRec: Record "Bank Account";
        //GenProdPosGrp: record "Gen. Product Posting Group";
        //LineAmount: Decimal;
        //TDSAmt: Decimal;
        CreditAmt: Decimal;
        //AdvanceAmount: Decimal;
        Desc: Text[100];
        //VendorLedgerEntry: Record "Vendor Ledger Entry";
        //PurchInvLine: Record "Purch. Inv. Line";
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        PurchInvLine2: Record "Purch. Inv. Line";
        PurchInvHdr2: Record "Purch. Inv. Header";
        CompanyInfo: Record "Company Information";
        LocationGRec: Record Location;//B2BSSD09Jan2023
        genjnl: Record "Gen. Journal Line";
        Rep: Report 18031;
        pag: Page "Journal Voucher";
        glentryies: Page "General Ledger Entries";
        repo: Report 18041;
        //JournalBankCharges: Record "Journal Bank Charges";
        // BankChargesGvar: Decimal;
        //DescriptionTextGvar: Text;
        //GLsetup: Record "General Ledger Setup";
        //DimensionValues: Record "Dimension Value";
        //DimensionSetEntry: Record "Dimension Set Entry";
        //AppliesDocNo: Text;
        VendorLedgerEntryGrec: Record "Vendor Ledger Entry";
        //EmployeeGrec: Record Employee;
        GenJnlGrec: Record "Gen. Journal Line";
        CreditAccountNameGar: Text;
        TotalLineAmountGvar: Decimal;
        SumBankCharges: Decimal;
        SumTdsAmt: Decimal;
        GstLedgSum: Decimal;
        PrevPurchInvNo: Text;
        TotalTdsAmt: Decimal;
        TdsAmtNew: Decimal;
        AcpayeeEnable: Boolean;
        NewAmountGvar: Decimal;
        TotalAmountNewGvar: Decimal;


}
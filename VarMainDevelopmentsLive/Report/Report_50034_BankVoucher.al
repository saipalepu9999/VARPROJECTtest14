report 50034 "BankVoucher"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\BankVoucherNew.rdl';
    Caption = 'Journal Vouchers New';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            column(HdrText; HdrText)
            { }
            column(NumberText1; NumberText[1])
            { }
            column(DebitAmount_GenJournalLine; "Debit Amount")
            {
            }
            column(DebitAmountGvar; DebitAmountGvar)
            {

            }
            column(CreditAmount_GenJournalLine; "Credit Amount")
            {
            }
            column(Cheque_No_; "Cheque No.")
            { }
            column(Cheque_Date; format("Cheque Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }

            column(Document_No_; "Document No.")
            { }
            column(BankVoucherLbl; BankVoucherLbl)
            { }
            column(CompanyInfoName; CompanyInfo.Name)
            { }
            column(CompanyInfoAdd; CompanyInfo.Address)
            { }
            column(Location_address; LocationGRec.Address)//B2BSSD09Jan2023
            { }
            column(CompanyInfoPict; CompanyInfo.Picture)
            { }
            column(DateCapLbl; DateCapLbl)
            { }
            column(VrNoCapLbl; VrNoCapLbl)
            { }
            column(DebitVchrCapLbl; DebitVchrCapLbl)
            {

            }
            column(AccountLbl; AccountLbl)
            { }
            column(AmountCapLbl; AmountCapLbl)
            { }
            column(PAIDToCapLbl; PAIDToCapLbl)
            { }
            column(ByChequeNoCapLbl; ByChequeNoCapLbl)
            { }
            column(DtCapLbl; DtCapLbl)
            { }
            column(TowardsCapLbl; TowardsCapLbl)
            { }
            column(RupeesCapLbl; RupeesCapLbl)
            { }
            column(PreparedCapLbl; PreparedCapLbl)
            { }
            column(CheckedCapLbl; CheckedCapLbl)
            { }
            column(PassedCapLbl; PassedCapLbl)
            { }
            column(SanctionedCapLbl; SanctionedCapLbl)
            { }
            column(CreditcodeCapLbl; CreditcodeCapLbl)
            {

            }
            column(CGSTCapLbl; CGSTCapLbl)
            { }
            column(SGSTCapLbl; SGSTCapLbl)
            { }
            column(RoundoffCapLbl; RoundoffCapLbl)
            { }
            column(TdsCapLbl; TdsCapLbl)
            { }

            column(PaymentRcvdCapLbl; PaymentRcvdCapLbl)
            { }
            column(BankAccGRecName; BankAccGRec.Name)
            { }
            column(Amount; Amount)
            { }
            column(CreditAccountNameGar; CreditAccountNameGar)
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(LineAmount; LineAmount)
            { }
            column(AdvanceAmount; AdvanceAmount)
            { }
            column(AppliestoID_GenJournalLine; "Applies-to ID")
            {
            }
            column(Desc; Desc)
            { }
            column(CGSTAmt; CGSTAmt)
            { }
            column(SGSTAmt; SGSTAmt)
            { }
            column(IGSSTAmt; IGSSTAmt)
            { }
            column(TdsEntryAmount; TDSAmt)
            { }
            column(BalAmt; BalAmt)
            { }
            column(VendorGRecName; VendorGRec.Name)
            { }
            column(GenJournalNarration; GenJnlNarrationGvar)
            { }
            column(TotalAmt; TotalAmt)
            { }
            column(Description; Description)
            { }
            column(Account_No_; "Account No.")
            { }
            column(CreditAmt; CreditAmt) { }
            column(BankChargesGvar; BankChargesGvar)
            {

            }
            column(DescriptionTextGvar; DescriptionTextGvar)
            { }
            column(AppliesDocNo; AppliesDocNo)
            { }
            column(TotalLineAmountGvar; TotalLineAmountGvar)
            { }
            column(SumBankCharges; SumBankCharges)
            { }
            column(SumTdsAmt; SumTdsAmt)
            { }

            column(TotalTdsAmt; TotalTdsAmt)
            { }

            trigger OnAfterGetRecord()
            var
                GenTemp: Record "Gen. Journal Template";
                GSTLedger: Record "GST Ledger Entry";
            begin
                Clear(TDSAmt);
                Clear(TotalAmt);
                Clear(VendorGRec);
                Clear(TdsEntry);
                Clear(BankAccGRec);
                Clear(IGSSTAmt);
                Clear(CGSTAmt);
                Clear(SGSTAmt);
                Clear(CessAmt);
                Clear(GenJournalNarration);
                Clear(PrevPurchInvNo);
                Clear(LineAmount);
                Clear(GenJnlNarrationGvar);
                Clear(TdsAmtNew);
                Clear(DebitAmountGvar);
                if ("Applies-to ID" = '') then begin
                    DebitAmountGvar := 0;
                    if ("Account Type" = "Account Type"::"G/L Account") then
                        DebitAmountGvar := "Debit Amount";
                end else
                    DebitAmountGvar := "Debit Amount";
                //Clear(TotalLineAmountGvar);
                GenTemp.Get("Gen. Journal Line"."Journal Template Name");
                HdrText := Format(GenTemp.Type);

                if VendorGRec.get("Account No.") then;
                if "Applies-to ID" <> '' then begin
                    VendorLedgerEntry.Reset();
                    VendorLedgerEntry.SetRange("Applies-to ID", "Applies-to ID");
                    if VendorLedgerEntry.FindSet() then begin
                        repeat
                            PurchInvLine.Reset();
                            PurchInvLine.SetFilter(Quantity, '>%1', 0);
                            PurchInvLine.SetRange("Document No.", VendorLedgerEntry."Document No.");
                            PurchInvLine.SetFilter("No.", '<>%1', '');
                            if PurchInvLine.FindSet() then begin
                                repeat
                                    // PurchInvLine.CalcSums("Line Amount");
                                    LineAmount += PurchInvLine."Line Amount";
                                    if GenProdPosGrp.Get(PurchInvLine."Gen. Prod. Posting Group") then
                                        Desc := GenProdPosGrp.Description;
                                    If PrevPurchInvNo <> PurchInvLine."Document No." then begin
                                        PrevPurchInvNo := PurchInvLine."Document No.";
                                        Clear(GstLedgSum);
                                        GSTLedger.Reset();
                                        GSTLedger.SetRange("Document No.", PurchInvLine."Document No.");
                                        if GSTLedger.FindSet() then
                                            repeat
                                                GstLedgSum += GSTLedger."GST Amount"
                                            until GSTLedger.Next() = 0;
                                    end;
                                //GSTLedger.CalcSums("GST Amount");

                                until PurchInvLine.Next() = 0;
                                LineAmount := LineAmount + GstLedgSum;
                            end else begin
                                LineAmount := "Gen. Journal Line".Amount;
                            end;
                        until VendorLedgerEntry.Next() = 0;


                    end;
                    GetTDSAmount("Gen. Journal Line");
                    GetAdvanceAmount("Gen. Journal Line");
                    BalAmt := LineAmount - (AdvanceAmount + "Gen. Journal Line".Amount + Abs(TdsAmtNew));
                end else begin
                    GetTDSAmount("Gen. Journal Line");
                    GetAdvanceAmount("Gen. Journal Line");
                    LineAmount := Amount;
                    if GenProdPosGrp.Get("Gen. Prod. Posting Group") then
                        Desc := GenProdPosGrp.Description;
                    if ("Account Type" = "Account Type"::Vendor) and (AdvanceAmount = 0) then begin
                        AdvanceAmount := LineAmount;
                        LineAmount := 0;
                    end;
                end;




                GenJnlGrec.Reset();
                GenJnlGrec.SetRange("Journal Template Name", "Journal Template Name");
                GenJnlGrec.SetRange("Journal Batch Name", "Journal Batch Name");
                GenJnlGrec.SetFilter("Line No.", '>%1', "Line No.");
                if GenJnlGrec.FindFirst() then begin
                    //if BankAccGRec.get(genjnl."Bal. Account No.") then;
                    CreditAccountNameGar := GenJnlGrec.Description;
                end;
                GenJournalNarration.Reset();
                GenJournalNarration.SetRange("Journal Template Name", "Journal Template Name");
                GenJournalNarration.SetRange("Journal Batch Name", "Journal Batch Name");
                GenJournalNarration.SetRange("Document No.", "Document No.");
                //GenJournalNarration.SetRange("Gen. Journal Line No.", "Line No.");
                if GenJournalNarration.Findset() then
                    repeat
                        GenJnlNarrationGvar += GenJournalNarration.Narration;
                    until GenJournalNarration.Next() = 0;

                CreditAmt := Amount - TDSAmt;
                TotalAmt := LineAmount + CGSTAmt + SGSTAmt + IGSSTAmt - TDSAmt;
                Clear(NumberText);
                Clear(BankChargesGvar);
                JournalBankCharges.Reset();
                JournalBankCharges.SetRange("Journal Template Name", "Journal Template Name");
                JournalBankCharges.SetRange("Journal Batch Name", "Journal Batch Name");
                JournalBankCharges.SetRange("Line No.", "Line No.");
                if JournalBankCharges.FindFirst() then
                    BankChargesGvar := JournalBankCharges.Amount;
                Clear(DescriptionTextGvar);
                DescriptionTextGvar := Description;
                if ("Account Type" = "Account Type"::"G/L Account") then begin
                    GLsetup.Get();
                    DimensionSetEntry.Reset();
                    DimensionSetEntry.SetRange("Dimension Set ID", "Dimension Set ID");
                    DimensionSetEntry.SetRange("Dimension Code", GLsetup."Shortcut Dimension 3 Code");
                    if DimensionSetEntry.FindFirst() then
                        if EmployeeGrec.Get(DimensionSetEntry."Dimension Value Code") then
                            DescriptionTextGvar := EmployeeGrec."Last Name" + ' ' + EmployeeGrec."First Name" + EmployeeGrec."Middle Name";
                end;
                TotalTdsAmt += TDSAmt;
                CreditAmountGvar += "Credit Amount";
                CheckGRec.InitTextVariable;
                CheckGRec.FormatNoText(NumberText, Round(CreditAmountGvar + BankChargesGvar - TotalTdsAmt + abs(BalAmt), 1, '='), "Currency Code");
                if ("Gen. Journal Line"."Applies-to ID" = '') and (("Account Type" = "Account Type"::Vendor) or ("Account Type" = "Account Type"::"G/L Account") or ("Account Type" = "Account Type"::"Bank Account")) then
                    TotalLineAmountGvar += "Debit Amount" + BankChargesGvar - TDSAmt;
                if "Applies-to ID" <> '' then
                    TotalLineAmountGvar += LineAmount + BankChargesGvar - TDSAmt + Abs(BalAmt);
                if "Applies-to ID" = '' then begin
                    SumBankCharges += BankChargesGvar;
                    SumTdsAmt += TDSAmt;
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

            }
        }
    }
    trigger OnPreReport()
    begin
        Clear(HdrText);
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;


    local procedure GetTDSAmount(GenJnlLine: Record "Gen. Journal Line")
    var
        TDSSetup: Record "TDS Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSEntry: Record "TDS Entry";

    begin
        Clear(AppliesDocNo);

        /*if "Gen. Journal Line"."Applies-to ID" <> '' then begin
            VendorLedgerEntry.Reset();
            VendorLedgerEntry.SetRange("Applies-to ID", "Gen. Journal Line"."Applies-to ID");
            if VendorLedgerEntry.FindSet() then begin
                repeat
                    TDSEntry.Reset();
                    TDSEntry.SetRange("Document No.", VendorLedgerEntry."Document No.");
                    if TDSEntry.FindSet() then begin
                        repeat
                            //TDSEntry.CalcSums("TDS Amount");
                            //TDSAmt := Round(TDSEntry."TDS Amount", 1);
                            TDSAmt += Abs(Round(TDSEntry."TDS Amount", 1));
                            TdsAmtNew += Abs(Round(TDSEntry."TDS Amount", 1))
                        until TDSEntry.Next() = 0;
                    end;
                    AppliesDocNo += VendorLedgerEntry."Document No." + ',';
                until VendorLedgerEntry.Next() = 0;
                if TDSAmt = 0 then begin
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
            end
        end else begin*/
        if "Gen. Journal Line"."Applies-to ID" <> '' then begin
            VendorLedgerEntry.Reset();
            VendorLedgerEntry.SetRange("Applies-to ID", "Gen. Journal Line"."Applies-to ID");
            if VendorLedgerEntry.FindSet() then begin
                repeat
                    AppliesDocNo += VendorLedgerEntry."Document No." + ',';
                until VendorLedgerEntry.Next() = 0;
            end;
        end;
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

    //end;

    local procedure GetAdvanceAmount(GenJnlLine: Record "Gen. Journal Line")
    var
        PurchInvHead: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        PrepInvHead: Record "Purch. Inv. Header";
        PrepInvLine: Record "Purch. Inv. Line";
        VendorLedger: Record "Vendor Ledger Entry";
        PrevDocNo: Code[20];
    begin
        Clear(AdvanceAmount);
        if "Gen. Journal Line"."Applies-to ID" = '' then
            exit;
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetRange("Applies-to ID", "Gen. Journal Line"."Applies-to ID");
        if VendorLedgerEntry.FindFirst() then begin
            repeat
                if PrevDocNo <> VendorLedgerEntry."Document No." then begin
                    PrevDocNo := VendorLedgerEntry."Document No.";

                    if PurchInvHead.Get(VendorLedgerEntry."Document No.") then;
                    PurchInvLine.Reset();
                    PurchInvLine.SetFilter("No.", '<>%1', '');
                    PurchInvLine.SetRange("Document No.", PurchInvHead."No.");
                    if PurchInvLine.FindSet() then;
                    PrepInvHead.Reset();
                    PrepInvHead.SetRange("Prepayment Order No.", PurchInvLine."Order No.");
                    PrepInvHead.SetRange("Prepayment Invoice", true);
                    if PrepInvHead.FindSet() then
                        repeat
                            VendorLedger.Reset();
                            VendorLedger.SetRange("Document No.", PrepInvHead."No.");
                            VendorLedger.SetRange("Remaining Amount", 0);
                            if VendorLedger.FindSet() then begin
                                repeat
                                    VendorLedger.CalcFields("Amount");
                                    AdvanceAmount += VendorLedger.Amount;
                                until VendorLedger.Next() = 0
                            end;
                            AdvanceAmount := Abs(AdvanceAmount);
                        until PrepInvHead.Next() = 0;
                end;
            until VendorLedgerEntry.Next() = 0;
        end;
    end;



    var
        HdrText: Text;
        TotalAmt: Decimal;
        CheckGRec: Codeunit "Check Codeunit";
        NumberText: array[2] of Text;
        GenJournalNarration: Record "Gen. Journal Narration";
        VendorGRec: Record Vendor;
        TdsEntry: Record "TDS Entry";
        TdsCapLbl: Label 'TDS Amount';
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        BalAmt: Decimal;
        BankAccGRec: Record "Bank Account";
        GenProdPosGrp: record "Gen. Product Posting Group";
        LineAmount: Decimal;
        TDSAmt: Decimal;
        CreditAmt: Decimal;
        AdvanceAmount: Decimal;
        Desc: Text[100];
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvLine: Record "Purch. Inv. Line";
        VendorLedgerEntry2: Record "Vendor Ledger Entry";
        PurchInvLine2: Record "Purch. Inv. Line";
        PurchInvHdr2: Record "Purch. Inv. Header";
        CompanyInfo: Record "Company Information";
        BankVoucherLbl: Label 'BANK VOUCHER';
        DateCapLbl: Label 'Date';
        VrNoCapLbl: Label 'V.R.No.';
        DebitVchrCapLbl: Label 'DEBIT VOUCHER';
        AccountLbl: Label 'ACCOUNT';
        AmountCapLbl: Label 'AMOUNT';
        PAIDToCapLbl: Label 'PAID TO';
        ByChequeNoCapLbl: Label 'By Cheque No';
        DtCapLbl: Label 'Dt';
        TowardsCapLbl: Label 'TOWARDS';
        RupeesCapLbl: Label 'RUPEES';
        PreparedCapLbl: Label 'PREPARED';
        CheckedCapLbl: Label 'CHECKED';
        PassedCapLbl: Label 'PASSED';
        SanctionedCapLbl: Label 'SANCTIONED';
        CreditcodeCapLbl: Label 'CREDIT CODE';
        CGSTCapLbl: Label 'CGST';
        SGSTCapLbl: Label 'SGST';
        RoundoffCapLbl: Label 'Roundoff';
        PaymentRcvdCapLbl: Label 'PAYMENT RECEIVED';
        LocationGRec: Record Location;//B2BSSD09Jan2023
        genjnl: Record "Gen. Journal Line";
        Rep: Report 18031;
        pag: Page "Journal Voucher";
        glentryies: Page "General Ledger Entries";
        repo: Report 18041;
        JournalBankCharges: Record "Journal Bank Charges";
        BankChargesGvar: Decimal;
        DescriptionTextGvar: Text;
        GLsetup: Record "General Ledger Setup";
        DimensionValues: Record "Dimension Value";
        DimensionSetEntry: Record "Dimension Set Entry";
        AppliesDocNo: Text;
        VendorLedgerEntryGrec: Record "Vendor Ledger Entry";
        EmployeeGrec: Record Employee;
        GenJnlGrec: Record "Gen. Journal Line";
        CreditAccountNameGar: Text;
        TotalLineAmountGvar: Decimal;
        SumBankCharges: Decimal;
        SumTdsAmt: Decimal;
        GstLedgSum: Decimal;
        PrevPurchInvNo: Text;
        TotalTdsAmt: Decimal;
        GenJnlNarrationGvar: Text;
        TdsAmtNew: Decimal;
        DebitAmountGvar: Decimal;
        CreditAmountGvar: Decimal;
}
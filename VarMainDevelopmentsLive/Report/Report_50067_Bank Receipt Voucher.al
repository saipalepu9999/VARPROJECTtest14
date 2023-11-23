report 50067 BankReceiptVoucher
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\BankReceiptVoucher.rdl';
    Caption = 'Bank Receipt Print_50067';

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            column(HdrText; HdrText)
            { }
            column(NumberText1; NumberText[1])
            { }
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
            //B2BSSD09Jan2023<<
            column(Location_Address; LocationGrec.Address)
            { }
            //B2BSSD09Jan2023>>
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
            column(Amount; CreditAmt)
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(LineAmount; LineAmount)
            { }
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
            column(VendorGRecName; VendorGRec.Name)
            { }
            column(GenJournalNarration; GenJournalNarration.Narration)
            { }
            column(TotalAmt; TotalAmt)
            { }
            column(Description; Description)
            { }
            column(Account_No_; "Account No.")
            { }



            trigger OnAfterGetRecord()
            var
                GenTemp: Record "Gen. Journal Template";
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
                Clear(LocationGrec);//B2BSSD09Jan2023
                GenTemp.Get("Gen. Journal Line"."Journal Template Name");
                HdrText := Format(GenTemp.Type);
                if VendorGRec.get("Account No.") then;
                if "Applies-to ID" <> '' then begin
                    VendorLedgerEntry.Reset();
                    VendorLedgerEntry.SetRange("Applies-to ID", "Applies-to ID");
                    if VendorLedgerEntry.FindFirst() then begin
                        PurchInvLine.Reset();
                        PurchInvLine.SetRange("Document No.", VendorLedgerEntry."Document No.");
                        PurchInvLine.SetFilter("No.", '<>%1', '');
                        if PurchInvLine.FindSet() then begin
                            PurchInvLine.CalcSums("Line Amount");
                            LineAmount := PurchInvLine."Line Amount";
                            if GenProdPosGrp.Get(PurchInvLine."Gen. Prod. Posting Group") then
                                Desc := GenProdPosGrp.Description;
                        end;
                    end;
                    VendorLedgerEntry2.Reset();
                    VendorLedgerEntry2.SetRange("Applies-to ID", "Applies-to ID");
                    if VendorLedgerEntry2.FindFirst() then begin
                        PurchInvLine2.Reset();
                        PurchInvLine2.SetRange("Document No.", VendorLedgerEntry."Document No.");
                        PurchInvLine2.SetFilter("No.", '<>%1', '');
                        if PurchInvLine2.FindSet() then begin
                            Clear(PurchInvHdr2);
                            if PurchInvHdr2.Get(PurchInvLine2."Document No.") then;
                            repeat
                                GetPurchGSTAmount(PurchInvHdr2, PurchInvLine2);
                            until PurchInvLine2.Next() = 0;
                        end;
                    end;
                end else begin
                    GetGSTAmounts("Gen. Journal Line");
                    LineAmount := Amount;
                    if GenProdPosGrp.Get("Gen. Prod. Posting Group") then
                        Desc := GenProdPosGrp.Description;
                end;

                GetTDSAmount("Gen. Journal Line");

                if BankAccGRec.get("Bal. Account No.") then;
                GenJournalNarration.Reset();
                GenJournalNarration.SetRange("Journal Template Name", "Journal Template Name");
                GenJournalNarration.SetRange("Journal Batch Name", "Journal Batch Name");
                GenJournalNarration.SetRange("Document No.", "Document No.");
                GenJournalNarration.SetRange("Gen. Journal Line No.", "Line No.");
                if GenJournalNarration.FindFirst() then;

                CreditAmt := Amount - TDSAmt;

                TotalAmt := ABS(LineAmount + CGSTAmt + SGSTAmt + IGSSTAmt - TDSAmt);
                Clear(NumberText);
                CheckGRec.InitTextVariable;
                CheckGRec.FormatNoText(NumberText, Round(TotalAmt, 1, '='), "Currency Code");
                if LocationGrec.Get("Location Code") then;//B2BSSD09Jan2023
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
                    ToolTip = 'Executes the ActionName action.';

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        Clear(HdrText);
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    local procedure GetPurchGSTAmount(PurchInvHeader: Record "Sales Invoice Header";
           PurchInvLine: Record "Sales Invoice Line")
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", PurchInvLine."Document No.");
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Document Line No.", PurchInvLine."Line No.");
        if DetailedGSTLedgerEntry.FindSet() then begin
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
                    IGSSTAmt := Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then
                        IGSSTAmt := Abs(DetailedGSTLedgerEntry."GST Amount");
                if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) And (PurchInvHeader."Currency Code" <> '') then
                    CessAmt += Round((Abs(DetailedGSTLedgerEntry."GST Amount") * PurchInvHeader."Currency Factor"), GetGSTRoundingPrecision(DetailedGSTLedgerEntry."GST Component Code"))
                else
                    if (DetailedGSTLedgerEntry."GST Component Code" = CessLbl) then
                        CessAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
            until DetailedGSTLedgerEntry.Next() = 0;

        end;
    end;

    local procedure GetGSTAmounts(GenJnlLine: Record "Gen. Journal Line")
    var
        ComponentName: Code[30];
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        ComponentName := GetComponentName(GenJnlLine, GSTSetup);

        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", GenJnlLine.RecordId);
        TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                case TaxTransactionValue."Value ID" of
                    6:
                        SGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                    2:
                        CGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                    3:
                        IGSSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                end;
            until TaxTransactionValue.Next() = 0;
    end;

    local procedure GetComponentName(GenJnlLine: Record "Gen. Journal Line";
        GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if GenJnlLine."GST Jurisdiction Type" = GenJnlLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
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

    local procedure GetTDSAmount(GenJnlLine: Record "Gen. Journal Line")
    var
        TDSSetup: Record "TDS Setup";
        TaxTransactionValue: Record "Tax Transaction Value";
    begin
        TDSSetup.Get();
        TaxTransactionValue.Reset();
        TaxTransactionValue.SetRange("Tax Record ID", GenJnlLine.RecordId);
        TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if TaxTransactionValue.FindSet() then
            repeat
                TDSAmt += TaxTransactionValue.Amount;
            until TaxTransactionValue.Next() = 0;
        TDSAmt := Round(TDSAmt, 1);
    end;




    var
        HdrText: Text;
        TotalAmt: Decimal;
        CheckGRec: Codeunit "Check Codeunit";

        NumberText: array[2] of Text;
        GenJournalNarration: Record "Gen. Journal Narration";
        VendorGRec: Record Customer;
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
        BankAccGRec: Record "Bank Account";
        GenProdPosGrp: record "Gen. Product Posting Group";
        LineAmount: Decimal;
        TDSAmt: Decimal;
        CreditAmt: Decimal;
        Desc: Text[100];
        VendorLedgerEntry: Record "Cust. Ledger Entry";
        PurchInvLine: Record "Sales Invoice Line";
        VendorLedgerEntry2: Record "Cust. Ledger Entry";
        PurchInvLine2: Record "Sales Invoice Line";
        PurchInvHdr2: Record "Sales Invoice Header";
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
        LocationGrec: Record Location;//B2BSSD09Jan2023
                                      //LocationAddress: Label 'Location_Address';//B2BSSD09Jan2023

}
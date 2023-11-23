reportextension 50000 "Posted Voucher Ext B2B" extends "Posted Voucher"
{

    //Created By - B2BMSOn21APR2023
    dataset
    {
        modify("G/L Entry")
        {
            trigger OnAfterAfterGetRecord()
            var
                BankAccLedgEntry: Record "Bank Account Ledger Entry";
            begin
                BankName := '';
                if ("Source No." <> '') and ("Source Type" = "Source Type"::"Bank Account") then begin
                    GLSetup.Get();
                    "G/L Entry".CalcFields("Shortcut Dimension 3 Code");
                    if DimensionValueGRec.Get(GLSetup."Shortcut Dimension 3 Code", "G/L Entry"."Shortcut Dimension 3 Code") then
                        EmpName := DimensionValueGRec.Name;

                    ChequeNo1 := '';
                    ChequeDate1 := 0D;
                    if ("Source No." <> '') and ("Source Type" = "Source Type"::"Bank Account") then
                        if BankAccLedgEntry.Get("Entry No.") then begin
                            ChequeNo1 := BankAccLedgEntry."Cheque No.";
                            ChequeDate1 := BankAccLedgEntry."Cheque Date";
                        end;
                end;
            end;
        }
        add("G/L Entry")
        {
            column(AdvanceTDS; AdvanceTDS)
            { }
            column(VoucherNoLbl; VoucherNoLbl)
            { }
            column(DateCapLbl; DateCapLbl)
            { }
            column(PartyTypeLbl; PartyTypeLbl)
            { }
            column(VoucherAmountLbl; VoucherAmountLbl)
            { }
            column(PrintPaymentInvoiceDetails; PrintPaymentInvoiceDetails)
            { }
            column(InvoiceNoLbl; InvoiceNoLbl)
            { }
            column(InvoiceDateLbl; InvoiceDateLbl)
            { }
            column(BasicAmountLbl; BasicAmountLbl)
            { }
            column(GSTAmountLbl; GSTAmountLbl)
            { }
            column(TDSamountLbl; TDSamountLbl)
            { }
            column(NetAmountLbl; NetAmountLbl)
            { }
            column(IGSSTAmt; IGSSTAmt)
            { }
            column(CGSTAmt; CGSTAmt)
            { }
            column(SGSTAmt; SGSTAmt)
            { }
            column(TDSAmt; TDSAmt)
            { }
            column(SNoLbl; SNoLbl)
            { }
            column(AdvaceAmountLbl; AdvaceAmountLbl)
            { }
            column(AdvanceTDSLbl; AdvanceTDSLbl)
            { }
            column(PartialApplicationamountLbl; PartialApplicationamountLbl)
            { }
            column(CreditmemoNoLbl; CreditmemoNoLbl)
            { }
            column(CreditmemoAmountLbl; CreditmemoAmountLbl)
            { }
            column(TotalAmountLbl; TotalAmountLbl)
            { }
            column(IGSTLbl; IGSTLbl)
            { }
            column(CGSTLbl; CGSTLbl)
            { }
            column(SGSTLbl; SGSTLbl)
            { }
            column(NetAmount; NetAmount)
            { }
            column(AmountLcy; VLEGobal."Amount (LCY)")
            { }
            column(CompanyName; CompanyInfoGRec.Name)
            { }
            column(CompanyAddress; CompanyInfoGRec.Address)
            { }
            column(CompanyCity; CompanyInfoGRec.City + ' ' + CompanyInfoGRec."Post Code")
            { }
            column(Vendor_CustomerNameLbl; "Vendor/CustomerNameLbl")
            { }
            column(BankNameLbl; BankNameLbl)
            { }
            column(ChequeNoDateLbl; "ChequeNo.& DateLbl")
            { }
            column(GSTAmount; GSTAmount)
            { }
            column(Partytypename; Partytypename)
            { }
            column(Posting_Date_New; format("Posting Date"))
            { }
            column(BankName; BankName)
            { }
            column(ChequeNonew; ChequeNonew)
            { }
            column(ChequeDateNew; ChequeDateNew)
            { }
            column(entryNo; entryNo)
            { }
            column(BasicAmount; BasicAmount)
            { }
            column(CompanyInfoPic; CompanyInfoGRec.Picture)
            { }
            column(AdvanceReasoncode; AdvanceReasoncode)
            { }
            column(Advanceamount; Advanceamount)
            { }
            column(CreditmemoNo; CreditmemoNo)
            { }
            column(CreditMemoAmount; CreditMemoAmount)
            { }
            column(RemainingAmountLbl; RemainingAmountLbl)
            { }
            column(RemainingAmount; RemainingAmount)
            { }
            column(TotalNetAmount; TotalNetAmount)
            { }
            column(Sno; Sno)
            { }
            column(GrandTotalCap; GrandTotalCap)
            { }
            column(PossedCapLbl; PossedCapLbl)
            {
            }
            column(SanctionCapLbl; SanctionCapLbl)
            { }
        }
        addlast("G/L Entry")
        {
            dataitem(ApplyEntriesLoop; Integer)
            {
                DataItemLinkReference = "G/L Entry";
                DataItemTableView = sorting(Number);

                column(RecCount; RecCount)
                { }
                column(Number_ApplyEntriesLoop; Number)
                { }
                column(AppliedToID; AppliesToIDGvar)
                { }
                column(ExtDocNo; VLEGobal."External Document No.")
                { }
                column(RefCap; RefCap)
                { }
                column(PostingDate; VLEGobal."Posting Date")
                { }
                column(ClosedAmountGvar; ClosedAmountGvar)
                { }

                trigger OnPreDataItem()
                var
                    CreateVendLedgEntry: Record "Vendor Ledger Entry";
                    CreateCustLedgEntry: Record "Cust. Ledger Entry";
                    Heading: Text[50];
                    Text000: Label 'Document';
                    GLEntry: Record "G/L Entry";

                begin
                    if not PrintPaymentInvoiceDetails then
                        CurrReport.Break();

                    CustomerLoop := false;
                    VendorLoop := false;
                    RecCount := 0;
                    ClosedAmountGvar := 0;
                    Clear(FirstDocNo);
                    GLEntry.Reset();
                    GLEntry.SetCurrentKey("Document No.", "Posting Date", Amount);
                    GLEntry.Ascending(false);
                    GLEntry.SetRange("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                    if GLEntry.FindLast() then
                        if GLEntry."Entry No." = "G/L Entry"."Entry No." then begin
                            //----Vendor Entries>>
                            //Partytypename := "G/L Entry"."Source Type"::Vendor;
                            VendorLedgerEntry.Reset();
                            VendorLedgerEntry.SetRange("Transaction No.", "G/L Entry"."Transaction No.");
                            if VendorLedgerEntry.FindFirst() then begin
                                if VendorLedgerEntry."Document Type" = VendorLedgerEntry."Document Type"::Payment then
                                    FirstDocNo := VendorLedgerEntry."Document No.";
                                // ClosedAmountGvar := VendorLedgerEntry."Closed by Amount";
                                VendorLoop := true;
                                CreateVendLedgEntry := VendorLedgerEntry;
                                if CreateVendLedgEntry."Document Type" = CreateVendLedgEntry."Document Type"::" " then
                                    Heading := Text000
                                else
                                    Heading := Format(CreateVendLedgEntry."Document Type");
                                Heading := Heading + ' ' + CreateVendLedgEntry."Document No.";
                                VendorLedgerEntry.Reset();
                                FindApplnEntriesDtldtLedgEntry(CreateVendLedgEntry, VendorLedgerEntry);
                                VendorLedgerEntry.SetCurrentKey("Entry No.");
                                VendorLedgerEntry.SetRange("Entry No.");

                                if CreateVendLedgEntry."Closed by Entry No." <> 0 then begin
                                    VendorLedgerEntry."Entry No." := CreateVendLedgEntry."Closed by Entry No.";
                                    VendorLedgerEntry.Mark(true);
                                end;

                                VendorLedgerEntry.SetCurrentKey("Closed by Entry No.");
                                VendorLedgerEntry.SetRange("Closed by Entry No.", CreateVendLedgEntry."Entry No.");
                                if VendorLedgerEntry.Find('-') then
                                    repeat
                                        VendorLedgerEntry.Mark(true);
                                    until VendorLedgerEntry.Next() = 0;

                                VendorLedgerEntry.SetCurrentKey("Entry No.");
                                VendorLedgerEntry.SetRange("Closed by Entry No.");

                                VendorLedgerEntry.MarkedOnly(true);
                                if VendorLedgerEntry.FindSet() then
                                    RecCount := VendorLedgerEntry.Count;
                            end else begin
                                //----Vendor Entries<<

                                //----Customer Entries>>

                                CustLedgerEntry.Reset();
                                CustLedgerEntry.SetRange("Transaction No.", "G/L Entry"."Transaction No.");
                                if CustLedgerEntry.FindFirst() then begin
                                    if CustLedgerEntry."Document Type" = CustLedgerEntry."Document Type"::Payment then
                                        FirstDocNo := CustLedgerEntry."Document No.";
                                    CustomerLoop := true;
                                    CreateCustLedgEntry := CustLedgerEntry;
                                    if CreateCustLedgEntry."Document Type" = CreateCustLedgEntry."Document Type"::" " then
                                        Heading := Text000
                                    else
                                        Heading := Format(CreateCustLedgEntry."Document Type");
                                    Heading := Heading + ' ' + CreateCustLedgEntry."Document No.";
                                    CustLedgerEntry.Reset();
                                    FindApplnEntriesDtldtLedgEntryCustomer(CreateCustLedgEntry);
                                    CustLedgerEntry.SetCurrentKey("Entry No.");
                                    CustLedgerEntry.SetRange("Entry No.");

                                    if CreateCustLedgEntry."Closed by Entry No." <> 0 then begin
                                        CustLedgerEntry."Entry No." := CreateCustLedgEntry."Closed by Entry No.";
                                        CustLedgerEntry.Mark(true);
                                    end;

                                    CustLedgerEntry.SetCurrentKey("Closed by Entry No.");
                                    CustLedgerEntry.SetRange("Closed by Entry No.", CreateCustLedgEntry."Entry No.");
                                    if CustLedgerEntry.Find('-') then
                                        repeat
                                            CustLedgerEntry.Mark(true);
                                        until CustLedgerEntry.Next() = 0;

                                    CustLedgerEntry.SetCurrentKey("Entry No.");
                                    CustLedgerEntry.SetRange("Closed by Entry No.");

                                    CustLedgerEntry.MarkedOnly(true);
                                    if CustLedgerEntry.FindSet() then
                                        RecCount := CustLedgerEntry.Count;
                                    //----Customer Entries<<
                                end;
                            end;
                        end;
                    if RecCount > 0 then
                        SetRange(Number, 1, RecCount)
                    else
                        CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                var
                    BankAccLedgEntry: Record "Bank Account Ledger Entry";
                    BankAccount: Record "Bank Account";
                    AppiedVendorEntries: Record "Vendor Ledger Entry";
                    VendorLedgerEntries: Record "Vendor Ledger Entry";
                    TdsEntry: Record "TDS Entry";
                    vendorLedEntyLRec: Record "Vendor Ledger Entry";
                    venderLedEntyRec1: Record "Vendor Ledger Entry";
                    custLedEntries: Record "Cust. Ledger Entry";
                    DetailedVenLedEntries: Record "Detailed Vendor Ledg. Entry";

                begin

                    if VendorLoop then begin
                        Partytypename := "G/L Entry"."Source Type"::Vendor.AsInteger();
                        Clear(AppliesToIDGvar);
                        GetTDSAmt(VendorLedgerEntry."Document No.");
                        GetGSTAmount(VendorLedgerEntry."Document No.", VendorLedgerEntry."Posting Date");
                        AppliesToIDGvar := VendorLedgerEntry."Document No.";

                        Sno += 1;
                        BankAccLedgEntry.Reset();
                        BankAccLedgEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                        if BankAccLedgEntry.FindFirst() then begin
                            ChequeNonew := BankAccLedgEntry."Cheque No.";
                            ChequeDateNew := BankAccLedgEntry."Cheque Date";
                            BankAccount.Reset();
                            BankAccount.SetRange("No.", BankAccLedgEntry."Bank Account No.");
                            if BankAccount.FindFirst() then
                                BankName := BankAccount.Name;
                            //B2BPROn28JUN2023<<<
                        end;
                        /* TdsEntry.Reset();
                         TdsEntry.SetRange("Document No.", "G/L Entry"."Document No.");
                         if TdsEntry.FindFirst() then
                             AdvanceTDS := TdsEntry."TDS Amount";*/
                        Clear(Advanceamount);
                        Clear(AdvanceTDS);
                        VendorLedgerEntries.Reset();
                        VendorLedgerEntries.SetRange("Closed by Entry No.", VendorLedgerEntry."Entry No.");
                        if (VendorLedgerEntries.FindFirst()) and (VendorLedgerEntries."Reason Code" = 'ADVANCE') then begin
                            TdsEntry.Reset();
                            TdsEntry.SetRange("Document No.", VendorLedgerEntries."Document No.");
                            if TdsEntry.FindFirst() then
                                AdvanceTDS := TdsEntry."TDS Amount";
                            VendorLedgerEntries.CalcFields(Amount);
                            Advanceamount := VendorLedgerEntries.Amount;
                            ClosedAmountGvar := 0;
                        end else begin
                            DetailedVenLedEntries.Reset();
                            DetailedVenLedEntries.SetRange("Vendor Ledger Entry No.", VendorLedgerEntries."Closed by Entry No.");
                            DetailedVenLedEntries.SetRange("Entry Type", DetailedVenLedEntries."Entry Type"::Application);
                            DetailedVenLedEntries.SetRange("Document Type", DetailedVenLedEntries."Document Type"::Invoice);
                            if DetailedVenLedEntries.FindSet() then
                                Advanceamount := DetailedVenLedEntries.Amount;
                        end;

                        GSTAmount := IGSSTAmt + CGSTAmt + SGSTAmt;
                        VendorLedgerEntry.CalcFields(Amount);
                        Clear(BasicAmount);
                        GetInvoiceAmount(VendorLedgerEntry, BasicAmount);
                        //BasicAmount := abs(VendorLedgerEntry.Amount) - GSTAmount;
                        NetAmount := BasicAmount + GSTAmount - TDSAmt;
                        CreditMemoAmount := 0;
                        RemainingAmount := 0;
                        vendorLedEntyLRec.Reset();
                        vendorLedEntyLRec.SetRange("Document No.", VendorLedgerEntry."Document No.");
                        if vendorLedEntyLRec.FindFirst() then begin
                            vendorLedEntyLRec.CalcFields("Remaining Amount");
                            RemainingAmount += abs(vendorLedEntyLRec."Remaining Amount");
                            VendorLedgerEntryNew.Reset();
                            FindApplnEntriesDtldtLedgEntry(vendorLedEntyLRec, VendorLedgerEntryNew);
                            VendorLedgerEntryNew.SetCurrentKey("Entry No.");
                            VendorLedgerEntryNew.SetRange("Entry No.");
                            if vendorLedEntyLRec."Closed by Entry No." <> 0 then begin
                                VendorLedgerEntryNew."Entry No." := vendorLedEntyLRec."Closed by Entry No.";
                                VendorLedgerEntryNew.Mark(true);
                            end;
                            VendorLedgerEntryNew.SetCurrentKey("Closed by Entry No.");
                            VendorLedgerEntryNew.SetRange("Closed by Entry No.", vendorLedEntyLRec."Entry No.");
                            if VendorLedgerEntryNew.Find('-') then
                                repeat
                                    VendorLedgerEntryNew.Mark(true);
                                until VendorLedgerEntryNew.Next() = 0;
                            VendorLedgerEntryNew.SetCurrentKey("Entry No.");
                            VendorLedgerEntryNew.SetRange("Closed by Entry No.");

                            VendorLedgerEntryNew.MarkedOnly(true);
                            if VendorLedgerEntryNew.FindSet() then
                                repeat
                                    VendorLedgerEntryNew.CalcFields("Debit Amount");
                                    if (FirstDocNo <> VendorLedgerEntryNew."Document No.") and (VendorLedgerEntryNew."Reason Code" = '') and (VendorLedgerEntryNew."Document Type" = VendorLedgerEntryNew."Document Type"::Payment) then
                                        ClosedAmountGvar += VendorLedgerEntryNew."Debit Amount";
                                    if VendorLedgerEntryNew."Document Type" = VendorLedgerEntryNew."Document Type"::" " then
                                        TDSAmt += VendorLedgerEntryNew."Debit Amount";
                                    if VendorLedgerEntryNew."Document Type" = VendorLedgerEntryNew."Document Type"::"Credit Memo" then begin
                                        CreditmemoNo := VendorLedgerEntryNew."Document No.";
                                        VendorLedgerEntryNew.CalcFields(Amount);
                                        CreditMemoAmount += VendorLedgerEntryNew.Amount;
                                    end;
                                until VendorLedgerEntryNew.Next() = 0;
                        end;
                        NetAmount := BasicAmount + GSTAmount - TDSAmt;
                        TotalNetAmount := NetAmount - Advanceamount - CreditMemoAmount;
                        VLEGobal := VendorLedgerEntry;
                        VendorLedgerEntry.Next();
                    end else
                        if CustomerLoop then begin
                            Partytypename := "G/L Entry"."Source Type"::Customer.AsInteger();
                            CustLedgerEntry.Next();
                            GetTDSAmt(CustLedgerEntry."Document No.");
                            GetGSTAmount(CustLedgerEntry."Document No.", CustLedgerEntry."Posting Date");
                            AppliesToIDGvar := CustLedgerEntry."Document No.";
                            custLedEntries.Reset();
                            custLedEntries.SetRange("Closed by Entry No.", CustLedgerEntry."Entry No.");
                            if (custLedEntries.FindFirst()) and (custLedEntries."Reason Code" = 'ADVANCE') then begin
                                custLedEntries.CalcFields(Amount);
                                Advanceamount := custLedEntries.Amount;
                            end;
                            GSTAmount := IGSSTAmt + CGSTAmt + SGSTAmt;
                            custLedEntries.CalcFields(Amount);
                            BasicAmount := abs(CustLedgerEntry.Amount) - GSTAmount;
                            NetAmount := BasicAmount + GSTAmount - TDSAmt;
                        end;
                end;
            }
        }
        add(PostedNarration1)
        {
            column(ChequeDetail1; ChequeNoLbl1 + ChequeNo1 + DatedLbl1 + FORMAT(ChequeDate1))
            {
            }
            column(EmpName; EmpName)
            { }


        }
    }

    requestpage
    {
        layout
        {
            addafter(PrintLineNarration1)
            {
                field(PrintPaymentInvoiceDetails; PrintPaymentInvoiceDetails)
                {
                    ApplicationArea = All;
                    Caption = 'Print Payment Invoice Details';
                }
            }
        }
    }

    rendering
    {
        layout(ModifiedReport)
        {
            Type = RDLC;
            LayoutFile = 'Report Extensions\Layouts\Default - Copy.rdl';
            //LayoutFile = 'Report Extensions\Layouts\Default - Copy.rdl';
        }
    }
    trigger OnPreReport()
    var

    begin
        CompanyInfoGRec.get;
        CompanyInfoGRec.CalcFields(Picture);
    end;

    var
        FirstDocNo: Code[20];
        DimensionValueGRec: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        RecCount: Integer;
        ClosedAmountGvar: Decimal;
        VLEGobal: Record "Vendor Ledger Entry";
        CustomerLoop: Boolean;
        VendorLoop: Boolean;
        VendorLedgerEntryNew: Record "Vendor Ledger Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        RefCap: Text;
        VoucherNoLbl: Label 'Voucher No.';
        DateCapLbl: Label 'Voucher Date';
        PartyTypeLbl: Label 'Party Type';
        VoucherAmountLbl: Label 'Voucher Amount';
        SNoLbl: Label 'S.No';
        InvoiceNoLbl: Label 'Invoice No.';
        InvoiceDateLbl: Label 'Invoice Date';
        BasicAmountLbl: Label 'Basic Amount';
        TDSamountLbl: Label 'TDS Amount';
        NetAmountLbl: Label 'Net Amount';
        AdvaceAmountLbl: Label 'Advance Amount';
        AdvanceTDSLbl: Label 'Advance TDS';
        PartialApplicationamountLbl: Label 'Partial Application Amount';
        CreditmemoNoLbl: Label 'Credit Memo No';
        CreditmemoAmountLbl: Label 'Credit Memo Amount';
        TotalAmountLbl: Label 'Total Amount';
        IGSTLbl: Label 'IGST';
        CGSTLbl: Label 'CGST';
        SGSTLbl: Label 'SGST';
        GSTAmountLbl: Label 'GST Amount';
        GSTAmount: Decimal;
        IGSSTAmt: Decimal;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        TDSAmt: Decimal;
        NetAmount: Decimal;
        PrintPaymentInvoiceDetails: Boolean;
        CompanyInfoGRec: Record "Company Information";
        "Vendor/CustomerNameLbl": Label 'Vendor / Customer Name';
        BankNameLbl: Label 'Bank Name';
        "ChequeNo.& DateLbl": Label 'Cheque No. & Date';
        Partytypename: Option Vendor,Customer;
        GLEntry1: Record "G/L Entry";
        ChequeNonew: Code[50];
        ChequeDateNew: Date;
        ChequeNoLbl1: Label 'Cheque No: ';
        DatedLbl1: Label ' Date: ';
        ChequeNo1: Code[50];
        ChequeDate1: Date;
        BankName: Text[100];
        BasicAmount: Decimal;
        entryNo: Integer;
        AdvanceReasoncode: Code[20];
        Advanceamount: Decimal;
        AdvanceTDS: Decimal;
        CreditmemoNo: Code[10];
        CreditMemoAmount: Decimal;
        RemainingAmountLbl: Label 'Remaining Amount';
        RemainingAmount: Decimal;
        TotalNetAmount: Decimal;
        PartialAmount: Decimal;
        Sno: Integer;
        AppliesToIDGvar: Code[20];
        GrandTotalCap: Label 'Sum of Totals';
        PossedCapLbl: Label 'Passed by:';
        SanctionCapLbl: Label 'Sanctioned by:';
        EmpName: text[30];

    local procedure FindApplnEntriesDtldtLedgEntry(CreateVendLedgEntry: Record "Vendor Ledger Entry"; var VLERec: Record "Vendor Ledger Entry")
    var
        DtldVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        DtldVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
    begin
        DtldVendLedgEntry1.SetCurrentKey("Vendor Ledger Entry No.");
        DtldVendLedgEntry1.SetRange("Vendor Ledger Entry No.", CreateVendLedgEntry."Entry No.");
        DtldVendLedgEntry1.SetRange(Unapplied, false);
        if DtldVendLedgEntry1.Find('-') then
            repeat
                if DtldVendLedgEntry1."Vendor Ledger Entry No." =
                   DtldVendLedgEntry1."Applied Vend. Ledger Entry No."
                then begin
                    DtldVendLedgEntry2.Reset();
                    DtldVendLedgEntry2.SetCurrentKey("Applied Vend. Ledger Entry No.", "Entry Type");
                    DtldVendLedgEntry2.SetRange(
                      "Applied Vend. Ledger Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    DtldVendLedgEntry2.SetRange("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
                    DtldVendLedgEntry2.SetRange(Unapplied, false);
                    if DtldVendLedgEntry2.Find('-') then
                        repeat
                            if DtldVendLedgEntry2."Vendor Ledger Entry No." <>
                               DtldVendLedgEntry2."Applied Vend. Ledger Entry No."
                            then begin
                                VLERec.SetCurrentKey("Entry No.");
                                VLERec.SetRange("Entry No.", DtldVendLedgEntry2."Vendor Ledger Entry No.");
                                if VLERec.Find('-') then
                                    VLERec.Mark(true);
                            end;
                        until DtldVendLedgEntry2.Next() = 0;
                end else begin
                    VLERec.SetCurrentKey("Entry No.");
                    VLERec.SetRange("Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    if VLERec.Find('-') then
                        VLERec.Mark(true);
                end;
            until DtldVendLedgEntry1.Next() = 0;
    end;


    local procedure FindApplnEntriesDtldtLedgEntryCustomer(CreatedCustLedgEntry: Record "Cust. Ledger Entry")
    var
        DtldCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
    begin
        DtldCustLedgEntry1.SetCurrentKey("Cust. Ledger Entry No.");
        DtldCustLedgEntry1.SetRange("Cust. Ledger Entry No.", CreatedCustLedgEntry."Entry No.");
        DtldCustLedgEntry1.SetRange(Unapplied, false);
        if DtldCustLedgEntry1.Find('-') then
            repeat
                if DtldCustLedgEntry1."Cust. Ledger Entry No." =
                   DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                then begin
                    DtldCustLedgEntry2.Reset();
                    DtldCustLedgEntry2.SetCurrentKey("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SetRange(
                      "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldCustLedgEntry2.SetRange("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                    DtldCustLedgEntry2.SetRange(Unapplied, false);
                    if DtldCustLedgEntry2.Find('-') then
                        repeat
                            if DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                               DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                            then begin
                                CustLedgerEntry.SetCurrentKey("Entry No.");
                                CustLedgerEntry.SetRange("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                if CustLedgerEntry.Find('-') then
                                    CustLedgerEntry.Mark(true);
                            end;
                        until DtldCustLedgEntry2.Next() = 0;
                end else begin
                    CustLedgerEntry.SetCurrentKey("Entry No.");
                    CustLedgerEntry.SetRange("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    if CustLedgerEntry.Find('-') then
                        CustLedgerEntry.Mark(true);
                end;
            until DtldCustLedgEntry1.Next() = 0;
    end;

    local procedure GetGSTAmount(DocNo: Code[20]; PostDate: Date)
    var
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
    begin
        Clear(IGSSTAmt);
        Clear(CGSTAmt);
        Clear(SGSTAmt);
        DetailedGSTLedgerEntry.Reset();
        DetailedGSTLedgerEntry.SetRange("Document No.", DocNo);
        DetailedGSTLedgerEntry.SetRange("Entry Type", DetailedGSTLedgerEntry."Entry Type"::"Initial Entry");
        DetailedGSTLedgerEntry.SetRange("Posting Date", PostDate);
        if DetailedGSTLedgerEntry.FindSet() then begin
            repeat
                if (DetailedGSTLedgerEntry."GST Component Code" = CGSTLbl) then begin
                    CGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                end;

                if (DetailedGSTLedgerEntry."GST Component Code" = SGSTLbl) then begin
                    SGSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                end;

                if (DetailedGSTLedgerEntry."GST Component Code" = IGSTLbl) then begin
                    IGSSTAmt += Abs(DetailedGSTLedgerEntry."GST Amount");
                end;
            until DetailedGSTLedgerEntry.Next() = 0;
        end;
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

    local procedure GetTDSAmt(DocNo: Code[20])
    var
        TDSEntry: Record "TDS Entry";
    begin
        Clear(TDSAmt);
        TDSEntry.Reset();
        TDSEntry.SetRange("Document No.", DocNo);
        if TDSEntry.FindSet() then
            repeat
                TDSAmt += TDSEntry."Total TDS Including SHE CESS";
            until TDSEntry.Next() = 0;
    end;

    local procedure GetInvoiceAmount(VLEPar: Record "Vendor Ledger Entry"; var BasicAmt: Decimal)
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        PurchInvLine.Reset();
        PurchInvLine.SetRange("Document No.", VLEPar."Document No.");
        PurchInvLine.SetFilter("No.", '<>%1', '');
        if PurchInvLine.FindSet() then
            repeat
                BasicAmt += PurchInvLine.Amount;
            until PurchInvLine.Next() = 0;
    end;
}
report 50074 "Expenditure Details For Gst"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    Caption = 'Expenditure Details For Gst(Layout)';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\ExpenditureDetailsForGst.rdl';


    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            column(SlNoCap; SlNoCap)
            { }
            column(TotalAmountOfCap; TotalAmountOfCap)
            { }
            column(RelatingToGoodsCap; RelatingToGoodsCap)
            { }
            column(RelatingToEntitiesCap; RelatingToEntitiesCap)
            { }
            column(RelatingToOtherCap; RelatingToOtherCap)
            { }
            column(TotalPaymenttoCap; TotalPaymenttoCap)
            { }
            column(ExpenditureRelatingCap; ExpenditureRelatingCap)
            { }
            column(ExpenditureinrespectCap; ExpenditureinrespectCap)
            { }
            column(ExpenditurerelatedtoCap; ExpenditurerelatedtoCap)
            { }
            column(ExpensesAmount; ExpensesAmount) { }
            column(GSTExempted; GSTExempted) { }
            column(GSTComposition; GSTComposition) { }
            column(GSTRegistered; GSTRegistered) { }
            column(GSTPaid; GSTPaid) { }
            column(UnRegAmount; UnRegAmount) { }
            column(Salaries; Salaries) { }

            trigger OnAfterGetRecord()
            var
                GLAccount: Record "G/L Account";
                GSTLedgerEntries: Record "Detailed GST Ledger Entry";
                PostedGenJnl: Record "Posted Gen. Journal Line";
                PosDeb: Decimal;
                PosCrd: Decimal;
            begin
                Clear(ExpensesAmount);

                GLAccount.Reset();
                GLAccount.SetRange("Account Category", GLAccount."Account Category"::Expense);
                GLAccount.SetRange("Date Filter", StartDateGvar, EndDateGvar);
                GLAccount.SetLoadFields("No.", Balance);
                if GLAccount.FindSet() then
                    repeat
                        GLAccount.CalcFields(Balance);
                        ExpensesAmount := GLAccount.Balance;

                    until GLAccount.Next() = 0;


                Clear(GSTExempted);
                /*GSTLedgerEntries.Reset();
                GSTLedgerEntries.SetRange("Transaction Type", GSTLedgerEntries."Transaction Type"::Purchase);
                GSTLedgerEntries.SetRange("Posting Date", StartDateGvar, EndDateGvar);
                GSTLedgerEntries.SetRange("GST Exempted Goods", true);
                if GSTLedgerEntries.FindSet() then begin
                    GSTLedgerEntries.CalcSums("GST Base Amount");
                    GSTExempted := GSTLedgerEntries."GST Base Amount";
                end;*/

                VendorLedgerEntriesGrec.Reset();
                VendorLedgerEntriesGrec.SetRange("GST Vendor Type", VendorLedgerEntriesGrec."GST Vendor Type"::Exempted);
                VendorLedgerEntriesGrec.SetRange("Document Type", VendorLedgerEntriesGrec."Document Type"::Invoice);
                VendorLedgerEntriesGrec.SetRange("Posting Date", StartDateGvar, EndDateGvar);
                if VendorLedgerEntriesGrec.FindSet() then
                    repeat
                        detaildGstEntryGrec.Reset();
                        detaildGstEntryGrec.SetRange("Document No.", VendorLedgerEntriesGrec."Document No.");
                        detaildGstEntryGrec.SetRange("GST %", 0);
                        if detaildGstEntryGrec.FindFirst() then begin
                            PurchInvLineGrec.Reset();
                            PurchInvLineGrec.SetRange("Document No.", VendorLedgerEntriesGrec."Document No.");
                            PurchInvLineGrec.SetFilter(Type, '<>%1', PurchInvLineGrec.Type::" ");
                            if PurchInvLineGrec.FindSet() then
                                repeat
                                    GSTExempted += PurchInvLineGrec."Line Amount";
                                until PurchInvLineGrec.Next() = 0;
                        end;
                    until VendorLedgerEntriesGrec.Next() = 0;
                Clear(GSTComposition);
                GSTLedgerEntries.Reset();
                GSTLedgerEntries.SetRange("Transaction Type", GSTLedgerEntries."Transaction Type"::Purchase);
                GSTLedgerEntries.SetRange("Posting Date", StartDateGvar, EndDateGvar);
                GSTLedgerEntries.SetRange("GST Vendor Type", GSTLedgerEntries."GST Vendor Type"::Composite);
                if GSTLedgerEntries.FindSet() then begin
                    GSTLedgerEntries.CalcSums("GST Base Amount");
                    GSTComposition := GSTLedgerEntries."GST Base Amount";
                end;

                Clear(GSTRegistered);
                GSTLedgerEntries.Reset();
                GSTLedgerEntries.SetRange("Transaction Type", GSTLedgerEntries."Transaction Type"::Purchase);
                GSTLedgerEntries.SetRange("Posting Date", StartDateGvar, EndDateGvar);
                GSTLedgerEntries.SetRange("GST Vendor Type", GSTLedgerEntries."GST Vendor Type"::Registered);
                if GSTLedgerEntries.FindSet() then begin
                    GSTLedgerEntries.CalcSums("GST Base Amount");
                    GSTRegistered := GSTLedgerEntries."GST Base Amount";
                end;

                Clear(GSTPaid);
                GSTLedgerEntries.Reset();
                GSTLedgerEntries.SetRange("Transaction Type", GSTLedgerEntries."Transaction Type"::Purchase);
                GSTLedgerEntries.SetRange("Posting Date", StartDateGvar, EndDateGvar);
                GSTLedgerEntries.SetRange(Paid, true);
                if GSTLedgerEntries.FindSet() then begin
                    GSTLedgerEntries.CalcSums("GST Base Amount");
                    GSTPaid := GSTLedgerEntries."GST Base Amount";
                end;

                Clear(PosCrd);
                Clear(PosDeb);
                Clear(UnRegAmount);
                PostedGenJnl.Reset();
                PostedGenJnl.SetFilter("Debit Amount", '<>%1', 0);
                if PostedGenJnl.FindSet() then begin
                    PostedGenJnl.CalcSums("Debit Amount");
                    PosDeb := PostedGenJnl."Debit Amount";
                end;

                PostedGenJnl.Reset();
                PostedGenJnl.SetFilter("Credit Amount", '<>%1', 0);
                if PostedGenJnl.FindSet() then begin
                    PostedGenJnl.CalcSums("Credit Amount");
                    PosCrd := PostedGenJnl."Credit Amount";
                end;

                UnRegAmount := PosDeb + PosCrd;

                GLAccount.Reset();
                GLAccount.SetFilter("No.", '440080|430020|430030|430100');
                GLAccount.SetRange("Date Filter", StartDateGvar, EndDateGvar);
                GLAccount.SetLoadFields("No.", Balance);
                if GLAccount.FindSet() then
                    repeat
                        GLAccount.CalcFields(Balance);
                        Salaries += GLAccount.Balance;
                    until GLAccount.Next() = 0;
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
                    field(StartDateGvar; StartDateGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Start Date';
                    }
                    field(EndDateGvar; EndDateGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'End Date';
                    }

                }
            }
        }

    }


    trigger OnPreReport()
    begin
        if (StartDateGvar = 0D) or (EndDateGvar = 0D) then
            Error('Please Select Start Date and End Date');
    end;

    var
        myInt: Integer;
        SlNoCap: Label 'SlNo.';
        TotalAmountOfCap: Label 'Total amount of Expenditure incurred during the year';
        RelatingToGoodsCap: Label 'Relating to goods or Services exempt from GST';
        RelatingToEntitiesCap: Label 'Relating to entities falling under composition scheme';
        RelatingToOtherCap: Label 'Relating to other registered entities';
        TotalPaymenttoCap: Label 'Total payment to registered entities';
        ExpenditureRelatingCap: Label 'Expenditure relating to entities not registered under GST';
        ExpenditurerelatedtoCap: Label 'Expenditure related to Non GST Supplies(Example Salaries)';
        ExpenditureinrespectCap: Label 'Expenditure in respect of entities registered under GST';

        StartDateGvar: Date;
        EndDateGvar: Date;
        ExpensesAmount: Decimal;
        GSTExempted: Decimal;
        GSTComposition: Decimal;
        GSTRegistered: Decimal;
        GSTPaid: Decimal;
        UnRegAmount: Decimal;
        Salaries: Decimal;
        VendorLedgerEntriesGrec: Record "Vendor Ledger Entry";
        detaildGstEntryGrec: Record "Detailed GST Ledger Entry";

        PurchInvLineGrec: Record "Purch. Inv. Line";


}
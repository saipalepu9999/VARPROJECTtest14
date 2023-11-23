report 50063 FinancialStatement
{
    //UsageCategory = ReportsAndAnalysis;
   // ApplicationArea = All;
    Caption = 'Depreciation As Per Company(Layout)';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\FinancialStatement.rdl';

    dataset
    {
        dataitem(Integer; Integer)
        {
            MaxIteration = 1;
            column(DescriptionCapLbl; DescriptionCapLbl)
            { }
            column(GrossblockCapLbl; GrossblockCapLbl)
            { }
            column(DepreciationCapLbl; DepreciationCapLbl)
            { }
            column(NetblockCapLbl; NetblockCapLbl)
            { }
            column(AdditionsCapLbl; AdditionsCapLbl)
            { }
            column(DeletionsCapLbl; DeletionsCapLbl)
            { }
            column(chargeyearCapLbl; chargeyearCapLbl)
            { }
            column(DelectionCapLbl1; DelectionCapLbl1)
            { }
            column(AprilCapLbl; AprilCapLbl)
            { }
            column(MarchCapLbl; MarchCapLbl)
            { }
            column(PropertyCapLbl; PropertyCapLbl)
            { }
            column(TotalpropertyCapLbl; TotalpropertyCapLbl)
            { }
            column(IntangibleCapLbl; IntangibleCapLbl)
            { }
            column(TotalIntangibleCapLbl; TotalIntangibleCapLbl)
            { }
            column(CapitalCapLbl; CapitalCapLbl)
            { }
            column(TotalCapitalCapLbl; TotalCapitalCapLbl)
            { }
            column(TotalCapLbl; TotalCapLbl)
            { }
        }
        dataitem("Financials B2B Setup"; "Financials B2B Setup")
        {
            column(TotalCode_FinancialsB2BSetup; "Total Code")
            {
            }
            column(Description_FinancialsB2BSetup; Description)
            {
            }
            column(AsAtValue; AsAtValue)
            {
            }
            column(GrossBlockAddValue; GrossBlockAddValue)
            {
            }
            column(GrossBlockDelValue; GrossBlockDelValue)
            {
            }
            column(AccDepAsAtValue; AccDepAsAtValue)
            {
            }
            column(AccDepAddValue; AccDepAddValue)
            {
            }
            column(AccDepDelValue; AccDepDelValue)
            {
            }
            column(GroupHeaderCap; GroupHeaderCap)
            {
            }
            column(GroupTotalCap; GroupTotalCap)
            {
            }

            trigger OnPreDataItem()
            begin
                if StartDate = 0D then
                    StartDate := WorkDate();

                if Date2DMY(StartDate, 2) <= 3 then begin
                    FinancialYrStart := DMY2Date(01, 04, Date2DMY(StartDate, 3) - 1);
                    FinancialYrEnd := DMY2Date(31, 03, Date2DMY(StartDate, 3));
                end else begin
                    FinancialYrStart := DMY2Date(01, 04, Date2DMY(StartDate, 3));
                    FinancialYrEnd := DMY2Date(31, 03, Date2DMY(StartDate, 3) + 1)
                end;
            end;

            trigger OnAfterGetRecord()
            var
                GLAcc: Record "G/L Account";
                GLEntry: Record "G/L Entry";
                FALedEntry: Record "FA Ledger Entry";
            begin
                ClearValues();

                case "Total Code" of
                    'A':
                        begin
                            GroupHeaderCap := '(a) Property, plant and equipment';
                            GroupTotalCap := 'Total Property, plant and equipment (A)';
                        end;

                    'B':
                        begin
                            GroupHeaderCap := '(b) Intangible assets';
                            GroupTotalCap := 'Total intangibles assets (B)';
                        end;

                    'C':
                        begin
                            GroupHeaderCap := '(c) Capital Work in Progress';
                            GroupTotalCap := 'Total Capital Work in Progress (C)';
                        end;

                end;

                //Gross Block As At Value
                GLAcc.Reset();
                GLAcc.SetRange("No.", "Financials B2B Setup"."Gross Block As At Account");
                GLAcc.SetFilter("Date Filter", '..%1', FinancialYrStart);
                if GLAcc.FindSet() then begin
                    GLAcc.CalcFields("Balance at Date");
                    AsAtValue := GLAcc."Balance at Date"
                end;

                //Gross Block Additions
                FALedEntry.Reset();
                FALedEntry.SetRange("FA Posting Type", FALedEntry."FA Posting Type"::"Acquisition Cost");
                FALedEntry.SetRange("Posting Date", FinancialYrStart, FinancialYrEnd);
                if FALedEntry.FindSet() then
                    repeat
                        GLEntry.Reset();
                        GLEntry.SetRange("Document No.", FALedEntry."Document No.");
                        GLEntry.SetRange("G/L Account No.", "Financials B2B Setup"."Gross Block Additions");
                        if GLEntry.FindSet() then begin
                            GLEntry.CalcSums(Amount);
                            AccDepAddValue := GLEntry.Amount;
                        end;
                    until FALedEntry.Next() = 0;


                //Gross Block Deletion
                FALedEntry.Reset();
                FALedEntry.SetRange("FA Posting Type", FALedEntry."FA Posting Type"::"Proceeds on Disposal"); // need to change
                FALedEntry.SetRange("Posting Date", FinancialYrStart, FinancialYrEnd);
                if FALedEntry.FindSet() then
                    repeat
                        GLEntry.Reset();
                        GLEntry.SetRange("Document No.", FALedEntry."Document No.");
                        GLEntry.SetRange("G/L Account No.", "Financials B2B Setup"."Gross Block Deletions");
                        if GLEntry.FindSet() then begin
                            GLEntry.CalcSums(Amount);
                            AccDepAddValue := GLEntry.Amount;
                        end;
                    until FALedEntry.Next() = 0;

                //Acc Dept. As At Value
                GLAcc.Reset();
                GLAcc.SetRange("No.", "Financials B2B Setup"."Gross Block As At Account");
                GLAcc.SetFilter("Date Filter", '..%1', FinancialYrStart);
                if GLAcc.FindSet() then begin
                    GLAcc.CalcFields("Balance at Date");
                    AsAtValue := GLAcc."Balance at Date"
                end;
                //Acc Dept. Additions
                FALedEntry.Reset();
                FALedEntry.SetRange("FA Posting Type", FALedEntry."FA Posting Type"::"Acquisition Cost");
                FALedEntry.SetRange("Posting Date", FinancialYrStart, FinancialYrEnd);
                if FALedEntry.FindSet() then
                    repeat
                        GLEntry.Reset();
                        GLEntry.SetRange("Document No.", FALedEntry."Document No.");
                        GLEntry.SetRange("G/L Account No.", "Financials B2B Setup"."Acc Dep. Additions");
                        if GLEntry.FindSet() then begin
                            GLEntry.CalcSums(Amount);
                            AccDepAddValue := GLEntry.Amount;
                        end;
                    until FALedEntry.Next() = 0;


                //Acc Dept. Deletion
                FALedEntry.Reset();
                FALedEntry.SetRange("FA Posting Type", FALedEntry."FA Posting Type"::"Proceeds on Disposal"); // need to change
                FALedEntry.SetRange("Posting Date", FinancialYrStart, FinancialYrEnd);
                if FALedEntry.FindSet() then
                    repeat
                        GLEntry.Reset();
                        GLEntry.SetRange("Document No.", FALedEntry."Document No.");
                        GLEntry.SetRange("G/L Account No.", "Financials B2B Setup"."Acc Dep. Deletions");
                        if GLEntry.FindSet() then begin
                            GLEntry.CalcSums(Amount);
                            AccDepAddValue := GLEntry.Amount;
                        end;
                    until FALedEntry.Next() = 0;



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
                    ShowCaption = false;
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                    }
                }
            }
        }
    }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    local procedure ClearValues()
    begin
        Clear(AsAtValue);
        Clear(GrossBlockAddValue);
        Clear(GrossBlockDelValue);
        Clear(AccDepAsAtValue);
        Clear(AccDepAddValue);
        Clear(AccDepDelValue);
    end;

    var
        DescriptionCapLbl: Label 'Description';
        GrossblockCapLbl: Label 'Gross block';
        DepreciationCapLbl: Label 'Accumulated depreciation / amortisation';
        NetblockCapLbl: Label 'Net block';
        AdditionsCapLbl: Label 'Additions';
        DeletionsCapLbl: Label 'Deletions';
        chargeyearCapLbl: Label 'Charge for the Year';
        DelectionCapLbl1: Label 'Deletions';
        AprilCapLbl: Label 'As at 1 April 2021';
        MarchCapLbl: Label 'As at 31 March 2021';
        PropertyCapLbl: Label '(a) Property, plant and equipment';
        TotalpropertyCapLbl: Label 'Total Property, plant and equipment(A)';
        IntangibleCapLbl: Label '(b) Intangible assests';
        TotalIntangibleCapLbl: Label 'Total intangibles assests(B)';
        CapitalCapLbl: Label '(c) Capital Work in Progress';
        TotalCapitalCapLbl: Label 'Total Capital Work in Progress(C)';
        TotalCapLbl: Label 'Total(A+B+C)';
        AsAtValue: Decimal;
        GrossBlockAddValue: Decimal;
        GrossBlockDelValue: Decimal;
        AccDepAsAtValue: Decimal;
        AccDepAddValue: Decimal;
        AccDepDelValue: Decimal;
        FinancialYrStart: Date;
        FinancialYrEnd: Date;
        GroupHeaderCap: Text[500];
        GroupTotalCap: Text[500];
        StartDate: Date;

}
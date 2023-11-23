report 50071 "Fixed Asset Register Cust"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fixed Asset Register';
    //DefaultRenderingLayout = LayoutName;
    DefaultLayout = RDLC;

    RDLCLayout = 'Report\Layouts\Fixed Asset Register.rdl';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {

            column(No_; "No.")
            {
            }
            column(PostingdateofAcquitsion; PostingdateofAcquitsion)
            { }
            column(FALedgerEntryGrec; FALedgerEntryGrec.Amount)
            { }
            column(AcquitsionCost; AcquitsionCost)
            {

            }
            column(FALedgerEntryGrecDBC; FALedgerEntryGrec."Depreciation Book Code")
            {

            }
            column(FALedgerEntryGrecFANO; FALedgerEntryGrec."FA No.")
            { }


            column(FA_Subclass_Code; "FA Subclass Code")
            {

            }
            column(FA_Class_Code; "FA Class Code")
            {

            }
            column(FA_Posting_Group; "FA Posting Group")
            {

            }
            column(DateofPurchaseCap; DateofPurchaseCap)
            { }
            column(FixedAssetNoCap; FixedAssetNoCap)
            {

            }
            column(AssetDescreptionCap; AssetDescreptionCap)
            { }
            column(PostingGroupCap; PostingGroupCap)
            { }
            column(FAClassCodeCap; FAClassCodeCap)
            { }
            column(FASubclassCap; FASubclassCap)
            { }
            column(OriginalcostCap; OriginalcostCap)
            { }
            column(SalvageValueCap; SalvageValueCap)
            { }
            column(Description; Description)
            { }
            column(DepricationbookCap; DepricationbookCap)
            { }
            column(DepriAmouasondaCap; DepriAmouasondaCap)
            { }
            column(CurBoValueCap; CurBoValueCap)
            { }
            column(DateofPurchase; DateofPurchase)
            { }
            column(BookValue; BookValue)
            { }

            column(FADepreciationBookGrec_Book; FADepreciationBookGrec."Depreciation Book Code")
            { }
            column(DepreciationCost; DepreciationCost)
            { }
            column(SalvageValue; SalvageValue)
            { }

            trigger OnAfterGetRecord()
            begin
                //Clear(FALedgerEntryGrec);
                //Clear(PostingdateofAcquitsion);
                Clear(AcquitsionCost);
                FALedgerEntryGrec.Reset();
                FALedgerEntryGrec.SetRange("FA No.", "No.");
                FALedgerEntryGrec.SetRange("FA Posting Type", FALedgerEntryGrec."FA Posting Type"::"Acquisition Cost");
                IF FALedgerEntryGrec.FindSet() then begin
                    PostingdateofAcquitsion := FALedgerEntryGrec."FA Posting Date";
                    FALedgerEntryGrec.CalcSums(Amount);
                    AcquitsionCost += FALedgerEntryGrec.Amount;


                end;

                clear(BookValue);
                FADepreciationBookGrec.Reset();
                FADepreciationBookGrec.SetRange("FA No.", "No.");
                FADepreciationBookGrec.SetRange("Depreciation Book Code", FALedgerEntryGrec."Depreciation Book Code");
                if FADepreciationBookGrec.FindSet() then begin
                    FADepreciationBookGrec.CalcFields("Book Value");
                    BookValue := FADepreciationBookGrec."Book Value";
                end;

                clear(DepreciationCost);
                FALedgerEntryGrec.Reset();
                FALedgerEntryGrec.SetRange("FA No.", "No.");
                FALedgerEntryGrec.SetRange("FA Posting Type", FALedgerEntryGrec."FA Posting Type"::Depreciation);
                FALedgerEntryGrec.SetFilter("FA Posting Date", '..%1', WorkDate());
                IF FALedgerEntryGrec.FindSet() then begin
                    FALedgerEntryGrec.CalcSums(Amount);
                    DepreciationCost := FALedgerEntryGrec.Amount;
                end;

                clear(SalvageValue);
                FALedgerEntryGrec.Reset();
                FALedgerEntryGrec.SetRange("FA No.", "No.");
                FALedgerEntryGrec.SetRange("FA Posting Type", FALedgerEntryGrec."FA Posting Type"::"Salvage Value");
                FALedgerEntryGrec.SetFilter("FA Posting Date", '..%1', WorkDate());
                IF FALedgerEntryGrec.FindSet() then begin
                    FALedgerEntryGrec.CalcSums(Amount);
                    SalvageValue := FALedgerEntryGrec.Amount;
                end;

            end;

        }
    }

    /*requestpage
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
    }
    
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }*/

    var
        myInt: Integer;
        FALedgerEntryGrec: Record "FA Ledger Entry";
        FADepreciationBookGrec: Record "FA Depreciation Book";
        PostingdateofAcquitsion: Date;
        DateofPurchaseCap: Label 'Date of Purchase';
        FixedAssetNoCap: Label 'Fixed Asset No.';
        AssetDescreptionCap: Label 'Asset Descreption';
        PostingGroupCap: Label 'Posting Group';
        FAClassCodeCap: Label 'FA Class Code';
        FASubclassCap: Label 'FA Sub class';
        OriginalcostCap: Label 'Original cost';
        SalvageValueCap: Label 'Salvage Value';
        DepricationbookCap: Label 'Deprication book';
        DepriAmouasondaCap: Label 'Deprication Amount as on date';
        CurBoValueCap: Label 'Current Book Value';
        DateofPurchase: Label 'Date of Purchase';
        AcquitsionCost: Decimal;
        BookValue: Decimal;
        DepreciationCost: Decimal;
        SalvageValue: Decimal;




}
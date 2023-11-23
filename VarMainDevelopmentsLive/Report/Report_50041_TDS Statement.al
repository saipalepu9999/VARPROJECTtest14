report 50041 "TDS Statement"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\TDSStatement.rdl';
    dataset
    {
        dataitem("TDS Entry"; "TDS Entry")
        {
            RequestFilterFields = "Posting Date";
            column(PanNoCapLbl; PanNoCapLbl)
            { }
            column(NameOfTheSupplierCapLbl; NameOfTheSupplierCapLbl)
            { }
            column(SNoCapLbl; SNoCapLbl)
            { }
            column(BillNoCapLbl; BillNoCapLbl)
            { }
            column(DateCapLbl; DateCapLbl)
            { }
            column(DescriptionCapLbl; DescriptionCapLbl)
            { }
            column(TaxableAmount; TaxableAmount)
            { }
            column(TDSAmountCapLbl; TDSAmountCapLbl)
            { }
            column(TaxCapLbl; TaxCapLbl)
            { }
            column(Document_No_; "Document No.")
            { }
            column(Section; Section)
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(TDS_Base_Amount; "TDS Base Amount")
            { }
            column(TDS_Amount; "TDS Amount")
            { }
            column(TDS__; "TDS %")
            { }
            column(Deductee_PAN_No_; "Deductee PAN No.")
            { }
            column(VendorName; VendorName)
            { }
            column(CompanyInfo_Name; CompanyInfo.Name)
            { }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            { }
            column(BillNoGvar; BillNoGvar)
            { }
            column(DescriptionGvar; DescriptionGvar)
            { }
            column(VarText; VarText)
            { }
            trigger OnPreDataItem()
            begin
                SetFilter("Document Type", '%1|%2|%3', "Document Type"::" ", "Document Type"::Invoice, "Document Type"::Payment);
                SetCurrentKey(Section);
                DateGVar := GetRangeMin("Posting Date");
                //Message('%1', Format(DateGVar));
                VarText := StrSubstNo(VarCapLbl, FORMAT(DateGVar, 0, '<Month Text> <Year4>'));
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(VendorName);
                Clear(BillNoGvar);
                Clear(DescriptionGvar);
                if VendorGrec.get("Vendor No.") then
                    VendorName := VendorGrec.Name;
                PurchInvLine.Reset();
                PurchInvLine.SetRange("Document No.", "Document No.");
                PurchInvLine.SetFilter("No.", '<>%1', '');
                if PurchInvLine.FindFirst() then begin
                    DescriptionGvar := PurchInvLine.Description;
                    if PurchInvHdr.Get(PurchInvLine."Document No.") then
                        BillNoGvar := PurchInvHdr."Vendor Invoice No.";
                end;

                if BillNoGvar = '' then
                    BillNoGvar := "TDS Entry"."Document No.";
            end;
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.get();
        CompanyInfo.CalcFields(Picture);
    end;
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
    }*/
    var
        VendorGrec: Record Vendor;
        CompanyInfo: Record "Company Information";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchInvHdr: Record "Purch. Inv. Header";
        VendorName: Text;
        BillNoGvar: Text;
        DescriptionGvar: Text;
        DateGVar: Date;
        PanNoCapLbl: Label 'PAN No.';
        NameOfTheSupplierCapLbl: Label 'Name Of The Supplier';
        SNoCapLbl: Label 'S.No.';
        BillNoCapLbl: Label 'Bill No.';
        DateCapLbl: Label 'Date';
        DescriptionCapLbl: Label 'Description';
        TaxableAmount: Label 'Taxable Amount';
        TDSAmountCapLbl: Label 'TDS Amount';
        TaxCapLbl: Label 'Tax %';
        VarCapLbl: Label 'VAR ELECTROCHEM PVT. LTD. TDS  STATEMENT  FOR THE MONTH OF %1 ';
        VarText: Text;
}
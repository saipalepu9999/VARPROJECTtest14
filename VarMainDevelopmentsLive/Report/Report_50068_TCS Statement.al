report 50068 "TCS Statement"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\TCSStatement.rdl';
    dataset
    {
        dataitem("TCS Entry"; "TCS Entry")
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
            column(TDSAmountCapLbl; TCSAmountCapLbl)
            { }
            column(TaxCapLbl; TaxCapLbl)
            { }
            column(Document_No_; "Document No.")
            { }
            column(Section; "TCS Nature of Collection")
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(TCS_Base_Amount; "TCS Base Amount")
            { }
            column(TCS_Amount; "TCS Amount")
            { }
            column(TCS__; "TCS %")
            { }
            column(Customer_P_A_N__No_; "Customer P.A.N. No.")
            { }
            column(CustomerName; CustomerName)
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
                SetCurrentKey("TCS Nature of Collection");
                DateGVar := GetRangeMin("Posting Date");
                //Message('%1', Format(DateGVar));
                VarText := StrSubstNo(VarCapLbl, FORMAT(DateGVar, 0, '<Month Text> <Year4>'), FORMAT(CalcDate('<-1Y>', DateGVar), 0, '<Year4>'), FORMAT(DateGVar, 0, '<Year4>'));
            end;

            trigger OnAfterGetRecord()
            begin
                Clear(CustomerName);
                Clear(BillNoGvar);
                Clear(DescriptionGvar);
                if CustomerGrec.get("Customer No.") then
                    CustomerName := CustomerGrec.Name;
                /*PurchInvLine.Reset();
                PurchInvLine.SetRange("Document No.", "Document No.");
                PurchInvLine.SetFilter("No.", '<>%1', '');
                if PurchInvLine.FindFirst() then begin
                    DescriptionGvar := PurchInvLine.Description;
                    if PurchInvHdr.Get(PurchInvLine."Document No.") then
                        BillNoGvar := PurchInvHdr."Vendor Invoice No.";
                end;*/
                SaleInvLine.Reset();
                SaleInvLine.SetRange("Document No.", "Document No.");
                SaleInvLine.SetFilter("No.", '<>%1', '');
                if SaleInvLine.FindFirst() then begin
                    DescriptionGvar := SaleInvLine.Description;
                    if salesInvHdr.Get(SaleInvLine."Document No.") then
                        BillNoGvar := salesInvHdr."External Document No."
                end;

                if BillNoGvar = '' then
                    BillNoGvar := "TCS Entry"."Document No.";
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
        CustomerGrec: Record Customer;
        CompanyInfo: Record "Company Information";
        //PurchInvLine: Record "Purch. Inv. Line";
        //PurchInvHdr: Record "Purch. Inv. Header";
        CustomerName: Text;
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
        TCSAmountCapLbl: Label 'TCS Amount';
        TaxCapLbl: Label 'Tax %';
        VarCapLbl: Label 'VAR ELECTROCHEM PVT. LTD. TCS  STATEMENT  FOR THE MONTH OF %1  (%2-%3)';
        VarText: Text;
        SaleInvLine: Record "Sales Invoice Line";
        salesInvHdr: Record "Sales Invoice Header";
}
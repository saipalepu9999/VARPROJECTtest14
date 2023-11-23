report 50092 "FD Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\FD Report.rdl';

    dataset
    {
        dataitem("Fixed Deposit_B2B"; "Fixed Deposit_B2B")
        {
            RequestFilterFields = "Maturity Date", "FD Date";
            column(CompanyName; CompanyInfo.Name)
            { }
            column(FD_No_; "FD No.")
            { }
            column(FD_Amount; "FD Amount")
            { }
            column(FD_Date; "FD Date")
            { }
            column(FD_Type; "FD Type")
            { }
            column(Maturity_Date; "Maturity Date")
            { }
            column(Maturity_Value; "Maturity Value")
            { }
            column(Status; Status)
            { }
            column(FD_Intrest_Amount; "FD Intrest Amount")
            { }
            column(TDS_Receivable_Amount; "TDS Receivable Amount")
            { }
            column(TitleCapLbl; TitleCapLbl)
            { }
            column(SerialNum; SerialNum)
            { }
            column(FDnumCapLbl; FDnumCapLbl)
            { }
            column(FDAmouCapLbl; FDAmouCapLbl)
            { }
            column(FDdateCapLbl; FDdateCapLbl)
            { }
            column(FDTypeCapLbl; FDTypeCapLbl)
            { }
            column(MaturityCapLbl; MaturityCapLbl)
            { }
            column(MaturValuCapLbl; MaturValuCapLbl)
            { }
            column(InterestCapLbl; InterestCapLbl)
            { }
            column(TDSReceiCapLbl; TDSReceiCapLbl)
            { }
            column(RemarksCapLbl; RemarksCapLbl)
            { }
            column(BankNameCapLbl; BankNameCapLbl)
            { }
            column(BankNameVar; BankNameVar)
            { }
            trigger OnAfterGetRecord()
            begin
                if BankAccountRec.get("Account No") then
                    BankNameVar := BankAccountRec.Name;
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

                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
        BankAccountRec: Record "Bank Account";
        BankNameVar: Text[30];
        TitleCapLbl: Label 'FD DETAILS';
        SerialNum: Label 'S.No';
        FDnumCapLbl: Label 'FD NO.';
        FDAmouCapLbl: Label 'FD AMOUNT';
        FDdateCapLbl: Label 'FD DATE';
        FDTypeCapLbl: Label 'FD TYPE';
        MaturityCapLbl: Label 'Maturity date';
        MaturValuCapLbl: Label 'Maturity Value';
        InterestCapLbl: Label 'Intrest';
        TDSReceiCapLbl: Label 'TDS Receivable';
        RemarksCapLbl: Label 'Remarks';
        BankNameCapLbl: Label 'Bank Name';

}
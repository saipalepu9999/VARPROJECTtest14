report 50062 "Trial Balance WS"
{
    // version WINSPIRE

    DefaultLayout = RDLC;
    Caption = 'Trail Balance New';
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Report\Layouts\Trial Balance WS.rdl';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            CalcFields = "Net Change", "Balance at Date";
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Account Type" = FILTER(Posting));
            RequestFilterFields = "No.", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            column(CompanyInfo_Name; CompanyInfo.Name)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(RepFilter; RepFilter)
            {
            }
            column(G_L_Account__No__; "No.")
            {
            }
            column(VarTranDr; VarTranDr)
            {
            }
            column(VarTranCr; VarTranCr)
            {
            }
            column(VarCloseDr; VarCloseDr)
            {
            }
            column(VarCloseCr; VarCloseCr)
            {
            }
            column(VarOpenCr; VarOpenCr)
            {
            }
            column(VarOpenDr; VarOpenDr)
            {
            }
            column(TotVarOpenDr; TotVarOpenDr)
            {
            }
            column(TotVarOpenCrS; TotVarOpenCr)
            {
            }
            column(TotVarTranDr; TotVarTranDr)
            {
            }
            column(TotVarTranCr; TotVarTranCr)
            {
            }
            column(TotVarCloseDr; TotVarCloseDr)
            {
            }
            column(TotVarCloseCr; TotVarCloseCr)
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(G_L_Account__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(TransactionCaption; TransactionCaptionLbl)
            {
            }
            column(DrCaption; DrCaptionLbl)
            {
            }
            column(CrCaption; CrCaptionLbl)
            {
            }
            column(OpeningCaption; OpeningCaptionLbl)
            {
            }
            column(DrCaption_Control1102159024; DrCaption_Control1102159024Lbl)
            {
            }
            column(CrCaption_Control1102159025; CrCaption_Control1102159025Lbl)
            {
            }
            column(CrCaption_Control1102159026; CrCaption_Control1102159026Lbl)
            {
            }
            column(ClosingCaption; ClosingCaptionLbl)
            {
            }
            column(DrCaption_Control1102159027; DrCaption_Control1102159027Lbl)
            {
            }
            column(End_of_ReportCaption; End_of_ReportCaptionLbl)
            {
            }
            column(Name_GLAccount; "G/L Account".Name)
            {
            }

            trigger OnAfterGetRecord();
            begin
                CompanyInfo.GET;
                VarOpenDr := 0;
                VarOpenCr := 0;
                VarTranDr := 0;
                VarTranCr := 0;
                VarCloseDr := 0;
                VarCloseCr := 0;


                IF "G/L Account"."Net Change" >= 0 THEN
                    VarTranDr := "G/L Account"."Net Change"
                ELSE
                    VarTranCr := "G/L Account"."Net Change" * -1;



                IF "G/L Account"."Balance at Date" >= 0 THEN
                    VarCloseDr := "G/L Account"."Balance at Date"
                ELSE
                    VarCloseCr := "G/L Account"."Balance at Date" * -1;

                CLEAR(RsGL);
                RsGL.SETFILTER(RsGL."No.", "G/L Account"."No.");
                IF RsGL.FINDFIRST THEN BEGIN
                    RsGL.SETRANGE(RsGL."Date Filter", 0D, CLOSINGDATE(VarDate - 1));
                    RsGL.CALCFIELDS(RsGL."Balance at Date");

                    IF RsGL."Balance at Date" >= 0 THEN
                        VarOpenDr := RsGL."Balance at Date"
                    ELSE
                        VarOpenCr := RsGL."Balance at Date" * -1;


                    OpeningAmount := VarOpenDr - VarOpenCr;

                END;

                if (VarOpenCr = 0) and (VarOpenDr = 0) and (VarTranCr = 0) and (VarTranDr = 0) and (VarCloseDr = 0) and (VarCloseCr = 0) then
                    CurrReport.Skip();


                TotVarOpenDr += VarOpenDr;
                TotVarOpenCr += VarOpenCr;

                TotVarTranDr += VarTranDr;
                TotVarTranCr += VarTranCr;

                TotVarCloseDr += VarCloseDr;
                TotVarCloseCr += VarCloseCr;


            end;

            trigger OnPreDataItem();
            begin
                VarDate := 0D;
                VarDate := "G/L Account".GETRANGEMIN("G/L Account"."Date Filter");

                RepFilter := '';
                RepFilter := 'Report Filter : ' + "G/L Account".GETFILTERS;

                IF RepFilter = '' THEN
                    RepFilter := 'ALL';


                TotVarOpenDr := 0;
                TotVarOpenCr := 0;
                TotVarTranDr := 0;
                TotVarTranCr := 0;
                TotVarCloseDr := 0;
                TotVarCloseCr := 0;

                IF PrintToExcel = TRUE THEN BEGIN
                    ExcelBuf.DELETEALL;
                    Row := 1;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport();
    begin
        /*
        IF PrintToExcel=TRUE THEN BEGIN
          ExcelBuf.RESET;
          ExcelBuf.CreateBook;
          ExcelBuf.CreateSheet('Trial Balance','Trial Balance',COMPANYNAME,USERID);
          ExcelBuf.GiveUserControl;
        END;
        */

    end;

    trigger OnPreReport();
    begin
        //PrintHead:=FALSE;
    end;

    var
        VarOpenDr: Decimal;
        VarOpenCr: Decimal;
        VarTranDr: Decimal;
        VarTranCr: Decimal;
        VarCloseDr: Decimal;
        VarCloseCr: Decimal;
        RsGL: Record "G/L Account";
        VarDate: Date;
        RepFilter: Text[200];
        TotVarOpenDr: Decimal;
        TotVarOpenCr: Decimal;
        TotVarTranDr: Decimal;
        TotVarTranCr: Decimal;
        TotVarCloseDr: Decimal;
        TotVarCloseCr: Decimal;
        ExcelBuf: Record "Excel Buffer";
        PrintToExcel: Boolean;
        Row: Integer;
        PrintHead: Boolean;
        Trial_BalanceCaptionLbl: Label 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
        TransactionCaptionLbl: Label 'Transaction';
        DrCaptionLbl: Label 'Dr';
        CrCaptionLbl: Label 'Cr';
        OpeningCaptionLbl: Label 'Opening';
        DrCaption_Control1102159024Lbl: Label 'Dr';
        CrCaption_Control1102159025Lbl: Label 'Cr';
        CrCaption_Control1102159026Lbl: Label 'Cr';
        ClosingCaptionLbl: Label 'Closing';
        DrCaption_Control1102159027Lbl: Label 'Dr';
        End_of_ReportCaptionLbl: Label 'End of Report';
        CompanyInfo: Record "Company Information";
        OpeningAmount: Decimal;
}


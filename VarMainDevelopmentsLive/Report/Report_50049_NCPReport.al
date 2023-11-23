report 50049 "NCP Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\NCP Report.rdl';
    dataset
    {
        dataitem(NCPR; NCPR)
        {
            //DataItemTableView = where(Status = filter(true));
            RequestFilterFields = "No.";
            column(No_; "No.")
            { }
            column(AuthorizedApprovedBy_NCPR; "Authorized/Approved By")
            {
            }
            column(CorrctiveInitiatedBy_NCPR; "Corrctive Initiated By")
            {
            }
            column(CorrectiveActionImplemenetd_NCPR; "Corrective Action Implemenetd")
            {
            }
            column(CorrectiveActionPlanned_NCPR; "Corrective Action Planned")
            {
            }
            column(DescriptionInitiatedBy_NCPR; "Description Initiated By")
            {
            }
            column(CorrectiveInitiatedDate_NCPR; "Corrective Initiated Date")
            {
            }
            column(DescriptionInitiatedDate_NCPR; "Description Initiated Date")
            {
            }
            column(DescriptionOfProduct_NCPR; "Description Of Product")
            {
            }
            column(FollowUpAudit_NCPR; "Follow Up Audit")
            {
            }
            column(IRDate_NCPR; "IR Date")
            {
            }
            column(IRNo_NCPR; "IR No.")
            {
            }
            column(MRVDate_NCPR; "MRV Date")
            {
            }
            column(MRVNo_NCPR; "MRV No.")
            {
            }
            column(NcprClosedNotClosed_NCPR; "Ncpr Closed/Not Closed")
            {
            }
            column(PartyName_NCPR; "Party Name")
            {
            }
            column(TobeimplementedbyInhouse_NCPR; "Tobeimplementedby(In house):")
            {
            }
            column(ProductDescription_NCPR; "Product Description")
            {
            }
            column(Reference_NCPR; Reference)
            {
            }
            column(Regrade_NCPR; Regrade)
            {
            }
            column(NoSeries_NCPR; "No. Series")
            {
            }
            column(RejectReturnToVendor_NCPR; "Reject&Return To Vendor")
            {
            }
            column(RejectScrap_NCPR; "Reject&Scrap")
            {
            }
            column(Rework_NCPR; Rework)
            {
            }
            column(RootCause_NCPR; "Root Cause")
            {
            }
            column(ToBeImplementedDate_NCPR; "To Be Implemented Date")
            {
            }
            column(ToBeImplemetedBy_NCPR; "To Be Implemeted By")
            {
            }

            column(CompanyLogo; CompanyInfo.Picture)
            { }
            column(CompanyNameCap; CompanyNameCap)
            { }
            column(VEPLCap; VEPLCap)
            { }
            column(NoCap; NoCap)
            { }
            column(DateCap; DateCap)
            { }
            column(ProdDesCap; ProdDesCap)
            { }
            column(ReferCap; ReferCap)
            { }
            column(MrvNoCap; MrvNoCap)
            { }
            column(DatedCap; DatedCap)
            { }
            column(PartyNameCap; PartyNameCap)
            { }
            column(DescriptionCap; DescriptionCap)
            { }
            column(InitiCap; InitiCap)
            { }
            column(DispositionCap; DispositionCap)
            { }
            column(ReworkCap; ReworkCap)
            { }
            column(RegradeCap; RegradeCap)
            { }
            column(RejectReturnCap; RejectReturnCap)
            { }
            column(RecectScrapCap; RecectScrapCap)
            { }
            column(AuthorizeCap; AuthorizeCap)
            { }
            column(RootCauseCap; RootCauseCap)
            { }
            column(CorrectivePlanCap; CorrectivePlanCap)
            { }
            column(CorrectiveImpntCap; CorrectiveImpntCap)
            { }
            column(ToBeImpntCap; ToBeImpntCap)
            { }
            column(FollowUpAudCap; FollowUpAudCap)
            { }
            column(NCPRCap; NCPRCap)
            { }
            column(AcceptCap; AcceptCap)
            { }
            column(RejectCap; RejectCap)
            { }
            column(SignInitCap; SignInitCap)
            { }
            column(SignMRCap; SignMRCap)
            { }
            column(PurchRcptDate; PurchRcptDate)
            { }
            column(Description; Description) //B2BVCOn14Mar2023
            { }
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
    }*/

    var
        CompanyInfo: Record "Company Information";
        CompanyNameCap: Label 'NON-CONFORMING PRODUCT REPORT';
        VEPLCap: Label 'VEPL/NCP_NCPR/00';
        NoCap: Label 'NO:';
        DateCap: Label 'DATE:';
        ProdDesCap: Label 'PRODUCT DESCRIPTION:';
        ReferCap: Label 'REFERENCE';
        MrvNoCap: Label 'MRV No.';
        DatedCap: Label 'Dated:';
        PartyNameCap: Label 'Party Name:';
        DescriptionCap: Label 'DESCRIPTION OF NON-CONFORMANCE OF THE PRODUCT:';
        InitiCap: Label 'INITIATED BY:';
        DispositionCap: Label 'DISPOSITION';
        AuthorizeCap: Label 'AUTHORIZED / APPROVED BY:';
        RootCauseCap: Label 'ROOT CAUSE (ON INVESTIGATION):';
        CorrectivePlanCap: Label 'CORRECTIVE ACTION PLANNED:';
        CorrectiveImpntCap: Label 'CORRECTIVE ACTION IMPLEMENTED:';
        ToBeImpntCap: Label 'TO BE IMPLEMENTED BY:';
        FollowUpAudCap: Label 'FOLLOW - UP AUDIT:';
        NCPRCap: Label 'NCPR CLOSED / NOT CLOSED';
        AcceptCap: Label 'ACCEPTED';
        RejectCap: Label 'REJECTED';
        SignInitCap: Label 'SIGN OF INITIATOR';
        SignMRCap: Label 'SIGNATURE OF MR';
        ReworkCap: Label '( )REWORK';
        RegradeCap: Label '( )REGRADE';
        RejectReturnCap: Label '(  ) REJECT AND RETURN TO VENDOR';
        RecectScrapCap: Label '( )REJECT AND SCRAP';
        PurchaseRcptHdr: Record "Purch. Rcpt. Header";
        PurchRcptDate: Date;

    trigger OnPreReport()
    begin
        if CompanyInfo.Get() then
            CompanyInfo.CalcFields(Picture);
    end;
}
report 50026 "Material Requsition Slip"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Material Requsition Slip';
    RDLCLayout = 'Report\Layouts\Material Requsition Slip.rdl';



    dataset

    {

        dataitem("Transfer Header"; "Transfer Header")
        {
            RequestFilterFields = "No.";
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            { }
            column(Production_Order_No_; "Production Order No.")
            { }
            column(SiNocap; SiNocap)
            { }
            column(MaterialdescCap; MaterialdescCap)
            { }
            column(QtyCap; QtyCap)
            { }
            column(ProjectCap; ProjectCap)
            { }
            column(RecevingMarCap; RecevingMarCap)
            { }
            column(MrsCap; MrsCap)
            { }
            column(RequiredDatecap; RequiredDatecap)
            { }
            column(MRSNoCap; MRSNoCap)
            { }
            column(UserSectionCap; UserSectionCap)
            { }
            column(MaterialRequest; Text003)
            { }
            column(TheInderisresponsible; Text000)
            { }
            column(Note; Text001)
            { }
            column(Form; Text004)
            {

            }
            column(CompanyInfoName; CompanyInfo.Name)
            { }
            column(CompanyInfoAdd; CompanyInfo.Address)
            { }
            column(Location_Address; LocationGRec.Address)//B2BSSD09Jan2023
            { }
            column(CompanyInfoPic; CompanyInfo.Picture)
            { }
            column(IndentRaisedCap; IndentRaisedCap)
            {

            }
            column(AuthroisedbyCap; AuthroisedbyCap)
            {

            }
            column(ApprovedByCap; ApprovedByCap)
            {

            }
            column(DepatCap; DepatCap)
            {

            }
            column(RPONoCap; RpoNoCap)
            {

            }
            column(UseridCap; UseridCap)
            {

            }
            column(ItemCodeCap; ItemCodeCap)
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(No_; "No.")
            { }

            column(Assigned_User_ID; "Assigned User ID")
            {

            }




            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLinkReference = "Transfer Header";
                DataItemLink = "Document No." = field("No.");

                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                { }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                { }
                column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
                { }
                column(Receipt_Date; format("Receipt Date", 0, '<Day,2>-<Month,2>-<Year4>'))
                { }
                column(Item_No; "Item No.")
                {

                }

            }

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
                    /*field(Name; SourceExpression)
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
    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    /*rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }*/

    var
        myInt: Integer;
        CompanyInfo: Record "Company Information";

        SiNocap: Label 'SI.NO.';
        MaterialdescCap: Label 'Material Description';
        QtyCap: Label 'QTY';
        ProjectCap: Label 'Project';
        RequiredDatecap: Label 'Required Date';
        RecevingMarCap: Label 'Receiving Remarks';
        MrsCap: Label 'MRS Dt:';
        MRSNoCap: Label 'MRS NO:';
        UserSectionCap: Label 'User Section:';
        Text003: Label 'Material Requisition Slip';
        Text000: Label 'The indenter is responsible for proper usage of the Materials Purchased';
        Text001: Label 'Note';
        IndentRaisedCap: Label 'Indent raised by:';
        AuthroisedbyCap: Label 'Authorised by:';
        ApprovedByCap: Label 'Approved by:';
        DepatCap: Label 'Dept.Code:';
        RpoNoCap: Label 'RPO No.:';
        UseridCap: Label 'User ID:';
        ItemCodeCap: Label 'Item Code';
        Text004: Label 'Form: VEPL/PUR/MRS-1/01';
        LocationGRec: Record Location;//B2BSSD09Jan2023

}
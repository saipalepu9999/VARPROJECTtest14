report 50015 MaterialssueVoucher
{

    Caption = 'Material Issue Voucher_50015';
    DefaultLayout = RDLC;
    //ApplicationArea = all;
    //UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Report\Layouts\MaterialIssueVoucher.rdl';


    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            RequestFilterFields = "No.";

            column(No_TransferHeader; "No.")
            {
            }
            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
            { }
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
            { }
            column(location_Address; LocationGRec.Address)//B2BSSD09Jan2023
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(location_Address2; LocationGRec."Address 2")//B2BSSD09Jan2023
            { }
            column(IndentDtCapLbl; IndentDtCapLbl)
            { }
            column(IndentNoCapLbl; IndentNoCapLbl)
            { }
            column(UserSctnCapLbl; UserSctnCapLbl)
            { }
            column(SNoCapLbl; SNoCapLbl)
            { }
            column(MaterialCapLbl; MaterialCapLbl)
            { }
            column(QtyCapLbl; QtyCapLbl)
            { }
            column(ReqCapLbl; ReqCapLbl)
            { }
            column(ReceivingCapLbl; ReceivingCapLbl)
            { }
            column(IndentRaiCapLbl; IndentRaiCapLbl)
            { }
            column(AuthoridedCapLbl; AuthoridedCapLbl)
            { }
            column(ApprovedCapLbl; ApprovedCapLbl)
            { }
            column(MaterialIndCapLbl; MaterialIndCapLbl)
            { }
            column(MivNoCapLbl; MivNoCapLbl)
            { }
            column(dateCapLbl; dateCapLbl)
            { }
            column(CodenoCapLbl; CodenoCapLbl)
            { }
            column(UnitCapLbl; UnitCapLbl)
            { }
            column(QtyIssuedCapLbl; QtyIssuedCapLbl)
            { }
            column(jobNoCapLbl; jobNoCapLbl)
            { }
            column(RemarkCapLbl; RemarkCapLbl)
            { }

            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLinkReference = "Transfer Shipment Header";
                DataItemLink = "Document No." = FIELD("No.");
                column(Document_No_; "Document No.")
                {

                }
                column(Amount_TransferLine; Amount)
                {
                }
                column(ItemNo_TransferShipmentLine; "Item No.")
                {
                }
                column(Description_TransferLine; Description)
                {
                }
                column(Quantity_TransferShipmentLine; Quantity)
                {
                }

                column(UnitofMeasureCode_TransferShipmentLine; "Unit of Measure Code")
                {
                }
                column(ShipmentDate_TransferLine; format("Shipment Date", 0, '<Day,2>-<Month,2>-<Year4>'))
                {
                }
                column(ProjCOde; ProjCOde)
                {

                }
                column(TransferQtyGvar; TransferQtyGvar)
                { }
                trigger OnAfterGetRecord()
                begin
                    Clear(TransferQtyGvar);
                    Clear(ProjCOde);
                    if "Transfer Shipment Line".Quantity = 0 then
                        CurrReport.Skip();
                    TransferLine.Reset();
                    TransferLine.SetRange("Document No.", "Transfer Order No.");
                    TransferLine.SetRange("Item No.", "Item No.");
                    if TransferLine.FindFirst() then begin
                        TransferQtyGvar := TransferLine.Quantity;
                    end;

                    ILe.Reset();
                    ILe.SetRange("Document No.", "Document No.");
                    ILe.SetRange("Item No.", "Item No.");
                    ILe.SetRange("Document Line No.", "Line No.");
                    if ILe.FindFirst() then
                        ProjCOde := ile."Global Dimension 2 Code";

                end;

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

            end;
        }

    }

    trigger OnPreReport()
    begin
        CompanyInfoGrec.Get();
        CompanyInfoGrec.CalcFields(Picture);
    end;
    /*requestpage
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
    }*/



    var
        CompanyInfoGrec: Record "Company Information";
        IndentDtCapLbl: label 'Indent Dt';

        IndentNoCapLbl: Label 'Indent No.';
        UserSctnCapLbl: Label 'User Section';
        CodenoCapLbl: Label 'Code No.';
        MivNoCapLbl: Label 'MIV NO. :';
        dateCapLbl: Label 'Date :';
        UnitCapLbl: Label 'UOM';
        SNoCapLbl: Label 'SNO';
        MaterialCapLbl: Label 'Description';
        QtyCapLbl: Label 'MRS Qty';
        QtyIssuedCapLbl: Label 'Qty Issued';
        jobNoCapLbl: Label 'Job No.';
        ReqCapLbl: Label 'Required Dt';
        RemarkCapLbl: Label 'Remarks';
        ReceivingCapLbl: Label 'Receiving Remarks';
        IndentRaiCapLbl: Label 'Indentor';
        AuthoridedCapLbl: Label 'Issued';
        ApprovedCapLbl: Label 'Approved';
        MaterialIndCapLbl: Label 'MATERIAL ISSUE VOUCHER';
        TransferOrder: Record "Transfer Header";
        TransferLine: Record "Transfer Line";
        TransferQtyGvar: Decimal;
        LocationGRec: Record Location;//B2BSSD09Jan2023
        ILe: Record "Item Ledger Entry";
        ProjCOde: Code[20];
        TransferLine2: Record "Transfer Line";

        Quantityvar: Decimal;
}
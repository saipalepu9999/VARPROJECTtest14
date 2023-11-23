report 50097 "QualityLedger"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'QualityLedger_50097';
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\QualityLedgerReport.rdl';


    dataset
    {
        dataitem("Inspection Receipt Header B2B"; "Inspection Receipt Header B2B")
        {
            DataItemTableView = where(Status = const(true));
            column(No_; "No.")
            {

            }
            column(Qty__Accepted; "Qty. Accepted")
            {

            }
            column(Qty__Rejected; "Qty. Rejected")
            {

            }
            column(Qty__Rework; "Qty. Rework")
            {

            }
            trigger OnAfterGetRecord()
            var
                QLe: Record "Quality Ledger Entry B2B";
                Irstatus: text;
            begin
                QLe.Reset();
                QLe.SetRange("Document No.", "Inspection Receipt Header B2B"."No.");
                if QLe.FindFirst() then
                    CurrReport.Skip();

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

}
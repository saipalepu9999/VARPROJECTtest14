report 50028 TransferOrderProcess
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Update Transfer Order Process';


    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            RequestFilterFields = "No.";
            trigger OnAfterGetRecord()
            begin
                "Transfer Header"."Excess Material Returns" := ExcessMaterialReturns;
                "Transfer Header"."Finished Good Transfer" := FinishedGoodTransfer;
                Modify();
                TransfShptHdr.Reset();
                TransfShptHdr.setrange("Transfer Order No.", "Transfer Header"."No.");
                if TransfShptHdr.FindSet() then begin
                    TransfShptHdr.ModifyAll("Excess Material Returns", ExcessMaterialReturns);
                    TransfShptHdr.ModifyAll("Finished Good Transfer", FinishedGoodTransfer);
                end;
                TransferRcptHdr.Reset();
                TransferRcptHdr.setrange("Transfer Order No.", "Transfer Header"."No.");
                if TransferRcptHdr.FindSet() then begin
                    TransferRcptHdr.ModifyAll("Excess Material Returns", ExcessMaterialReturns);
                    TransferRcptHdr.ModifyAll("Finished Good Transfer", FinishedGoodTransfer);
                end;

            end;

            trigger OnPostDataItem()
            begin
                Message('Done');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(ExcessMaterialReturns; ExcessMaterialReturns)
                    {
                        ApplicationArea = all;
                        Caption = 'Excess Material Returns';
                    }
                    field(FinishedGoodTransfer; FinishedGoodTransfer)
                    {
                        ApplicationArea = all;
                        Caption = 'Finished Good Transfer';
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



    var
        ExcessMaterialReturns: Boolean;
        FinishedGoodTransfer: Boolean;
        TransfShptHdr: Record "Transfer Shipment Header";
        TransferRcptHdr: Record "Transfer Receipt Header";
}
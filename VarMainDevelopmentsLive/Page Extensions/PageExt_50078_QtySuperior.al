pageextension 50094 QtySupervisor_Ext extends "Qty Supervisor Activities B2B"
{
    layout
    {
        // Add changes to page layout here
        addafter("Inspection Receipt")
        {
            field("Insepection Receipt_New"; IRSCerFun)
            {
                ApplicationArea = All;
                Caption = 'Insepection Receipt Certificate';
                trigger OnDrillDown()
                begin
                    InspectionRecpGRec.Reset();
                    InspectionRecpGRec.SetRange("Vendor Test Certificate_B2B", true);
                    InspectionRecpGRec.SetRange("Warranty Certificate_B2B", true);
                    InspectionRecpGRec.SetFilter("QC Certificate(s) Status", '<>%1', InspectionRecpGRec."QC Certificate(s) Status"::Available);
                    if InspectionRecpGRec.FindSet() then;
                    InsepectionRecpPageG.SetTableView(InspectionRecpGRec);
                    InsepectionRecpPageG.Run();

                end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        InspectionRecpGRec: record "Inspection Receipt Header B2B";
        InsepectionRecpPageG: Page "Inspection Receipt List B2B";
        ItemLedgerentriesGRec: Record "Item Ledger Entry";
        ItemListPage: page "Item List";
        ItemGrec: Record Item;
        ItemList: Integer;
        IRSCerFun: Integer;
        DateGVar: Date;

    local procedure IRS_CerFun()
    begin
        InspectionRecpGRec.Reset();
        InspectionRecpGRec.SetRange("Vendor Test Certificate_B2B", true);
        InspectionRecpGRec.SetRange("Warranty Certificate_B2B", true);
        InspectionRecpGRec.SetFilter("QC Certificate(s) Status", '<>%1', InspectionRecpGRec."QC Certificate(s) Status"::Available);
        if InspectionRecpGRec.FindSet() then;
        IRSCerFun := InspectionRecpGRec.Count;
    end;

    local procedure ItemList_Fun()
    begin
        ItemLedgerentriesGRec.Reset();
        ItemLedgerentriesGRec.SetFilter("Expiration Date", '<>%1', 0D);
        if ItemLedgerentriesGRec.FindSet() then
            DateGVar := CalcDate('<2W>', WorkDate());
        repeat
            if ItemLedgerentriesGRec."Expiration Date" < DateGVar then begin
                  if ItemGrec.Get(ItemLedgerentriesGRec."Item No.") then;
                  //ItemGrec.mar
            end;
              


        until ItemLedgerentriesGRec.Next() = 0;
    end;

}
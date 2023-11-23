page 50094 QCRolePage
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    // SourceTable = TableName;

    layout
    {
        area(Content)
        {
            cuegroup("Quality Ques")
            {
                field(FGQCPending; FGQCPending)
                {
                    ApplicationArea = all;
                    Caption = 'FG QC Pending';
                    trigger OnDrillDown()
                    var
                        ProductionOrderLvar: Record "Production Order";
                        ProductionOrderLineLvar: Record "Prod. Order Line";
                        ReleasedProdOrders: Page "Released Production Orders";
                    begin
                        ProductionOrderLvar.Reset();
                        ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
                        ProductionOrderLineLvar.SetRange("WIP QC Enabled B2B", true);
                        ProductionOrderLineLvar.SetFilter("Quantity Sent to Quality B2B", '<>%1', 0);
                        //ProductionOrderLineLvar.SetFilter("Finished Qty. (Base)");
                        if ProductionOrderLvar.FindSet() then
                            repeat
                                ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                                if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" <> ProductionOrderLineLvar."Quantity Sent to Quality B2B" then begin
                                    if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                                        ProductionOrderLvar.Mark(true);
                                end;
                            until ProductionOrderLineLvar.Next() = 0;
                        ProductionOrderLvar.MarkedOnly(true);
                        if ProductionOrderLineLvar.FindSet() then;
                        ReleasedProdOrders.SetTableView(ProductionOrderLvar);
                        ReleasedProdOrders.RunModal();
                    end;
                }
                field(FGQCCompleted; FGQCCompleted)
                {
                    ApplicationArea = all;
                    Caption = 'FG QC Completed';
                    trigger OnDrillDown()
                    var
                        ProductionOrderLvar: Record "Production Order";
                        ProductionOrderLineLvar: Record "Prod. Order Line";
                        ReleasedProdOrders: Page "Released Production Orders";
                    begin
                        ProductionOrderLvar.Reset();
                        ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
                        ProductionOrderLineLvar.SetRange("WIP QC Enabled B2B", true);
                        ProductionOrderLineLvar.SetFilter("Quantity Sent to Quality B2B", '<>%1', 0);
                        if ProductionOrderLvar.FindSet() then
                            repeat
                                ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                                if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" = ProductionOrderLineLvar."Quantity Sent to Quality B2B" then begin
                                    if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                                        ProductionOrderLvar.Mark(true);
                                end;
                            until ProductionOrderLineLvar.Next() = 0;
                        ProductionOrderLvar.MarkedOnly(true);
                        if ProductionOrderLineLvar.FindSet() then;
                        ReleasedProdOrders.SetTableView(ProductionOrderLvar);
                        ReleasedProdOrders.RunModal();
                    end;
                }
                field(InProcessQCSFG; InProcessQCSFG)
                {
                    ApplicationArea = all;
                    Caption = 'In Process QC SFG Status';
                    trigger OnDrillDown()
                    var
                        InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
                        InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
                        ProductionOrderLrec: Record "Production Order";
                        ReleasedProdOrders: Page "Released Production Orders";
                    begin
                        ProductionOrderLrec.Reset();
                        ProductionOrderLrec.SetRange(Status, ProductionOrderLrec.Status::Released);
                        if ProductionOrderLrec.FindSet() then
                            repeat
                                InspectionDataHdrLrec.Reset();
                                InspectionDataHdrLrec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                                if InspectionDataHdrLrec.FindSet() then
                                    ProductionOrderLrec.Mark(true);
                                InsReceiptHdrLRec.Reset();
                                InsReceiptHdrLRec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                                if InsReceiptHdrLRec.FindSet() then
                                    ProductionOrderLrec.Mark(true);
                            until ProductionOrderLrec.Next() = 0;
                        ProductionOrderLrec.MarkedOnly(true);
                        if ProductionOrderLrec.FindSet() then;
                        ReleasedProdOrders.SetTableView(ProductionOrderLrec);
                        ReleasedProdOrders.RunModal();
                    end;
                }
                field(IDSPostingPendingPurchase; IDSPostingPendingPurchase)
                {
                    ApplicationArea = all;
                    Caption = 'In-Process related IDS posting pending-Purchase';
                    trigger OnDrillDown()
                    var
                        InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
                        InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
                        ProductionOrderLrec: Record "Production Order";
                        PurchaseHeaderLrec: Record "Purchase Header";
                        PurchaseOrders: Page "Purchase Order List";
                        ReleasedProdOrders: Page "Released Production Orders";
                    begin
                        PurchaseHeaderLrec.Reset();
                        PurchaseHeaderLrec.SetRange("Document Type", PurchaseHeaderLrec."Document Type"::Order);
                        if PurchaseHeaderLrec.FindSet() then
                            repeat
                                InspectionDataHdrLrec.Reset();
                                InspectionDataHdrLrec.SetRange("Order No.", PurchaseHeaderLrec."No.");
                                if InspectionDataHdrLrec.FindSet() then
                                    PurchaseHeaderLrec.Mark(true);

                            until PurchaseHeaderLrec.Next() = 0;
                        PurchaseHeaderLrec.MarkedOnly(true);
                        if PurchaseHeaderLrec.FindSet() then;
                        PurchaseOrders.SetTableView(PurchaseHeaderLrec);
                        PurchaseOrders.RunModal();
                    end;
                }
                field(IDSPostingPendingProduction; IDSPostingPendingProduction)
                {
                    ApplicationArea = all;
                    Caption = 'In-Process related IDS posting pending-Production';
                    trigger OnDrillDown()
                    var
                        InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
                        InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
                        ProductionOrderLrec: Record "Production Order";
                        ReleasedProdOrders: Page "Released Production Orders";
                    begin
                        ProductionOrderLrec.Reset();
                        ProductionOrderLrec.SetRange(Status, ProductionOrderLrec.Status::Released);
                        if ProductionOrderLrec.FindSet() then
                            repeat
                                InspectionDataHdrLrec.Reset();
                                InspectionDataHdrLrec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                                if InspectionDataHdrLrec.FindSet() then
                                    ProductionOrderLrec.Mark(true);

                            until ProductionOrderLrec.Next() = 0;
                        ProductionOrderLrec.MarkedOnly(true);
                        if ProductionOrderLrec.FindSet() then;
                        ReleasedProdOrders.SetTableView(ProductionOrderLrec);
                        ReleasedProdOrders.RunModal();
                    end;
                }
                field(IDSList; IDSList)
                {
                    ApplicationArea = all;
                    Caption = 'IDS List';
                    trigger OnDrillDown()
                    var
                        InspectonDataSheet: Record "Ins Datasheet Header B2B";
                        PostedInsDataSeetList: Page "Inspection Data Sheet List B2B";
                    begin
                        InspectonDataSheet.Reset();
                        if InspectonDataSheet.FindSet() then;
                        PostedInsDataSeetList.SetTableView(InspectonDataSheet);
                        PostedInsDataSeetList.RunModal();
                    end;
                }
                field(IRList; IRList)
                {
                    ApplicationArea = all;
                    Caption = 'In Bound IR List';
                    trigger OnDrillDown()
                    var
                        InspectionReceipt: Record "Inspection Receipt Header B2B";
                        InspectionReceiptList: Page "Inspection Receipt List B2B";
                    begin
                        InspectionReceipt.Reset();
                        InspectionReceipt.SetRange(Status, false);
                        InspectionReceipt.SetFilter("Receipt No.", '<>%1', '');
                        if InspectionReceipt.FindSet() then;
                        InspectionReceiptList.SetTableView(InspectionReceipt);
                        InspectionReceiptList.RunModal();
                    end;
                }
                field(PostedIdsList; PostedIdsList)
                {
                    ApplicationArea = all;
                    Caption = 'Posted IDS List';
                    trigger OnDrillDown()
                    var
                        InspectonDataSheet: Record "Posted Ins DatasheetHeader B2B";
                        PostedInsDataSeetList: Page "Posted Ins DataSheet List B2B";
                    begin
                        InspectonDataSheet.Reset();
                        if InspectonDataSheet.FindSet() then;
                        PostedInsDataSeetList.SetTableView(InspectonDataSheet);
                        PostedInsDataSeetList.RunModal();
                    end;
                }
                field(PostedIrList; PostedIrList)
                {
                    ApplicationArea = all;
                    Caption = 'Posted IR List';
                    trigger OnDrillDown()
                    var
                        InspectionReceipt: Record "Inspection Receipt Header B2B";
                        InspectionReceiptList: Page "Posted Ins Receipt List B2B";
                    begin
                        InspectionReceipt.Reset();
                        InspectionReceipt.SetRange(Status, true);
                        if InspectionReceipt.FindSet() then;
                        InspectionReceiptList.SetTableView(InspectionReceipt);
                        InspectionReceiptList.RunModal();
                    end;
                }
                field(LotExpiryBefore6Weeks; LotExpiryBefore6Weeks)
                {
                    ApplicationArea = all;
                    Caption = 'Lot/Batch No expiration is due in next 6 to 8 weeks';
                    trigger OnDrillDown()
                    var
                        Items: Record Item;
                        ItemLedgerEntries: Record "Item Ledger Entry";
                        ItemList: Page "Item List";
                    begin
                        Items.Reset();
                        if Items.FindSet() then
                            repeat
                                ItemLedgerEntries.Reset();
                                ItemLedgerEntries.SetRange("Item No.", Items."No.");

                                ItemLedgerEntries.SetFilter("Expiration Date", '<>%1', 0D);
                                ItemLedgerEntries.FilterGroup(-1);
                                ItemLedgerEntries.SetFilter("Expiration Date", '<%1', WorkDate() - 42);
                                if ItemLedgerEntries.FindFirst() then begin
                                    Items.Mark(true);
                                end;
                            until Items.Next() = 0;
                        Items.MarkedOnly(true);
                        if Items.FindSet() then;
                        ItemList.SetTableView(Items);
                        ItemList.RunModal();
                    end;
                }
                field(VendorCertificateWarrenty; VendorCertificateWarrenty)
                {
                    ApplicationArea = all;
                    Caption = 'Vendor Test Report/Warranty Certificates - Pending from Vendor';
                    trigger OnDrillDown()
                    var
                        InspectionReceipt: Record "Inspection Receipt Header B2B";
                        InspectionReceiptList: page "Inspection Receipt List B2B";
                    begin
                        InspectionReceipt.Reset();
                        InspectionReceipt.SetRange(Status, false);
                        InspectionReceipt.SetFilter("QC Certificate(s) Status", '<>%1|<>%2', InspectionReceipt."QC Certificate(s) Status"::"Not Required", InspectionReceipt."QC Certificate(s) Status"::Available);
                        if InspectionReceipt.FindSet() then;
                        InspectionReceiptList.SetTableView(InspectionReceipt);
                        InspectionReceiptList.RunModal();
                    end;
                }
                field(SpecificationsCertified; SpecificationsCertified)
                {
                    ApplicationArea = all;
                    Caption = 'Certified Specifications';
                    trigger OnDrillDown()
                    var
                        SpecificationsLrec: Record "Specification Header B2B";
                        SpecList: page "Specification List B2B";
                    begin
                        SpecificationsLrec.Reset();
                        SpecificationsLrec.SetFilter(Status, '%1', SpecificationsLrec.Status::Certified);
                        if SpecificationsLrec.FindSet() then;
                        SpecList.SetTableView(SpecificationsLrec);
                        SpecList.RunModal();
                    end;
                }
                field(SpecificationsUncertified; SpecificationsUncertified)
                {
                    ApplicationArea = all;
                    Caption = 'UnCertified Specifications';
                    trigger OnDrillDown()
                    var
                        SpecificationsLrec: Record "Specification Header B2B";
                        SpecList: page "Specification List B2B";
                    begin
                        SpecificationsLrec.Reset();
                        SpecificationsLrec.SetFilter(Status, '<>%1', SpecificationsLrec.Status::Certified);
                        if SpecificationsLrec.FindSet() then;
                        SpecList.SetTableView(SpecificationsLrec);
                        SpecList.RunModal();
                    end;
                }
                field(NCPR; NCPR)
                {
                    ApplicationArea = all;
                    Caption = 'NCPR List';
                    trigger OnDrillDown()
                    var
                        NCPRLrec: Record NCPR;
                        NCPRListLrec: Page "NCPR List";
                    begin
                        NCPRLrec.Reset();
                        NCPRLrec.SetRange(Posted, false);
                        if NCPRLrec.FindSet() then;
                        NCPRListLrec.SetTableView(NCPRLrec);
                        NCPRListLrec.RunModal();
                    end;
                }
                field(InProcessIRList; InProcessIRList)
                {
                    ApplicationArea = all;
                    Caption = 'In Process IR List';
                    trigger OnDrillDown()
                    var
                        InspectionReceipt: Record "Inspection Receipt Header B2B";
                        InspectionReceiptList: Page "Inspection Receipt List B2B";
                    begin
                        InspectionReceipt.Reset();
                        InspectionReceipt.SetRange(Status, false);
                        InspectionReceipt.SetFilter("Prod. Order No.", '<>%1', '');
                        if InspectionReceipt.FindSet() then;
                        InspectionReceiptList.SetTableView(InspectionReceipt);
                        InspectionReceiptList.RunModal();
                    end;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    procedure FgqcpendingProcedure()
    var
        ProductionOrderLvar: Record "Production Order";
        ProductionOrderLineLvar: Record "Prod. Order Line";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        ProductionOrderLvar.Reset();
        ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
        ProductionOrderLineLvar.SetRange("WIP QC Enabled B2B", true);
        ProductionOrderLineLvar.SetFilter("Quantity Sent to Quality B2B", '<>%1', 0);
        if ProductionOrderLvar.FindSet() then
            repeat
                ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" <> ProductionOrderLineLvar."Quantity Sent to Quality B2B" then begin
                    if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                        ProductionOrderLvar.Mark(true);
                end;
            until ProductionOrderLineLvar.Next() = 0;
        ProductionOrderLvar.MarkedOnly(true);
        if ProductionOrderLineLvar.FindSet() then
            FGQCPending := ProductionOrderLvar.Count;


    end;

    procedure FgqcCompletdProcedure()
    var
        ProductionOrderLvar: Record "Production Order";
        ProductionOrderLineLvar: Record "Prod. Order Line";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        ProductionOrderLvar.Reset();
        ProductionOrderLineLvar.SetRange(Status, ProductionOrderLineLvar.Status::Released);
        ProductionOrderLineLvar.SetRange("WIP QC Enabled B2B", true);
        ProductionOrderLineLvar.SetFilter("Quantity Sent to Quality B2B", '<>%1', 0);
        if ProductionOrderLvar.FindSet() then
            repeat
                ProductionOrderLineLvar.CalcFields("Quantity Accepted B2B", "Quantity Rejected B2B", "Quantity Rework B2B");
                if ProductionOrderLineLvar."Quantity Accepted B2B" + ProductionOrderLineLvar."Quantity Rejected B2B" + ProductionOrderLineLvar."Quantity Rework B2B" = ProductionOrderLineLvar."Quantity Sent to Quality B2B" then begin
                    if ProductionOrderLvar.Get(ProductionOrderLineLvar.Status, ProductionOrderLineLvar."Prod. Order No.") then
                        ProductionOrderLvar.Mark(true);
                end;
            until ProductionOrderLineLvar.Next() = 0;
        ProductionOrderLvar.MarkedOnly(true);
        if ProductionOrderLineLvar.FindSet() then
            FGQCCompleted := ProductionOrderLvar.Count;


    end;

    procedure InProcessQCSFGStatus()
    var
        InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
        InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
        ProductionOrderLrec: Record "Production Order";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        ProductionOrderLrec.Reset();
        ProductionOrderLrec.SetRange(Status, ProductionOrderLrec.Status::Released);
        if ProductionOrderLrec.FindSet() then
            repeat
                InspectionDataHdrLrec.Reset();
                InspectionDataHdrLrec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                if InspectionDataHdrLrec.FindSet() then
                    ProductionOrderLrec.Mark(true);
                InsReceiptHdrLRec.Reset();
                InsReceiptHdrLRec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                if InsReceiptHdrLRec.FindSet() then
                    ProductionOrderLrec.Mark(true);
            until ProductionOrderLrec.Next() = 0;
        ProductionOrderLrec.MarkedOnly(true);
        if ProductionOrderLrec.FindSet() then
            InProcessQCSFG := ProductionOrderLrec.Count;
    end;

    procedure InProcessrelatedIDSpostingpendingpurchase()
    var
        InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
        InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
        ProductionOrderLrec: Record "Production Order";
        PurchaseHeaderLrec: Record "Purchase Header";
        PurchaseOrders: Page "Purchase Order List";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        PurchaseHeaderLrec.Reset();
        PurchaseHeaderLrec.SetRange("Document Type", PurchaseHeaderLrec."Document Type"::Order);
        if PurchaseHeaderLrec.FindSet() then
            repeat
                InspectionDataHdrLrec.Reset();
                InspectionDataHdrLrec.SetRange("Order No.", PurchaseHeaderLrec."No.");
                if InspectionDataHdrLrec.FindSet() then
                    PurchaseHeaderLrec.Mark(true);

            until PurchaseHeaderLrec.Next() = 0;
        PurchaseHeaderLrec.MarkedOnly(true);
        if PurchaseHeaderLrec.FindSet() then
            IDSPostingPendingPurchase := PurchaseHeaderLrec.Count;

    end;

    procedure InProcessrelatedIDSpostingpendingproduction()
    var
        InspectionDataHdrLrec: Record "Ins Datasheet Header B2B";
        InsReceiptHdrLRec: Record "Inspection Receipt Header B2B";
        ProductionOrderLrec: Record "Production Order";
        ReleasedProdOrders: Page "Released Production Orders";
    begin
        ProductionOrderLrec.Reset();
        ProductionOrderLrec.SetRange(Status, ProductionOrderLrec.Status::Released);
        if ProductionOrderLrec.FindSet() then
            repeat
                InspectionDataHdrLrec.Reset();
                InspectionDataHdrLrec.SetRange("Prod. Order No.", ProductionOrderLrec."No.");
                if InspectionDataHdrLrec.FindSet() then
                    ProductionOrderLrec.Mark(true);
            until ProductionOrderLrec.Next() = 0;
        ProductionOrderLrec.MarkedOnly(true);
        if ProductionOrderLrec.FindSet() then
            IDSPostingPendingProduction := ProductionOrderLrec.count;
    end;

    procedure InspectionDataSheetList()
    var
        InspectonDataSheet: Record "Ins Datasheet Header B2B";
        PostedInsDataSeetList: Page "Inspection Data Sheet List B2B";
    begin
        InspectonDataSheet.Reset();
        if InspectonDataSheet.FindSet() then
            IDSList := InspectonDataSheet.Count;

    end;

    procedure InspectionReceiptList()
    var
        InspectionReceipt: Record "Inspection Receipt Header B2B";
        InspectionReceiptList: Page "Inspection Receipt List B2B";
    begin
        InspectionReceipt.Reset();
        InspectionReceipt.SetRange(Status, false);
        InspectionReceipt.SetFilter("Receipt No.", '<>%1', '');
        if InspectionReceipt.FindSet() then
            IRList := InspectionReceipt.Count;

    end;

    procedure PosInspectionDataSheetList()
    var
        InspectonDataSheet: Record "Posted Ins DatasheetHeader B2B";
        PostedInsDataSeetList: Page "Posted Ins DataSheet List B2B";
    begin
        InspectonDataSheet.Reset();
        if InspectonDataSheet.FindSet() then
            PostedIdsList := InspectonDataSheet.Count;

    end;

    procedure PosInspectionReceiptList()
    var
        InspectionReceipt: Record "Inspection Receipt Header B2B";
        InspectionReceiptList: Page "Inspection Receipt List B2B";
    begin
        InspectionReceipt.Reset();
        InspectionReceipt.SetRange(Status, true);
        if InspectionReceipt.FindSet() then
            PostedIrList := InspectionReceipt.Count;

    end;

    procedure LotExpiryList()
    var
        Items: Record Item;
        ItemLedgerEntries: Record "Item Ledger Entry";
        ItemList: Page "Item List";
    begin
        Items.Reset();
        if Items.FindSet() then
            repeat
                ItemLedgerEntries.Reset();
                ItemLedgerEntries.SetRange("Item No.", Items."No.");

                ItemLedgerEntries.SetFilter("Expiration Date", '<>%1', 0D);
                ItemLedgerEntries.FilterGroup(-1);
                ItemLedgerEntries.SetFilter("Expiration Date", '<%1', WorkDate() - 42);
                if ItemLedgerEntries.FindFirst() then begin
                    Items.Mark(true);
                end;
            until Items.Next() = 0;
        Items.MarkedOnly(true);
        if Items.FindSet() then
            LotExpiryBefore6Weeks := Items.Count;

    end;

    procedure VendortestCertificate()
    var
        InspectionReceipt: Record "Inspection Receipt Header B2B";
        InspectionReceiptList: page "Inspection Receipt List B2B";
    begin
        InspectionReceipt.Reset();
        InspectionReceipt.SetRange(Status, false);
        InspectionReceipt.SetFilter("QC Certificate(s) Status", '<>%1|<>%2', InspectionReceipt."QC Certificate(s) Status"::"Not Required", InspectionReceipt."QC Certificate(s) Status"::Available);
        if InspectionReceipt.FindSet() then
            VendorCertificateWarrenty := InspectionReceipt.Count;
    end;

    procedure CertifiedSpecList()

    var
        SpecificationsLrec: Record "Specification Header B2B";
        SpecList: page "Specification List B2B";
    begin
        SpecificationsLrec.Reset();
        SpecificationsLrec.SetFilter(Status, '%1', SpecificationsLrec.Status::Certified);
        if SpecificationsLrec.FindSet() then
            SpecificationsCertified := SpecificationsLrec.Count

    end;

    procedure UncertifiedSpecList()
    var
        SpecificationsLrec: Record "Specification Header B2B";
        SpecList: page "Specification List B2B";
    begin
        SpecificationsLrec.Reset();
        SpecificationsLrec.SetFilter(Status, '<>%1', SpecificationsLrec.Status::Certified);
        if SpecificationsLrec.FindSet() then
            SpecificationsUncertified := SpecificationsLrec.Count

    end;

    procedure ShowNcprList()
    var
        NCPRLrec: Record NCPR;
        NCPRListLrec: Page "NCPR List";
    begin
        NCPRLrec.Reset();
        NCPRLrec.SetRange(Posted, false);
        if NCPRLrec.FindSet() then
            NCPR := NCPRLrec.Count;

    end;

    procedure InProcessInspectionReceiptList()
    var
        InspectionReceipt: Record "Inspection Receipt Header B2B";
        InspectionReceiptList: Page "Inspection Receipt List B2B";
    begin
        InspectionReceipt.Reset();
        InspectionReceipt.SetRange(Status, false);
        InspectionReceipt.SetFilter("Prod. Order No.", '<>%1', '');
        if InspectionReceipt.FindSet() then
            InProcessIRList := InspectionReceipt.Count;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        FgqcCompletdProcedure();
        FgqcpendingProcedure();
        InProcessQCSFGStatus();
        InspectionDataSheetList();
        InspectionReceiptList();
        InProcessrelatedIDSpostingpendingproduction();
        InProcessrelatedIDSpostingpendingpurchase();
        LotExpiryList();
        VendortestCertificate();
        PosInspectionDataSheetList();
        PosInspectionReceiptList();
        CertifiedSpecList();
        UncertifiedSpecList();
        ShowNcprList();
        InProcessInspectionReceiptList();
    end;

    var
        FGQCCompleted: Integer;
        FGQCPending: Integer;
        InProcessQCSFG: Integer;
        IDSPostingPendingPurchase: Integer;
        IDSPostingPendingProduction: Integer;
        IDSList: Integer;
        IRList: Integer;
        LotExpiryBefore6Weeks: Integer;
        VendorCertificateWarrenty: Integer;
        PostedIdsList: Integer;
        PostedIrList: Integer;
        SpecificationsCertified: Integer;
        SpecificationsUncertified: Integer;
        NCPR: Integer;
        InProcessIRList: Integer;

}
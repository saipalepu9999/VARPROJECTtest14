report 50024 MIV
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Material Issue Voucher';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\MIVNew.rdl';

    dataset
    {
        dataitem("Indent Header"; "Indent Header")
        {
            RequestFilterFields = "No.";

            column(CompanyInfoGrec; CompanyInfoGrec.Address)
            { }
            column(MRSDepartment_IndentHeader; "MRS Department")
            {
            }
            column(UserId_IndentHeader; "User Id")
            {
            }
            column(TransferOrderNo_IndentHeader; "Transfer Order No.")
            {
            }
            column(MRSRequestor_IndentHeader; "MRS Requestor")
            {
            }
            column(MRSRequestedDate_IndentHeader; format("MRS Requested Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(ShortcutDimension1Code_B2B_IndentHeader; "Shortcut Dimension 1 Code_B2B")
            {
            }
            column(ShortcutDimension2Code_B2B_IndentHeader; "Shortcut Dimension 2 Code_B2B")
            {
            }
            column(Description_IndentHeader; Description)
            {
            }
            column(DocumentDate_IndentHeader; format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(DueDate_IndentHeader; format("Due Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(CompanyInfoname; CompanyInfoGrec.Name)
            { }
            column(MIVNo; "No.")
            { }
            column(CompanyInfoPicture; CompanyInfoGrec.Picture)
            { }
            column(PurchaseIndentCapLbl; PurchaseIndentCapLbl)
            { }
            column(IndentNoCapbl; IndentNoCapbl)
            { }
            column(IndentdateCapLbl; IndentdateCapLbl)
            { }
            column(IndentorDeptCapLbl; IndentorDeptCapLbl)
            { }
            column(IndentorNameCapLbl; IndentorNameCapLbl)
            { }
            column(RequestedDeptCapLbl; RequestedDeptCapLbl)
            { }
            column(RequestorNameCapLbl; RequestorNameCapLbl)
            { }
            column(ProjectCodeCapLbl; ProjectCodeCapLbl)
            { }
            column(DivisionCodeCapLbl; DivisionCodeCapLbl)
            { }
            column(MRSNoCapLbl; MRSNoCapLbl)
            { }
            column(MRSDateCapLbl; MRSDateCapLbl)
            { }
            column(ItemNoCapLbl; ItemNoCapLbl)
            { }
            column(ItemDescriptionCapLbl; ItemDescriptionCapLbl)
            { }
            column(ItemDrawingNoCapLbl; ItemDrawingNoCapLbl)
            { }
            column(MakeCapLbl; MakeCapLbl)
            { }
            column(ModelCapLbl; ModelCapLbl)
            { }
            column(UOMCapLbl; UOMCapLbl)
            { }
            column(ReqDateCapLbl; ReqDateCapLbl)
            { }
            column(ReqQtyCapLbl; ReqQtyCapLbl)
            { }
            column(InventoryAvailQtyCapLbl; InventoryAvailQtyCapLbl)
            { }
            column(PendingIndentQtyCapLbl; PendingIndentQtyCapLbl)
            { }
            column(ItemDrawingNo; ItemDrawingNo)
            { }
            column(LocationGrec_Address; LocationGrec.Address)
            { }
            dataitem("Indent Line"; "Indent Line")
            {
                DataItemLinkReference = "Indent Header";
                DataItemLink = "Document No." = FIELD("No.");
                CalcFields = "Available Inventory";
                //DataItemTableView = where("Derived From Line No." = CONST(0));
                column(Description; Description)
                { }
                column(ReqQuantity_IndentLine; "Req.Quantity")
                {
                }
                column(Amount_IndentLine; Amount)
                {
                }
                column(Make_IndentLine; Make)
                {
                }
                column(Model_IndentLine; Model)
                {
                }
                column(DueDate_IndentLine; "Due Date")
                {
                }
                column(No_IndentLine; "No.")
                {
                }
                column(ShortageQty_IndentLine; "Shortage Qty")
                {
                }
                column(AvailableInventory_IndentLine; "Available Inventory")
                { }
                column(UnitofMeasure_IndentLine; "Unit of Measure")
                { }
                column(QuantityIndented; Quantity)
                { }
                trigger OnAfterGetRecord()
                var
                    DocAttach: Record "Document Attachment";
                begin
                    DocAttach.Reset();
                    DocAttach.SetRange("Table ID", 27);
                    DocAttach.SetRange("No.", "No.");
                    DocAttach.SetRange(Type_B2B, DocAttach.Type_B2B::Drawing);
                    if DocAttach.FindLast() then begin
                        ItemDrawingNo := DocAttach."Drawing No_B2B";
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                /* TransferShpnthdr.Reset();
                 TransferShpnthdr.SetRange("Transfer Order No.", "No.");
                 if TransferShpnthdr.FindSet() then
                     repeat
                         TransferShpntLine.Reset();
                         TransferShpntLine.SetRange("Document No.", TransferShpnthdr."No.");
                         if TransferShpntLine.FindSet() then
                             repeat
                                 Quantity += TransferShpntLine.Quantity;
                             until TransferShpntLine.Next() = 0;
                     until TransferShpnthdr.Next() = 0;*/
                Clear(LocationGrec);
                if LocationGrec.Get("Delivery Location") then;
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

        Quantity: Decimal;
        CompanyInfoGrec: Record "Company Information";
        IndentorNameCapLbl: Label 'Indentor Name';
        IndentorDeptCapLbl: Label 'Indentor Dept';
        RequestedDeptCapLbl: Label 'Requested Dept';
        RequestorNameCapLbl: Label 'Requestor Name';
        MRSNoCapLbl: Label 'MRS No.';
        MRSDateCapLbl: Label 'MRS Date';
        PurchaseIndentCapLbl: Label 'Purchase Indent';
        IndentNoCapbl: Label 'Indent No.';
        IndentdateCapLbl: Label 'Indent Date';
        DivisionCodeCapLbl: Label 'Division Code';
        ProjectCodeCapLbl: Label 'Project Code';
        ItemNoCapLbl: Label 'Item No.';
        ItemDescriptionCapLbl: Label 'Item Description';
        ItemDrawingNoCapLbl: Label 'Item Drawing No.';
        MakeCapLbl: Label 'Make';
        ModelCapLbl: Label 'Model';
        UOMCapLbl: Label 'Unit Of Measure';
        ReqQtyCapLbl: Label 'Required Quantity';
        ReqDateCapLbl: Label 'Required Date';
        InventoryAvailQtyCapLbl: Label 'Inventory Available Qty';
        PendingIndentQtyCapLbl: Label 'Pending Indent Qty';
        TransferShpnthdr: Record "Transfer Shipment Header";
        TransferShpntLine: Record "Transfer Shipment Line";
        ItemDrawingNo: Text;
        LocationGrec: Record Location;
}
pageextension 50019 TransferOrderExt extends "Transfer Order"
{
    layout
    {
        addlast(General)
        {
            field("Approval Status"; Rec."Approval Status")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the value of the Approval Status field.';
            }
            field("Production Order No."; Rec."Production Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production Order No. field.';
            }
            field("Sale Order No."; Rec."Sale Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Sale Order No. field.';
            }
            field("Production Order Line No."; Rec."Production Order Line No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Production Order Line No. field.';
            }
            field("Subcon Order No."; Rec."Subcon Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Subcon Order No. field.';
            }


        }
        modify("Transfer-from Code")
        {
            trigger OnBeforeValidate()
            begin
                /* if ("Transfer-from Code" <> '') and (("Transfer-from Code" = 'DOMSTORES') or ("Transfer-from Code" = 'EOUSTORES')) then
                     Error('From Location Should not Be - DOMSTORES or EOUSTORES');*/
                if CopyStr("Transfer-from Code", 1, 1) <> CopyStr("No. Series", 1, 1) then
                    Error('You cannot Selet This Location');
            end;
        }
        modify("Transfer-to Code")
        {
            // Editable
            trigger OnBeforeValidate()
            var
                LocationLrec: Record Location;
            begin
                /*  if (LocationLrec.get(Rec."Transfer-to Code")) and (not LocationLrec."Stores Location") then
                      Error('You cannot select this location');*/
                if "Transfer-from Code" <> '' then
                    if CopyStr("Transfer-from Code", 1, 1) <> CopyStr("Transfer-to Code", 1, 1) then
                        Error('you cannot select this location');
            end;
        }
        modify("Direct Transfer")
        {
            Visible = false;
        }
        modify("In-Transit Code")
        {
            Editable = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 2 Code_B2B"; Rec."Shortcut Dimension 2 Code_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
            }
        }

    }



    actions
    {
        addlast(processing)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                ToolTip = 'The User Can Send The documents For Approvals';
                action(Approve)
                {
                    ApplicationArea = All;
                    Image = Action;
                    //Visible = openapp;
                    Visible = false;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Approve action.';
                    trigger OnAction()
                    var
                        approvalmngmt: Codeunit "Approvals Mgmt.";
                    begin
                        approvalmngmt.ApproveRecordApprovalRequest(rec.RecordId());
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = All;
                    Image = SendApprovalRequest;
                    //Visible = Not OpenApprEntrEsists and CanrequestApprovForFlow;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Send Approval Request action.';
                    trigger OnAction()
                    var
                        ApprovalsCodeunit: Codeunit ApprovalsCodeunit;

                    begin
                        if ApprovalsCodeunit.CheckTransferOrderApprovalsWorkflowEnabled(Rec) then
                            ApprovalsCodeunit.OnSendTransferOrderForApproval(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = All;
                    Image = CancelApprovalRequest;
                    //Visible = CanCancelapprovalforrecord or CanCancelapprovalforflow;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Cancel Approval Request action.';
                    trigger OnAction()
                    var
                        ApprovalsCodeunit: Codeunit ApprovalsCodeunit;
                    begin
                        ApprovalsCodeunit.OnCancelTransferOrderForApproval(Rec);
                    end;
                }
                action("Approval Entries")
                {
                    ApplicationArea = All;
                    Image = Entries;
                    //Visible = openapp;
                    Visible = false;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    ToolTip = 'Executes the Approval Entries action.';
                    trigger OnAction()
                    var
                        ApprovalEntries: Page "Approval Entries";
                        ApprovalEntry: Record "Approval Entry";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetRange("Table ID", DATABASE::"Ins Datasheet Header B2B");
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.RUN;
                    end;
                }
            }
        }//CHB2B12OCT2022<<
        addafter("&Print")
        {
            action("Material Requsition Slip")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Material Requsition Slip action.';
                trigger OnAction()
                var
                    TransferHead: record "Transfer Header";
                begin
                    TransferHead.Reset();
                    TransferHead.SetRange("No.", Rec."No.");
                    if TransferHead.FindFirst() then
                        Report.RunModal(Report::"Material Requsition Slip", true, true, TransferHead);
                end;
            }
        }//CHB2B12OCT2022>>
        addlast("F&unctions")
        {
            action("Copy BOM Lines")
            {
                ApplicationArea = All;
                Image = CopyBOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Copy BOM Lines action.';
                trigger OnAction();
                var
                    BOMLineR: Report "Quant Explo of BOM In Transfer";
                    ItemRec: Record Item;
                    ProductionLine: Record "Prod. Order Line";
                begin
                    Clear(ItemRec);
                    Clear(BOMLineR);
                    IF rec."No." = '' then
                        rec.TestField(Rec."No.");
                    BOMLineR.GetTrans(rec."No.");
                    ProductionLine.Reset();
                    ProductionLine.SetRange("Prod. Order No.", Rec."Production Order No.");
                    if ProductionLine.FindFirst() then begin
                        //if ItemRec.get(ProductionLine."Item No.") then;
                        ItemRec.Reset();
                        ItemRec.SetRange("No.", ProductionLine."Item No.");
                        if ItemRec.FindFirst() then begin
                            BOMLineR.SetTableView(ItemRec);
                            BOMLineR.Run();
                        end;
                    end;
                end;
            }
            action("Create Shortage")
            {
                ApplicationArea = All;
                Image = Create;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create Shortage action.';
                trigger OnAction();
                var
                    ShortageTableLrec: Record "Shortage Table";
                    TransferLineLrec: Record "Transfer Line";
                    ShortagePage: Page "Shortage Page";
                    countGvar: Integer;
                begin
                    Clear(countGvar);
                    Clear(ShortagePage);
                    TransferLineLrec.Reset();
                    TransferLineLrec.SetRange("Document No.", Rec."No.");
                    if TransferLineLrec.FindSet() then
                        repeat
                            TransferLineLrec.CalcFields("Available Inventory");
                            if TransferLineLrec.Quantity > TransferLineLrec."Available Inventory" then begin
                                ShortageTableLrec.Init();
                                ShortageTableLrec."Transfer Order No." := TransferLineLrec."Document No.";
                                ShortageTableLrec."Transfer Order Line No." := TransferLineLrec."Line No.";
                                ShortageTableLrec."Item No." := TransferLineLrec."Item No.";
                                ShortageTableLrec."Item Description" := TransferLineLrec.Description;
                                ShortageTableLrec.Quantity := TransferLineLrec.Quantity;
                                ShortageTableLrec.Amount := TransferLineLrec.Amount;
                                ShortageTableLrec.Insert;
                                countGvar += 1;
                            end;
                        until TransferLineLrec.Next() = 0;
                    if countGvar > 1 then begin
                        ShortagePage.GetValues(Rec."No.");
                        ShortagePage.Run();
                    end;
                end;
            }
            action("Create Indent")
            {
                ApplicationArea = All;
                Image = Create;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create Indent action.';
                trigger OnAction()
                var
                    TransferLineLvar: Record "Transfer Line";
                    TransferHeaderLvar: Record "Transfer Header";
                    IndentHeaderLvar: Record "Indent Header";
                    IndentLineLvar: Record "Indent Line";
                    lineNoLvar: Integer;
                    PurchPayabeSetup: Record "Purchases & Payables Setup";
                    NoSeriesRelationship: Record "No. Series Relationship";
                    NoSeries: Record "No. Series";
                    NoSeriesCode: Code[20];
                    NoseriesMgmt: Codeunit NoSeriesManagement;
                begin
                    Rec.TestField("Shortcut Dimension 1 Code");
                    Rec.TestField("Shortcut Dimension 2 Code");
                    PurchPayabeSetup.Get();
                    PurchPayabeSetup.TestField("Indent Nos.");
                    NoSeries.Reset();
                    NoSeriesRelationship.SetRange(Code, PurchPayabeSetup."Indent Nos.");
                    NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", Rec."Shortcut Dimension 1 Code");
                    if NoSeriesRelationship.FindSet() then
                        repeat
                            NoSeries.Code := NoSeriesRelationship."Series Code";
                            NoSeries.Mark := true;
                            NoSeriesCode := NoSeriesRelationship."Series Code";
                        until NoSeriesRelationship.Next() = 0;
                    if NoSeries.Get(PurchPayabeSetup."Indent Nos.") then
                        if NoSeries."Shortcut Dimension 1 Code_B2B" = Rec."Shortcut Dimension 1 Code" then
                            NoSeries.Mark := true;
                    NoSeries.MarkedOnly := true;
                    if NoSeries.FindSet() then
                        repeat
                            //if NoSeries."Shortcut Dimension 1 Code_B2B" = Rec."Transfer-from Code" then
                            NoSeriesCode := NoSeries.Code;
                        until NoSeries.Next() = 0;
                    TransferLineLvar.Reset();
                    TransferLineLvar.SetRange("Document No.", Rec."No.");
                    TransferLineLvar.SetRange("Create Indent", true);
                    if TransferLineLvar.FindSet() then begin
                        IndentHeaderLvar.Init();
                        IndentHeaderLvar."No." := NoseriesMgmt.GetNextNo(NoSeriesCode, WorkDate(), true);
                        IndentHeaderLvar.Insert(true);
                        IndentHeaderLvar.Description := 'Transfer Order Indent';
                        IndentHeaderLvar."Transfer Order No." := Rec."No.";
                        IndentHeaderLvar."Shortcut Dimension 1 Code_B2B" := Rec."Shortcut Dimension 1 Code";
                        IndentHeaderLvar."Shortcut Dimension 2 Code_B2B" := Rec."Shortcut Dimension 2 Code";
                        IndentHeaderLvar."MRS Requestor" := UserId;
                        IndentHeaderLvar."MRS Requested Date" := WorkDate();
                        IndentHeaderLvar.Validate("Delivery Location", Rec."Transfer-from Code");
                        //IndentHeaderLvar."MRS Department" 
                        //IndentHeaderLvar.
                        IndentHeaderLvar.Modify(true);
                        lineNoLvar := 10000;
                        repeat
                            IndentLineLvar.Init();
                            IndentLineLvar."Document No." := IndentHeaderLvar."No.";
                            IndentLineLvar."Line No." := lineNoLvar;
                            lineNoLvar += 10000;
                            IndentLineLvar.Insert(true);
                            IndentLineLvar.Validate("No.", TransferLineLvar."Item No.");
                            IndentLineLvar.Validate("Delivery Location", TransferLineLvar."Transfer-from Code");
                            IndentLineLvar.Validate("Req.Quantity", TransferLineLvar."Shortage Qty");
                            IndentLineLvar."Unit of Measure" := TransferLineLvar."Unit of Measure";
                            //IndentLineLvar."Delivery Location" := tran
                            IndentLineLvar.Modify(true);
                            TransferLineLvar."Indent Created" := true;
                            TransferLineLvar."Create Indent" := false;
                            TransferLineLvar.Modify();
                            if TransferHeaderLvar.Get(TransferLineLvar."Document No.") then begin
                                TransferHeaderLvar."Indents Craeted" := true;
                                TransferHeaderLvar.Modify();
                            end;
                        //IndentHeaderLvar
                        until TransferLineLvar.Next() = 0;
                        Message('Indent %1 Has Been Created', IndentHeaderLvar."No.");
                    end else
                        Message('No Lines Have Been Selected');


                end;
            }
            action("Show Indents")
            {
                ApplicationArea = All;
                ToolTip = 'Executes the Show Indents action.';

                trigger OnAction()
                var
                    IndentHedaer: Record "Indent Header";
                begin
                    IndentHedaer.Reset();
                    IndentHedaer.SetRange("Transfer Order No.", Rec."No.");
                    if IndentHedaer.FindSet() then
                        Page.RunModal(Page::"Indent List", IndentHedaer);
                end;
            }
            action("Recalculate Shortage")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    TransferLine: Record "Transfer Line";
                begin
                    TransferLine.Reset();
                    TransferLine.SetRange("Document No.", Rec."No.");
                    if TransferLine.FindSet() then
                        repeat
                            TransferLine.CalcFields("Available Inventory");
                            if (TransferLine."Quantity (Base)" - TransferLine."Available Inventory") > 0 then
                                TransferLine."Shortage Qty" := TransferLine."Quantity (Base)" - TransferLine."Available Inventory"
                            else
                                TransferLine."Shortage Qty" := 0;
                            TransferLine.Modify();
                        until TransferLine.Next() = 0;
                end;
            }
        }
        /*modify("Attached Gate Entry")
        {
            Visible = false;
        }*/
        addlast(Warehouse)
        {
            group("Delivery Challan")
            {
                action("RDC Out List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = InwardEntry;
                    RunObject = page "Posted RGP Out List";
                    RunPageLink = "Reference No." = field("No.");
                    ToolTip = 'View attached gate entry list.';
                    Caption = 'RDC Out List';
                }
                action("RDC IN List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = InwardEntry;
                    RunObject = page "Posted RGP IN List";
                    RunPageLink = "Reference No." = field("No.");
                    ToolTip = 'View attached gate entry list.';
                    Caption = 'RDC In List';
                }
                action("NRDC List")
                {
                    ApplicationArea = Basic, Suite;
                    Image = InwardEntry;
                    RunObject = page "Posted NRGP List";
                    RunPageLink = "Reference No." = field("No.");
                    ToolTip = 'View attached gate entry list.';
                    Caption = 'NRDC List';
                }

            }
        }
        modify("Re&lease")
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
            end;
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            var
                ProdOrder: Record "Production Order";
                ProdOrderLine: Record "Prod. Order Line";
                PurhaseLine: Record "Purchase Line";
            begin
                Rec.TestField("Shortcut Dimension 1 Code");
                Rec.TestField("Shortcut Dimension 2 Code");
                /*if Rec."Subcon Order No." <> '' then begin
                    ProdOrder.Reset();
                    ProdOrder.SetRange("No.", "Subcon Order No.");
                    if ProdOrder.FindFirst() then begin
                        if (Rec."Shortcut Dimension 1 Code" <> ProdOrder."Shortcut Dimension 1 Code") or ("Shortcut Dimension 2 Code" <> ProdOrder."Shortcut Dimension 2 Code") then
                            Error('Please Select the Correct Division And Project Codes Same as in Rpo-%1,%2', ProdOrder."Shortcut Dimension 1 Code", ProdOrder."Shortcut Dimension 2 Code");
                        ProdOrderLine.Reset();
                        ProdOrderLine.SetRange("Prod. Order No.", ProdOrder."No.");
                        ProdOrderLine.SetRange("Subcontracting Order", true);
                        if ProdOrderLine.FindFirst() then begin
                            PurhaseLine.Reset();
                            PurhaseLine.SetRange("Document No.", ProdOrderLine."Purchase Order No.");
                            PurhaseLine.SetRange("Line No.", ProdOrderLine."Purchase Order Line No.");
                            if PurhaseLine.FindFirst() then begin
                                if PurhaseLine."Location Code" <> Rec."Transfer-to Code" then
                                    Error('Please Select The Correct Location Same As In Purchase Order-%1', PurhaseLine."Location Code");
                            end;
                        end;
                    end;
                end;*/
            end;
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Shortcut Dimension 2 Code_B2B" = '' then
            Rec."Shortcut Dimension 2 Code_B2B" := Rec."Shortcut Dimension 2 Code";
        if Rec."Production Order No." <> '' then
            BoolGvar := true
        else
            BoolGvar := false;
    end;

    var
        myInt: Integer;
        BoolGvar: Boolean;
        Cu: Codeunit 90;
        CUPo: Codeunit 18548;
}
page 50036 "Posted RGP Out"
{
    Caption = 'Posted RDC Out Document';
    Editable = false;
    PageType = Document;
    SourceTable = "Posted Gate Pass Header";
    SourceTableView = WHERE(Status = FILTER(Posted),
                            "Document Type" = FILTER("RGP Out"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Consignee Type"; Rec."Consignee Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Type field.';
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Consignee City"; Rec."Consignee City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee City field.';
                }
                field("Consignee Contact"; Rec."Consignee Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Contact field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Responsible Person Code"; Rec."Responsible Person Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Person Code field.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Person field.';
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                }

                field("Reference Type"; Rec."Reference Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Reference Type field.';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Reference No. field.';
                }
                field("Excise Challan Date"; Rec."Excise Challan Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference Date(If any) field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approval Status field.';
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                }
                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Value field.';
                }
                field("Doc. Receipt Date"; Rec."Doc. Receipt Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Doc. Receipt Date field.';
                }
                field("Way Bill No."; Rec."Way Bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Way Bill No. field.';
                }

            }
            part(Lines; "Posted RGP Out Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = WHERE(Status = FILTER(Posted));
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&RGP Out")
            {
                Caption = '&RGP Out';
                action("&List")
                {
                    Caption = '&List';
                    Image = List;
                    ShortCutKey = 'F5';
                    ApplicationArea = All;
                    ToolTip = 'Executes the &List action.';

                    trigger OnAction()
                    begin
                        PRGPout.RESET;
                        PRGPout.SETRANGE("Document Type", Rec."Document Type"::"RGP Out");
                        PRGPout.SETRANGE("Equipment No", EqptNo);
                        PRGPout.SETRANGE(Status, PRGPout.Status::Posted);
                        PAGE.RUN(Page::"Posted RGP Out List", PRGPout);
                    end;
                }
                action("RGP Ledger Entries")
                {
                    Caption = 'RGP Ledger Entries';
                    Image = LedgerEntries;
                    ApplicationArea = All;
                    ToolTip = 'Executes the RGP Ledger Entries action.';

                    trigger OnAction()
                    begin
                        GPLedgerEntry.SETRANGE(GPLedgerEntry."Source No.", Rec."No.");
                        GPLedgerEntry.SETRANGE(GPLedgerEntry."Source Type", Rec."Document Type");

                        GpLedgerEntryForm.SETTABLEVIEW(GPLedgerEntry);
                        GpLedgerEntryForm.RUNMODAL;
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the &Print action.';

                trigger OnAction()
                begin
                    // if Rec."Total Value" > 50000 then
                    //    Message('Way Bill Is Required For Document-%1', Rec."No.");
                    PRGPout.SETRANGE("Document Type", Rec."Document Type");
                    PRGPout.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(50018, TRUE, FALSE, PRGPout);
                end;
            }
            action("Outward Gate Entry")
            {
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                /* RunObject = page "Outward Gate Entry";
               RunPageLink =  = field("No.");*/

                trigger OnAction()
                var
                    GateEntryHdr: Record "Gate Entry Header";
                begin
                    GateEntryHdr.Reset();
                    GateEntryHdr.SetRange("RDC List", Rec."No.");
                    if GateEntryHdr.FindFirst() then
                        Page.RunModal(Page::"Outward Gate Entry", GateEntryHdr);
                end;
            }

            action("Create Outward Gate Entry")
            {
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Createoutward();
                end;
            }
        }
    }
    procedure Createoutward()
    var
        GateEntryHdr: Record "Gate Entry Header";
        GateEntryLine: Record "Gate Entry Line";
        PostedGatePassLine: Record "Posted Gate Pass Line";
        InventorySetup: Record "Inventory Setup";
        Noseries: Codeunit NoSeriesManagement;
    begin
        InventorySetup.Get();

        GateEntryHdr.Init();
        GateEntryHdr."Entry Type" := GateEntryHdr."Entry Type"::Outward;
        GateEntryHdr."No." := Noseries.GetNextNo(InventorySetup."Outward Gate Entry Nos.", WorkDate(), true);
        // GateEntryHdr."Location Code" := Rec."Location Code";
        GateEntryHdr."RDC List" := rec."No.";
        GateEntryHdr.Insert(true);
        //  if Rec."Reference Type"=rec."Reference Type"::
        PostedGatePassLine.Reset();
        PostedGatePassLine.SetRange("Document No.", "No.");
        //PostedGatePassLine.SetRange("Document Type","Document Type"::);
        if PostedGatePassLine.FindSet() then begin
            repeat

                GateEntryLine.Init();
                GateEntryLine."Line No." := PostedGatePassLine."Line No.";
                GateEntryLine."Entry Type" := GateEntryHdr."Entry Type"::Outward;
                GateEntryLine."Gate Entry No." := GateEntryHdr."No.";
                if Rec."Reference Type" = rec."Reference Type"::"Purchase Order" then
                    GateEntryLine.Validate(GateEntryLine."Source Type", GateEntryLine."Source Type"::"Purchase Order") else
                    if Rec."Reference Type" = rec."Reference Type"::"Purchase Return Shipment" then
                        GateEntryLine.Validate(GateEntryLine."Source Type", GateEntryLine."Source Type"::"Purchase Return Shipment") else
                        if Rec."Reference Type" = rec."Reference Type"::"Sales Shipment" then
                            GateEntryLine.Validate(GateEntryLine."Source Type", GateEntryLine."Source Type"::"Sales Shipment") else
                            if Rec."Reference Type" = rec."Reference Type"::"Transfer Shipment" then
                                GateEntryLine.Validate(GateEntryLine."Source Type", GateEntryLine."Source Type"::"Transfer Shipment") else
                                if Rec."Reference Type" = rec."Reference Type"::Inspection then
                                    GateEntryLine.Validate(GateEntryLine."Source Type", GateEntryLine."Source Type"::Inspection);
                GateEntryLine."Source No." := "Reference No.";
                GateEntryLine.Quantity := PostedGatePassLine.Quantity;
                GateEntryLine."Challan No." := GateEntryHdr."RDC List";
                GateEntryLine.Insert();
            until PostedGatePassLine.Next() = 0;
            Message('Outward create sucessfully');
        end;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
    end;

    trigger OnOpenPage()
    begin
        Rec.SETRANGE("Equipment No", EqptNo);
    end;

    var
        GPLedgerEntry: Record "GP Ledger Entry";
        GpLedgerEntryForm: Page "GP Ledger Entries";
        EqptNo: Code[20];
        PRGPout: Record "Posted Gate Pass Header";


    procedure GetEqptNo(EqptNoLoc: Code[20])
    begin
        EqptNo := EqptNoLoc;
    end;
}


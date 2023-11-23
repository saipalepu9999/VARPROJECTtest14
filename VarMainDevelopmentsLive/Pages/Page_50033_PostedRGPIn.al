page 50033 "Posted RGP In"
{
    Caption = 'Posted RDC In Document';
    Editable = false;
    PageType = Document;
    SourceTable = "Posted Gate Pass Header";
    SourceTableView = WHERE(Status = FILTER(Posted),
                            "Document Type" = FILTER("RGP In"));

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
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Reference No."; "Reference No.")
                {
                    ApplicationArea = all;
                }
                field("Reference Type"; "Reference Type")
                {
                    ApplicationArea = all;
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
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
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
                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Value field.';
                }
                field("Posted RDC No."; Rec."Posted RDC No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted RDC No. field.';
                }
                field("Way Bill No."; Rec."Way Bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Way Bill No. field.';
                }
            }
            part(Lines; "Posted RGP In Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = WHERE(Status = FILTER(Posted),
                                    "Document Type" = FILTER("RGP In"));
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&RGP IN")
            {
                Caption = '&RGP IN';
                action("&List")
                {
                    Caption = '&List';
                    Image = List;
                    ShortCutKey = 'F5';
                    ApplicationArea = All;
                    ToolTip = 'Executes the &List action.';

                    trigger OnAction()
                    begin
                        PRGPheader.RESET;
                        PRGPheader.SETRANGE("Document Type", Rec."Document Type"::"RGP In");
                        PRGPheader.SETRANGE("Equipment No", EqptNo);
                        PAGE.RUN(Page::"Posted RGP Header List", PRGPheader);
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
                    PRGPheader.SETRANGE("Document Type", Rec."Document Type");
                    PRGPheader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(50018, TRUE, FALSE, PRGPheader);
                end;
            }
            action("Inward Gate Entry")
            {
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                // RunObject = page "Inward Gate Entry";
                //RunPageLink = "RDC List" = field("No.");
                trigger OnAction()
                var
                    GateEntryHdr: Record "Gate Entry Header";
                begin
                    GateEntryHdr.Reset();
                    GateEntryHdr.SetRange("RDC List", Rec."No.");
                    if GateEntryHdr.FindFirst() then
                        Page.RunModal(Page::"Inward Gate Entry", GateEntryHdr);
                end;
            }
            action("Create Inward Gate Entry")
            {
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    CreateInward();
                end;
            }
        }
    }
    procedure CreateInward()
    var
        GateEntryHdr: Record "Gate Entry Header";
        GateEntryLine: Record "Gate Entry Line";
        InventorySetup: Record "Inventory Setup";
        Noseries: Codeunit NoSeriesManagement;
        PostedGatePassLine: Record "Posted Gate Pass Line";
    begin
        InventorySetup.Get();

        GateEntryHdr.Init();
        GateEntryHdr."Entry Type" := GateEntryHdr."Entry Type"::Inward;
        GateEntryHdr."No." := Noseries.GetNextNo(InventorySetup."Inward Gate Entry Nos.", WorkDate(), true);
        //  GateEntryHdr."Location Code" := Rec."Location Code";
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
                GateEntryLine."Entry Type" := GateEntryHdr."Entry Type"::Inward;
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
                                    GateEntryLine.Validate(GateEntryLine."Source Type", GateEntryLine."Source Type"::Inspection) else
                                    if Rec."Reference Type" = rec."Reference Type"::"Posted Purchase Receipt " then
                                        GateEntryLine.Validate(GateEntryLine."Source Type", GateEntryLine."Source Type"::"Posted Purchase Receipt");
                GateEntryLine."Source No." := "Reference No.";
                GateEntryLine.Quantity := PostedGatePassLine.Quantity;

                GateEntryLine.Insert();
            until PostedGatePassLine.Next() = 0;
            Message('Inward create sucessfully');
        end;
    end;

    trigger OnOpenPage()
    begin
        Rec.SETRANGE("Equipment No", EqptNo);
    end;

    var
        PRGPheader: Record "Posted Gate Pass Header";
        EqptNo: Code[20];


    procedure GetEqptNo(EqptNoLoc: Code[20])
    begin
        EqptNo := EqptNoLoc;
    end;
}


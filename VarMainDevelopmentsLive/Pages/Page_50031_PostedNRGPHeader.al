page 50031 "Posted NRGP Header"
{
    Editable = false;
    PageType = Document;
    SourceTable = "NRGP Header";
    Caption = 'Posted NRDC Document';
    SourceTableView = WHERE(Status = FILTER(Posted));
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No. "; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
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
                field("Consignee Name 2"; Rec."Consignee Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Name 2 field.';
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Telex No. field.';
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
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
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
                    ApplicationArea = all;
                    Caption = 'Reference Date';
                    ToolTip = 'Specifies the value of the Reference Date field.';
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = all;
                }
                field("Posting No"; "Posting No")
                {
                    ApplicationArea = all;
                }

            }
            part(NRGPLine; "NRGP Sub Form")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");

            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("&Dimensions")
                {
                    Caption = '&Dimensions';
                    Ellipsis = true;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                    ToolTip = 'Executes the &Dimensions action.';

                    trigger OnAction()
                    var
                        Text050: Label 'There is nothing to post';
                        Text051: Label 'Do you want to post %1?';
                    begin
                        CurrPage.NRGPLine.PAGE.ShowDimensionsNew;
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
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the &Print action.';

                trigger OnAction()
                begin
                    NRGP.SETRANGE(Status, NRGP.Status::Posted);
                    NRGP.SETRANGE("Document Type", Rec."Document Type");
                    NRGP.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(50048, TRUE, FALSE, NRGP);
                end;
            }
            action("Outward Gate Entry")
            {
                ApplicationArea = All;
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Outward Gate Entry";
                RunPageLink = "NRDC List" = field("No.");
                /*trigger OnAction()
                var
                    GateEntryHdr: Record "Gate Entry Header";
                begin
                    GateEntryHdr.Reset();
                    GateEntryHdr.SetRange("NRDC List", Rec."No.");
                    if GateEntryHdr.FindFirst() then
                        Page.RunModal(Page::"Outward Gate Entry", GateEntryHdr);
                end;*/
                /* trigger OnAction()
                 var
                     GateEntryHdr: Record "Gate Entry Header";
                 begin
                     GateEntryHdr.Reset();
                     GateEntryHdr.SetRange("NRDC List", Rec."No.");
                     if GateEntryHdr.FindFirst() then
                         Page.RunModal(Page::"Outward Gate Entry", GateEntryHdr);
                 end;*/
            }
            action(" Create Outward Gate Entry")
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
        InventorySetup: Record "Inventory Setup";
        Noseries: Codeunit NoSeriesManagement;
    begin
        InventorySetup.Get();

        GateEntryHdr.Init();
        GateEntryHdr."Entry Type" := GateEntryHdr."Entry Type"::Outward;
        GateEntryHdr."No." := Noseries.GetNextNo(InventorySetup."Outward Gate Entry Nos.", WorkDate(), true);
        GateEntryHdr."Location Code" := Rec."Location Code";
        GateEntryHdr."NRDC List" := rec."No.";
        GateEntryHdr.Insert(true);
        //  if Rec."Reference Type"=rec."Reference Type"::
        NRGPLine.Reset();
        NRGPLine.SetRange("Document No.", "No.");
        //NRGPLine.SetRange("Document Type","Document Type"::);
        if NRGPLine.FindSet() then begin
            repeat

                GateEntryLine.Init();
                GateEntryLine."Line No." := NRGPLine."Line No.";
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
                                    GateEntryLine.Validate(GateEntryLine."Source Type", GateEntryLine."Source Type"::Inspection) else
                                    if Rec."Reference Type" = rec."Reference Type"::"Posted Purchase Receipt" then
                                        GateEntryLine.Validate(GateEntryLine."Source Type", GateEntryLine."Source Type"::"Posted Purchase Receipt");
                GateEntryLine."Source No." := "Reference No.";
                GateEntryLine.Quantity := NRGPLine.Quantity;
                GateEntryLine."Challan No." := GateEntryHdr."NRDC List";

                GateEntryLine.Insert();
            until NRGPLine.Next() = 0;
            Message('Outward create sucessfully');
        end;


    end;

    var
        NRGP: Record "NRGP Header";
        NRGPLine: Record "NRGP Line";
        NRGPPost: Codeunit "NRGP Post";
        Text050: Label 'There is nothing to post';
        Text051: Label 'Do you want to post?';
}


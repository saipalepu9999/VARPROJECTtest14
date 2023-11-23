page 50040 "RGP In"
{
    Caption = 'RDC In Document';
    PageType = Document;
    SourceTable = "Gate Pass Header";
    SourceTableView = WHERE("Document Type" = FILTER("RGP In"));
    //Editable = false;

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
                field("External Document No.";
                Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }

                field("Excise Challan No."; Rec."Excise Challan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference No.(If any) field.';
                }
                field("Excise Challan Date"; Rec."Excise Challan Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference Date(If any) field.';
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
                field("Way Bill No."; Rec."Way Bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Way Bill No. field.';
                }
            }
            part("RGP Lines"; "RGP In Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = WHERE(Status = FILTER("Not Posted"),
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
                    ShortCutKey = 'F5';
                    ApplicationArea = All;
                    ToolTip = 'Executes the &List action.';

                    trigger OnAction()
                    begin
                        GPInHeader.RESET;
                        GPInHeader.SETRANGE("Document Type", Rec."Document Type"::"RGP In");
                        GPInHeader.SETRANGE("Equipment No", EqptNo);
                        PAGE.RUN(Page::"RGP Header List", GPInHeader);
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Get RGP Out")
                {
                    Caption = 'Get RGP Out';
                    ApplicationArea = All;
                    ToolTip = 'Executes the Get RGP Out action.';

                    trigger OnAction()
                    begin
                        InsertRGPOutLines;
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                action("P&ost")
                {
                    Caption = 'P&ost';
                    Ellipsis = true;
                    ShortCutKey = 'F11';
                    ApplicationArea = All;
                    ToolTip = 'Executes the P&ost action.';

                    trigger OnAction()
                    var
                        Text050: Label 'There is nothing to post';
                        Text051: Label 'Do you want to post ?';
                    begin
                        Rec.TESTFIELD("Consignee No.");
                        Rec.TESTFIELD("Posting Date");
                        GPInLine.SETRANGE("Document No.", Rec."No.");
                        IF NOT GPInLine.FIND('-') THEN
                            ERROR(Text050)
                        ELSE
                            GPInLine.TESTFIELD("Remaining Quantity");

                        IF CONFIRM(Text051, FALSE, Rec."No.") THEN BEGIN
                            Rec.PostRGPIN(Rec);
                            CurrPage.UPDATE;
                        END;
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
                Visible = false;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the &Print action.';

                trigger OnAction()
                begin
                    GPInHeader.SETRANGE("Document Type", Rec."Document Type");
                    GPInHeader.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(50018, TRUE, FALSE, GPInHeader);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Equipment No", EqptNo);

        Rec."Posting Date" := TODAY;
    end;

    var
        GPInLine: Record "Gate Pass Line";
        GPInHeader: Record "Gate Pass Header";
        PGPOutLine: Record "Posted Gate Pass Line";
        PGPOutHeader: Record "Posted Gate Pass Header";
        GatePassInLine: Record "Gate Pass Line";
        "LineNo.": Integer;
        "DocNo.": Code[20];
        Text000: Label 'No Matched Consignee.';
        GpOut: Record "Gate Pass Header";
        Text001: Label 'There Is Nothing to Release for Indent %1';
        EqptNo: Code[20];
        PRGPILine: Record "Posted Gate Pass Line";
        Qtyrecieved: Decimal;
        "B2B.1.0": Integer;
        PostedGatePassHeaderRec: Record "Posted Gate Pass Header";


    procedure InsertRGPOutLines()
    var
        Number: Code[20];
    begin
        PGPOutHeader.SETRANGE(PGPOutHeader."Document Type", PGPOutHeader."Document Type"::"RGP Out");
        PGPOutHeader.SETRANGE("Consignee Type", Rec."Consignee Type");
        PGPOutHeader.SETRANGE("Consignee No.", Rec."Consignee No.");
        PGPOutHeader.SETRANGE("Equipment No", EqptNo);
        //IF PAGE.RUNMODAL(50116,PGPOutHeader) = ACTION::LookupOK THEN BEGIN //B2B.1.0
        IF PAGE.RUNMODAL(0, PGPOutHeader) = ACTION::LookupOK THEN BEGIN
            PGPOutLine.RESET;
            PGPOutLine.SETRANGE("Document Type", PGPOutHeader."Document Type"::"RGP Out");
            PGPOutLine.SETRANGE("Document No.", PGPOutHeader."No.");
            PGPOutLine.SETFILTER("Remaining Quantity", '<>%1', 0);
            IF PGPOutLine.FIND('-') THEN
                REPEAT
                    CLEAR(Qtyrecieved);
                    PRGPILine.RESET;
                    PRGPILine.SETRANGE(PRGPILine."Document Type", PRGPILine."Document Type"::"RGP In");
                    PRGPILine.SETRANGE(PRGPILine."Applies GP No", PGPOutHeader."No.");
                    IF PRGPILine.FINDFIRST THEN
                        REPEAT
                            Qtyrecieved += PRGPILine."Recieved Qty";
                        UNTIL PRGPILine.NEXT = 0;
                    GatePassInLine.INIT;
                    GatePassInLine."Document No." := Rec."No.";
                    GatePassInLine."Document Type" := Rec."Document Type"::"RGP In";
                    GatePassInLine."Line No." := GatePassInLine."Line No." + 10000;
                    GatePassInLine.Type := PGPOutLine.Type;
                    GatePassInLine."No." := PGPOutLine."No.";
                    GatePassInLine.Description := PGPOutLine.Description;
                    GatePassInLine."Unit of Measure" := PGPOutLine."Unit of Measure";
                    GatePassInLine."Applies GP No" := PGPOutLine."Document No.";
                    GatePassInLine.VALIDATE(Quantity, PGPOutLine.Quantity);
                    GatePassInLine."Recieved Qty" := Qtyrecieved;
                    GatePassInLine."Remaining Quantity" := PGPOutLine."Remaining Quantity";
                    GatePassInLine.Remarks := PGPOutLine.Remarks;
                    GatePassInLine.INSERT;
                UNTIL PGPOutLine.NEXT = 0;
            //B2B.1.0
            PostedGatePassHeaderRec.RESET;
            PostedGatePassHeaderRec.SETRANGE("No.", PGPOutLine."Document No.");
            IF PostedGatePassHeaderRec.FINDFIRST THEN BEGIN
                Rec."Responsible Person Code" := PostedGatePassHeaderRec."Responsible Person Code";
                Rec."Responsible Person" := PostedGatePassHeaderRec."Responsible Person";
                Rec.MODIFY;
            END;
            //B2B.1.0
        END;
    end;


    procedure GetEqptNo(EqptNoLoc: Code[20])
    begin
        EqptNo := EqptNoLoc;
    end;
}


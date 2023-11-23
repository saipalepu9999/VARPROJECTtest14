page 50049 "NRGP Header"
{
    Caption = 'NRDC Document';
    PageType = Document;
    SourceTable = "NRGP Header";
    SourceTableView = WHERE(Status = FILTER("Not Posted"));

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
                    Editable = false;
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
                    ApplicationArea = all;
                    Caption = 'Reference Date';
                    ToolTip = 'Specifies the value of the Reference Date field.';
                }


            }
            part(NRGPLine; "NRGP Sub Form")
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
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
                        Text051: Label 'Do you want to post %1?';
                    begin
                        if (rec."Consignee Type" <> Rec."Consignee Type"::Transfer) then
                            Rec.TESTFIELD("Consignee No.");
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField("Global Dimension 2 Code");
                        Rec.TestField("Posting Date");
                        rec.TestField("Location Code");
                        //      TestField("Posting No");
                        NRGPLine.SETRANGE("Document No.", Rec."No.");
                        IF NOT NRGPLine.FIND('-') THEN
                            ERROR(Text050);
                        //     TestField("Posting No");
                        IF CONFIRM(Text051, FALSE, Rec."No.") THEN BEGIN
                            PostedNRdc();
                            rec.Delete(true)

                        END;
                    end;
                }
            }//
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
                    NRGP.SETRANGE("Document Type", Rec."Document Type");
                    NRGP.SETRANGE("No.", Rec."No.");
                    REPORT.RUN(50048, TRUE, FALSE, NRGP);
                end;
            }
        }
    }
    local procedure PostedNRdc()
    var
        myInt: Integer;
        PostedNRdcHdr: Record "NRGP Header";
        NrgpLine: Record "NRGP Line";
        POstedNRGPlineVar: Record "NRGP Line";
        NoseriesMgmt: Codeunit NoSeriesManagement;

    begin
        PostedNRdcHdr.Reset();
        PostedNRdcHdr.SetRange("No.", Rec."No.");
        if PostedNRdcHdr.FindFirst() then begin
            PostedNRdcHdr.Init();
            IF "Global Dimension 1 Code" = 'DOM' then
                PostedNRdcHdr."No." := NoseriesMgmt.GetNextNo('NRDC-DOM', WorkDate(), true);

            IF "Global Dimension 1 Code" = 'EOU' then
                PostedNRdcHdr."No." := NoseriesMgmt.GetNextNo('NRDC -EOU', WorkDate(), true);

            IF ("Global Dimension 1 Code" = 'DOM') then begin
                IF ((REC."Consignee Type" = "Consignee Type"::Customer) AND (REC."Reference Type" = Rec."Reference Type"::"Sales Shipment")) THEN
                    PostedNRdcHdr."No." := NoseriesMgmt.GetNextNo('NRDC-DOM-SDC', WorkDate(), true)
            END;
            IF ("Global Dimension 1 Code" = 'EOU') then begin
                IF ((REC."Consignee Type" = "Consignee Type"::Customer) AND (REC."Reference Type" = Rec."Reference Type"::"Sales Shipment")) THEN
                    PostedNRdcHdr."No." := NoseriesMgmt.GetNextNo('NRDC-EOU-SDC', WorkDate(), true)
            END;

            IF ("Global Dimension 1 Code" = 'DOM') then begin
                IF ((REC."Consignee Type" = "Consignee Type"::Vendor) AND (REC."Reference Type" = Rec."Reference Type"::"Transfer Shipment")) THEN
                    PostedNRdcHdr."No." := NoseriesMgmt.GetNextNo('JOB-DOM', WorkDate(), true)
            END;
            IF ("Global Dimension 1 Code" = 'EOU') then begin
                IF ((REC."Consignee Type" = "Consignee Type"::Vendor) AND (REC."Reference Type" = Rec."Reference Type"::"Transfer Shipment")) THEN
                    PostedNRdcHdr."No." := NoseriesMgmt.GetNextNo('JOB-EOU', WorkDate(), true)
            END;

            PostedNRdcHdr."Consignee Type" := rec."Consignee Type";
            PostedNRdcHdr."Consignee No." := rec."Consignee No.";
            PostedNRdcHdr."Consignee Name" := Rec."Consignee Name";
            PostedNRdcHdr."Consignee Name 2" := rec."Consignee Name 2";
            PostedNRdcHdr.Address := Rec.Address;
            PostedNRdcHdr."Consignee City" := rec."Consignee City";
            PostedNRdcHdr."Consignee Contact" := rec."Consignee Contact";
            PostedNRdcHdr."Phone No." := rec."Phone No.";
            PostedNRdcHdr."Reference Type" := Rec."Reference Type";
            PostedNRdcHdr."Reference No." := Rec."Reference No.";
            PostedNRdcHdr."Posted Date" := rec."Posted Date";
            PostedNRdcHdr."Posting Date" := rec."Posting Date";
            PostedNRdcHdr."Location Code" := rec."Location Code";
            PostedNRdcHdr.Status := PostedNRdcHdr.Status::Posted;
            PostedNRdcHdr."External Document No." := rec."External Document No.";
            PostedNRdcHdr."Responsible Person" := Rec."Responsible Person";
            PostedNRdcHdr."Responsible Person Code" := rec."Responsible Person Code";
            PostedNRdcHdr."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
            PostedNRdcHdr."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
            PostedNRdcHdr."Excise Challan Date" := rec."Excise Challan Date";
            PostedNRdcHdr."Posting No" := rec."Posting No";

            NrgpLine.Reset();
            NrgpLine.SetRange("Document No.", Rec."No.");
            if NrgpLine.FindSet() then begin
                repeat
                    POstedNRGPlineVar.Init();
                    POstedNRGPlineVar."Line No." := NrgpLine."Line No.";
                    POstedNRGPlineVar.Type := NrgpLine.Type;
                    POstedNRGPlineVar."Document No." := PostedNRdcHdr."No.";
                    POstedNRGPlineVar."No." := NrgpLine."No.";
                    POstedNRGPlineVar."Document Type" := NrgpLine."Document Type";
                    POstedNRGPlineVar.Description := NrgpLine.Description;
                    POstedNRGPlineVar."Unit of Measure" := NrgpLine."Unit of Measure";
                    POstedNRGPlineVar.Quantity := NrgpLine.Quantity;
                    POstedNRGPlineVar.Remarks := NrgpLine.Remarks;
                    POstedNRGPlineVar."Quantity Received" := NrgpLine."Quantity Received";
                    POstedNRGPlineVar."Quantity to Receive" := NrgpLine."Quantity to Receive";
                    POstedNRGPlineVar."Remaining Quantity" := NrgpLine."Remaining Quantity";
                    POstedNRGPlineVar."Expected Return Date" := NrgpLine."Expected Return Date";
                    POstedNRGPlineVar.Insert()
                until NrgpLine.Next() = 0;
            end;
        end;
        PostedNRdcHdr.Insert();
    end;

    var
        NRGPLine: Record "NRGP Line";
        NRGPPost: Codeunit "NRGP Post";
        Text050: Label 'There is nothing to post';
        Text051: Label 'Do you want to post?';
        NRGP: Record "NRGP Header";
        NoseriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Record "No. Series";
}


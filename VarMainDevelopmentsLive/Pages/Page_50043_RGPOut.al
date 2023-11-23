page 50043 "RGP Out"
{
    Caption = 'RDC Document';
    DeleteAllowed = false;
    PageType = Document;
    SourceTable = "Gate Pass Header";
    SourceTableView = SORTING("Document Type", "No.")
                      WHERE("Document Type" = FILTER("RGP Out"));

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
                    Editable = RGPEditableGvar;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Type field.';
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    Editable = RGPEditableGvar;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    Editable = RGPEditableGvar;
                    Enabled = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                }
                field(Address; Rec.Address)
                {
                    Editable = RGPEditableGvar;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Consignee City"; Rec."Consignee City")
                {
                    Editable = RGPEditableGvar;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee City field.';
                }
                field("Consignee Contact"; Rec."Consignee Contact")
                {
                    Editable = RGPEditableGvar;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Contact field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';

                    trigger OnValidate()
                    begin
                        IF Rec."Posting Date" < Rec."Created Date" THEN
                            ERROR(Text50005, Rec."Posting Date");
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = RGPEditableGvar;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    //TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                    /*trigger OnLookup(var Text: Text): Boolean
                    begin
                        //B2B1.0 >>2wdqw2
                        UserSetup.INIT;
                        UserSetup.SETRANGE("User ID", UPPERCASE(USERID));
                        UserSetup.SETRANGE("Assign Security Filter", TRUE);
                        IF UserSetup.FIND('-') THEN
                            SD := UserSetup."Global Dimension 1 Filter";
                        IF SD <> '' THEN BEGIN
                            Y := 'WHERE("Global Dimension No." =CONST(1),Code=FILTER(' + SD + '))';
                            DimensionValueGRec.FILTERGROUP(2);
                            DimensionValueGRec.SETVIEW(Y);
                            DimensionValueGRec.FILTERGROUP(0);
                        END ELSE BEGIN
                            Y := 'WHERE("Global Dimension No." =CONST(1))';
                            DimensionValueGRec.FILTERGROUP(2);
                            DimensionValueGRec.SETVIEW(Y);
                            DimensionValueGRec.FILTERGROUP(0);
                        END;

                        IF PAGE.RUNMODAL(0, DimensionValueGRec) = ACTION::LookupOK THEN
                            Rec."Global Dimension 1 Code" := DimensionValueGRec.Code;
                        //B2B1.0 <<
                    end;*/
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = RGPEditableGvar;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
                    //TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                    /*trigger OnLookup(var Text: Text): Boolean
                    begin
                        //B2B1.0 >>
                        UserSetup.INIT;
                        UserSetup.SETRANGE("User ID", UPPERCASE(USERID));
                        UserSetup.SETRANGE("Assign Security Filter", TRUE);
                        IF UserSetup.FIND('-') THEN
                            SD2 := UserSetup."Global Dimension 2 Filter";
                        IF SD2 <> '' THEN BEGIN
                            //Z:='WHERE("Global Dimension No." =CONST(2),Consolidation Code=FIELD(Rec.Shortcut Dimension 1 Code),Code=FILTER(' + SD2 + '))';
                            DimensionValue2GRec.FILTERGROUP(2);
                            DimensionValue2GRec.SETRANGE("Global Dimension No.", 2);
                            DimensionValue2GRec.SETRANGE("Consolidation Code", Rec."Global Dimension 1 Code");
                            DimensionValue2GRec.SETFILTER(Code, '=%1', SD2);
                            IF DimensionValue2GRec.FINDSET THEN;
                            DimensionValue2GRec.FILTERGROUP(0);
                        END ELSE BEGIN
                            //Z:='WHERE("Global Dimension No." =CONST(2),Consolidation Code=FIELD(Rec.Shortcut Dimension 1 Code))';
                            DimensionValue2GRec.FILTERGROUP(2);
                            DimensionValue2GRec.SETRANGE("Global Dimension No.", 2);
                            DimensionValue2GRec.SETRANGE("Consolidation Code", Rec."Global Dimension 1 Code");
                            IF DimensionValue2GRec.FINDSET THEN;
                            DimensionValue2GRec.FILTERGROUP(0);
                        END;

                        IF PAGE.RUNMODAL(0, DimensionValue2GRec) = ACTION::LookupOK THEN
                            Rec."Global Dimension 2 Code" := DimensionValue2GRec.Code;
                        //B2B1.0 <<
                    end;*/
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
                field("Responsible Person Code"; Rec."Responsible Person Code")
                {
                    Editable = RGPEditableGvar;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Person Code field.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Person field.';
                }
                field(Shipped; Rec.Shipped)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipped field.';
                }
                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Value field.';
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Mode of Transport"; Rec."Mode of Transport")
                {
                    Editable = RGPEditableGvar;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mode of Transport field.';
                }
                field("Location Code"; "Location Code")
                {
                    Editable = RGPEditableGvar;

                    ApplicationArea = all;
                }
                field("Equipment No"; "Equipment No")
                {
                    ApplicationArea = all;
                }

                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    //Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created Date field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Editable = RGPEditableGvar;
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
                field("Posted By"; Rec."Posted By")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted By field.';
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posted Date field.';
                }
                field("Doc. Receipt Date"; Rec."Doc. Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Doc. Receipt Date field.';

                    trigger OnValidate()
                    begin
                        Rec."Documented By" := USERID;
                    end;
                }
                field("Way Bill No."; Rec."Way Bill No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Way Bill No. field.';
                }


            }
            part(Lines; "RGPOut Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
                SubPageView = WHERE(Status = FILTER("Not Posted"));
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
                    Caption = 'Posted RDC Out LIst';
                    Image = List;
                    ShortCutKey = 'F5';
                    ApplicationArea = All;
                    ToolTip = 'Executes the &List action.';

                    trigger OnAction()
                    begin
                        PostedGatePassHeaderGRec.RESET;
                        PostedGatePassHeaderGRec.SETRANGE("Document Type", Rec."Document Type"::"RGP Out");
                        PostedGatePassHeaderGRec.SETRANGE("Equipment No", EqptNo);
                        PAGE.RUN(Page::"Posted RGP Out List", PostedGatePassHeaderGRec);
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
                    Image = Post;
                    ShortCutKey = 'F11';
                    ApplicationArea = All;
                    ToolTip = 'Executes the P&ost action.';

                    trigger OnAction()
                    var
                        Text050: Label 'There is nothing to post';
                        Text051: Label 'Do you want to post?';
                        Text011: Label 'Ship,Receive';
                        Selection: Integer;
                        GatePass: Record "Gate Pass Header";
                        Text0059: Label 'Nothing to post';
                        UserSetup1GRec: Record 91;
                        Text015: Label 'You do not have permission to Post RGP Out';
                        Text016: Label 'You do not have permission to Post RGP In';
                    begin
                        //B2B1.0 >>
                        /*IF UserSetup1GRec.GET(USERID) THEN BEGIN
                            IF NOT UserSetup1GRec."RGP Posting" THEN
                                ERROR(Text015);
                    END;*/ //Commented By B2BJK For RGP Process
                        //B2B1.0 <<

                        Rec.TESTFIELD("Approval Status", Rec."Approval Status"::Released);
                        Rec.TESTFIELD("Consignee No.");
                        Rec.TESTFIELD("Posting Date");
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField("Global Dimension 2 Code");
                        Rec.TestField("Location Code");
                        IF DateNotAllowed(Rec."Posting Date") THEN
                            ERROR(Text50003);
                        //Changed code as per Scenario.
                        //B2B1.0 >>
                        CLEAR(Ship);
                        CLEAR(Receive);
                        Selection := STRMENU(Text011, 1);
                        IF Selection = 0 THEN
                            EXIT;


                        GatePassLineGRec.RESET;
                        GatePassLineGRec.SETRANGE("Document Type", GatePassLineGRec."Document Type"::"RGP Out");
                        GatePassLineGRec.SETRANGE("Document No.", Rec."No.");
                        IF GatePassLineGRec.FINDSET THEN
                            REPEAT
                                GatePassLineGRec.CALCFIELDS("Quantity Received");
                                IF GatePassLineGRec.Quantity < (GatePassLineGRec."Quantity to Receive" + GatePassLineGRec."Quantity Received") THEN
                                    ERROR('Quantity to Receive should not exceed quantity.');
                            UNTIL GatePassLineGRec.NEXT = 0;

                        IF (Selection = 1) THEN BEGIN
                            GPLine.SETRANGE("Document No.", Rec."No.");
                            IF NOT GPLine.FIND('-') THEN
                                ERROR(Text050);

                            IF Rec.Shipped THEN
                                ERROR(Text0059);

                            PostOutputGVar := FALSE;

                            PostedGatePassHeaderGRec.RESET;
                            IF NOT PostedGatePassHeaderGRec.GET(PostedGatePassHeaderGRec."Document Type"::"RGP Out", Rec."No.") THEN
                                PostOutputGVar := TRUE;
                            //    Rec.TestField("Posting No RGP Out");
                            IF (PostOutputGVar = TRUE) THEN BEGIN
                                IF CONFIRM(Text051, FALSE, Rec."No.") THEN BEGIN
                                    Rec.PostRGPOut;


                                    MESSAGE('Materials Sent Successfully');
                                    RDCOut();
                                    // CurrPage.UPDATE;
                                END;
                            END;

                        END ELSE
                            IF (Selection = 2) THEN BEGIN
                                //B2B1.0 >>
                                /*IF UserSetup1GRec.GET(USERID) THEN BEGIN
                                    IF NOT UserSetup1GRec."RGP In Posting" THEN
                                        ERROR(Text016);
                                END;*/ //Commented By B2BJk For RGP Process
                                //B2B1.0 <<
                                Rec.TESTFIELD(Shipped, TRUE);
                                //  Rec.TestField("Posting No RGP in");
                                rec.TestField("Location Code");
                                GatePassLineGRec.RESET;
                                GatePassLineGRec.SETRANGE("Document Type", GatePassLineGRec."Document Type"::"RGP Out");
                                GatePassLineGRec.SETRANGE("Document No.", Rec."No.");
                                GatePassLineGRec.SETFILTER("Remaining Quantity", '<>%1', 0);
                                GatePassLineGRec.SETFILTER("Quantity to Receive", '<>%1', 0);
                                IF GatePassLineGRec.FINDSET THEN
                                    REPEAT
                                        GatePassLineGRec.CALCFIELDS("Quantity Received");
                                        GatePassLineGRec."Remaining Quantity" := GatePassLineGRec.Quantity - (GatePassLineGRec."Quantity to Receive" + GatePassLineGRec."Quantity Received");
                                        GatePassLineGRec."Quantity to Receive" := GatePassLineGRec."Quantity to Receive";
                                        GatePassLineGRec."Outstanding Amount" := (GatePassLineGRec."Remaining Quantity" * GatePassLineGRec."Unit Rate");
                                        GatePassLineGRec.MODIFY;
                                    UNTIL GatePassLineGRec.NEXT = 0;

                                GatePassLineGRec.RESET;
                                GatePassLineGRec.SETRANGE("Document Type", GatePassLineGRec."Document Type"::"RGP Out");
                                GatePassLineGRec.SETRANGE("Document No.", Rec."No.");
                                GatePassLineGRec.SETFILTER("Quantity to Receive", '<>%1', 0);
                                IF GatePassLineGRec.FINDFIRST THEN begin
                                    //IF (GatePassLineGRec."Quantity to Receive" <> 0) THEN BEGIN
                                    CreateRGPING;
                                    RDCIN();
                                    // Rec.Delete(true);


                                end ELSE
                                    ERROR(Text0059);
                            END;
                        //B2B1.0 <<
                        //Changed code as per Scenario.



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
                Visible = false;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                ToolTip = 'Executes the &Print action.';

                trigger OnAction()
                begin
                    GPout.RESET;
                    GPout.SETRANGE("Document Type", Rec."Document Type");
                    GPout.SETRANGE("No.", Rec."No.");
                    IF GPout.FINDFIRST THEN BEGIN
                        GPout.TESTFIELD("Approval Status", GPout."Approval Status"::Released);
                        REPORT.RUN(50018, TRUE, FALSE, GPout);
                    END;
                end;
            }
            action("Posted RGP IN List")
            {
                Caption = 'Posted RGP IN List';
                Image = List;
                RunObject = Page "Posted RGP IN List";
                RunPageLink = "RGP Out No." = FIELD("No.");
                ApplicationArea = All;
                ToolTip = 'Executes the Posted RGP IN List action.';
            }

            group(Approval)
            {
                Caption = 'Approval';
                /*
                action(Approve)
                {
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Reject)
                {
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                action(Delegate)
                {
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RECORDID);
                    end;
                }
                */
                action(Release)
                {
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Release action.';

                    trigger OnAction()
                    var
                        GatePassHdr: Record "Gate Pass Header";
                        NOSeries: Record "No. Series";
                    begin
                        /*
                        IF NOT  ApprovalMgt.IsRGPApprovalsWorkflowEnabled(Rec) THEN BEGIN
                          IF NOT CONFIRM(Text50000,FALSE) THEN
                            EXIT;
                          TESTFIELD("Approval Status","Approval Status" :: Open);
                          "Approval Status" := "Approval Status"::Released;
                          MODIFY;
                        END ELSE
                          ERROR(Text50001);
                        */
                        //ERROR('Please use Send Approval option');
                        // Rec.TESTFIELD("Approval Status", Rec."Approval Status"::"Pending Approval");
                        //SETFILTER("Approval Status",'<>%1',"Approval Status"::Open);
                        //IF Rec."Approval Status" = Rec."Approval Status"::"Pending Approval" THEN
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField("Global Dimension 2 Code");
                        Rec.CalcFields("Total Value");
                        //   rec.TestField("Posted Date");
                        rec.TestField("Location Code");
                        if "Total Value" > 50000 then
                            Rec.TestField("Way Bill No.");
                        Answer := DIALOG.CONFIRM('Do you want to Release ?', FALSE);
                        // IF Rec."Document Type" = REC."Document Type"::"RGP Out" then begin




                        if Answer then begin
                            Rec."Approval Status" := Rec."Approval Status"::Released;
                            Rec.Modify();
                        end;


                    end;
                }
                action("Re-Open")
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    ToolTip = 'Executes the Re-Open action.';

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Approval Status", Rec."Approval Status"::Released);
                        //B2B1.0 >>
                        IF Rec.Shipped THEN
                            ERROR(Text50004);
                        //B2B1.0 <<
                        IF NOT CONFIRM(Text50002, FALSE) THEN
                            EXIT;

                        Rec."Approval Status" := Rec."Approval Status"::Open;
                        Rec.MODIFY;
                    end;
                }
                /*
                action("Approval Comments")
                {
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Table ID" = CONST(50030),
                                  "Document No." = FIELD("No.");
                }
                action("Approval Entries List")
                {
                    Image = Entries;
                    RunObject = Page "Approval Entries";
                    RunPageLink = "Document No." = FIELD("No.");
                }
                */
            }
            /*
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Image = SendApprovalRequest;
                Visible = false;
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        GatePassLineGRec: Record 50031;
                        Text017: Label 'Quantity should not be less than or equal to Zero.';
                    begin
                        Rec.TESTFIELD("Approval Status", Rec."Approval Status"::Open);
                        //B2B1.0 >>
                        Rec.TESTFIELD("Responsible Person Code");
                        Rec.TESTFIELD("Shortcut Dimension 4 Code");
                        Rec.TESTFIELD("Global Dimension 2 Code");
                        Rec.TESTFIELD("Consignee No.");

                        GatePassLineGRec.RESET;
                        GatePassLineGRec.SETRANGE("Document Type", Rec."Document Type");
                        GatePassLineGRec.SETRANGE("Document No.", Rec."No.");
                        IF GatePassLineGRec.FINDSET THEN
                            REPEAT
                                GatePassLineGRec.TESTFIELD("Location Code");
                                GatePassLineGRec.TESTFIELD("Expected date of receipt");
                                GatePassLineGRec.TESTFIELD(Remarks);
                                GatePassLineGRec.TESTFIELD("Unit of Measure");
                                GatePassLineGRec.TESTFIELD(Type);
                                GatePassLineGRec.TESTFIELD(Description);
                                IF GatePassLineGRec.Quantity <= 0 THEN
                                    ERROR(Text017);
                            UNTIL GatePassLineGRec.NEXT = 0;
                        //B2B1.0 <<

                        IF ApprovalsMgmt.CheckRGPApprovalsWorkflowEnabled(Rec) THEN
                            ApprovalsMgmt.OnSendRGPForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = OpenApprovalEntriesExist;
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit 1535;
                    begin
                        ApprovalsMgmt.OnCancelRGPApprovalRequest(Rec);
                    end;
                }
            }
            */
        }
    }

    trigger OnAfterGetRecord()
    begin
        //RGPDocEdit;
        SetControlAppearance;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SAVERECORD;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //B2B1.0 >>
        Rec."Created By" := USERID;
        Rec."Created Date" := WORKDATE;
        //B2B1.0 <<
    end;

    trigger OnModifyRecord(): Boolean
    begin
        //TESTFIELD("Approval Status","Approval Status"::Open);
        //RGPDocEdit;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // RGPDocEdit;
    end;

    trigger OnOpenPage()
    begin
        Rec.SETFILTER("Equipment No", EqptNo);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        RGPDocEdit();
    end;

    var
        GPLine: Record "Gate Pass Line";
        GPout: Record "Gate Pass Header";
        EqptNo: Code[20];
        GatePassLineGRec: Record "Gate Pass Line";
        PostOutPut: Boolean;
        PostedGatePassHeaderGRec: Record "Posted Gate Pass Header";
        PostedGatePassLineGRec: Record "Posted Gate Pass Line";
        PostOutputGVar: Boolean;
        Ship: Boolean;
        Receive: Boolean;
        "--RGPOutApproval--": Integer;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ApprovalMgt: Codeunit 1535;
        RGPEditableGvar: Boolean;
        Text50000: Label 'Do you want to Release?';
        Text50001: Label 'WorkFlow is enabled,try sending Approval request to get it Released.';
        Text50002: Label 'Do you want to Re-Open?';
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        UserSetupGRec: Record 91;
        Text50003: Label 'Posting date is not with in your range.';
        UserSetup: Record 91;
        SD: Text[100];
        Y: Text[250];
        DimensionValueGRec: Record 349;
        SD2: Text[100];
        Z: Text[250];
        DimensionValue2GRec: Record 349;
        DimensionValue3GRec: Record 349;
        DimensionValue4GRec: Record 349;
        x: Text[250];
        ss: Text[50];
        location: Record 14;
        Text50004: Label 'RGP is already posted you cannot Re-Open it.';
        Text50005: Label 'Posting date %1 must not be less than Created date.';
        Answer: Boolean;


    procedure GetEqptNo(EqptNoLoc: Code[20])
    begin
        EqptNo := EqptNoLoc;
    end;


    procedure CreateRGPING()
    var
        GatePassHeaderGRec: Record "Gate Pass Header";
        GatePassLinGRec: Record "Gate Pass Line";
        GatePassLnGRec: Record "Gate Pass Line";
        InventorySetupGRec: Record 313;
        Text003: Label 'RGP In Posted Successfully.';
        InventorySetup: Record "Inventory Setup";
        NoSeries: Record "No. Series";
        NoSeriesRelationship: Record "No. Series Relationship";
        NoseriesMgmt: Codeunit NoSeriesManagement;
    begin
        GatePassHeaderGRec.INIT;
        GatePassHeaderGRec."Document Type" := GatePassHeaderGRec."Document Type"::"RGP In";
        InventorySetup.Get();
        InventorySetup.TestField("RGP In");
        NoSeries.Reset();
        NoSeriesRelationship.SetRange(Code, InventorySetup."RGP In");
        NoSeriesRelationship.SetRange("Shortcut Dimension 1 Code_B2B", Rec."Global Dimension 1 Code");
        if NoSeriesRelationship.FindSet() then
            repeat
                NoSeries.Code := NoSeriesRelationship."Series Code";
                NoSeries.Mark := true;
            until NoSeriesRelationship.Next() = 0;
        if NoSeries.Get(InventorySetup."RGP In") then
            if NoSeries."Shortcut Dimension 1 Code_B2B" = rec."Global Dimension 1 Code" then
                NoSeries.Mark := true;
        NoSeries.MarkedOnly := true;
        //if PAGE.RunModal(0, NoSeries) = ACTION::LookupOK then begin
        //Noseries.SETRANGE(Code, PurchaseSetup."Quote Nos.");
        //IF PAGE.RUNMODAL(458, Noseries) = ACTION::LookupOK THEN
        if NoSeries.FindSet() then
            GatePassHeaderGRec."No." := NoseriesMgmt.GetNextNo(NoSeries.Code, WorkDate(), true);
        ;
        GatePassHeaderGRec.INSERT(TRUE);

        GatePassHeaderGRec."RGP Date" := Rec."RGP Date";
        GatePassHeaderGRec."Consignee Type" := Rec."Consignee Type";
        GatePassHeaderGRec."Consignee No." := Rec."Consignee No.";
        GatePassHeaderGRec."Consignee Name" := Rec."Consignee Name";
        GatePassHeaderGRec."Consignee Name 2" := Rec."Consignee Name 2";
        GatePassHeaderGRec.Address := Rec.Address;
        GatePassHeaderGRec."Consignee City" := Rec."Consignee City";
        GatePassHeaderGRec."Consignee Contact" := Rec."Consignee Contact";
        GatePassHeaderGRec."Phone No." := Rec."Phone No.";
        GatePassHeaderGRec."Telex No." := Rec."Telex No.";
        GatePassHeaderGRec."Posting Date" := Rec."Posting Date";
        GatePassHeaderGRec."Calibration Status" := Rec."Calibration Status";
        GatePassHeaderGRec."Equipment No" := Rec."Equipment No";
        GatePassHeaderGRec.Results := Rec.Results;
        GatePassHeaderGRec.Recommendations := Rec.Recommendations;
        GatePassHeaderGRec."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
        GatePassHeaderGRec."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
        GatePassHeaderGRec."External Document No." := Rec."External Document No.";
        IF InventorySetupGRec.GET THEN
            GatePassHeaderGRec."No. Series" := InventorySetupGRec."RGP In";
        GatePassHeaderGRec."Calibration Cert No./ IR No" := Rec."Calibration Cert No./ IR No";
        GatePassHeaderGRec."GP No" := Rec."GP No";
        GatePassHeaderGRec."RGP Out Date" := Rec."RGP Date";
        GatePassHeaderGRec."RGP Out No." := Rec."No.";
        GatePassHeaderGRec."RGP Out Posting Date" := Rec."Posting Date";
        GatePassHeaderGRec."Responsible Person" := Rec."Responsible Person";
        GatePassHeaderGRec."Excise Challan No." := Rec."Excise Challan No.";
        GatePassHeaderGRec."Excise Challan Date" := Rec."Excise Challan Date";
        GatePassHeaderGRec."Responsible Person" := Rec."Responsible Person";
        GatePassHeaderGRec."Responsible Person Code" := Rec."Responsible Person Code";
        GatePassHeaderGRec.Shipped := Rec.Shipped;
        GatePassHeaderGRec."Mode of Transport" := Rec."Mode of Transport";
        Rec.CALCFIELDS("Total Value");
        GatePassHeaderGRec."Total Value" := Rec."Total Value";
        //B2B1.0 >>
        GatePassHeaderGRec."Created By" := Rec."Created By";
        GatePassHeaderGRec."Created Date" := Rec."Created Date";
        //B2B1.0 <<
        GatePassHeaderGRec."Reference Type" := Rec."Reference Type";
        GatePassHeaderGRec."Reference No." := Rec."Reference No.";
        GatePassHeaderGRec."Posted RDC No." := Rec."No.";
        GatePassHeaderGRec."Way Bill No." := Rec."Way Bill No.";
        GatePassHeaderGRec.MODIFY;


        GatePassLnGRec.RESET;
        GatePassLnGRec.SETRANGE("Document Type", GatePassLnGRec."Document Type"::"RGP Out");
        GatePassLnGRec.SETRANGE("Document No.", Rec."No.");
        IF GatePassLnGRec.FINDSET THEN
            REPEAT
                GatePassLinGRec.INIT;
                GatePassLinGRec."Document Type" := GatePassLineGRec."Document Type"::"RGP In";
                GatePassLinGRec."Document No." := GatePassHeaderGRec."No.";
                GatePassLinGRec."Line No." := GatePassLnGRec."Line No.";
                GatePassLinGRec.Type := GatePassLnGRec.Type;
                GatePassLinGRec."No." := GatePassLnGRec."No.";
                GatePassLinGRec.Description := GatePassLnGRec.Description;
                GatePassLinGRec."Unit of Measure" := GatePassLnGRec."Unit of Measure";
                GatePassLinGRec.Quantity := GatePassLnGRec.Quantity;
                GatePassLinGRec."Quantity to Receive" := GatePassLnGRec."Quantity to Receive";
                GatePassLinGRec."Quantity Received" := GatePassLnGRec."Quantity Received";
                GatePassLinGRec."Remaining Quantity" := GatePassLnGRec."Remaining Quantity";
                GatePassLinGRec.Status := GatePassLinGRec.Status::"Not Posted";
                GatePassLinGRec."Expected Return Date" := GatePassLnGRec."Expected Return Date";
                GatePassLinGRec."Applies GP No" := GatePassLnGRec."Applies GP No";
                GatePassLinGRec."Calibration Status" := GatePassLnGRec."Calibration Status";
                GatePassLinGRec.Remarks := GatePassLnGRec.Remarks;
                GatePassLinGRec."RGP Out Document No." := GatePassLnGRec."Document No.";
                GatePassLinGRec."RGP Out Line No." := GatePassLnGRec."Line No.";
                GatePassLinGRec."Recieved Qty" := GatePassLnGRec."Recieved Qty";
                GatePassLinGRec."Expected date of receipt" := GatePassLnGRec."Expected date of receipt";
                GatePassLinGRec."Outstanding Amount" := GatePassLnGRec."Outstanding Amount";
                GatePassLinGRec."Total Value" := GatePassLnGRec."Total Value";
                GatePassLinGRec."Unit Rate" := GatePassLnGRec."Unit Rate";
                GatePassLinGRec.INSERT;
            UNTIL GatePassLnGRec.NEXT = 0;
        Rec.PostRGPIN(GatePassHeaderGRec);

        MESSAGE(Text003);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit 1535;
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RECORDID);
    end;


    procedure RGPDocEdit()
    begin
        IF Rec."Approval Status" = Rec."Approval Status"::Open THEN
            RGPEditableGvar := TRUE
        ELSE
            RGPEditableGvar := FALSE;
    end;



    procedure RDCIN()
    var
        myInt: Integer;
        PostedGatePassHdr: Record "Posted Gate Pass Header";
        // GatePassLine: Record "Posted Gate Pass Line";
        GatePassLine: Record "Gate Pass Line";
        PostedGatePassLine: Record "Posted Gate Pass Line";
        GatepassVar: Record "Gate Pass Header";
        NoseriesMgmt: Codeunit NoSeriesManagement;
        NoSeries: Record "No. Series";
        GatePassLineCopy: Record "Gate Pass Line";
        RemQty: Decimal;

    begin

        PostedGatePassHdr.Init();
        IF "Global Dimension 1 Code" = 'DOM' then
            PostedGatePassHdr."No." := NoseriesMgmt.GetNextNo('RDC-IN', WorkDate(), true);

        IF "Global Dimension 1 Code" = 'EOU' then
            PostedGatePassHdr."No." := NoseriesMgmt.GetNextNo('RDC-IN-EOU', WorkDate(), true);

        IF ("Global Dimension 1 Code" = 'DOM') then begin
            IF ((REC."Consignee Type" = "Consignee Type"::Customer) AND (REC."Reference Type" = Rec."Reference Type"::"Sales Shipment")) THEN
                PostedGatePassHdr."No." := NoseriesMgmt.GetNextNo('RDC-I-DOM-SDC', WorkDate(), true)
        END;
        IF ("Global Dimension 1 Code" = 'EOU') then begin
            IF ((REC."Consignee Type" = "Consignee Type"::Customer) AND (REC."Reference Type" = Rec."Reference Type"::"Sales Shipment")) THEN
                PostedGatePassHdr."No." := NoseriesMgmt.GetNextNo('RDC-I-EOU-SDC', WorkDate(), true)
        END;

        PostedGatePassHdr."Document Type" := PostedGatePassHdr."Document Type"::"RGP In";
        PostedGatePassHdr."Consignee Type" := rec."Consignee Type";
        PostedGatePassHdr."Consignee No." := rec."Consignee No.";
        PostedGatePassHdr."Consignee Name" := Rec."Consignee Name";
        PostedGatePassHdr."Consignee Name 2" := rec."Consignee Name 2";
        PostedGatePassHdr.Address := Rec.Address;
        PostedGatePassHdr."Consignee City" := rec."Consignee City";
        PostedGatePassHdr."Consignee Contact" := rec."Consignee Contact";
        PostedGatePassHdr."Phone No." := rec."Phone No.";
        PostedGatePassHdr."Reference Type" := Rec."Reference Type";
        PostedGatePassHdr."Reference No." := Rec."Reference No.";
        PostedGatePassHdr."Posted Date" := rec."Posted Date";
        PostedGatePassHdr.Status := PostedGatePassHdr.Status::Posted;
        PostedGatePassHdr."External Document No." := rec."External Document No.";
        PostedGatePassHdr."Responsible Person" := Rec."Responsible Person";
        PostedGatePassHdr."Responsible Person Code" := rec."Responsible Person Code";
        PostedGatePassHdr."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
        PostedGatePassHdr."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
        PostedGatePassHdr."Excise Challan Date" := rec."Excise Challan Date";
        PostedGatePassHdr.Shipped := rec.Shipped;
        PostedGatePassHdr."Total Value" := rec."Total Value";
        PostedGatePassHdr.Status := rec."Approval Status";
        PostedGatePassHdr."Mode of Transport" := Rec."Mode of Transport";
        PostedGatePassHdr."Created By" := rec."Created By";
        PostedGatePassHdr."Created Date" := rec."Created Date";
        PostedGatePassHdr."Posted By" := rec."Posted By";
        PostedGatepassHdr."Posting Date" := rec."Posting Date";
        PostedGatePassHdr."Location Code" := rec."Location Code";
        PostedGatePassHdr."Doc. Receipt Date" := rec."Doc. Receipt Date";
        PostedGatePassHdr."Way Bill No." := rec."Way Bill No.";


        GatePassLine.Reset();
        GatePassLine.SetRange("Document No.", Rec."No.");
        if GatePassLine.FindSet() then begin
            repeat
                PostedGatePassLine.Init();
                PostedGatePassLine."Line No." := GatePassLine."Line No.";
                PostedGatePassLine."Document No." := PostedGatePassHdr."No.";
                PostedGatePassLine."Document Type" := PostedGatePassLine."Document Type"::"RGP In";
                PostedGatePassLine.Type := GatePassLine.Type;
                PostedGatePassLine.Description := GatePassLine.Description;
                PostedGatePassLine."No." := GatePassLine."No.";
                PostedGatePassLine.Description := GatePassLine.Description;
                PostedGatePassLine."Unit of Measure" := GatePassLine."Unit of Measure";
                PostedGatePassLine.Quantity := GatePassLine.Quantity;
                PostedGatePassLine.Remarks := GatePassLine.Remarks;
                PostedGatePassLine."Quantity Received" := GatePassLine."Quantity to Receive";
                //PostedGatePassLine.Validate("Quantity to Receive", GatePassLine."Quantity to Receive");
                PostedGatePassLine."Remaining Quantity" := GatePassLine."Remaining Quantity";
                PostedGatePassLine."Expected Return Date" := GatePassLine."Expected Return Date";
                PostedGatePassLine."Location Code" := GatePassLine."Location Code";
                PostedGatePassLine."Unit Rate" := GatePassLine."Unit Rate";
                PostedGatePassLine."Expected date of receipt" := GatePassLine."Expected date of receipt";
                PostedGatePassLine."Expected Return Date" := GatePassLine."Expected Return Date";
                PostedGatePassLine.Status := PostedGatePassLine.Status::Posted;

                PostedGatePassLine.Insert()
            until GatePassLine.Next() = 0;
        end;
        PostedGatePassHdr.Insert();

        CLEAR(RemQty);
        GatePassLineCopy.RESET;
        GatePassLineCopy.SETRANGE("Document No.", "No.");
        IF GatePassLineCopy.FINDSET THEN BEGIN
            REPEAT
                RemQty += GatePassLineCopy."Remaining Quantity";
                GatePassLineCopy."Quantity to Receive" := 0;
                GatePassLineCopy.MODIFY;
            UNTIL GatePassLineCopy.NEXT = 0;
        END;
        IF RemQty = 0 THEN BEGIN
            GatePassLine.RESET;
            GatePassLine.SETRANGE("Document Type", GatePassLine."Document Type"::"RGP Out");
            GatePassLine.SETRANGE("Document No.", "No.");
            IF GatePassLine.FIND('-') THEN
                GatePassLine.DELETEALL;

        End;
        //    rec.Delete(true);
    end;

    //end;


    procedure RDCOut()
    var
        myInt: Integer;
        PostedGatpassHdr: Record "Posted Gate Pass Header";
        GatePassLine: Record "Gate Pass Line";
        PostedGatePassLine: Record "Posted Gate Pass Line";
        NoseriesMgmt: Codeunit NoSeriesManagement;
        GatePassHdr: Record "Gate Pass Header";

    begin




        PostedGatpassHdr.Init();
        IF "Global Dimension 1 Code" = 'DOM' then
            PostedGatpassHdr."No." := NoseriesMgmt.GetNextNo('RDC-OUT', WorkDate(), true)
        ELSE
            IF "Global Dimension 1 Code" = 'EOU' then
                PostedGatpassHdr."No." := NoseriesMgmt.GetNextNo('RDC-OUT-EOU', WorkDate(), true);
        IF ("Global Dimension 1 Code" = 'DOM') then begin
            IF ((REC."Consignee Type" = "Consignee Type"::Customer) AND (REC."Reference Type" = Rec."Reference Type"::"Sales Shipment")) THEN
                PostedGatpassHdr."No." := NoseriesMgmt.GetNextNo('RDC-DOM-SDC', WorkDate(), true)
        END;
        IF ("Global Dimension 1 Code" = 'EOU') then begin
            IF ((REC."Consignee Type" = "Consignee Type"::Customer) AND (REC."Reference Type" = Rec."Reference Type"::"Sales Shipment")) THEN
                PostedGatpassHdr."No." := NoseriesMgmt.GetNextNo('RDC-EOU-SDC', WorkDate(), true)
        END;

        PostedGatpassHdr."Document Type" := PostedGatpassHdr."Document Type"::"RGP Out";
        PostedGatpassHdr."Consignee Type" := rec."Consignee Type";
        PostedGatpassHdr."Consignee No." := rec."Consignee No.";
        PostedGatpassHdr."Consignee Name" := Rec."Consignee Name";
        PostedGatpassHdr."Consignee Name 2" := rec."Consignee Name 2";
        PostedGatpassHdr.Address := Rec.Address;
        PostedGatpassHdr."Consignee City" := rec."Consignee City";
        PostedGatpassHdr."Consignee Contact" := rec."Consignee Contact";
        PostedGatpassHdr."Phone No." := rec."Phone No.";
        PostedGatpassHdr."Equipment No" := rec."Equipment No";
        PostedGatpassHdr."Reference Type" := Rec."Reference Type";
        PostedGatpassHdr."Reference No." := Rec."Reference No.";
        PostedGatpassHdr."Posting Date" := rec."Posting Date";
        PostedGatpassHdr.Status := PostedGatpassHdr.Status::Posted;
        PostedGatpassHdr."External Document No." := rec."External Document No.";
        PostedGatpassHdr."Responsible Person" := Rec."Responsible Person";
        PostedGatpassHdr."Responsible Person Code" := rec."Responsible Person Code";
        PostedGatpassHdr."Global Dimension 1 Code" := rec."Global Dimension 1 Code";
        PostedGatpassHdr."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
        PostedGatpassHdr."Excise Challan Date" := rec."Excise Challan Date";
        PostedGatpassHdr.Shipped := rec.Shipped;
        PostedGatpassHdr."Total Value" := rec."Total Value";
        PostedGatpassHdr.Status := PostedGatpassHdr.Status::Posted;
        PostedGatpassHdr."Mode of Transport" := Rec."Mode of Transport";
        PostedGatpassHdr."Created By" := rec."Created By";
        PostedGatpassHdr."Created Date" := rec."Created Date";
        PostedGatpassHdr."Posted By" := rec."Posted By";
        PostedGatpassHdr."Location Code" := Rec."Location Code";
        PostedGatpassHdr."Doc. Receipt Date" := rec."Doc. Receipt Date";
        PostedGatpassHdr."Way Bill No." := rec."Way Bill No.";

        PostedGatpassHdr.Insert();
        GatePassLine.Reset();
        GatePassLine.SetRange("Document No.", Rec."No.");
        if GatePassLine.FindSet() then begin
            repeat
                PostedGatePassLine.Init();
                PostedGatePassLine."Document Type" := PostedGatePassLine."Document Type"::"RGP Out";
                PostedGatePassLine."Line No." := GatePassLine."Line No.";

                PostedGatePassLine.Type := GatePassLine.Type;
                PostedGatePassLine."Document No." := PostedGatpassHdr."No.";
                PostedGatePassLine."No." := GatePassLine."No.";
                // PostedGatePassLine.Validate("No.", GatePassLine."No.");
                PostedGatePassLine.Description := GatePassLine.Description;
                PostedGatePassLine."Unit of Measure" := GatePassLine."Unit of Measure";
                PostedGatePassLine.Quantity := GatePassLine.Quantity;
                PostedGatePassLine.Remarks := GatePassLine.Remarks;
                PostedGatePassLine."Quantity Received" := GatePassLine."Quantity Received";
                PostedGatePassLine."Quantity to Receive" := GatePassLine."Quantity to Receive";
                PostedGatePassLine."Remaining Quantity" := GatePassLine."Remaining Quantity";
                PostedGatePassLine."Expected Return Date" := GatePassLine."Expected Return Date";
                PostedGatePassLine."Location Code" := GatePassLine."Location Code";
                PostedGatePassLine."Unit Rate" := GatePassLine."Unit Rate";
                PostedGatePassLine."Expected date of receipt" := GatePassLine."Expected date of receipt";
                PostedGatePassLine."Expected Return Date" := GatePassLine."Expected Return Date";
                PostedGatePassLine."Calibration Status" := GatePassLine."Calibration Status";
                PostedGatePassLine."Expected date of receipt" := GatePassLine."Expected date of receipt";
                PostedGatePassLine."Expected Return Date" := GatePassLine."Expected Return Date";
                PostedGatePassLine."Location Code" := GatePassLine."Location Code";
                PostedGatePassLine.Status := PostedGatePassLine.Status::Posted;
                PostedGatePassLine.Insert();
            until GatePassLine.Next() = 0;
        end;
    end;





    procedure DateNotAllowed(PostingDate: Date): Boolean
    begin
        CLEAR(AllowPostingFrom);
        CLEAR(AllowPostingTo);
        IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
            IF USERID <> '' THEN
                IF UserSetupGRec.GET(USERID) THEN BEGIN
                    AllowPostingFrom := UserSetupGRec."Allow Posting From";
                    AllowPostingTo := UserSetupGRec."Allow Posting To";
                END;
            /*
            IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
              GLSetup.GET;
              AllowPostingFrom := GLSetup."Allow Posting From";
              AllowPostingTo := GLSetup."Allow Posting To";
            END;
            */

            IF AllowPostingTo = 0D THEN
                AllowPostingTo := DMY2Date(31, 12, 9999); //12319999D;
        END;
        EXIT((PostingDate < AllowPostingFrom) OR (PostingDate > AllowPostingTo));

    end;
}


page 50100 "MRV Quality Ledger Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "MRV Quality Ledger Entry";
    AutoSplitKey = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = ALL;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = ALL;
                    Visible = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
                field("Accepted Quantity"; Rec."Accepted Quantity")
                {
                    ApplicationArea = ALL;
                }
                field("Rework Quantity"; Rec."Rework Quantity")
                {
                    ApplicationArea = ALL;
                }
                field("Rejected Quantity"; Rec."Rejected Quantity")
                {
                    ApplicationArea = ALL;
                }
                field("Rework Level"; Rec."Rework Level")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
                field("Qty to sent rework"; Rec."Qty to sent rework")
                {
                    ApplicationArea = ALL;
                }
                field("Qty to send reworked"; Rec."Qty to send reworked")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
                field("Qty to Receive Rework"; Rec."Qty to Receive Rework")
                {
                    ApplicationArea = ALL;
                }
                field("Qty to Received Rework"; Rec."Qty to Received Rework")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
                field("Item Spec meets the Req(Y/N)"; Rec."Item Spec meets the Req(Y/N)")
                {
                    ApplicationArea = ALL;
                }
                field("Item Working Condition Accepted (Y/N)"; Rec."Item Working Condition Accepted (Y/N)")
                {
                    ApplicationArea = ALL;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = ALL;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = ALL;
                }

            }
        }
        area(Factboxes)
        {

        }

    }

    actions
    {
        area(Processing)
        {
            action("Send for Rework")
            {
                ApplicationArea = All;
                Visible = Storesvar;


                trigger OnAction()
                var
                    Mrv: Record "MRV Quality Ledger Entry";
                    ReworkVar: Decimal;
                    DocumentLinenovar: Integer;
                    LineNovar: Integer;
                    MRV1: Record "MRV Quality Ledger Entry";
                    Text001: Label 'Do you want to continue';
                    Text002: Label 'Send To Rework Successfully';
                begin
                    IF CONFIRM(Text001, FALSE, 1) THEN BEGIN
                        Rec.TestField("Rework Quantity");
                        rec.TestField("Qty to sent rework");
                        Clear(ReworkVar);

                        MRV1.Reset();
                        Mrv1.SetRange("Document No.", Rec."Document No.");
                        MRV1.SetCurrentKey("Line No.");
                        IF MRV1.FindLast() THEN begin
                            LineNovar := MRV1."Line No." + 10000;
                        end ELSE begin
                            LineNovar := 10000;
                        end;

                        Mrv.Init();
                        Mrv."Line No." := LineNovar;
                        Mrv."Document Line No." := DocumentLinenovar;
                        Mrv."Document No." := rec."Document No.";
                        ReworkVar := rec."Qty to sent rework";

                        Mrv."Rework Quantity" := ReworkVar;
                        Mrv."Posting Date" := Today;
                        Mrv."Rework Level" += 1;
                        Mrv."Vendor No." := rec."Vendor No.";
                        Mrv."Location Code" := Rec."Location Code";
                        Mrv.Insert();

                        Rec."Qty to send reworked" += rec."Qty to sent rework";
                        Rec."Qty to sent rework" := 0;
                        Rec.Modify();
                    end;
                    Message(Text002);
                end;
            }
            action("Received for Rework")
            {
                ApplicationArea = All;
                Visible = Qcvar;

                trigger OnAction()
                var
                    Selection: Integer;
                    MRVeQst: Label 'Accept,Reject,Rework';
                    Mrv: Record "MRV Quality Ledger Entry";
                    Qtyvar: Decimal;
                    DocumentLinenovar: Integer;
                    LineNovar: Integer;
                    MRV1: Record "MRV Quality Ledger Entry";
                    Text001: Label 'Do you want to continue';
                    MRV2: Record "MRV Quality Ledger Entry";
                    AccMsg: Label 'Accept successufully';
                    RejMsg: Label 'Reject successufully';
                    Reworkmsg: Label 'Rework successufully';

                begin
                    IF CONFIRM(Text001, FALSE, 1) THEN BEGIN
                        //if Rec."Rework Level" = 0 then begin
                        Selection := StrMenu(MRVeQst, 1);
                        if Selection = 0 then
                            exit;
                        if Selection = 1 then begin
                            //   Rec.TestField("Accepted Quantity");
                            rec.TestField("Qty to Receive Rework");
                            Clear(Qtyvar);
                            MRV1.Reset();
                            Mrv1.SetRange("Document No.", Rec."Document No.");
                            MRV1.SetCurrentKey("Line No.");
                            IF MRV1.FindLast() THEN begin
                                LineNovar := MRV1."Line No." + 10000;
                            end ELSE begin
                                LineNovar := 10000;
                            end;

                            Mrv.Init();
                            Mrv."Line No." := LineNovar;
                            Mrv."Document Line No." := rec."Document Line No.";
                            Mrv."Document No." := rec."Document No.";
                            Qtyvar := rec."Qty to Receive Rework";
                            Mrv."Accepted Quantity" := Qtyvar;
                            Mrv."Vendor No." := rec."Vendor No.";
                            Mrv."Location Code" := rec."Location Code";
                            Mrv."Item No." := rec."Item No.";
                            Mrv."Posting Date" := Today;
                            Mrv."Rework Level" += 1;
                            PurchPaySetup.Get();
                            Mrv."No." := NoSeriesMgt.GetNextNo(PurchPaySetup."MRV No.Series", WorkDate(), true);
                            Mrv."MRV Posting Date" := WorkDate();
                            Mrv.Insert(true);
                            rec."Qty to Received Rework" += rec."Qty to Receive Rework";
                            rec."Qty to send reworked" := Abs(rec."Qty to Receive Rework" - "Qty to send reworked");
                            rec."Qty to Receive Rework" := 0;
                            rec.Modify();
                            Message(AccMsg);
                        end else

                            if Selection = 2 then begin
                                Rec.TestField("Rejected Quantity");
                                rec.TestField("Qty to Receive Rework");
                                MRV1.Reset();
                                Mrv1.SetRange("Document No.", Rec."Document No.");
                                MRV1.SetCurrentKey("Line No.");
                                IF MRV1.FindLast() THEN begin
                                    LineNovar := MRV1."Line No." + 10000;
                                end ELSE
                                    LineNovar := 10000;

                                Mrv.Init();
                                Mrv."Line No." := LineNovar;
                                Mrv."Document Line No." := rec."Document Line No.";
                                Mrv."Document No." := rec."Document No.";

                                Qtyvar := rec."Qty to Receive Rework";
                                Mrv."Item No." := rec."Item No.";
                                Mrv."Rejected Quantity" := Qtyvar;
                                Mrv."Posting Date" := Today;
                                Mrv."Rework Level" += 1;
                                Mrv."Vendor No." := rec."Vendor No.";
                                Mrv."Location Code" := rec."Location Code";
                                PurchPaySetup.Get();
                                Mrv."No." := NoSeriesMgt.GetNextNo(PurchPaySetup."MRV No.Series", WorkDate(), true);
                                Mrv."MRV Posting Date" := WorkDate();
                                Mrv.Insert(true);
                                rec."Qty to Received Rework" += rec."Qty to Receive Rework";
                                rec."Qty to send reworked" := Abs(rec."Qty to Receive Rework" - "Qty to send reworked");
                                rec."Qty to Receive Rework" := 0;
                                rec.Modify();
                                Message(RejMsg);
                            end else
                                if Selection = 3 then begin


                                    Rec.TestField("Rework Quantity");
                                    //   rec.TestField("Qty to Receive Rework");
                                    MRV1.Reset();
                                    Mrv1.SetRange("Document No.", Rec."Document No.");
                                    MRV1.SetCurrentKey("Line No.");
                                    IF MRV1.FindLast() THEN begin
                                        LineNovar := MRV1."Line No." + 10000;
                                    end ELSE
                                        LineNovar := 10000;

                                    Mrv.Init();
                                    Mrv."Line No." := LineNovar;
                                    Mrv."Document Line No." := rec."Document Line No.";
                                    Mrv."Document No." := rec."Document No.";

                                    Qtyvar := rec."Qty to Receive Rework";
                                    Mrv."Item No." := rec."Item No.";
                                    Mrv."Rejected Quantity" := 0;
                                    Mrv."Posting Date" := Today;
                                    Mrv."Rework Level" += rec."Rework Level" + 1;
                                    Mrv."Vendor No." := rec."Vendor No.";
                                    Mrv."Location Code" := rec."Location Code";
                                    Mrv."Rework Quantity" := rec."Qty to Receive Rework";
                                    PurchPaySetup.Get();
                                    Mrv."No." := NoSeriesMgt.GetNextNo(PurchPaySetup."MRV No.Series", WorkDate(), true);
                                    Mrv."MRV Posting Date" := WorkDate();
                                    Mrv.Insert(true);
                                    rec."Qty to Received Rework" += rec."Qty to Receive Rework";
                                    rec."Qty to send reworked" := Abs(rec."Qty to Receive Rework" - "Qty to send reworked");
                                    rec."Qty to Receive Rework" := 0;
                                    rec.Modify();
                                    Message(Reworkmsg);
                                end;




                        // end;
                    END;
                end;
            }

        }

    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if UsersetupRec.get(UserId) then begin
            if (UsersetupRec."Store Approval") = false
            then
                Storesvar := false
            else
                Storesvar := true;

            if (UsersetupRec."Qc Approval") = false
      then
                Qcvar := false
            else
                Qcvar := true;
            if ((UsersetupRec."Store Approval" = true) and (UsersetupRec."Qc Approval" = true)) then begin
                Storesvar := true;
                Qcvar := true;


            end;



        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchPaySetup: Record "Purchases & Payables Setup";
        Storesvar: Boolean;
        Qcvar: Boolean;
        UsersetupRec: Record "User Setup";

}



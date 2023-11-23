tableextension 50081 "GenJnlLineExt" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Bal. Account Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        //B2BPROn24JUN2023<<<
        field(50001; "BG No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Guarantee";
        }
        field(50002; "FD No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Deposit_B2B";
        }
        //B2BPROn24JUN2023<<<
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnBeforeValidate()
            var
                GenJnBatch: Record "Gen. Journal Batch";
                NoSeries: Record "No. Series";
            begin
                if GenJnBatch.Get("Journal Template Name", "Journal Batch Name") then begin
                    //B2BMSOn21APR2023>>
                    //if NoSeries.Get(GenJnBatch."No. Series") and (NoSeries."Shortcut Dimension 1 Code_B2B" <> Rec."Shortcut Dimension 1 Code") then
                    if (NoSeries.Get(GenJnBatch."No. Series"))
                     and (NoSeries."Shortcut Dimension 1 Code_B2B" <> '')
                     and (NoSeries."Shortcut Dimension 1 Code_B2B" <> Rec."Shortcut Dimension 1 Code") then
                        //B2BMSOn21APR2023<<
                        Error('Please Select The Correct Divison');
                end;
            end;
        }
        //B2BPROn10Jul2023<<<
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                if CopyStr(Rec."Document No.", 2, 1) <> CopyStr(Rec."Location Code", 1, 1) then
                    Error('Please Select The Correct Location Code');
            end;
        }
        //B2BPROn10Jul2023<<<
    }

    var
        myInt: Integer;
}
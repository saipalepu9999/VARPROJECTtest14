report 50073 "PINS Inspection Log Sheet"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\InspeectionLogSheetPINS.rdl';

    dataset
    {
        dataitem("Inspection Receipt Header B2B"; "Inspection Receipt Header B2B")
        {
            RequestFilterFields = "No.";
            DataItemTableView = where(Status = const(true));
            column(No_; "No.")
            { }
            column(LocationGrec_Name; LocationGrec.Name)
            { }
            column(LocationGrec_Address; LocationGrec.Address)
            { }
            column(Item_No_; "Item No.")
            { }
            column(Item_Description; "Item Description")
            { }
            column(Document_Date; format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {

            }
            column(QualityRemarks_InspectionReceiptHeaderB2B; "Quality Remarks")
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            { }
            column(LocationGrec; LocationGrec.Address)
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            {

            }
            column(Vendor_Name; "Vendor Name")
            {

            }
            column(Quantity; Quantity)
            {

            }
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(Title; "Item Description" + ' Inspection Log Sheet')
            {

            }
            column(Qty__Accepted; "Qty. Accepted")
            {

            }
            column(Qty__Rejected; "Qty. Rejected")
            {

            }
            column(PostingDate_InspectionReceiptHeaderB2B; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {
            }
            column(Qty__Rework; "Qty. Rework") { }
            column(SpecHeadISO; SpecHead."ISO Format Number") { }
            column(ProjectDesc; ProjectDesc) { }
            column(DocumentAttach; DocumentAttach."Drawing No_B2B") { }
            column(RefInsp; Item."Ref. Inspection Procedure No.") { }
            column(No__Of_Samples_Taken; "No. Of Samples Taken") { }
            column(PrintDate; PrintDateTxt) { }
            column(CharactedCode_1; CharactedCode[1]) { }
            column(CharactedCode_2; CharactedCode[2]) { }
            column(CharactedCode_3; CharactedCode[3]) { }
            column(CharactedCode_4; CharactedCode[4]) { }
            column(CharactedCode_5; CharactedCode[5]) { }
            column(CharactedCode_6; CharactedCode[6]) { }
            column(CharactedCode_7; CharactedCode[7]) { }
            column(CharactedCode_8; CharactedCode[8]) { }
            column(CharactedCode_9; CharactedCode[9]) { }
            column(CharactedCode_10; CharactedCode[10]) { }
            column(Receipt_No_; "Receipt No.") { }

            dataitem("Inspection Receipt Line B2B"; "Inspection Receipt Line B2B")
            {
                DataItemLinkReference = "Inspection Receipt Header B2B";
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Character Code" = filter(<> ''));

                column(Document_No_; "Document No.")
                {

                }
                column(Line_No_; "Line No.")
                {

                }
                column(Character_Code; "Character Code")
                {

                }
                column(Description; Description)
                {

                }
                column(Normal_Value__Num_; "Normal Value (Num)")
                {

                }
                column(Normal_Value__Text_; "Normal Value (Text)")
                {

                }
                column(Max__Value__Num_; "Max. Value (Num)")
                {

                }
                column(Max__Value__Text_; "Max. Value (Text)")
                {

                }
                column(Min__Value__Num_; "Min. Value (Num)")
                {

                }
                column(Min__Value__Text_; "Min. Value (Text)")
                {

                }
                column(Remarks; Remarks)
                {

                }

                column(MinValue; MinValue) { }
                column(MaxValue; MaxValue) { }
                column(NormalValue; NormalValue) { }
                column(UOM; UOM) { }
                column(SamplingCode; SamplingCode) { }




                trigger OnAfterGetRecord()
                var
                    PosInsDataHead: Record "Posted Ins DatasheetHeader B2B";
                    PosInsDataLine: Record "Posted Ins Datasheet Line B2B";
                begin
                    Clear(MinValue);
                    Clear(MaxValue);
                    Clear(NormalValue);
                    Clear(UOM);
                    Clear(SamplingCode);
                    PosInsDataHead.Reset();
                    PosInsDataHead.SetRange("Inspection Receipt No.", "Inspection Receipt Line B2B"."Document No.");
                    if PosInsDataHead.FindFirst() then begin
                        PosInsDataLine.Reset();
                        PosInsDataLine.SetRange("Document No.", PosInsDataHead."No.");
                        PosInsDataLine.SetRange(Description, "Inspection Receipt Line B2B".Description);
                        if PosInsDataLine.FindFirst() then begin
                            if PosInsDataLine."Min. Value (Num)" <> 0 then
                                MinValue := format(PosInsDataLine."Min. Value (Num)")
                            else
                                MinValue := PosInsDataLine."Min. Value (Text)";

                            if PosInsDataLine."Max. Value (Num)" <> 0 then
                                MaxValue := format(PosInsDataLine."Max. Value (Num)")
                            else
                                MaxValue := PosInsDataLine."Max. Value (Text)";
                            if PosInsDataLine."Normal Value (Num)" <> 0 then
                                NormalValue := Format(PosInsDataLine."Normal Value (Num)")
                            else
                                NormalValue := PosInsDataLine."Normal Value (Text)";

                            UOM := PosInsDataLine."Unit of Measure Code";
                            SamplingCode := PosInsDataLine."Sampling Plan Code";

                            if PosInsDataLine."Actual Value (Num)" <> 0 then
                                ActualVal := Format(PosInsDataLine."Actual Value (Num)")
                            else
                                ActualVal := PosInsDataLine."Actual  Value (Text)";
                        end;
                    end;

                end;

                trigger OnPreDataItem()
                begin
                    Clear(SNo);
                    SetCurrentKey("Character Code");
                    SetFilter("Character Code", '<>%1', ' ');
                end;
            }
            dataitem(Integer; Integer)
            {
                DataItemLinkReference = "Inspection Receipt Header B2B";

                column(Number; Number) { }
                column(ActualValue_1; ActualValue[1]) { }
                column(ActualValue_2; ActualValue[2]) { }
                column(ActualValue_3; ActualValue[3]) { }
                column(ActualValue_4; ActualValue[4]) { }
                column(ActualValue_5; ActualValue[5]) { }
                column(ActualValue_6; ActualValue[6]) { }
                column(ActualValue_7; ActualValue[7]) { }
                column(ActualValue_8; ActualValue[8]) { }
                column(ActualValue_9; ActualValue[9]) { }
                column(ActualValue_10; ActualValue[10]) { }
                column(Status_1; Status[1]) { }
                column(Status_2; Status[2]) { }
                column(Status_3; Status[3]) { }
                column(Status_4; Status[4]) { }
                column(Status_5; Status[5]) { }
                column(Status_6; Status[6]) { }
                column(Status_7; Status[7]) { }
                column(Status_8; Status[8]) { }
                column(Status_9; Status[9]) { }
                column(Status_10; Status[10]) { }

                column(SNo; SNo) { }

                trigger OnAfterGetRecord()
                var
                    PostedDataHead: Record "Posted Ins DatasheetHeader B2B";
                    PosInsDataLine: Record "Posted Ins Datasheet Line B2B";
                    I: Integer;
                begin
                    Clear(I);
                    SNo += 1;
                    I := 1;
                    Clear(ActualValue);
                    Clear(Status);
                    PostedDataHead.Reset();
                    PostedDataHead.SetRange("Inspection Receipt No.", "Inspection Receipt Header B2B"."No.");
                    if PostedDataHead.FindFirst() then begin

                        PosInsDataLine.Reset();
                        PosInsDataLine.SetCurrentKey(Description);
                        PosInsDataLine.SetFilter("Character Code", '<>%1', '');
                        PosInsDataLine.SetRange("Document No.", PostedDataHead."No.");
                        PosInsDataLine.SetRange("Sequence No.", Integer.Number);
                        if PosInsDataLine.FindSet() then begin
                            repeat
                                //CharactedCode[I] := PosInsDataLine."Character Code";
                                if PosInsDataLine."Actual Value (Num)" <> 0 then
                                    ActualValue[I] := Format(PosInsDataLine."Actual Value (Num)")
                                else
                                    ActualValue[I] := PosInsDataLine."Actual  Value (Text)";

                                if PosInsDataLine.Accept then
                                    Status[I] := 'Pass'
                                else
                                    Status[I] := 'Fail';

                                I += 1;
                            until PosInsDataLine.Next() = 0;
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                var
                    PostedDataHead: Record "Posted Ins DatasheetHeader B2B";
                    PosInsDataLine: Record "Posted Ins Datasheet Line B2B";
                    I: Integer;
                begin

                    PostedDataHead.Reset();
                    PostedDataHead.SetRange("Inspection Receipt No.", "Inspection Receipt Header B2B"."No.");
                    if PostedDataHead.FindFirst() then begin

                        PosInsDataLine.Reset();
                        PosInsDataLine.SetCurrentKey("Sequence No.");
                        PosInsDataLine.SetFilter("Character Code", '<>%1', '');
                        PosInsDataLine.SetRange("Document No.", PostedDataHead."No.");

                        if PosInsDataLine.FindLast() then;

                    end;

                    SetRange(Number, 1, PosInsDataLine."Sequence No.");
                end;
            }

            trigger OnAfterGetRecord()
            var
                PostedDataHead: Record "Posted Ins DatasheetHeader B2B";
                PosInsDataLine: Record "Posted Ins Datasheet Line B2B";
                TempCharCode: Code[20];
                SeqNo: Integer;
                I: Integer;
                prevCode: Code[20];
                DimensionValues: Record "Dimension Value";

            begin

                Clear(I);
                I := 1;
                PostedDataHead.Reset();
                PostedDataHead.SetRange("Inspection Receipt No.", "Inspection Receipt Header B2B"."No.");
                if PostedDataHead.FindFirst() then begin
                    PosInsDataLine.Reset();
                    PosInsDataLine.SetCurrentKey(Description);
                    PosInsDataLine.SetFilter("Character Code", '<>%1', '');
                    PosInsDataLine.SetRange("Document No.", PostedDataHead."No.");
                    PosInsDataLine.SetRange("Sequence No.", 1);
                    if PosInsDataLine.FindSet() then begin
                        repeat
                            if prevCode <> PosInsDataLine.Description then begin
                                prevCode := PosInsDataLine.Description;
                                CharactedCode[I] := PosInsDataLine.Description;
                                I += 1;
                            end;
                        until PosInsDataLine.Next() = 0;
                    end;
                end;
                if Item.Get("Inspection Receipt Header B2B"."Item No.") then;
                if SpecHead.Get("Inspection Receipt Header B2B"."Spec ID") then;

                Clear(ProjectDesc);
                DimensionValues.Reset();
                DimensionValues.SetRange("Global Dimension No.", 2);
                DimensionValues.SetRange(Code, "Inspection Receipt Header B2B"."Shortcut Dimension 2 Code");
                if DimensionValues.FindFirst() then
                    ProjectDesc := DimensionValues.Name;

                DocumentAttach.Reset();
                DocumentAttach.SetCurrentKey("Drawing Revision No._B2B");
                DocumentAttach.SetRange("Table ID", 27);
                DocumentAttach.SetRange("No.", "Inspection Receipt Header B2B"."Item No.");
                DocumentAttach.SetRange(Type_B2B, DocumentAttach.Type_B2B::Drawing);
                if DocumentAttach.FindLast() then;

                PrintDate := Today;

                PrintDateTxt := CopyStr(Format(PrintDate), 1, StrLen(Format(PrintDate)));
                Clear(LocationGrec);
                if LocationGrec.Get("Location Code") then;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }


    }




    var
        CompanyInfo: Record "Company Information";
        SNo: Integer;
        MinValue: Text;
        MaxValue: Text;
        NormalValue: Text;
        UOM: Code[20];
        SamplingCode: Code[20];
        ActualVal: Text;

        CharactedCode: array[20] of Text[100];
        ActualValue: array[20] of Text[100];
        Status: array[20] of Text[100];
        ProjectDesc: Text;
        SpecHead: Record "Specification Header B2B";
        DocumentAttach: Record "Document Attachment";
        Item: Record Item;
        PrintDate: Date;
        PrintDateTxt: Text;
        LocationGrec: Record Location;

    trigger OnPreReport()
    var
        PostedDataHead: Record "Posted Ins DatasheetHeader B2B";
        PosInsDataLine: Record "Posted Ins Datasheet Line B2B";
        TempCharCode: Text;
        SeqNo: Integer;
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        PostedDataHead.Reset();
        if PostedDataHead.FindSet() then begin
            repeat
                PosInsDataLine.Reset();
                PosInsDataLine.SetFilter("Character Code", '<>%1', '');
                PosInsDataLine.SetRange("Document No.", PostedDataHead."No.");
                if PosInsDataLine.FindSet() then begin
                    PosInsDataLine.Reset();
                    PosInsDataLine.SetCurrentKey(Description);
                    PosInsDataLine.SetFilter("Character Code", '<>%1', '');
                    PosInsDataLine.SetRange("Document No.", PostedDataHead."No.");
                    if PosInsDataLine.FindSet() then begin
                        repeat
                            if TempCharCode <> PosInsDataLine.Description then begin
                                Clear(SeqNo);
                                TempCharCode := PosInsDataLine.Description;
                            end;
                            SeqNo := SeqNo + 1;
                            PosInsDataLine."Sequence No." := SeqNo;
                            PosInsDataLine.Modify();
                        until PosInsDataLine.Next() = 0;
                    end;
                end;
            until PostedDataHead.Next() = 0;
        end;
    end;
}
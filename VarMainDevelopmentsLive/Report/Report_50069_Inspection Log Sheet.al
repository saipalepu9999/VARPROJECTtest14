report 50069 "Inspection Log Sheet"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\InspeectionLogSheetMatrix.rdl';

    dataset
    {
        dataitem("Inspection Receipt Header B2B"; "Inspection Receipt Header B2B")
        {
            RequestFilterFields = "No.";
            DataItemTableView = where(Status = const(true));
            column(No_; "No.")
            {

            }
            column(Item_No_; "Item No.")
            {

            }
            column(Item_Description; "Item Description")
            {

            }
            column(Document_Date; format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {

            }
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
            column(LocationGrec; LocationGrec.Address)
            { }
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
                column(SNo; SNo)
                {
                }
                column(MinValue; MinValue) { }
                column(MaxValue; MaxValue) { }
                column(NormalValue; NormalValue) { }
                column(UOM; UOM) { }
                column(SamplingCode; SamplingCode) { }
                // column(Actual_Value__Num_IDS; ActualVal) { }
                // column(Accept_IDS; Status) { }

                trigger OnAfterGetRecord()
                var
                    PosInsDataHead: Record "Posted Ins DatasheetHeader B2B";
                    PosInsDataLine: Record "Posted Ins Datasheet Line B2B";
                    PrevCharCode: Code[20];
                begin
                    if PrevCharCode <> "Character Code" then
                        SNo += 1;
                    PrevCharCode := "Character Code";


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
                        PosInsDataLine.SetRange("Character Code", "Inspection Receipt Line B2B"."Character Code");
                        if PosInsDataLine.FindFirst() then begin
                            if "Posted Ins Datasheet Line B2B"."Min. Value (Num)" <> 0 then
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

            dataitem("Posted Ins DatasheetHeader B2B"; "Posted Ins DatasheetHeader B2B")
            {

                DataItemLinkReference = "Inspection Receipt Header B2B";
                DataItemLink = "Inspection Receipt No." = field("No.");

                dataitem("Posted Ins Datasheet Line B2B"; "Posted Ins Datasheet Line B2B")
                {
                    DataItemLinkReference = "Posted Ins DatasheetHeader B2B";
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemTableView = sorting("Line No.");

                    column(Character_Code_IDS; "Character Code") { }
                    column(Document_No_IDS; "Document No.") { }
                    column(Line_No_IDS; "Line No.") { }

                    column(Accept_IDS; Status) { }
                    column(Sampling_Plan_Code_IDS; "Sampling Plan Code") { }
                    column(Unit_of_Measure_Code_IDS; "Unit of Measure Code") { }
                    column(Actual_Value__Num_IDS; "Actual Value (Num)") { }
                    column(CharCode; CharCode) { }
                    column(Sequence_No_; "Sequence No.") { }


                    trigger OnPreDataItem()
                    begin
                        SetFilter("Character Code", '<>%1', ' ');
                    end;

                    trigger OnAfterGetRecord()
                    var

                        PosInsDataLine: Record "Posted Ins Datasheet Line B2B";
                    begin
                        if "Posted Ins Datasheet Line B2B".Accept then
                            Status := 'Pass'
                        else
                            Status := 'Fail';
                    end;


                }
            }
            trigger OnAfterGetRecord()
            begin
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
        Status: Text;
        CharCode: Integer;
        LocationGrec: Record Location;

    trigger OnPreReport()
    var
        PosInsDataLine: Record "Posted Ins Datasheet Line B2B";
        TempCharCode: Code[20];
        SeqNo: Integer;
    begin
        CompanyInfo.Get();


        PosInsDataLine.Reset();
        PosInsDataLine.SetCurrentKey("Character Code");
        PosInsDataLine.SetRange("Document No.", 'PIDS0143');
        if PosInsDataLine.FindSet() then begin
            repeat

                if TempCharCode <> PosInsDataLine."Character Code" then begin
                    Clear(SeqNo);
                    TempCharCode := PosInsDataLine."Character Code";
                end;

                SeqNo := SeqNo + 1;

                PosInsDataLine."Sequence No." := SeqNo;
                PosInsDataLine.Modify();
            until PosInsDataLine.Next() = 0;
        end;
    end;
}
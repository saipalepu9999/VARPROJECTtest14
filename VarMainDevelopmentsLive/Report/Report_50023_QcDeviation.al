report 50023 QcDeviation
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'QC Deviation Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\Qcdeviation.rdl';

    dataset
    {
        dataitem("Posted Ins DatasheetHeader B2B"; "Posted Ins DatasheetHeader B2B")
        {
            RequestFilterFields = "No.", "Posted Date";
            column(ItemNoCaptionLbl; ItemNoCaptionLbl)
            { }
            column(ItemDescrCapLbl; ItemDescrCapLbl)
            { }
            column(UomCapLbl; UomCapLbl)
            { }
            column(quantityCapLbl; quantityCapLbl)
            { }
            column(SpecCapLbl; SpecCapLbl)
            { }
            column(LocCapLbl; LocCapLbl)
            { }
            column(LotCapLbl; LotCapLbl)
            { }
            column(SNOCapLbl; SNOCapLbl)
            { }
            column(CharCapLbl; CharCapLbl)
            { }
            column(InspCapLbl; InspCapLbl)
            { }
            column(SamplCapLbl; SamplCapLbl)
            { }
            column(MinCapLbl; MinCapLbl)
            { }
            column(MaxCapLbl; MaxCapLbl)
            { }
            column(ActCapLbl; ActCapLbl)
            { }
            column(MinTextCapLbl; MinTextCapLbl)
            {

            }
            column(MaxTextCapLbl; MaxTextCapLbl)
            { }
            column(ActTextCapLbl; ActTextCapLbl)
            { }
            column(RemarksCapLbl; RemarksCapLbl)
            { }
            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
            { }
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
            { }
            column(location_Addres; LocationGRec.Address)//B2BSSD09Jan2023
            { }
            column(location_Adress2; LocationGRec."Address 2")//B2BSSD09Jan2023
            { }
            column(Item_No_; "Item No.")
            {

            }
            column(Description; Description)
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }
            column(Quantity; Quantity)
            { }
            column(Spec_ID; "Spec ID")
            {

            }
            column(Location; Location)
            { }
            column(Lot_No_; "Lot No.")
            { }

            dataitem("Posted Ins Datasheet Line B2B"; "Posted Ins Datasheet Line B2B")
            {
                DataItemTableView = where(Accept = const(false), Qualitative = const(false), "Character Code" = filter(<> ''));
                DataItemLinkReference = "Posted Ins DatasheetHeader B2B";
                DataItemLink = "Document No." = field("No.");

                column(SNo; SNo)
                { }
                column(Character_Code; "Character Code")
                { }
                column(Sampling_Plan_Code; "Sampling Plan Code")
                { }
                column(Min__Value__Num_1; "Min. Value (Num)")
                { }
                column(Max__Value__Num_1; "Max. Value (Num)")
                {

                }
                column(Min__Value__Text_1; "Min. Value (Text)")
                { }
                column(Max__Value__Text_1; "Max. Value (Text)")
                { }

                column(Actual_Value__Num_1; "Actual Value (Num)")
                {

                }
                column(Actual__Value__Text_1; "Actual  Value (Text)")
                { }


                column(Remarks; Remarks)
                { }
                trigger OnAfterGetRecord()
                begin
                    SNo += 1;
                end;
            }
        }
    }
    trigger OnPreReport()
    begin
        Clear(SNo);
        CompanyInfoGrec.Get();
        CompanyInfoGrec.CalcFields(Picture);
    end;
    /*requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }*/



    var
        SNo: Integer;
        CompanyInfoGrec: Record "Company Information";
        myInt: Integer;
        ItemNoCaptionLbl: Label 'Item No.';
        ItemDescrCapLbl: Label 'Item Description';
        UomCapLbl: Label 'Unit Of Measure';
        quantityCapLbl: Label 'Quantity';
        SpecCapLbl: Label 'Spec ID';
        LocCapLbl: Label 'Location';
        LotCapLbl: Label 'Lot';
        SNOCapLbl: Label 'SNO';
        CharCapLbl: Label 'Char';
        InspCapLbl: Label 'Inspection Group';
        SamplCapLbl: Label 'Sampling Plan';
        MinCapLbl: Label 'Min(Nos)';
        MaxCapLbl: Label 'Max(Nos)';
        ActCapLbl: Label 'Act (nos)';
        MinTextCapLbl: Label 'Min (text)';
        MaxTextCapLbl: Label 'Max (text)';
        ActTextCapLbl: Label 'Act (text)';
        RemarksCapLbl: Label 'Remarks';
        LocationGRec: Record Location;//B2BSSD09Jan2023

}
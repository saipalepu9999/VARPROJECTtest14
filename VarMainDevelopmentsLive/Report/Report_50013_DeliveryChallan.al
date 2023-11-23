report 50013 "Delivery Challan Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Delivery Challan';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\DeliveryChallan.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            //DataItemTableView = where("Document Type" = filter(Invoice));
            RequestFilterFields = "No.";
            column(No_SalesHeader; "No.")
            { }
            column(CompanyInfoGrec_Name; CompanyInfoGrec.Name)
            { }
            column(CompanyInfoGrec_Address; CompanyInfoGrec.Address)
            { }
            column(CompanyInfoGrec_Address2; CompanyInfoGrec."Address 2")
            { }
            column(location_Address; Location.Address)//B2BSSD09Jan2023
            { }
            column(location_Address2; Location."Address 2")//B2BSSD09Jan2023
            { }
            column(DelNoteCapLbl; DelNoteCapLbl)
            { }
            Column(DCNOCapLbl; DCNOCapLbl)
            { }
            Column(DateCapLbl; DateCapLbl)
            { }
            column(ToCapLbl; ToCapLbl)
            { }
            column(MsCapLbl; MsCapLbl)
            { }
            column(AgainstOrderNoCapLbl; AgainstOrderNoCapLbl)
            { }
            column(PleaseRecCapLbl; PleaseRecCapLbl)
            { }
            column(SINoCapLbl; SINoCapLbl)
            { }
            column(DescCapLbl; DescCapLbl)
            { }
            column(QtyCapLbl; QtyCapLbl)
            { }
            column(RemarksCapLbl; RemarksCapLbl)
            { }
            column(TotalCratesCapLbl; TotalCratesCapLbl)
            { }
            column(GrossWtCapLbl; GrossWtCapLbl)
            { }
            column(NetWtCapLbl; NetWtCapLbl)
            { }
            column(DimensionCapLbl; DimensionCapLbl)
            { }
            column(TotalGRWT; TotalGRWT)
            { }
            column(TotalNTWT; TotalNTWT)
            { }
            column(GSTINCapLbl; GSTINCapLbl)
            { }
            column(ForVarCapLbl; ForVarCapLbl)
            { }
            column(RecSigCapLbl; RecSigCapLbl)
            { }
            column(StoresCopyCapLbl; StoresCopyCapLbl)
            { }
            column(AuthSigCapLbl; AuthSigCapLbl)
            { }
            column(No_; "No.")
            { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            { }
            column(Sell_to_Address; "Sell-to Address")
            { }
            column(Order_No_; "Order No.")
            { }
            column(Document_Date; format("Document Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            { }
            column(CommentsText_1; CommentsText[1])
            { }
            column(CommentsText_2; CommentsText[2])
            { }
            column(CommentsText_3; CommentsText[3])
            { }
            column(CommentsText_4; CommentsText[4])
            { }
            column(CommentsText_5; CommentsText[5])
            { }
            column(CommentsText_6; CommentsText[6])
            { }
            column(CommentsText_7; CommentsText[7])
            { }
            column(CommentsText_8; CommentsText[8])
            { }
            column(CommentsCode_1; CommentsCode[1])
            { }
            column(CommentsCode_2; CommentsCode[2])
            { }
            column(CommentsCode_3; CommentsCode[3])
            { }
            column(CommentsCode_4; CommentsCode[4])
            { }
            column(CommentsCode_5; CommentsCode[5])
            { }
            column(CommentsCode_6; CommentsCode[6])
            { }
            column(CommentsCode_7; CommentsCode[7])
            { }
            column(CommentsCode_8; CommentsCode[8])
            { }



            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {

                DataItemLinkReference = "Sales Shipment Header";
                DataItemLink = "Document No." = FIELD("No.");
                /*column(No_SalesLine; "No.")
                {
                }
                column(HSNSACCode_SalesLine; "HSN/SAC Code")
                {
                }*/
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(GST; GST)
                { }
                column(Address; Address)
                { }


            }
            trigger OnAfterGetRecord()
            begin
                Location.Reset();
                Location.SetRange(Code, "Sales Shipment Header"."Location Code");
                if Location.FindFirst() then
                    Address := Location.Address;
                GST := Location."GST Registration No.";
                Clear(I);
                i := 1;
                Clear(CommentsText);
                Clear(CommentsCode);
                SalesCommentLineGrec.Reset();
                SalesCommentLineGrec.SetRange("Document Type", SalesCommentLineGrec."Document Type"::Shipment);
                SalesCommentLineGrec.SetRange("No.", "No.");
                SalesCommentLineGrec.SetRange("Document Line No.", 0);
                SalesCommentLineGrec.SetCurrentKey("Line No.");
                if SalesCommentLineGrec.FindSet() then
                    repeat
                        CommentsCode[I] := SalesCommentLineGrec."Code New";
                        CommentsText[I] := SalesCommentLineGrec.Comment;
                        i += 1;
                    until SalesCommentLineGrec.Next() = 0;
            end;

        }
    }
    trigger OnPreReport()
    begin
        CompanyInfoGrec.Get();
        CompanyInfoGrec.CalcFields(Picture);
        // StrSubstNo(StoresCopyCapLbl,)
    end;


    /*requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; SourceExpression)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

     /*   actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }
    
   */

    var

        CompanyInfoGrec: Record "Company Information";
        DelNoteCapLbl: Label 'DELIVERY CHALLAN';
        DCNOCapLbl: Label 'D.C.No.:';
        DateCapLbl: Label 'Date:';
        ToCapLbl: Label 'To,';
        MsCapLbl: Label 'M/s.';
        AgainstOrderNoCapLbl: Label 'Against Order No.';
        PleaseRecCapLbl: Label 'Please receive the following goods in good order and condition and return the duplicate duly signed with Companys Stamp.';
        HSNCodeCapLBl: Label 'HSN CODE';
        SINoCapLbl: Label 'SI No.';
        DescCapLbl: Label 'DESCRIPTION';
        QtyCapLbl: Label 'Quantity';
        RemarksCapLbl: Label 'Remarks';
        TotalCratesCapLbl: Label 'TOTAL CRATES:';
        GrossWtCapLbl: Label 'GROSS WEIGHT:';
        NetWtCapLbl: Label 'NET WEIGHT:';
        DimensionCapLbl: Label 'DIMENSION IN MM:';
        TotalGRWT: Label 'TOTAL GR.WT:';
        TotalNTWT: Label 'TOTAL NT.WT:';
        GSTINCapLbl: Label 'GSTIN:';
        ForVarCapLbl: Label 'For VAR ELECTROCHEM PRIVATE LIMITED';
        RecSigCapLbl: Label 'Receivers Signature';
        StoresCopyCapLbl: Label 'Stores Copy';
        AuthSigCapLbl: Label '(Authorised Signatory)';
        Location: Record Location;
        Address: Text;
        GST: Code[20];
        Tracking: Page "Item Tracking Lines";
        SalesCommentLineGrec: Record "Sales Comment Line";
        CommentsCode: array[10] of Text;
        CommentsText: array[10] of Text;
        I: Integer;
        pa: Page 9233;


}

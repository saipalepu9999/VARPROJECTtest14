report 50017 MaterialRequestVoucher
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Comparative Statement';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\Comparative.rdl';

    dataset
    {

        dataitem(QuotCompHdr; QuotCompHdr)
        {
            RequestFilterFields = "No.";
            column(No_QuotCompHdr; "No.")
            {
            }
            column(PurchReqRefNo_QuotCompHdr; "Purch. Req. Ref. No.")
            {
            }
            column(RFQNumber_QuotCompHdr; RFQNumber)
            {
            }


            dataitem("Quotation Comparison Test"; "Quotation Comparison Test")
            {
                DataItemLinkReference = QuotCompHdr;
                DataItemLink = "Quot Comp No." = FIELD("No.");
                DataItemTableView = where("Item No." = filter(<> ''));
                column(Amount; Amount)
                { }
                column(Quote_No_; "Quote No.")
                { }

                column(Status_QuotCompHdr; Status)
                {
                }
                column(ComparitiveCapLbl; ComparitiveCapLbl)
                { }
                column(SNOCapLbl; SNOCapLbl)
                {

                }
                column(DescapLbl; DescapLbl)
                { }
                column(UOMCapLbl; UOMCapLbl)
                { }
                column(QtyCapLbl; QtyCapLbl)
                { }
                column(UnitPriceCapLbl; UnitPriceCapLbl)
                { }
                column(TotalAmntCapLbl; TotalAmntCapLbl)
                { }
                column(TotalCapLbl; TotalCapLbl)
                {

                }
               column(Vendor_Quote_No_;"Vendor Quote No.")
               { }
               column(Vendor_Quote_Date;format("Vendor Quote Date",0,'<Day,2>-<Month,2>-<Year4>'))
               { }
                column(Description; Description)
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(Vendor_No_; "Vendor No.")
                {

                }
                column(RFQ_No_; "RFQ No.")
                { }
                column(Item_No_; "Item No.")
                { }
                column(Total_Amount; "Total Amount")

                { }
                column(Vendor_Name; "Vendor Name")
                { }
                column(UnitPrice; Rate)
                { }
                column(UnitofMeasure; "Unit of Measure Code")
                { }
                trigger OnAfterGetRecord()
                begin
                    /*PurchaseHdr.Reset();
                    PurchaseHdr.SetRange("RFQ No.", "RFQ No.");
                    if PurchaseHdr.FindSet() then
                        repeat
                            PurchLn.Reset();
                            PurchLn.SetRange("Document No.", PurchaseHdr."No.");
                            if PurchLn.FindSet() then
                                repeat
                                    UnitPrice := PurchLn."Unit Price (LCY)";
                                    UnitofMeasure := PurchLn."Unit of Measure";
                                until PurchLn.Next() = 0;
                        until PurchaseHdr.Next() = 0;*/

                end;


            }
        }

    }

    requestpage
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
                    ToolTip = 'Executes the ActionName action.';

                }
            }
        }
    }


    var
        PurchaseHdr: Record "Purchase Header";
        PurchLn: Record "Purchase Line";
        myInt: Integer;
        ComparitiveCapLbl: Label 'COMPARATIVE STATEMENT';
        SNOCapLbl: Label 'SNO.';
        DescapLbl: Label 'Description';
        UOMCapLbl: Label 'UOM';
        QtyCapLbl: Label 'QTY';
        UnitPriceCapLbl: Label 'Unit Price';
        TotalAmntCapLbl: Label 'Total Amount';
        QuotationCapLbl: Label 'Quotation';
        TotalCapLbl: Label 'Total in Rs';
        UnitPrice: Decimal;
        UnitofMeasure: Text[20];
}
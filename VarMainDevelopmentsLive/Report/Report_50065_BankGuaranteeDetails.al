report 50065 "Bank Guarantee  Details"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    Caption = 'Bank Guarantee Details';
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\BankGuaranteeDetails.rdl';
    dataset
    {
        dataitem("Bank Guarantee"; "Bank Guarantee")
        {
            RequestFilterFields = "BG Date", "Expiry Date";

            column(Bank_BG_No; "Bank BG No")
            {

            }
            column(Name; Name)
            { }
            column(BG_Margin_Amount; "BG Margin Amount")
            {

            }
            column(Issuing_Bank___Receiving_Bank; "Issuing Bank / Receiving Bank")
            {

            }
            column(Cancelation_Date; format("Cancelation Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {

            }
            column(BG_Date; format("BG Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {

            }
            column(Expiry_Date; format("Expiry Date", 0, '<Day,2>-<Month,2>-<Year4>'))
            {

            }
            column(BankGuaranteeDetailsCap; BankGuaranteeDetailsCap)
            { }
            column(SnoCap; SnoCap)
            { }
            column(BgNumberCap; BgNumberCap)
            { }
            column(BankNameCap; BankNameCap)
            { }
            column(ProjectNameCap; ProjectNameCap)
            { }
            column(BGMarginCap; BGMarginCap)
            { }
            column(MarginCap; MarginCap)
            { }
            column(BGMargin100Cap; BGMargin100Cap)
            { }
            column(BGstartDateCap; BGstartDateCap)
            { }
            column(BGValidupCap; BGValidupCap)
            { }
            column(BGCancelationCap; BGCancelationCap)
            {

            }
            column(BGReceivedDAmountCap; BGReceivedDAmountCap)
            { }
            column(IntrestCap; IntrestCap)
            { }
            column(TDSReceviableCap; TDSReceviableCap)
            { }
            column(RemarksCap; RemarksCap)
            {

            }
            column(Status; Status)
            { }
            column(BGStatus; "BG Status")
            { }
            column(FinalAmount; FinalAmount)
            {

            }
            column(FinalValue; FinalValue)
            {

            }
            column(StoreValue; StoreValue)
            {

            }
            column(SupplierCap; SupplierCap)
            { }
            column(TypeOfBGCap; TypeOfBGCap)
            { }
            column(SupplierNameVar; SupplierNameVar)
            { }
            column(TypeOfBG; "Type Of BG")
            { }
            column(BankName; "Bank Name")
            { }
            column(BG_Intrest; "BG Intrest")
            { }
            column(BG_Received_Amount; "BG Received Amount")
            { }
            column(TDS_Receivable_Amount; "TDS Receivable Amount")
            { }
            column(ProjectName; ProjectName)
            { }
            column(ProjectNameTxt; ProjectNameTxt)
            { }
            trigger OnAfterGetRecord()
            var
                SalesHeader: Record "Sales Header";
                SalesLine: Record "Sales Line";
            begin
                // if LocationGrec.Get(loc)
                Clear(FinalAmount);
                Clear(StoreValue);
                Clear(FinalValue);
                SalesHeader.Reset();
                SalesHeader.SetRange("BG No.", "BG No.");
                if SalesHeader.FindFirst() then
                    StoreValue := SalesHeader."Shortcut Dimension 2 Code";
                /*
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", SalesHeader."No.");
                if SalesLine.FindSet() then
                    repeat
                        FinalAmount += SalesLine.Amount;
                    until SalesLine.Next() = 0;
                */
                if SalesHeader."BG No." <> '' then begin
                    FinalValue := SalesHeader."BG Margin %";
                    FinalAmount := SalesHeader."BG Margin";
                end;
                if CustomerGRec.get("Customer/Vendor") then
                    SupplierNameVar := CustomerGRec.Name;
                if VendorGrec.Get("Customer/Vendor") then
                    SupplierNameVar := VendorGrec.Name;

                DimensionValueRec.Reset();
                DimensionValueRec.SetRange(Code, SalesHeader."Shortcut Dimension 2 Code");
                if DimensionValueRec.FindFirst() then
                    ProjectNameTxt := DimensionValueRec.Name;
            end;
        }
    }
    /*
        requestpage
        {
            layout
            {
                area(Content)
                {
                    group(GroupName)
                    {
                        field(BGNumGVar; BGNumGVar)
                        {
                            ApplicationArea = All;
                            TableRelation = "Bank Guarantee";

                        }
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
        }
    */
    /* rendering
     {
         layout(LayoutName)
         {
             Type = RDLC;
             LayoutFile = 'mylayout.rdl';
         }
     }*/

    var
        CustomerGRec: Record Customer;
        VendorGrec: Record Vendor;
        DimensionValueRec: Record "Dimension Value";
        SupplierNameVar: Text[50];
        SnoCap: Label 'S.No';
        BgNumberCap: Label 'B.G Number';
        BankNameCap: Label 'BANK NAME';
        ProjectNameCap: Label 'Project No';
        BGMarginCap: Label 'B.G MARGIN';
        MarginCap: Label 'MARGIN %';
        BGMargin100Cap: Label 'B.G MARGIN Amount';
        BGstartDateCap: Label 'B.G start Date';
        BGValidupCap: Label 'B.G Valid up to';
        BGCancelationCap: label 'B.G. CANCELATION DATE';
        BGReceivedDAmountCap: Label 'B.G RECEIVED AMOUNT';
        IntrestCap: Label 'INTEREST';
        TDSReceviableCap: Label 'TDS RECEIVALBE';
        RemarksCap: Label 'REMARKS';
        BankGuaranteeDetailsCap: Label 'Bank Guarantee  Details';
        LocationGrec: Record Location;
        BGNumGVar: Code[20];
        FinalAmount: Decimal;
        FinalValue: Decimal;
        StoreValue: Code[20];
        ProjectNameTxt: Text[50];
        ProjectName: Label 'Project Name';
        SupplierCap: Label 'Supplier Name';
        TypeOfBGCap: Label 'Type of BG';
}


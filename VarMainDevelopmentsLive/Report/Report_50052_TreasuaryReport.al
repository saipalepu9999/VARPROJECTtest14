report 50052 "Treasuary Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Treasuary Report';

    dataset

    {

        dataitem("Purchase Line"; "Purchase Line")
        {

            RequestFilterFields = "Document No.", "Posting Date";
            DataItemTableView = where("Document Type" = const(order));

            trigger OnPreDataItem()
            begin
                SetFilter("No.", '<>%1', '');
            end;

            trigger OnAfterGetRecord()
            var
                DateRec: Record Date;
                i: Integer;
            begin
                if not PurchaseHeader.Get("Document Type", "Document No.") then
                    Clear(PurchaseHeader);

                Clear(Paid);
                Clear(ToBePaid);
                clear(SGSTAmt);
                clear(IGSTAmt);
                clear(CGSTAmt);
                clear(CessAmt);
                clear(CGSTPer);
                clear(IGSTPer);
                clear(SGSTPer);
                GSTSetup.get();
                GetGSTAmounts(TaxTransactionValue, "Purchase Line", GSTSetup);

                ExcelBuffer.NewRow();
                ExcelBuffer.AddColumn(format(PurchaseHeader."Order Date", 0, '<Day,2>-<Month,2>-<Year4>'), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Number);
                ExcelBuffer.AddColumn(PurchaseHeader."No.", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(PurchaseHeader."Buy-from Vendor Name", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Date);
                ExcelBuffer.AddColumn("Purchase Line".Description, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Purchase Line".Quantity, FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Purchase Line"."Quantity Received", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Purchase Line".Quantity - ("Purchase Line"."Quantity Received"), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Purchase Line"."Direct Unit Cost", FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn("Purchase Line"."Line Amount" + (SGSTAmt + IGSTAmt + CGSTAmt), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);


                PurcseInvceLiG.Reset();
                PurcseInvceLiG.SetRange("Order No.", "Purchase Line"."Document No.");
                PurcseInvceLiG.SetRange("Order Line No.", "Purchase Line"."Line No.");
                IF PurcseInvceLiG.FindSet() then
                    repeat
                        vendorledgerentriGv.Reset();
                        vendorledgerentriGv.SetRange("Document No.", PurcseInvceLiG."Document No.");
                        vendorledgerentriGv.SetRange("Vendor No.", PurcseInvceLiG."Buy-from Vendor No.");
                        vendorledgerentriGv.SetRange("Document Type", vendorledgerentriGv."Document Type"::Invoice);
                        if vendorledgerentriGv.FindSet() then
                            repeat
                                vendorledgerentriGv.CalcFields("Remaining Amount");
                                i := Date2DMY(vendorledgerentriGv."Posting Date", 2);
                                ToBePaid[i] += vendorledgerentriGv."Remaining Amount";
                                GetPaidAmount(vendorledgerentriGv, Paid);
                            until vendorledgerentriGv.Next() = 0;
                    UNTIL PurcseInvceLiG.NexT = 0
                else begin
                    PurchRcptLine.Reset();
                    PurchRcptLine.SetRange("Order No.", "Document No.");
                    PurchRcptLine.SetRange("Order Line No.", "Line No.");
                    if PurchRcptLine.FindSet() then
                        repeat
                            PurcseInvceLiG.Reset();
                            PurcseInvceLiG.SetRange("Receipt No.", PurchRcptLine."Document No.");
                            PurcseInvceLiG.SetRange("Receipt Line No.", PurchRcptLine."Line No.");
                            IF PurcseInvceLiG.FindSet() then
                                repeat
                                    vendorledgerentriGv.Reset();
                                    vendorledgerentriGv.SetRange("Document No.", PurcseInvceLiG."Document No.");
                                    vendorledgerentriGv.SetRange("Vendor No.", PurcseInvceLiG."Buy-from Vendor No.");
                                    vendorledgerentriGv.SetRange("Posting Date", YearStart, YearEnd);
                                    vendorledgerentriGv.SetRange("Document Type", vendorledgerentriGv."Document Type"::Invoice);
                                    if vendorledgerentriGv.FindSet() then
                                        repeat
                                            vendorledgerentriGv.CalcFields("Remaining Amount");
                                            i := Date2DMY(vendorledgerentriGv."Posting Date", 2);
                                            ToBePaid[i] += vendorledgerentriGv."Remaining Amount";
                                            GetPaidAmount(vendorledgerentriGv, Paid);
                                        until vendorledgerentriGv.Next() = 0;
                                UNTIL PurcseInvceLiG.NexT = 0;
                        until PurchRcptLine.Next() = 0;
                end;

                for i := 1 to ArrayLen(Paid) do begin
                    ExcelBuffer.AddColumn(Paid[i], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(ToBePaid[i], FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                end;


            end;
        }

    }

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
    trigger OnPreReport()
    begin
        YearStart := DMY2Date(01, 01, Date2DMY(WorkDate(), 3));
        YearEnd := DMY2Date(31, 12, Date2DMY(WorkDate(), 3));
        //YearStart := CalcDate('-11M,-CM',WorkDate());
        Makeexcelheader();
    end;


    var
        Window: Dialog;
        PurchaseHeader: Record "Purchase Header";
        ExcelBuffer: Record "Excel Buffer" temporary;
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        CessAmt: Decimal;
        IGSTLbl: Label 'IGST';
        SGSTLbl: Label 'SGST';
        CGSTLbl: Label 'CGST';
        CESSLbl: Label 'CESS';
        GSTLbl: Label 'GST';
        GSTCESSLbl: Label 'GST CESS';
        SGSTPer: Decimal;
        IGSTPer: Decimal;
        CGSTPer: Decimal;
        TaxTransactionValue: Record "Tax Transaction Value";

        GSTSetup: Record "GST Setup";
        PurcseInvceLiG: Record "Purch. Inv. Line";
        vendorledgerentriGv: Record "Vendor Ledger Entry";
        YearStart: Date;
        YearEnd: Date;
        Paid: array[12] of Decimal;
        ToBePaid: array[12] of Decimal;
        PurchRcptLine: Record "Purch. Rcpt. Line";


    procedure Makeexcelheader()
    var
        DateRec: Record Date;
        Year: Text[10];
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        DateRec.Reset();
        DateRec.SetRange("Period Start", YearStart, YearEnd);
        DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
        if DateRec.FindSet() then
            repeat
                ExcelBuffer.AddColumn('Paid', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn('To Be Paid', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            until DateRec.Next() = 0;

        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Date', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Purchase Order', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Supplier Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Material Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Qty', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Recd', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Balance', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Rate Per Unit', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Amount', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);

        Year := copystr(format(Date2DMY(WorkDate(), 3)), 3, 2);
        DateRec.Reset();
        DateRec.SetRange("Period Start", YearStart, YearEnd);
        DateRec.SetRange("Period Type", DateRec."Period Type"::Month);
        if DateRec.FindSet() then
            repeat
                ExcelBuffer.AddColumn(StrSubstNo('%1 %2', CopyStr(DateRec."Period Name", 1, 3), Year), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
                ExcelBuffer.AddColumn(StrSubstNo('%1 %2', CopyStr(DateRec."Period Name", 1, 3), Year), FALSE, '', FALSE, FALSE, TRUE, '', ExcelBuffer."Cell Type"::Text);
            until DateRec.Next() = 0;
    end;

    LOCAL PROCEDURE CreateBook();
    begin
        ExcelBuffer.CreateBookAndOpenExcel('', 'Treasuary Report', '', '', USERID);
    end;

    local procedure GetGSTAmounts(TaxTransactionValue: Record "Tax Transaction Value";
   PurchaseLine: Record "Purchase Line";
   GSTSetup: Record "GST Setup")
    var
        ComponentName: Code[30];
    begin
        ComponentName := GetComponentName("Purchase Line", GSTSetup);

        if (PurchaseLine.Type <> PurchaseLine.Type::" ") then begin
            TaxTransactionValue.Reset();
            TaxTransactionValue.SetRange("Tax Record ID", PurchaseLine.RecordId);
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
            TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
            TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
            if TaxTransactionValue.FindSet() then
                repeat
                    case TaxTransactionValue."Value ID" of
                        6:
                            begin
                                SGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                SGSTPer := TaxTransactionValue.Percent;
                            end;
                        2:
                            begin
                                CGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                CGSTPer := TaxTransactionValue.Percent;
                            end;
                        3:
                            begin
                                IGSTAmt += Round(TaxTransactionValue.Amount, GetGSTRoundingPrecision(ComponentName));
                                IGSTPer := TaxTransactionValue.Percent;
                            end;
                    end;
                until TaxTransactionValue.Next() = 0;
        end;
    end;

    local procedure GetComponentName(PurchaseLine: Record "Purchase Line";
       GSTSetup: Record "GST Setup"): Code[30]
    var
        ComponentName: Code[30];
    begin
        if GSTSetup."GST Tax Type" = GSTLbl then
            if PurchaseLine."GST Jurisdiction Type" = PurchaseLine."GST Jurisdiction Type"::Interstate then
                ComponentName := IGSTLbl
            else
                ComponentName := CGSTLbl
        else
            if GSTSetup."Cess Tax Type" = GSTCESSLbl then
                ComponentName := CESSLbl;
        exit(ComponentName)
    end;

    procedure GetGSTRoundingPrecision(ComponentName: Code[30]): Decimal
    var
        TaxComponent: Record "Tax Component";
        GSTSetup: Record "GST Setup";
        GSTRoundingPrecision: Decimal;
    begin
        if not GSTSetup.Get() then
            exit;
        GSTSetup.TestField("GST Tax Type");

        TaxComponent.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxComponent.SetRange(Name, ComponentName);
        TaxComponent.FindFirst();
        if TaxComponent."Rounding Precision" <> 0 then
            GSTRoundingPrecision := TaxComponent."Rounding Precision"
        else
            GSTRoundingPrecision := 1;
        exit(GSTRoundingPrecision);
    end;

    trigger OnPostReport()
    begin
        CreateBook();
    end;

    local procedure GetPaidAmount(VendorLedgerEntry: Record "Vendor Ledger Entry"; var PaidVar: array[12] of Decimal)
    var
        DtldVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        DtldVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
        j: Integer;
    begin
        DtldVendLedgEntry1.SETCURRENTKEY("Vendor Ledger Entry No.");
        DtldVendLedgEntry1.SETRANGE("Vendor Ledger Entry No.", VendorLedgerEntry."Entry No.");
        DtldVendLedgEntry1.SETRANGE(Unapplied, FALSE);
        IF DtldVendLedgEntry1.FIND('-') THEN
            REPEAT
                IF DtldVendLedgEntry1."Vendor Ledger Entry No." =
                   DtldVendLedgEntry1."Applied Vend. Ledger Entry No."
                THEN BEGIN
                    DtldVendLedgEntry2.INIT;
                    DtldVendLedgEntry2.SETCURRENTKEY("Applied Vend. Ledger Entry No.", "Entry Type");
                    DtldVendLedgEntry2.SETRANGE(
                      "Applied Vend. Ledger Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    DtldVendLedgEntry2.SETRANGE("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
                    DtldVendLedgEntry2.SETRANGE(Unapplied, FALSE);
                    IF DtldVendLedgEntry2.FIND('-') THEN
                        REPEAT
                            IF DtldVendLedgEntry2."Vendor Ledger Entry No." <>
                               DtldVendLedgEntry2."Applied Vend. Ledger Entry No."
                            THEN BEGIN
                                VendLedgEntry.SETCURRENTKEY("Entry No.");
                                VendLedgEntry.SETRANGE("Entry No.", DtldVendLedgEntry2."Vendor Ledger Entry No.");
                                VendLedgEntry.SetRange("Posting Date", YearStart, YearEnd);
                                IF VendLedgEntry.FIND('-') THEN begin
                                    VendLedgEntry.CalcFields(Amount);
                                    j := Date2DMY(VendLedgEntry."Posting Date", 2);
                                    PaidVar[j] += VendLedgEntry.Amount;
                                end;
                            END;
                        UNTIL DtldVendLedgEntry2.NEXT = 0;
                END ELSE BEGIN
                    VendLedgEntry.SETCURRENTKEY("Entry No.");
                    VendLedgEntry.SETRANGE("Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                    VendLedgEntry.SetRange("Posting Date", YearStart, YearEnd);
                    IF VendLedgEntry.FIND('-') THEN begin
                        VendLedgEntry.CalcFields(Amount);
                        j := Date2DMY(VendLedgEntry."Posting Date", 2);
                        PaidVar[j] += VendLedgEntry.Amount;
                    end;
                END;
            UNTIL DtldVendLedgEntry1.NEXT = 0;
    end;
}
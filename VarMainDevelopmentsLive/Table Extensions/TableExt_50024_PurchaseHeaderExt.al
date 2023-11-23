tableextension 50024 PurchaseHeaderExtension extends "Purchase Header"
{

    fields
    {
        field(50000; "MSME Certificate No."; Code[20])
        {
            Caption = 'MSME Certificate No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin

            end;
        }
        field(50001; "MSME Validity Date"; Date)
        {
            Caption = 'MSME Validity Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

            end;
        }
        modify("Buy-from Vendor No.")
        {
            trigger OnAfterValidate()
            var
                Vend: Record Vendor;
            begin
                If Vend.get("Buy-from Vendor No.") then begin
                    "MSME Certificate No." := Vend."MSME Certificate No.";
                    "MSME Validity Date" := Vend."MSME Validity Date";
                end;
            end;
        }
        //4.12 >>
        field(50002; "Short Close Status"; Enum ShortCloseStatus)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50003; "Short Closed By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50004; "Short Closed DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50005; "Pc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Procurement Certificate No.';
        }
        field(50006; "Pc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Procurement Certificate Date';
        }
        field(50007; "Dc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan  No.';
        }
        field(50008; "Dc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan Date';
        }
        field(50009; "Quality Remarks"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(50010; "Duty Involved_B2B"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Duty Involved For Cleared';
        }
        field(50011; "Item Drawings"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Item Drawings';
        }
        field(50012; "Terms & Conditions"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Terms & Conditions';
        }
        field(50013; "Test Certificate"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Test Certificate';
        }

        field(50014; "Shortcut Dimension 2 Code_B2B"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
             Blocked = CONST(false), "Division Code" = field("Shortcut Dimension 1 Code"));
            trigger OnValidate()
            begin

                Validate("Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code_B2B");
            end;
        }
        field(50015; "Reference Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnBeforeValidate()
            begin
                if CopyStr("Shortcut Dimension 1 Code", 1, 1) <> CopyStr("No. Series", 1, 1) then
                    Error('Please Select The Correct Division');
            end;
        }
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()
            var
                PostingNoSeries: Record "Posting No. Series";
                TableID: Integer;
                NoSeriesCode: Code[20];
                PostingNoSeriesMgmt: Codeunit "Posting No. Series Mgmt.";
                EmialMessage: Codeunit "Email Message";
            begin
                "Shortcut Dimension 2 Code_B2B" := "Shortcut Dimension 2 Code";
                Clear(NoSeriesCode);
                if "Document Type" = "Document Type"::Invoice then begin
                    TableID := Database::"Purchase Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Purch. Inv. Header");
                    if NoSeriesCode <> '' then
                        Rec."Posting No. Series" := NoSeriesCode;
                    // Rec."Receiving No. Series" := NoSeriesCode;
                end;
                Clear(NoSeriesCode);
                if "Document Type" = "Document Type"::Order then begin
                    TableID := Database::"Purchase Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Purch. Rcpt. Header");
                    if NoSeriesCode <> '' then
                        // Rec."Posting No. Series" := NoSeriesCode;
                        Rec."Receiving No. Series" := NoSeriesCode;
                end;
                Clear(NoSeriesCode);
                if "Document Type" = "Document Type"::"Credit Memo" then begin
                    TableID := Database::"Purchase Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Purch. Cr. Memo Hdr.");
                    if NoSeriesCode <> '' then
                        // Rec."Posting No. Series" := NoSeriesCode;
                        Rec."Posting No. Series" := NoSeriesCode;
                end;
                Clear(NoSeriesCode);
                if "Document Type" = "Document Type"::"Return Order" then begin
                    TableID := Database::"Purchase Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Purchase Return Shipment No.");
                    if NoSeriesCode <> '' then
                        // Rec."Posting No. Series" := NoSeriesCode;
                        Rec."Return Shipment No. Series" := NoSeriesCode;
                end;
            end;
        }

        field(50016; "Vendor Invoice Date"; Date)
        {
            Caption = 'Vendor Invoice Date';
            DataClassification = ToBeClassified;
        }
        field(50021; "Order Type"; Option)
        {
            Caption = 'Order Type';
            OptionMembers = " ",Production,Quality,"Maintenance/Jigs & Fixtures Spares","General Items";
            DataClassification = ToBeClassified;
        }

        field(50022; "Old Po No."; Code[50])
        {
            Caption = 'Old Purchase Order No.';
            DataClassification = ToBeClassified;
        }
        field(50023; "Old Po Date"; Date)
        {
            Caption = 'Old PUrchase Order Date';
            DataClassification = ToBeClassified;
        }
        field(50024; "New Remarks"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remarks';
        }
        field(50025; Printable; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Printable';
        }
        //B2BJKon10may2023 >>
        field(50026; "Service MRV"; boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Service MRV';
            Editable = false;
        }
        //B2BJKon10may2023 <<
        field(50027; "PO Ack.Date"; Date)
        {
            Caption = 'PO Ack.Date';
            DataClassification = ToBeClassified;
        }//B2BPROn03Jul2023
        field(50028; "Ack.Val"; Boolean)
        {
            Caption = 'Ack.Attachment';
            DataClassification = ToBeClassified;
        }

        //4.12 <<
    }

    var
        myInt: Integer;
        Pa11: page 491;
        Pa: page 9231;
        Pq1: page 113;
        Pag: Page 18695;
        Cu: Codeunit 90;
        uom: Codeunit "Unit of Measure Management";
        Ta83: Record 83;
}
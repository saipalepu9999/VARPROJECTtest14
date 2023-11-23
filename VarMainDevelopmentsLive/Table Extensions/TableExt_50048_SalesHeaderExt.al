tableextension 50048 "SalesHeaderExtension" extends "Sales Header"
{
    fields
    {
        field(50000; "Tender/Project"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tender/Project Conformation By Customer';

        }
        field(50001; "Liquidated Damages"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Applicable,"Not Applicable";
        }
        field(50002; "Green Card Applicable"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Yes,No;
            // OptionCaption = ' ,Yes,No';
        }
        field(50003; "Green Card Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Technical,Commercial,"Techno Commercial";
            // OptionCaption = ' ,Technical,Commercial';
            // Editable = EditableGvar;
        }
        field(50004; "Green Card Received"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Yes,No;
            //OptionCaption = ' ,Yes,No';
        }
        field(50005; "Green Card Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Shortcut Dimension 2 Code_B2B"; Code[20])
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
                //if "Invoice For Rental" = false then begin
                if "Document Type" = "Document Type"::Invoice then begin
                    TableID := Database::"Sales Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Sales Invoice Header");
                    if NoSeriesCode <> '' then
                        Rec."Posting No. Series" := NoSeriesCode;
                    // Rec."Receiving No. Series" := NoSeriesCode;
                end;
                Clear(NoSeriesCode);
                if "Document Type" = "Document Type"::Order then begin
                    TableID := Database::"Sales Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Sales Shipment Header");
                    if NoSeriesCode <> '' then
                        // Rec."Posting No. Series" := NoSeriesCode;
                        Rec."Shipping No. Series" := NoSeriesCode;
                end;
                Clear(NoSeriesCode);
                if "Document Type" = "Document Type"::"Credit Memo" then begin
                    TableID := Database::"Sales Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Sales Cr.Memo Header");
                    if NoSeriesCode <> '' then
                        // Rec."Posting No. Series" := NoSeriesCode;
                        Rec."Posting No. Series" := NoSeriesCode;
                end;
                Clear(NoSeriesCode);
                if "Document Type" = "Document Type"::"Return Order" then begin
                    TableID := Database::"Sales Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Sales Return Receipt No.");
                    if NoSeriesCode <> '' then
                        // Rec."Posting No. Series" := NoSeriesCode;
                        Rec."Return Receipt No. Series" := NoSeriesCode;
                end;
                //end;
            end;
        }

        field(50007; "BG No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Guarantee"."BG No.";
            trigger OnValidate()
            var
                BankGuaGrec: Record "Bank Guarantee";
            begin
                if BankGuaGrec.Get("BG No.") then
                    "BG Margin" := BankGuaGrec."BG Margin Amount";
            end;
        }
        field(50008; "Receipt Of Customer Po"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cluster Munition Certificate';
            OptionMembers = " ",Available,"Not Available";
        }
        field(50009; "Receipt Of Cust Drawings"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Of Customer Drawings';
            OptionMembers = " ",Available,"Not Available";
        }
        field(50010; "BG/FDR"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'BG/FDR';
            OptionMembers = " ",Required,"Not Required";
        }
        field(50011; "BG/FDR Availability"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Available,"Not Available";
        }
        field(50012; "BG/FDR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        /*field(50013; "BG/FDR Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "BG/FDR Closure Date"; Date)
        {
            DataClassification = ToBeClassified;
        }*/
        field(50015; "Acceptance Letter"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Required,"Not Required",Pending;
        }
        field(50016; "QAP document"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'QAP Document Delivery & Customer Acknowledgment';
            OptionMembers = " ",Yes,No,Pending;
        }
        field(50017; "External Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Port Of Discharge"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Cluster Munition"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Required,"Not Required";
            Caption = 'Cluster Munition Certificate Requiremnt';
        }
        field(50020; "Type Of BG"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Security BG\FDR","Performance BG\FDR","Security&PerformanceBG\FDR";
        }
        field(50021; "SBG FDR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "PBG FDR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "SPBG FDR No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "SBG Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "PBG Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "SPBG Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Extended Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Extended End Date';
        }
        field(50028; "SBG EndDate"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'SBG End Date';
        }
        field(50029; "PBG EndDate"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'PBG End Date';
        }
        field(50030; "SPBG EndDate"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'SPBG End Date';
        }
        field(50031; "Customer Po No."; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Customer Po Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50033; "Remarks1"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Terms';
        }
        field(50034; "Remarks2"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Final Destintion"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Amendment No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "Amendment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50038; "Invoice For Rental"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PostingNoSeries: Record "Posting No. Series";
                TableID: Integer;
                NoSeriesCode: Code[20];
                PostingNoSeriesMgmt: Codeunit "Posting No. Series Mgmt.";
                EmialMessage: Codeunit "Email Message";
            begin
                if "Document Type" = "Document Type"::Invoice then begin
                    TableID := Database::"Sales Header";
                    NoSeriesCode := PostingNoSeries.LoopPostingNoSeries(TableID, PostingNoSeries, Rec, PostingNoSeries."Document Type"::"Sales Invoice Header");
                    if NoSeriesCode <> '' then
                        Rec."Posting No. Series" := NoSeriesCode;
                    // Rec."Receiving No. Series" := NoSeriesCode;
                end;
            end;
        }
        field(50039; "BG Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'BG Margin';
        }
        field(50040; "BG Margin %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'BG Margin %';
        }
        field(50041; "GCA Exports"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'GCA Exports';
        }
        field(50042; "RPA Exports"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'RPA Exports';
        }

        modify("Exit Point")
        {
            Caption = 'Port Of Loading';
        }
        modify("Shipment Method Code")
        {
            Caption = 'Shipment Terms';
        }
    }
    var
        // EditableGvar : Boolean;
        item: Record Item;
}
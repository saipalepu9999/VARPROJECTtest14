table 50025 NCPR
{
    Caption = 'NCPR';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit 396;
                InventorySetup: Record "Inventory Setup";
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    InventorySetup.GET;
                    NoSeriesMgt.TestManual(InventorySetup."NCPR Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; "IR No."; Code[20])
        {
            Caption = 'IR No.';
            DataClassification = CustomerContent;
            TableRelation = "Inspection Receipt Header B2B"."No." where(Status = const(true));
            trigger OnValidate()
            var
                InspectionReceipt: Record "Inspection Receipt Header B2B";
                ProdOrder: Record "Production Order";
                ProdOrderLine: Record "Prod. Order Line";
                purchaseHeader: Record "Purchase Header";
                purchaseLine: Record "Purchase Line";
            begin
                TestStatus();
                if InspectionReceipt.Get("IR No.") then begin
                    "IR Date" := InspectionReceipt."Posting Date";
                    "Product Description" := InspectionReceipt."Item Description";
                    "MRV No." := InspectionReceipt."Receipt No.";
                    "MRV Date" := InspectionReceipt."Posting Date";
                    "Party Name" := InspectionReceipt."Vendor Name";
                    "To Be Implemeted By" := InspectionReceipt."Vendor Name";
                    "Released Prod.Order No" := InspectionReceipt."Prod. Order No.";
                    if ProdOrder.Get(ProdOrder.Status::Released, InspectionReceipt."Prod. Order No.") then
                        "Released Prod Order Date" := ProdOrder."Creation Date";
                    if ("Party Name" = '') and (InspectionReceipt."Prod. Order No." <> '') then begin
                        ProdOrderLine.Reset();
                        ProdOrderLine.SetRange("Prod. Order No.", InspectionReceipt."Prod. Order No.");
                        ProdOrderLine.SetRange("Subcontracting Order", true);
                        if ProdOrderLine.FindFirst() then begin
                            purchaseLine.Reset();
                            purchaseLine.SetRange("Document No.", ProdOrderLine."Purchase Order No.");
                            purchaseLine.SetRange("Line No.", ProdOrderLine."Purchase Order Line No.");
                            if purchaseLine.FindFirst() then begin
                                purchaseHeader.Reset();
                                purchaseHeader.SetRange("No.", purchaseLine."Document No.");
                                if purchaseHeader.FindFirst() then begin
                                    "Party Name" := purchaseHeader."Buy-from Vendor Name";
                                    "To Be Implemeted By" := purchaseHeader."Buy-from Vendor Name";
                                end;
                            end;

                        end;
                    end;

                end;
            end;
        }
        field(3; "IR Date"; Date)
        {
            Caption = 'IR Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Product Description"; Text[100])
        {
            Caption = 'Product Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; Reference; Text[1000])
        {
            Caption = 'Reference';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(6; "MRV No."; Code[20])
        {
            Caption = 'MRV No.';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(7; "MRV Date"; Date)
        {
            Caption = 'MRV Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Party Name"; Text[100])
        {
            Caption = 'Party Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Description Of Product"; Text[1000])
        {
            Caption = 'Description Of Product';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Description Initiated By"; Text[100])
        {
            Caption = 'Description Initiated By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(11; "Description Initiated Date"; Date)
        {
            Caption = 'Description Initiated Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(12; Rework; Boolean)
        {
            Caption = 'Rework';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(13; Regrade; Boolean)
        {
            Caption = 'Regrade';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(14; "Reject&Return To Vendor"; Boolean)
        {
            Caption = 'Reject&Return To Vendor';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(15; "Reject&Scrap"; Boolean)
        {
            Caption = 'Reject&Scrap';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(16; "Authorized/Approved By"; Text[100])
        {
            Caption = 'Authorized/Approved By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(17; "Root Cause"; Text[1000])
        {
            Caption = 'Root Cause';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(18; "Corrective Action Planned"; Text[1000])
        {
            Caption = 'Corrective Action Planned';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(19; "Corrctive Initiated By"; Text[100])
        {
            Caption = 'Corrctive Initiated By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(20; "Corrective Initiated Date"; Date)
        {
            Caption = 'Corrective Initiated Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(21; "Corrective Action Implemenetd"; Text[1000])
        {
            Caption = 'Corrective Action Implemenetd';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(22; "To Be Implemeted By"; Text[100])
        {
            Caption = 'To Be Implemeted By';
            DataClassification = CustomerContent;
            Editable = false;
            //TableRelation = "User Setup";
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(23; "To Be Implemented Date"; Date)
        {
            Caption = 'To Be Implemented Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(24; "Follow Up Audit"; Text[1000])
        {
            Caption = 'Follow Up Audit';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(25; "Ncpr Closed/Not Closed"; Option)
        {
            Caption = 'Ncpr Closed/Not Closed';
            // DataClassification = CustomerContent;
            OptionMembers = "Not Closed",Closed;
            trigger OnValidate()
            begin
                TestStatus();
            end;
        }
        field(26; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Status; Option)
        {
            OptionMembers = Open,Release;
        }
        field(28; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //B2BVCOn14Mar2023>>
        field(29; Description; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Tobeimplementedby(In house):"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'To be implemented by (In house) :';
            OptionMembers = " ","Var Electrochem Pvt Ltd.";
            trigger OnValidate()
            begin
                if "To Be Implemeted By" <> '' then
                    Error('you cannot select this option');
            end;
        }
        field(31; "Released Prod.Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(32; "Released Prod Order Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //B2BVCOn14Mar2023<<

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        InventorySetup.GET;
        IF "No." = '' THEN BEGIN
            InventorySetup.TestField("NCPR Nos.");
            NoSeriesMgt.InitSeries(InventorySetup."NCPR Nos.", xRec."No. Series", WorkDate(), "No.", "No. Series");
        END;
    end;

    procedure AssistEdit(NCPRHeader: Record NCPR): Boolean
    var
        NoSeries: Record "No. Series";
    begin
        InventorySetup.GET;
        //TestNoSeries;
        InventorySetup.TestField("NCPR Nos.");
        IF NoSeriesMgt.SelectSeries(InventorySetup."NCPR Nos.", NCPRHeader."No. Series", "No. Series") THEN BEGIN
            InventorySetup.GET;
            //TestNoSeries;
            InventorySetup.TestField("NCPR Nos.");
            NoSeriesMgt.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    procedure TestStatus()
    begin
        TestField(Status, Status::Open);
    end;

    var
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

}

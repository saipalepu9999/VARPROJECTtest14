table 50040 "MRV Quality Ledger Entry"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item Spec meets the Req(Y/N)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Item Working Condition Accepted (Y/N)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Accepted Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Accepted Quantity" <> 0 then
                    GetNoSeries();
                //   if Quantity < "Accepted Quantity" then
                QuantityTotal;
            end;
        }
        field(10; "Rework Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Rework Quantity" <> 0 then
                    GetNoSeries();
                /*  if (Quantity < ("Rework Quantity" + "Rejected Quantity" + "Accepted Quantity")) then
                      Error('Rework Quantity is More than Quantity');*/
                QuantityTotal;

            end;
        }
        field(11; "Rejected Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Rejected Quantity" <> 0 then
                    GetNoSeries();
                // if Quantity < "Rejected Quantity" then
                /*if (Quantity < ("Rework Quantity" + "Rejected Quantity" + "Accepted Quantity")) then
                    Error('Rejected Quantity is More than Quantity');*/
                QuantityTotal;
            end;

        }
        field(12; "Rework Level"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Qty to sent rework"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Rework Quantity" = "Qty to Received Rework" then
                    Error('Rework Quantity is Enough');
                Reworking();
            end;
        }
        field(14; "Qty to send reworked"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Reworking();
            end;
        }
        field(15; "Qty to Receive Rework"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                TEXT0001: Label 'Quantity to Send Reworked is less than Qty to Receive Rework';
            begin
                //  IF ("Qty to Receive Rework" + "Qty to Received Rework") > "Qty to send reworked" then begin
                //   IF ("Qty to Received Rework") > "Qty to send reworked" then begin
                IF "Qty to send reworked" = 0 then begin

                    Error(TEXT0001);
                    "Qty to Receive Rework" := 0;
                end;
            END;
        }
        field(16; "Qty to Received Rework"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "User ID"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            trigger OnValidate()
            begin
                /* if ("Accepted Quantity" <> 0) or ("Rejected Quantity" <> 0) or ("Rework Quantity" <> 0) then begin
                     IF "No." <> xRec."No." THEN BEGIN
                         PurchPaySetup.GET;
                         NoSeriesMgt.TestManual(PurchPaySetup."MRV No.Series");
                         "No. Series" := '';
                     END;
                 end;*/
            end;
        }
        field(22; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(23; "MRV Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }



    local procedure QuantityTotal()
    var
        myInt: Integer;
    begin
        if (rec.Quantity < (rec."Rework Quantity" + rec."Rejected Quantity" + rec."Accepted Quantity")) then
            Error(Text0001);

    end;

    local procedure Reworking()
    var
        myInt: Integer;
    begin
        if (rec."Rework Quantity" < (rec."Qty to sent rework" + rec."Qty to send reworked")) then
            Error(Text0001);
    end;
    /*
        trigger OnInsert()
        begin
            PurchPaySetup.GET;
            if ("Accepted Quantity" <> 0) or ("Rejected Quantity" <> 0) or ("Rework Quantity" <> 0) then begin
                IF "No." = '' THEN BEGIN
                    PurchPaySetup.TestField("MRV No.Series");
                    NoSeriesMgt.InitSeries(PurchPaySetup."MRV No.Series", xRec."No. Series", WorkDate(), "No.", "No. Series");
                END;
                "MRV Posting Date" := WorkDate();
            end;
        end;*/

    procedure GetNoSeries()
    begin
        if "No." = '' then begin
            PurchPaySetup.Get();
            "No." := NoSeriesMgt.GetNextNo(PurchPaySetup."MRV No.Series", WorkDate(), true);
            "MRV Posting Date" := WorkDate();
        end;
    end;

    var
        Text0001: Label 'Total Quantity not More than Quantity';
        Text0002: Label 'Total Quantity to sent rework not More than Rweork Quantity';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PurchPaySetup: Record "Purchases & Payables Setup";
}
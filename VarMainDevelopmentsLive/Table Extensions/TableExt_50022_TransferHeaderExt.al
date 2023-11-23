tableextension 50022 TransferHeaderExt extends "Transfer Header"
{
    fields
    {
        field(50000; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Released;
            OptionCaption = 'Open,Pending Approval,Released';
        }
        field(50001; "Production Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Production Order No.';
            Editable = false;
        }
        field(50002; "Sale Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sale Order No.';
            Editable = false;
        }
        field(50003; "Production Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Production Order Line No.';
            Editable = false;
        }
        field(50004; "Created From MRS"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Indents Craeted"; Boolean)
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
        field(50007; "Subcon Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Subocn Production Order No.';
            TableRelation = "Production Order"."No." where(Status = filter(Released));
        }
        field(50008; "Excess Material Returns"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Excess Material Returns';
            Editable = false;
        }
        field(50009; "Finished Good Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Finished Good Transfer';
            Editable = false;
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
            begin
                "Shortcut Dimension 2 Code_B2B" := "Shortcut Dimension 2 Code";
            end;
        }
        
    }
    procedure AssistEditMrs(OldTransHeader: Record "Transfer Header"): Boolean
    begin
        with TransHeader do begin
            TransHeader := Rec;
            GetInventorySetupMrs();
            TestNoSeries();
            if NoSeriesMgt.SelectSeries(GetNoSeriesCodeMrs(), OldTransHeader."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := TransHeader;
                //if NoSeries.Get(Rec."No. Series") then
                //   Rec.Validate("Shortcut Dimension 1 Code", NoSeries."Shortcut Dimension 1 Code_B2B");
                exit(true);
            end;
        end;
    end;

    local procedure GetInventorySetupMrs()
    begin
        if not HasInventorySetupMrs then begin
            InvtSetup.Get();
            HasInventorySetupMrs := true;
        end;
    end;

    local procedure TestNoSeries()
    var
    //IsHandled: Boolean;
    begin
        GetInventorySetupMrs();
        //IsHandled := false;
        // OnBeforeTestNoSeries(Rec, InvtSetup, IsHandled);
        //if IsHandled then
        //   exit;

        InvtSetup.TestField("MRS Nos.");
    end;

    local procedure GetNoSeriesCodeMrs(): Code[20]
    var
        NoSeriesCode: Code[20];
    // IsHandled: Boolean;
    begin
        GetInventorySetupMrs();
        //IsHandled := false;

        NoSeriesCode := InvtSetup."MRS Nos.";
        //OnAfterGetNoSeriesCode(Rec, NoSeriesCode);
        exit(NoSeriesCode);
    end;

    var
        myInt: Integer;
        TransHeader: Record "Transfer Header";
        InvtSetup: Record "Inventory Setup";
        HasInventorySetupMrs: Boolean;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Record "No. Series";
}
tableextension 50002 ItemExt extends Item
{
    fields
    {
        field(50000; "Approval Status_B2B"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approval Status';
            OptionMembers = Open,"Pending for Approval",Released;
            OptionCaption = 'Open,Pending for Approval,Released';
            Editable = false;
        }
        field(50001; "Vendor Test Certificate_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Test Certificate Required';
        }
        field(50002; "Warranty Certificate_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Warranty Certificate Required';
        }
        field(50003; "PlanningParametersRequired_B2B"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Planning Parameters Required';
        }
        field(50004; "Parameter 1"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Parameter 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Parameter 3"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Parameter 4"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Parameter 5"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Item Family"; Text[1024])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Shortcut Dimension 2 Code_B2B"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            //   TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
            //    Blocked = CONST(false), "Division Code" = field("Global Dimension 1 Code"));
            trigger OnValidate()
            begin

                Validate("Global Dimension 2 Code", "Shortcut Dimension 2 Code_B2B");
            end;
        }
        modify("Global Dimension 2 Code")
        {
            trigger OnAfterValidate()
            begin
                "Shortcut Dimension 2 Code_B2B" := "Global Dimension 2 Code";
            end;
        }
        field(50011; "Ref. Inspection Procedure No."; Code[100])
        {
            DataClassification = CustomerContent;
        }

        /*field(50011; "Shortcut Dimension 1 Code_B2B"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
            trigger OnValidate()
            begin
                GeneralLedgerSetup.Get();
                DefaultDimnsions1.Reset();
                DefaultDimnsions1.SetRange("Table ID", 27);
                DefaultDimnsions1.SetRange("No.", Rec."No.");
                DefaultDimnsions1.SetRange("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
                if not DefaultDimnsions1.FindFirst() then begin
                    DefaultDimnsions.Init();
                    DefaultDimnsions.Validate("Table ID", 27);
                    DefaultDimnsions.Validate("No.", Rec."No.");
                    DefaultDimnsions.Validate("Dimension Code", GeneralLedgerSetup."Shortcut Dimension 1 Code");
                    DefaultDimnsions.Validate("Dimension Value Code", Rec."Shortcut Dimension 1 Code_B2B");
                    DefaultDimnsions.Insert(true);
                end else begin
                    DefaultDimnsions1.Validate("Dimension Value Code", Rec."Shortcut Dimension 1 Code_B2B");
                    DefaultDimnsions1.Modify(true);
                end;
                
            end;

        }*/

    }

    var
        DefaultDimnsions: Record "Default Dimension";
        DefaultDimnsions1: Record "Default Dimension";
        GeneralLedgerSetup: Record "General Ledger Setup";
        Pa: Page 99000883;
}
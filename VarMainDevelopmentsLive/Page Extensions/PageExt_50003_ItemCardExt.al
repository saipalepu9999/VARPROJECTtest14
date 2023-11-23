pageextension 50003 ItemCardExt extends "Item Card"
{

    layout
    {
        addlast(Item)
        {
            field("Approval Status_B2B"; Rec."Approval Status_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Approval Status field.';
            }
            field("Vendor Test Certificate_B2B"; Rec."Vendor Test Certificate_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Vendor Test Certificate Required field.';
            }
            field("Warranty Certificate_B2B"; Rec."Warranty Certificate_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Warranty Certificate Required field.';
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
            }
            /*field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = all;
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false), "Division Code" = field("Global Dimension 1 Code"));
            }*/
            /* field("Shortcut Dimension 2 Code_B2B";"Shortcut Dimension 2 Code_B2B")
             {
                 ApplicationArea = all;
             }*/
            field("Ref. Inspection Procedure No."; "Ref. Inspection Procedure No.")
            {
                ApplicationArea = all;
            }

        }
        addfirst(Planning)
        {
            field(PlanningParametersRequired_B2B; Rec.PlanningParametersRequired_B2B)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Planning Parameters Required field.';
            }

        }
        addbefore("Service Item Group")
        {
            field("Item Family"; Rec."Item Family")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the value of the Item Family field.';
            }
        }
        addafter(Blocked)
        {
            field("Inventory Value Zero"; "Inventory Value Zero")
            {
                ApplicationArea = all;
            }
        }

        modify(GTIN)
        {
            Visible = false;
        }
        modify("Service Item Group")
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        /* modify("Replenishment System")
         {
             ApplicationArea = all;
         }*/
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify("Lots Accept B2B")
        {
            Visible = false;
        }
        modify("Scrap %")
        {
            Visible = false;
        }
        modify("Lot Size")
        {
            Visible = false;
        }
        modify("Assembly Policy")
        {
            Visible = false;
        }
        modify(AssemblyBOM)
        {
            Visible = false;
        }
        /*
        modify(Planning)
        {
            Visible = false;
        }*/
        modify(Warehouse)
        {
            Visible = false;
        }

    }


    actions
    {
        addafter(CancelApprovalRequest)
        {
            action("Re&lease")
            {
                ApplicationArea = all;
                Caption = 'Re&lease';
                ShortCutKey = 'Ctrl+F11';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Executes the Re&lease action.';
                trigger OnAction()
                var
                    WorkflowManagement: Codeunit "Workflow Management";
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    //IF WorkflowManagement.CanExecuteWorkflow(Rec, Approvalmgmt.run) then
                    if ApprovalsMgmt.CheckItemApprovalsWorkflowEnabled(Rec) then
                        error('Workflow is enabled. You can not release manually.');

                    IF Rec."Approval Status_B2B" <> Rec."Approval Status_B2B"::Released then BEGIN
                        Rec."Approval Status_B2B" := Rec."Approval Status_B2B"::Released;

                        Rec.Modify();
                        Message('Document has been Released.');
                    end;
                end;
            }


            action("Re&open")
            {
                ApplicationArea = all;
                Caption = 'Re&open';
                Image = ReOpen;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Executes the Re&open action.';
                trigger OnAction();
                var
                    RecordRest: Record "Restricted Record";
                begin
                    RecordRest.Reset();
                    RecordRest.SetRange(ID, 23);
                    RecordRest.SetRange("Record ID", Rec.RecordId());
                    IF RecordRest.FindFirst() THEN
                        error('This record is under in workflow process. Please cancel approval request if not required.');
                    IF Rec."Approval Status_B2B" <> Rec."Approval Status_B2B"::Open then BEGIN
                        Rec."Approval Status_B2B" := Rec."Approval Status_B2B"::Open;
                        Rec.Modify();
                        Message('Document has been Reopened.');
                    end;
                end;
            }
        }
        addafter("BOM Level")
        {
            action("Dimension Wise Inventory")
            {
                ApplicationArea = Location;
                Caption = 'Dimensions';
                Image = Warehouse;
                // RunObject = Page "Inventory Dimension wise";
                /*RunPageLink = "No." = FIELD("No."),
                              "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
                              "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter"),
                              "Location Filter" = FIELD("Location Filter"),
                              "Drop Shipment Filter" = FIELD("Drop Shipment Filter"),
                              "Variant Filter" = FIELD("Variant Filter");*/
                ToolTip = 'View the actual and projected quantity of the item per Dimension.';
                trigger OnAction()
                var
                    InventoryDimWise: Page "Inventory Dimension wise";
                begin
                    Clear(InventoryDimWise);
                    InventoryDimWise.GetValues(Rec."No.");
                    InventoryDimWise.RunModal();
                end;
            }

        }
        modify(Attributes)
        {
            Visible = false;
        }
    }
    trigger OnModifyRecord(): Boolean
    var
        userSetup: Record "User Setup";
    begin
        if (userSetup.get(UserId)) and (not userSetup."Items Access") then
            Error('you do not have permissions to modify item');
        Rec.TestField("Approval Status_B2B", Rec."Approval Status_B2B"::Open);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        // Error('You do not have permissions to delete the record');
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        userSetup: Record "User Setup";
    begin
        if (userSetup.get(UserId)) and (not userSetup."Items Access") then
            Error('you do not have permissions to create item');
    end;

    var

}
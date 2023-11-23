page 50034 "Posted RGP IN List"
{
    Caption = 'Posted RDC In List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Posted Gate Pass Header";
    SourceTableView = SORTING("Document Type", "No.")
                      WHERE("Document Type" = CONST("RGP In"));
    ApplicationArea = all;
    UsageCategory = Lists;
    CardPageId = "Posted RGP In";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Type field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("RGP Date"; Rec."RGP Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RGP Date field.';
                }
                field("Consignee Type"; Rec."Consignee Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Type field.';
                }
                field("Consignee No."; Rec."Consignee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee No. field.';
                }
                field("Consignee Name"; Rec."Consignee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Name field.';
                }
                field("Consignee Name 2"; Rec."Consignee Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Name 2 field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Consignee City"; Rec."Consignee City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee City field.';
                }
                field("Consignee Contact"; Rec."Consignee Contact")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consignee Contact field.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("Telex No."; Rec."Telex No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Telex No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Equipment No"; Rec."Equipment No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Equipment No field.';
                }
                field(Results; Rec.Results)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Results field.';
                }
                field(Recommendations; Rec.Recommendations)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recommendations field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("External Document No.";
                Rec."External Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the External Document No. field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field("GP No"; Rec."GP No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the GP No field.';
                }
                field("RGP Out No."; Rec."RGP Out No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RGP Out No. field.';
                }
                field("RGP Out Date"; Rec."RGP Out Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RGP Out Date field.';
                }
                field("RGP Out Posting Date"; Rec."RGP Out Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RGP Out Posting Date field.';
                }
                field("Excise Challan No."; Rec."Excise Challan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference No.(If any) field.';
                }
                field("Responsible Person Code"; Rec."Responsible Person Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Person Code field.';
                }
                field("Responsible Person"; Rec."Responsible Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Responsible Person field.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Posted RGP In")
            {
                Image = Card;
                RunObject = Page "Posted RGP IN List";
                ApplicationArea = All;
                RunPageLink = "No." = FIELD("No.");
                ToolTip = 'Executes the Posted RGP In action.';
            }
        }
    }
}


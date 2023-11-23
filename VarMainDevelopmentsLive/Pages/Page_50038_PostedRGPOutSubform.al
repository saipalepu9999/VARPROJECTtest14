page 50038 "Posted RGP Out Subform"
{
    Caption = 'Posted RDC Out Subform';
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Posted Gate Pass Line";
    SourceTableView = SORTING("Document Type", "Document No.", Type, "No.", status)
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST("RGP Out"));

    layout
    {
        area(content)
        {
            repeater(" ")
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Received field.';
                    Visible = false;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purpose of field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInit()
    begin
        Rec.CALCFIELDS("Quantity Received");
    end;
}


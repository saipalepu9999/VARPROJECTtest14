page 50035 "Posted RGP In Subform"
{
    Caption = 'Posted RDC In Subform';
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Posted Gate Pass Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      ORDER(Ascending)
                      WHERE("Document Type" = CONST("RGP In"));

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
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity Received field.';
                }
                field("Recieved Qty"; Rec."Recieved Qty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Recieved Qty field.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purpose of field.';
                }
                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Value field.';
                }
                field("Received Amount"; Rec."Received Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Received Amount field.';
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Outstanding Amount field.';
                }
                field("Unit Rate"; Rec."Unit Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Rate field.';
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


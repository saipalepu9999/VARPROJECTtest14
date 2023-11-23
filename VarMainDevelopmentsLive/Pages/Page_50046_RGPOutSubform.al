page 50046 "RGPOut Subform"
{
    Caption = 'RDC Out Subform';
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Gate Pass Line";

    layout
    {
        area(content)
        {
            repeater(" ")
            {
                field(Type; Rec.Type)
                {
                    Editable = RGPEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("No."; Rec."No.")
                {
                    Editable = RGPEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    Editable = RGPEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = RGPEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit of Measure field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = RGPEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity Received field.';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remaining Quantity field.';
                }
                field("Expected date of receipt"; Rec."Expected date of receipt")
                {
                    Editable = RGPEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expected date of receipt field.';

                    trigger OnValidate()
                    begin
                        IF GatePassHeaderGRec.GET(Rec."Document Type"::"RGP Out", Rec."Document No.") THEN BEGIN
                            IF Rec."Expected date of receipt" < GatePassHeaderGRec."Created Date" THEN
                                ERROR(Text010);
                        END;
                    end;
                }
                field(Remarks; Rec.Remarks)
                {
                    Editable = RGPEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purpose of field.';
                }
                field("Quantity to Receive"; Rec."Quantity to Receive")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity to Receive field.';
                }
                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Value field.';
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Outstanding Amount field.';
                }
                field("Unit Rate"; Rec."Unit Rate")
                {
                    //Editable = RGPEditable;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Rate field.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Location Code field.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        RGPEdit;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //B2B1.0 >>
        IF GatePassHeaderGRec.GET(Rec."Document Type"::"RGP Out", Rec."Document No.") THEN
            GatePassHeaderGRec.TESTFIELD("Approval Status", GatePassHeaderGRec."Approval Status"::Open);
        //B2B1.0 <<
    end;

    trigger OnInit()
    begin
        Rec.CALCFIELDS("Quantity Received");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        RGPEdit;
    end;

    var
        RGPEditable: Boolean;
        GatePassHeader: Record "Gate Pass Header";
        GatePassHeaderGRec: Record "Gate Pass Header";
        Text010: Label 'Expected date should not be less than Created date';


    procedure RGPEdit(): Boolean
    begin
        IF GatePassHeader.GET(GatePassHeader."Document Type"::"RGP Out", Rec."Document No.") THEN BEGIN
            IF GatePassHeader."Approval Status" = GatePassHeader."Approval Status"::Open THEN
                RGPEditable := TRUE
            ELSE
                RGPEditable := FALSE;
        END;
        EXIT(RGPEditable);
    end;
}


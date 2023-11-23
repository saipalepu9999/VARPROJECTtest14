pageextension 50052 SalesCreditmemoExt extends "Sales Credit Memo"
{
    layout
    {
        //B2BPR04Jul2023<<<
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                if CopyStr("Location Code", 1, 1) <> CopyStr("No. Series", 1, 1) then
                    Error('Please Select The Correct Location Code');
            end;
        } //B2BPR04Jul2023<<<
        addafter("Tax Info")
        {
            group("Sales Information")
            {
                field("Tender/Project"; Rec."Tender/Project")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tender/Project Conformation By Customer field.';
                }
                field("Liquidated Damages"; Rec."Liquidated Damages")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Liquidated Damages field.';
                }
                field("Green Card Applicable"; Rec."Green Card Applicable")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Applicable field.';
                    trigger OnValidate()
                    begin
                        if Rec."Green Card Applicable" = Rec."Green Card Applicable"::Yes then
                            EditableGvar := true
                        else
                            EditableGvar := false;
                    end;
                }
                field("Green Card Type"; Rec."Green Card Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Type field.';
                    Editable = EditableGvar;
                }
                field("Green Card Received"; Rec."Green Card Received")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Received field.';
                    trigger OnValidate()
                    begin
                        if Rec."Green Card Received" = Rec."Green Card Received"::Yes then
                            EditableGvar1 := true
                        else
                            EditableGvar := false;
                    end;
                }

                field("Green Card Receipt Date"; Rec."Green Card Receipt Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Card Receipt Date field.';
                    Editable = EditableGvar1;
                }
            }
        }
    }
    var
        EditableGvar: Boolean;
        EditableGvar1: Boolean;
}

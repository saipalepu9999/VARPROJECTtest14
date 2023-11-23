pageextension 50065 InspectionReceiptExt extends "Inspection Receipt B2B"
{
    layout
    {
        addafter("Item Description")
        {

            field("Vendor Test Certificate_B2B"; Rec."Vendor Test Certificate_B2B")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor Test Certificate Required field.';
            }
            field("Warranty Certificate_B2B"; Rec."Warranty Certificate_B2B")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Warranty Certificate Required field.';
            }
        }
        addlast(Receipt)
        {

            field("Pc No."; Rec."Pc No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pc No. field.';
            }
            field("Pc Date"; Rec."Pc Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Pc Date field.';
            }
            field("Dc No."; Rec."Dc No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dc No. field.';
            }
            field("Dc Date"; Rec."Dc Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Dc Date field.';
            }
            field("Bill of Entry No."; Rec."Bill of Entry No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bill of Entry No. field.';
            }
            field("Bill of Entry Date"; Rec."Bill of Entry Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bill of Entry Date field.';
            }
            field("No. Of Samples Taken"; "No. Of Samples Taken")
            {
                ApplicationArea = all;
            }
        }
        modify("QC Certificate(s) Status")
        {
            Editable = BoolGvar;
        }

    }


    actions
    {
        modify("P&ost")
        {
            trigger OnBeforeAction()
            begin
                if "Vendor Test Certificate_B2B" or "Warranty Certificate_B2B" then
                    TestField("QC Certificate(s) Status", "QC Certificate(s) Status"::Available);
            end;
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if (not "Vendor Test Certificate_B2B") and (not "Warranty Certificate_B2B") then begin
            "QC Certificate(s) Status" := "QC Certificate(s) Status"::"Not Required";
            //Modify();
        end else begin
            "QC Certificate(s) Status" := "QC Certificate(s) Status"::" ";
            // Modify();
        end;
        if "QC Certificate(s) Status" = "QC Certificate(s) Status"::"Not Required" then
            BoolGvar := false
        else
            BoolGvar := true;
    end;

    var
        BoolGvar: Boolean;
}
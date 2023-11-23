page 50051 "NRGP Sub Form"
{
    AutoSplitKey = true;
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "NRGP Line";
    Caption = 'NRDC Subform';
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
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Remarks field.';
                }
            }
        }
    }

    actions
    {


        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                action("Item &Tracking Lines")
                {
                    ToolTip = 'Not Specified';
                    Caption = 'Item &Tracking Lines';
                    ApplicationArea = all;
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';

                    trigger OnAction();
                    begin
                        Rec.OpenItemTrackingLines(false);
                    end;
                }

            }
        }

    }


    procedure ShowDimensionsNew()
    begin
        Rec.ShowDimensions;
    end;
}


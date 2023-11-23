page 50070 "Shortage Page"
{
    Caption = 'Shortage Page';
    PageType = Worksheet;
    SourceTable = "Shortage Table";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(TransferOrderNo; TransferOrderNo)
                {
                    ApplicationArea = all;
                    Caption = 'Tranfer Order No.';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Tranfer Order No. field.';
                    trigger OnValidate()
                    begin
                        SetPageFilter();
                    end;
                }
            }
            repeater(Control1)
            {

                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Carry Out"; Rec."Carry Out")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Carry Out field.';
                }
            }
        }

    }
    trigger OnOpenPage()
    begin
        SetPageFilter();
    end;

    trigger OnAfterGetRecord()
    begin
        SetPageFilter();
    end;

    var
        TransferOrderNo: Code[20];

    procedure GetValues(TranferOrderNoPar: Code[20])
    begin
        TransferOrderNo := TranferOrderNoPar;
    end;

    procedure SetPageFilter()
    begin
        Rec.SetRange("Transfer Order No.", TransferOrderNo);
        CurrPage.Update(false);
    end;
}

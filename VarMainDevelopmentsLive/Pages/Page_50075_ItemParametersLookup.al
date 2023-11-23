page 50075 "Item Parameters Lookup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Parameters";
    SourceTableView = sorting("Coding Index");

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Parameter Type"; Rec."Parameter Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Parameter Type field.';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Coding Index"; Rec."Coding Index")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Coding Index field.';
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {

        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange("Parameter Type", 1);
    end;
}
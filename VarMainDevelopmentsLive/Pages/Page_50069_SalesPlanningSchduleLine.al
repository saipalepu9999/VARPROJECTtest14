page 50069 "Sales Planning Schedule Line"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Sales Planning Schedule";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Order No. field.';

                }
                field("Sales Order Line No."; Rec."Sales Order Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sales Order Line No. field.';

                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item No. field.';

                }
                field("Planning Status"; Rec."Planning Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Planning Status field.';

                }
                field("Production Bom No."; Rec."Production Bom No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Of measurement field.';

                }
                field("Production Bom Vesion No."; Rec."Production Bom Vesion No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Unit Of measurement field.';

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                ToolTip = 'Executes the ActionName action.';

                trigger OnAction();
                begin

                end;
            }
        }
    }
}
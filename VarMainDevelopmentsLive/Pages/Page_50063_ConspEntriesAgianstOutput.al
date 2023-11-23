page 50063 "Consp Entries Agianst Output"
{
    ApplicationArea = All;
    Caption = 'Consumption Entries Agianst Output';
    Editable = false;
    PageType = List;
    SourceTable = "Consum Entry Against Output";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Consumption Entry No."; Rec."Consumption Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consumption Entry No. field.';
                }
                field("Consumption Item No."; Rec."Consumption Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consumption Item No. field.';
                }
                field("Consumption Lot No."; Rec."Consumption Lot No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consumption Lot No. field.';
                }
                field("Consumption Posting Date"; Rec."Consumption Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consumption Posting Date field.';
                }
                field("Consumption Quantity"; Rec."Consumption Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consumption Quantity field.';
                }
                field("Consumption Serial No."; Rec."Consumption Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Consumption Serial No. field.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Output Entry No."; Rec."Output Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Output Entry No. field.';
                }
                field("Output Item No."; Rec."Output Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Output Item No. field.';
                }
                field("Output Lot No."; Rec."Output Lot No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Output Lot No. field.';
                }
                field("Output Posting Date"; Rec."Output Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Output Posting Date field.';
                }
                field("Output Quantity"; Rec."Output Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Output Quantity field.';
                }
                field("Output Serial No."; Rec."Output Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Output Serial No. field.';
                }
            }
        }
    }
}

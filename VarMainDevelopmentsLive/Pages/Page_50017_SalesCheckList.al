page 50017 "Sales Check List"
{
    //ApplicationArea = All;
    Caption = 'QAP Check List';
    PageType = List;
    SourceTable = SalesCheckList;
    UsageCategory = Lists;
    ApplicationArea = All;
    DelayedInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;
    LinksAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment field.';
                }
                field(Check; Rec.Check)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the check field';
                }
            }
        }
    }
}

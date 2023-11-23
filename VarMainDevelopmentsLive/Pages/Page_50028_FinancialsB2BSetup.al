page 50028 "Financials B2B Setup"
{
    ApplicationArea = All;
    Caption = 'Financials B2B Setup';
    PageType = List;
    SourceTable = "Financials B2B Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Total Code"; Rec."Total Code")
                {
                    ToolTip = 'Specifies the value of the Total Code field.';
                }
                field("Gross Block As At Account"; Rec."Gross Block As At Account")
                {
                    ToolTip = 'Specifies the value of the Gross Block As At Account field.';
                }
                field("Gross Block Additions"; Rec."Gross Block Additions")
                {
                    ToolTip = 'Specifies the value of the Gross Block Additions field.';
                }
                field("Gross Block Deletions"; Rec."Gross Block Deletions")
                {
                    ToolTip = 'Specifies the value of the Gross Block Deletions field.';
                }
                field("Acc Dep. As At Account"; Rec."Acc Dep. As At Account")
                {
                    ToolTip = 'Specifies the value of the Acc Dep. As At Account field.';
                }
                field("Acc Dep. Additions"; Rec."Acc Dep. Additions")
                {
                    ToolTip = 'Specifies the value of the Acc Dep. Additions field.';
                }
                field("Acc Dep. Deletions"; Rec."Acc Dep. Deletions")
                {
                    ToolTip = 'Specifies the value of the Acc Dep. Deletions field.';
                }
            }
        }
    }
}

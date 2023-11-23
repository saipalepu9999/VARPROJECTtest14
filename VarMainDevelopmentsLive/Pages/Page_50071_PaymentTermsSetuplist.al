page 50019 PaymentTermsSetuplist
{
    ApplicationArea = All;
    Caption = 'Purchase terms & conditions setup';
    PageType = List;
    SourceTable = "Purchase terms setup";
    UsageCategory = Lists;

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Shortcut Dimension 1 Code_B2B"; Rec."Shortcut Dimension 1 Code_B2B")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }

            }
        }
    }
}

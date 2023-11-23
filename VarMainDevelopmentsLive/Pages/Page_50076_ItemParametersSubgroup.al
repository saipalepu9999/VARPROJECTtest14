page 50076 "Item Parameters Subgroup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Parameters";


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
                field("Parent Code"; Rec."Parent Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Parent Code field.';
                }
                field("Parent Code New"; Rec."Parent Code New")
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Parent Code New field.';
                }
                field("Lot Nos."; Rec."Lot Nos.")
                {
                    ToolTip = 'Specifies the value of the Lot Nos. field.';
                    Caption = 'Item Tracking Codes';
                    ApplicationArea = all;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Sub-Grouping")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = SubGroupVisible;
                ToolTip = 'Executes the Sub-Grouping action.';

                trigger OnAction()
                var
                    ItemParameters: Record "Item Parameters";
                begin
                    ItemParameters.Reset();
                    ItemParameters.SetRange("Parent Code", Rec.Code);
                    ItemParameters.SetRange("Parent Type", Rec."Parameter Type");
                    ItemParameters.SetRange("Parameter Type", Rec."Parameter Type" + 1);
                    if "Parent Code" <> '' then
                        ItemParameters.SetRange("Parent Code New", Rec."Parent Code");
                    if ItemParameters.FindSet() then;
                    Page.RunModal(Page::"Item Parameters Subgroup", ItemParameters);

                end;
            }
        }
    }

    var
        SubGroupVisible: Boolean;

    trigger OnAfterGetRecord()
    begin
        if Rec."Parameter Type" > 1 then
            SubGroupVisible := true
        else
            SubGroupVisible := false;
    end;
}
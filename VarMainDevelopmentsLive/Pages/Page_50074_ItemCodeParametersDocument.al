page 50074 "Item Parameters"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Item Parameters";

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(ItemParameter; ItemParameter)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the ItemParameter field.';

                    trigger OnDrillDown()
                    var
                        ItemParam: Record "Item Parameters";
                    begin
                        ItemParam.Reset();
                        ItemParam.SetRange("Parameter Type", 1);
                        if ItemParam.FindSet() then
                            if Page.RunModal(page::"Item Parameters Lookup", ItemParam) = Action::LookupOK then begin
                                ItemParameter := ItemParam.Code;
                                ItemParameterType := ItemParam."Coding Index";
                            end;
                        Rec.SetRange("Parameter Type", ItemParameterType);
                        CurrPage.UPDATE(FALSE);
                    end;
                }
            }

            repeater(GroupName)
            {
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
                field("Parent Type"; Rec."Parent Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Parent Type field.';
                }
                field("Parent Code"; Rec."Parent Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Parent Code field.';
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
                    ItemParameters.SetRange("Parent Code New",Rec."Parent Code");
                    if ItemParameters.FindSet() then;
                    Page.RunModal(Page::"Item Parameters Subgroup", ItemParameters);

                end;
            }
        }
    }

    var
        ItemParameter: Code[20];
        ItemParameterType: Integer;
        SubGroupVisible: Boolean;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Parameter Type" := ItemParameterType;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetRange("Parameter Type", 0);
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."Parameter Type" > 1 then
            SubGroupVisible := true
        else
            SubGroupVisible := false;
    end;
}
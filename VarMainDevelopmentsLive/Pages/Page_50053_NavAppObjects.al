page 50053 "Nav App Objects"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Application Object Metadata";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Runtime Package ID"; "Runtime Package ID")
                {
                    ApplicationArea = all;
                }
                field("Object Type"; "Object Type")
                {
                    ApplicationArea = all;
                }
                field("Object ID"; "Object ID")
                {
                    ApplicationArea = All;

                }
                field("Object Subtype"; "Object Subtype")
                {
                    ApplicationArea = all;
                }
                field("Object Name"; "Object Name")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}
page 50014 ApplicationObjects
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Application Object Metadata";
    Caption = 'Application Objects List';

    layout
    {
        area(Content)
        {
            repeater(Contol1)
            {

                field("Object Type"; Rec."Object Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Type field.';
                }
                field("Object ID"; Rec."Object ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object ID field.';
                }
                field("Object Name"; Rec."Object Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Name field.';
                }
                field("Object Subtype"; Rec."Object Subtype")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Subtype field.';
                }
                field(Metadata; Rec.Metadata)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Metadata field.';
                }
                field("Metadata Format"; Rec."Metadata Format")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Metadata Format field.';
                }
                field("Metadata Hash"; Rec."Metadata Hash")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Metadata Hash field.';
                }
                field("Metadata Version"; Rec."Metadata Version")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Metadata Version field.';
                }
                field("Object Flags"; Rec."Object Flags")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Flags field.';
                }
                field("Package ID"; Rec."Package ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Package ID field.';
                }
                field("Runtime Package ID"; Rec."Runtime Package ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Runtime Package ID field.';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.';
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemId field.';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.';
                }
                field("User AL Code"; Rec."User AL Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User AL Code field.';
                }
                field("User Code"; Rec."User Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Code field.';
                }
                field("User Code Hash"; Rec."User Code Hash")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Code Hash field.';
                }
            }
        }
    }


}
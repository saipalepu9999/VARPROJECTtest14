page 50091 "NCPR List"
{
    ApplicationArea = All;
    Caption = 'NCPR List';
    PageType = List;
    Editable = false;
    SourceTable = NCPR;
    SourceTableView = where(Posted = const(false));
    UsageCategory = Lists;
    CardPageId = "NCPR Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("IR No."; Rec."IR No.")
                {
                    ToolTip = 'Specifies the value of the IR No. field.';
                }
                field("IR Date"; Rec."IR Date")
                {
                    ToolTip = 'Specifies the value of the IR Date field.';
                }
                field("MRV No."; Rec."MRV No.")
                {
                    ToolTip = 'Specifies the value of the MRV No. field.';
                }
                field("MRV Date"; Rec."MRV Date")
                {
                    ToolTip = 'Specifies the value of the MRV Date field.';
                }
                field("Party Name"; Rec."Party Name")
                {
                    ToolTip = 'Specifies the value of the Party Name field.';
                }
                field("Product Description"; Rec."Product Description")
                {
                    ToolTip = 'Specifies the value of the Product Description field.';
                }
                field("Authorized/Approved By"; Rec."Authorized/Approved By")
                {
                    ToolTip = 'Specifies the value of the Authorized/Approved By field.';
                }
                field("Corrctive Initiated By"; Rec."Corrctive Initiated By")
                {
                    ToolTip = 'Specifies the value of the Corrctive Initiated By field.';
                }
                field("Corrective Action Implemenetd"; Rec."Corrective Action Implemenetd")
                {
                    ToolTip = 'Specifies the value of the Corrective Action Implemenetd field.';
                }
                field("Corrective Action Planned"; Rec."Corrective Action Planned")
                {
                    ToolTip = 'Specifies the value of the Corrective Action Planned field.';
                }
                field("Corrective Initiated Date"; Rec."Corrective Initiated Date")
                {
                    ToolTip = 'Specifies the value of the Corrective Initiated Date field.';
                }
                field("Description Initiated By"; Rec."Description Initiated By")
                {
                    ToolTip = 'Specifies the value of the Description Initiated By field.';
                }
                field("Description Initiated Date"; Rec."Description Initiated Date")
                {
                    ToolTip = 'Specifies the value of the Description Initiated Date field.';
                }
                field("Description Of Product"; Rec."Description Of Product")
                {
                    ToolTip = 'Specifies the value of the Description Of Product field.';
                }
                field("Follow Up Audit"; Rec."Follow Up Audit")
                {
                    ToolTip = 'Specifies the value of the Follow Up Audit field.';
                }
                field("Ncpr Closed/Not Closed"; Rec."Ncpr Closed/Not Closed")
                {
                    ToolTip = 'Specifies the value of the Ncpr Closed/Not Closed field.';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.';
                }
                field(Reference; Rec.Reference)
                {
                    ToolTip = 'Specifies the value of the Reference field.';
                }
                field(Regrade; Rec.Regrade)
                {
                    ToolTip = 'Specifies the value of the Regrade field.';
                }
                field("Reject&Return To Vendor"; Rec."Reject&Return To Vendor")
                {
                    ToolTip = 'Specifies the value of the Reject&Return To Vendor field.';
                }
                field("Reject&Scrap"; Rec."Reject&Scrap")
                {
                    ToolTip = 'Specifies the value of the Reject&Scrap field.';
                }
                field(Rework; Rec.Rework)
                {
                    ToolTip = 'Specifies the value of the Rework field.';
                }
                field("Root Cause"; Rec."Root Cause")
                {
                    ToolTip = 'Specifies the value of the Root Cause field.';
                }
                field("To Be Implemented Date"; Rec."To Be Implemented Date")
                {
                    ToolTip = 'Specifies the value of the To Be Implemented Date field.';
                }
                field("To Be Implemeted By"; Rec."To Be Implemeted By")
                {
                    ToolTip = 'Specifies the value of the To Be Implemeted By field.';
                }
            }
        }
    }
}

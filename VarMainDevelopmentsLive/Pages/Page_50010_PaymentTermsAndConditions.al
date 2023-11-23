page 50010 "Payment Terms and Condition"
{

    //ApplicationArea = All;
    UsageCategory = Administration;
    PageType = ListPart;
    SourceTable = "Payment Terms And Conditions";
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    SourceTableView = WHERE(DocumentType = FILTER(Order));
    Caption = 'Terms & Condition';
    ApplicationArea = All;


    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

    var
        salesOrder: page "Sales Order";
        tab: Report "Trial Balance";
    //re : Record Jour
}
page 50079 "Closed Indent List"
{
    // version PH1.0,PO1.0

    //CardPageID = "Indent Header";
    Editable = false;
    PageType = List;
    SourceTable = "Indent Header";
    SourceTableView = where("Indent Status" = const(Close));
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("Control")
            {
                field("Document Date"; rec."Document Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Due Date"; rec."Due Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Due Date field.';
                }
                field(Indentor; rec.Indentor)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Indentor field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Open Document")
            {
                ApplicationArea = All;
                RunObject = page "Indent Header";
                RunPageLink = "No." = field("No.");
                ToolTip = 'Executes the Open Document action.';
                trigger OnAction()
                begin

                end;
            }
        }
    }


}


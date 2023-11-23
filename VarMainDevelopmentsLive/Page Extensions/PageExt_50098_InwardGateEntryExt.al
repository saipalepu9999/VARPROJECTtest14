pageextension 50098 InwardGateEntryExt extends "Inward Gate Entry"
{
    layout
    {
        addlast(General)
        {

            field("RDC List"; Rec."RDC List")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RDC List field.';
                Caption = 'RDC in List';
            }
            field(Company; Rec.Company)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Company field.';
            }
        }
    }

    actions
    {
        addafter("Po&st")
        {
            action("Posted RDC List")
            {
                ApplicationArea = All;
                Image = List;
                RunObject = page "Posted RGP In List";
                RunPageLink = "No." = field("RDC List"), "Document Type" = const("RGP In");
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    rec.TestField("Location Code");
                end;
            }
        }
    }

    var
        myInt: Integer;
}
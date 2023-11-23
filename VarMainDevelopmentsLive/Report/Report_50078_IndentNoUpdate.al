report 50078 MyReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Indent No Update';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            trigger OnAfterGetRecord()
            begin
                PurchaseHeader.Reset();
                PurchaseHeader.SetFilter("Indent No.", '<>%1', '');
                if PurchaseHeader.FindSet() then
                    repeat
                        PurchaseLine.Reset();
                        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                        PurchaseLine.SetFilter(Type, '<>%1', PurchaseLine.Type::" ");
                        if PurchaseLine.FindSet() then begin
                            PurchaseLine.ModifyAll("Indent No New", PurchaseHeader."Indent No.");
                        end;
                    until PurchaseHeader.Next() = 0;
            end;

            trigger OnPostDataItem()
            begin
                Message('Indent No Has Been Updated');
            end;
        }
    }

    /*requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; SourceExpression)
                    {
                        ApplicationArea = All;
                        
                    }
                }
            }
        }
    
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }*/
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
}
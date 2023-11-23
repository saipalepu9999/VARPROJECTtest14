report 50032 "Update Production Order"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            trigger OnAfterGetRecord()
            begin
                "Production Order"."Sales Order No" := SalesOrderNo;
                "Production Order"."Sales Order Line No." := SalesOrderLineNo;
                Modify();
            end;

            trigger OnPostDataItem()
            begin
                Message('Done');
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(SalesOrderNo; SalesOrderNo)
                    {
                        ApplicationArea = all;
                        //TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            SalesHeader: Record "Sales Header";
                        begin
                            SalesHeader.Reset();
                            SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                            SalesHeader.SetRange("Shortcut Dimension 2 Code", ProjectCodeGvar);
                            if SalesHeader.FindSet() then begin
                                if Page.RunModal(Page::"Sales Order List", SalesHeader) = Action::LookupOK then
                                    SalesOrderNo := SalesHeader."No.";
                            end;
                        end;
                    }
                    field(SalesOrderLineNo; SalesOrderLineNo)
                    {
                        ApplicationArea = all;
                        // TableRelation = "Sales Line"."Line No." where("Document Type" = const(Order))
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            SalesLine: record "Sales Line";
                        begin
                            SalesLine.Reset();
                            SalesLine.SetRange("Document Type", SalesLine."Document Type"::Order);
                            SalesLine.SetRange("Document No.", SalesOrderNo);
                            if SalesLine.FindSet() then begin
                                if Page.RunModal(Page::"Sales Lines", SalesLine) = Action::LookupOK then
                                    SalesOrderLineNo := SalesLine."Line No.";
                            end;
                        end;
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
    }


    var
        SalesOrderNo: Code[20];
        SalesOrderLineNo: Integer;
        ProjectCodeGvar: Code[20];

    procedure GetValues(ProjectCodePar: Code[20])
    begin
        ProjectCodeGvar := ProjectCodePar;
    end;

}
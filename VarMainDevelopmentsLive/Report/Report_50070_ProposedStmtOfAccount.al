report 50070 "Processed Stmt Of Account"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //DefaultRenderingLayout = LayoutName;
    Caption = 'Processed Stmt Of Account';
    //DefaultLayout = RDLC;
    //RDLCLayout = 'Report\Layouts\ProcessedStmtOfAccount.rdl';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {

            column(PostingDateCap; PostingDateCap)
            { }
            column(DocumentNoCap; DocumentNoCap)
            { }
            column(DocumentDateCap; DocumentDateCap)
            { }
            column(DocumentTypeCap; DocumentTypeCap)
            { }
            column(SourceCodeCap; SourceCodeCap)
            { }
            column(DivisionCodeCap; DivisionCodeCap)
            { }
            column(ProjectCodeCap; ProjectCodeCap)
            { }
            column(ExternalDocNoCap; ExternalDocNoCap)
            { }
            column(DueDateCap; DueDateCap)
            { }
            column(InvoiceAmountCap; InvoiceAmountCap)
            { }
            column(PurchaseOrderNoCap; PurchaseOrderNoCap)
            { }
            column(InvoiceNoCap; InvoiceNoCap)
            { }
            column(InvoiceDateCap; InvoiceDateCap)
            { }
            column(DebitAmountCap; DebitAmountCap)
            { }
            column(CreditAmountCap; CreditAmountCap)
            { }
            column(CreditAmount1Cap; CreditAmount1Cap)
            { }
            column(DebitAmount1Cap; DebitAmount1Cap)
            { }
            column(IGSiCap; IGSiCap)
            { }
            column(IGSTAmountCap; IGSTAmountCap)
            { }
            column(CGSTiCap; CGSTiCap)
            { }
            column(CGSTAmountCap; CGSTAmountCap)
            { }
            column(SGSTiCap; SGSTiCap)
            { }
            column(SGSTAmountCap; SGSTAmountCap)
            { }
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

    /*rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }*/

    var
        myInt: Integer;
        PostingDateCap: Label 'Posting Date';
        DocumentNoCap: Label 'Document No.';
        DocumentDateCap: Label 'Document Date';
        DocumentTypeCap: Label 'Document Type';
        SourceCodeCap: Label 'Source Code';
        DivisionCodeCap: Label 'Division Code';
        ProjectCodeCap: Label 'Project Code';
        ExternalDocNoCap: Label 'External Doc. No.';
        DueDateCap: Label 'Due Date';
        InvoiceAmountCap: Label 'Invoice Amount';
        PurchaseOrderNoCap: label 'Purchase Order No';
        InvoiceNoCap: Label 'Invoice No';
        InvoiceDateCap: Label 'Invoice Date';
        DebitAmountCap: Label 'Debit Amount';
        CreditAmountCap: Label 'Credit Amount';
        DebitAmount1Cap: Label 'Debit Amount';
        CreditAmount1Cap: Label 'Credit Amount';
        IGSiCap: Label 'IGS%';
        IGSTAmountCap: Label 'IGST Amount';
        CGSTiCap: Label 'CGST %';
        CGSTAmountCap: Label 'CGST Amount';
        SGSTiCap: Label 'SGST %';
        SGSTAmountCap: Label 'SGST Amount';
        Text000: Label 'Pre Payment Invoice Details';



}
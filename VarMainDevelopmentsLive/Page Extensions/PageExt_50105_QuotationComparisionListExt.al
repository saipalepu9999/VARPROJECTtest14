pageextension 50105 QuotationComparisionDocExt extends "Quotation Comparision Doc"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("&Calculate Plan")
        {
            action("Print")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ComparativeStatement: Report MaterialRequestVoucher;
                    QuoteHdr: Record QuotCompHdr;
                begin
                    QuoteHdr.Reset();
                    QuoteHdr.SetRange("No.", Rec."No.");
                    ComparativeStatement.SetTableView(QuoteHdr);
                    ComparativeStatement.RunModal();
                end;
            }
        }
    }

    var
        myInt: Integer;
}
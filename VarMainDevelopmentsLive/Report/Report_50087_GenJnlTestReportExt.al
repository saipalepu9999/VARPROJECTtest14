reportextension 50087 GenJnlTestReportExt extends "General Journal - Test GST"
{

    // RDLCLayout = 'Report\Layouts\GenJnlTestNeww.rdl';
    dataset
    {
        add("Gen. Journal Line")
        {
            column(External_Document_No_; "External Document No.")
            { }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }


}
pageextension 50029 PurchaseOrderSubfmextension extends "Purchase Order Subform"
{
    layout
    {
        addlast(Control1)
        {

            field(Make; Rec.Make)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Make field.';
            }
            field(Model; Rec.Model)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Model field.';
            }
            field("PO Qty"; Rec."PO Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PO Qty field.';
            }
            field("Available Inventory"; Rec."Available Inventory")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Available Inventory field.';
            }
            field("Shortage Qty"; Rec."Shortage Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortage Qty field.';
            }
            field("Open Indent Qty"; Rec."Open Indent Qty")
            {
                ApplicationArea = all;
            }
            field("Vendor Test Certificate_B2B"; Rec."Vendor Test Certificate_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Vendor Test Certificate Required field.';
            }
            field("Warranty Certificate_B2B"; Rec."Warranty Certificate_B2B")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Warranty Certificate Required field.';
            }
            field("GST Reverse Charge"; Rec."GST Reverse Charge")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the GST Reverse Charge field.';
                Editable = true;
            }
        }

        modify("Qty. to Invoice")
        {
            Visible = false;
        }
        modify("Quantity Invoiced")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        addafter("Line Amount")
        {
            field("Printable UOM"; Rec."Printable UOM")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Printable UOM field.';
                Editable = PrintableEnabled;
            }
            field("Printable Qty"; Rec."Printable Qty")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Printable Qty field.';
                Editable = PrintableEnabled;
                DecimalPlaces = 0 : 12;
            }
            field("Printable unit rate"; Rec."Printable unit rate")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Printable unit rate field.';
                Editable = PrintableEnabled;
                DecimalPlaces = 0 : 12;
            }
            field("Printable amount"; Rec."Printable amount")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Printable amount field.';
                DecimalPlaces = 0 : 12;
            }

            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the GST specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the GST posting setup.';
            }
            field("Short Close Status "; "Short Close Status ")
            {
                ApplicationArea = all;

            }
            field("Short Close Quantity"; "Short Close Quantity")
            {
                ApplicationArea = all;

            }
            field("Short Closed by"; "Short Closed by")
            {
                ApplicationArea = all;

            }
            field("Short Closed Date & Time"; "Short Closed Date & Time")
            {
                ApplicationArea = all;

            }
            field("Short Close"; "Short Close")
            {
                ApplicationArea = all;
                //  Editable = ShortCloseEditble;

            }
        }

        modify("Spec ID B2B")
        {
            Editable = false;
        }
        modify("Prepayment %")
        {
            Visible = true;
        }
        modify("Prepmt. Line Amount")
        {
            Visible = true;
        }
        modify("Prepmt. Amt. Inv.")
        {
            Visible = true;
        }
        modify("No.")
        {
            trigger OnBeforeValidate()
            var
                PurchaseHdr: Record "Purchase Header";
                ItemRec: Record Item;
            begin
                if type = Type::Item then begin
                    if PurchaseHdr.get("Document Type", "Document No.") then begin
                        if ItemRec.Get("No.") and (ItemRec."Global Dimension 1 Code" <> PurchaseHdr."Shortcut Dimension 1 Code") then
                            Error('You Cannot Select This Item When The Division Is %1', PurchaseHdr."Shortcut Dimension 1 Code");
                    end;
                end;
            end;
        }
    }

    actions
    {
        addlast(processing)
        {
            action("Short Close new")
            {
                Caption = 'Short close';
                ApplicationArea = All;
                Ellipsis = true;
                Image = PostOrder;

                ToolTip = 'Short Close the order based on Qty Received and Invoiced';

                trigger OnAction()
                var

                begin

                    ShortClose();
                    // ShortCloseEditble := true;

                end;


            }
            //B2BSPON05JUNE23<<

            action("Item Price History")
            {
                ApplicationArea = All;
                Image = Navigate;
                ToolTip = 'Executes the Item Price History action.';
                //PromotedCategory = Process;
                //Promoted = true;
                //PromotedIsBig = true;
                trigger OnAction()
                var
                    PurchLineLrec: Record "Purch. Inv. Line";
                begin
                    PurchLineLrec.Reset();
                    PurchLineLrec.SetRange(Type, PurchLineLrec.Type::Item);
                    PurchLineLrec.SetRange("No.", Rec."No.");
                    if PurchLineLrec.FindSet() then
                        Page.RunModal(Page::"Posted Purch. Invoice Subform", PurchLineLrec);

                end;
            }
        }
        //B2BMSOn10Mar2023>>
        addafter("Inspection B2B")
        {
            action("Job Work RPO")
            {
                ApplicationArea = All;
                Image = ViewDocumentLine;

                trigger OnAction()
                var
                    ProdOrderLine: Record "Prod. Order Line";
                    ProdOrder: Record "Production Order";
                    ProdOrderNo: Code[20];
                begin
                    ProdOrderLine.Reset();
                    ProdOrderLine.SetRange(Status, ProdOrderLine.Status::Released);
                    ProdOrderLine.SetRange("Purchase Order No.", Rec."Document No.");
                    ProdOrderLine.SetRange("Purchase Order Line No.", Rec."Line No.");
                    ProdOrderLine.SetFilter(Quantity, '<>0');
                    if ProdOrderLine.FindSet() then begin
                        repeat
                            if ProdOrderNo <> ProdOrderLine."Prod. Order No." then begin
                                ProdOrderNo := ProdOrderLine."Prod. Order No.";
                                if ProdOrder.Get(ProdOrder.Status::Released, ProdOrderLine."Prod. Order No.") then
                                    ProdOrder.Mark(true);
                            end;
                        until ProdOrderLine.Next() = 0;
                        ProdOrder.MarkedOnly(true);
                        Page.RunModal(0, ProdOrder);
                    end;
                end;
            }
        }
        //B2BMSOn10Mar2023<<
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Available Inventory", "PO Qty", "Open Quote Qty");
        if (Rec.Quantity - Rec."Available Inventory" - Rec."PO Qty" - Rec."Open Quote Qty") > 0 then
            Rec."Shortage Qty" := Rec.Quantity - Rec."Available Inventory" - Rec."PO Qty" - Rec."Open Quote Qty"
        else
            Rec."Shortage Qty" := 0;

    end;

    trigger OnAfterGetCurrRecord()
    var
        PurchHdr: Record "Purchase Header";
    begin
        if PurchHdr.get(Rec."Document Type", Rec."Document No.") and (PurchHdr.Printable) then
            PrintableEnabled := true
        else
            PrintableEnabled := false;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Rec.CalcFields("Available Inventory", "PO Qty", "Open Quote Qty");
        if (Rec.Quantity - Rec."Available Inventory" - Rec."PO Qty" - Rec."Open Quote Qty") > 0 then
            Rec."Shortage Qty" := Rec.Quantity - Rec."Available Inventory" - Rec."PO Qty" - Rec."Open Quote Qty"
        else
            Rec."Shortage Qty" := 0;
    end;

    local procedure ShortClose()
    var
        PurchLine: Record "Purchase Line";
        ConfirmText: Label 'Do you want to Short Close the Purchase Order %1 ?';
        NotApplicableErr: Label 'Qty Received and Qty Invoiced should be equal for Line %1';
        SuccessMsg: Label 'Purchase Order %1 is Short Closed';
        ShortClosed: Boolean;
        PurchaseHeaderLRec: Record "Purchase Header";
        NtngShortclose: Label 'Nothing to Short close %1';
        ArchiveManagement: Codeunit ArchiveManagement;
        ShortClosedVar: Boolean;
        ArchiveVar: Boolean;
    begin
        ArchiveVar := false;
        ShortClosedVar := false;
        PurchLine.Reset();
        PurchLine.SetRange("Document Type", Rec."Document Type");
        PurchLine.SetRange("Document No.", Rec."Document No.");
        PurchLine.SetRange("Short Close Status ", PurchLine."Short Close Status "::Open);
        PurchLine.SetRange("Short Close", true);
        if PurchLine.FindSet() then
            repeat
               
                if PurchLine."Quantity Invoiced" <> PurchLine."Quantity Received" then
                    Error(NotApplicableErr, PurchLine."Line No.");
                if ((PurchLine.Quantity = PurchLine."Quantity Received") and (PurchLine.Quantity = PurchLine."Quantity Invoiced") and (PurchLine."Quantity Received" = PurchLine."Quantity Invoiced")) then
                    Error(NtngShortclose, PurchLine."Line No.");
                if not Confirm(StrSubstNo(ConfirmText, PurchLine."Document No."), false) then
                    exit;

                if not ArchiveVar then begin
                    If PurchaseHeaderLRec.get(Rec."Document Type", Rec."Document No.") and (PurchaseHeaderLRec.Status = PurchaseHeaderLRec.Status::Open) then begin
                        ArchiveManagement.ArchivePurchDocument(PurchaseHeaderLRec);
                        PurchaseHeaderLRec.Status := PurchaseHeaderLRec.Status::Open;
                        ArchiveVar := true;
                    end;

                end;
                PurchLine."Short Close Quantity" := PurchLine."Outstanding Quantity";
                PurchLine.validate(Quantity, PurchLine."Quantity Invoiced");
                PurchLine."Short Close Status " := PurchLine."Short Close Status "::"Short Close";


                if PurchLine."Short Close Quantity" <> 0 then begin
                    PurchLine."Outstanding Quantity" := 0;
                    PurchLine."Outstanding Qty. (Base)" := 0;
                end;
                PurchLine."Short Closed by" := UserId;
                PurchLine."Short Closed Date & Time" := CurrentDateTime;
                ShortClosedVar := true;
                PurchLine.Modify();
            until PurchLine.Next() = 0;
        if ShortClosedVar then
            Message(SuccessMsg, Rec."No.");


    end;

    var
        PrintableEnabled: Boolean;
        ShortCloseEditble: Boolean;
}
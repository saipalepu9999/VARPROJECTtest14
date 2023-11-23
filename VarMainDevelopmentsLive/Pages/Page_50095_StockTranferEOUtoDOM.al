page 50095 "Stock Transfer(Eou To Dom)"
{
    //B2BDNROn19Apr2023>>
    // version C2C

    Caption = 'Stock Transfer(Eou To Domestic)';
    DelayedInsert = true;
    PageType = Worksheet;
    SourceTable = "Code QC Worksheet";
    UsageCategory = Tasks;
    ApplicationArea = all;
    layout
    {
        area(content)
        {
            group("Item Details")
            {
                field("Item No. Filter"; FromItemNo)
                {
                    TableRelation = Item where("Global Dimension 1 Code" = const('EOU'));

                    trigger OnValidate();
                    begin
                        ValidateItem;
                        SetValues;
                        CurrPage.UPDATE(FALSE);
                    end;
                }
                /*field("Expiry Date Filter"; ExpiryDateFilter)
               {

                   trigger OnValidate();
                   begin
                       SetValues;
                       CurrPage.UPDATE(FALSE);
                   end;
               }*/
            }
            repeater(Control1)
            {
                field("Worksheet Doc No."; Rec."Worksheet Doc No.")
                {
                    ToolTip = 'Specifies the value of the Worksheet Doc No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("From Item No."; Rec."From Item No.")
                {
                    ToolTip = 'Specifies the value of the From Item No. field.';
                    trigger OnValidate()
                    begin
                        if Rec."From Item No." <> FromItemNo then
                            Error('You cannot modify this item');
                    end;
                }
                field("From Item Description"; Rec."From Item Description")
                {
                    ToolTip = 'Specifies the value of the From Item Description field.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field.';
                    Editable = false;
                }
                field("New Location Code"; Rec."New Location Code")
                {
                    ToolTip = 'Specifies the value of the New Location Code field.';
                    Editable = false;
                }
                field("ItemLedgEntry No."; Rec."ItemLedgEntry No.")
                {
                    ToolTip = 'Specifies the value of the Item Ledg Entry No. field.';
                }
                field("To Item No."; Rec."To Item No.")
                {
                    ToolTip = 'Specifies the value of the To Item No. field.';

                    TableRelation = Item where("Global Dimension 1 Code" = const('DOM'));
                    trigger OnValidate();
                    var
                        ItemRec: Record Item;
                        PurchInvLine: Record 123;
                        DefaultDimension: Record "Default Dimension";
                        GLSetup: Record "General Ledger Setup";
                    begin
                        GLSetup.Get();
                        TESTFIELD(Status, Status::Open);
                        if (CopyStr("To Item No.", 1, 1) <> 'E') and (CopyStr("To Item No.", 1, 1) <> 'D') then
                            Error('You cannot Select this item');
                        IF ItemRec.GET("To Item No.") THEN BEGIN
                            "To Item Description" := ItemRec.Description;
                            //"Specification ID" := ItemRec."Spec ID";
                            DefaultDimension.Reset();
                            DefaultDimension.SetRange("Table ID", 27);
                            DefaultDimension.SetRange("No.", "To Item No.");
                            DefaultDimension.SetRange("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
                            if DefaultDimension.FindFirst() then
                                "New Shortcut Dimension 1 Code" := DefaultDimension."Dimension Value Code";
                        END;

                        //DM 1.1>>End
                        PurchInvLine.RESET;
                        PurchInvLine.SETCURRENTKEY("Posting Date");
                        PurchInvLine.SETRANGE(Type, PurchInvLine.Type::Item);
                        PurchInvLine.SETRANGE("No.", "From Item No.");
                        IF PurchInvLine.FINDLAST THEN
                            "Unit Cost" := PurchInvLine."Unit Cost (LCY)";
                    end;
                }
                field("To Item Description"; Rec."To Item Description")
                {
                    ToolTip = 'Specifies the value of the To Item Description field.';
                }
                field("To Item Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(UOM; Rec.UOM)
                {
                    ToolTip = 'Specifies the value of the UOM field.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("New Shortcut Dimension 1 Code"; Rec."New Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                }
                field("New Shortcut Dimension 2 Code"; Rec."New Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                }
                field("New Lot No."; Rec."New Lot No.")
                {
                    ToolTip = 'Specifies the value of the New Lot No field.';
                }
                field("New Serial No."; Rec."New Serial No.")
                {
                    ToolTip = 'Specifies the value of the New Serial No field.';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                group(Items)
                {
                    Caption = 'Items';
                    action("Get Batches")
                    {
                        Caption = 'Get Batches';
                        Visible = true;
                        ToolTip = 'Executes the Get Batches action.';

                        trigger OnAction();
                        begin
                            Rec.SuggestRetestItemsEOUtoDOM(FromItemNo);
                        end;
                    }
                    action("Code-to-Code Transfer")
                    {
                        Caption = 'Code-to-Code Transfer';
                        ToolTip = 'Executes the Code-to-Code Transfer action.';

                        trigger OnAction();
                        begin

                            Rec.TESTFIELD(Posted, FALSE);
                            Rec.TESTFIELD(Status, Rec.Status::Released);
                            Rec.PostCodeToCodeTransfer(Rec."To Item No.");
                            Rec.Delete();
                            CurrPage.UPDATE(FALSE);
                            Message('Posted Successfully');
                        end;
                    }
                }
                action(Release)
                {
                    CaptionML = ENU = 'Re&lease',
                                ENN = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Executes the Release action.';

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit 1535;
                        IleGrec: Record "Item Ledger Entry";
                    begin
                        Rec.TESTFIELD("To Item No.");
                        Rec.TESTFIELD("From Item No.");
                        Rec.TESTFIELD("ItemLedgEntry No.");
                        Rec.TESTFIELD("Shortcut Dimension 1 Code");
                        Rec.TESTFIELD("Shortcut Dimension 2 Code");
                        Rec.TestField(Location);
                        Rec.TestField("New Location Code");
                        Rec.TestField("New Shortcut Dimension 1 Code");
                        Rec.TestField("New Shortcut Dimension 2 Code");
                        Rec.TESTFIELD("Unit Cost");
                        if IleGrec.Get(Rec."ItemLedgEntry No.") then begin
                            if IleGrec."Lot No." <> '' then
                                Rec.TestField("New Lot No.");
                            if IleGrec."Serial No." <> '' then
                                Rec.TestField("New Serial No.");
                        end;
                        Rec.Status := Rec.Status::Released;
                        Message('Status has been released');
                    end;
                }
                action(Reopen)
                {
                    CaptionML = ENU = 'Re&open',
                                ENN = 'Re&open';
                    Image = ReOpen;
                    ToolTip = 'Executes the Reopen action.';

                    trigger OnAction();
                    var
                        ReleasePurchDoc: Codeunit 415;
                    begin
                        IF Rec.Status = Rec.Status::"Pending For Approval" THEN
                            ERROR('The approval process must be cancelled or completed to reopen this document.');
                        IF NOT Rec.Posted THEN
                            Rec.Status := Rec.Status::Open;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        CodeQCWorkSheet.RESET;
        CodeQCWorkSheet.SETRANGE("QC Type", CodeQCWorkSheet."QC Type"::Miscellaneous);
        CodeQCWorkSheet.SETRANGE("QC Status", 0);
        CodeQCWorkSheet.DELETEALL(TRUE);
    end;

    var
        Text000: Label 'Inspection Data Sheets Created Successfully.';
        Text001: Label 'Inspection Data Sheets are already created.';
        Text002: Label 'Please Specify Location Code.';
        CodeQCWorkSheet: Record 50023;
        FromItemNo: Code[20];
        ToItemNo: Code[20];
        ExpiryDateFilter: Date;
        Text003: Label 'From Item No and To Item No cannot be same';
        Text004: Label 'Quality status is reject unable to transfer.';


    local procedure ValidateItem();
    var
        ItemLrec: Record Item;
    begin
        if ItemLrec.Get(FromItemNo) and (ItemLrec."Global Dimension 1 Code" <> 'EOU') then
            Error('You cannot select this item');
        IF (FromItemNo <> '') AND (Rec."To Item No." <> '') THEN BEGIN
            IF FromItemNo = Rec."To Item No." THEN
                ERROR(Text003);
        END;
    end;

    local procedure SetValues();
    begin
        Rec.RESET;
        IF FromItemNo <> '' THEN
            Rec.SETRANGE("From Item No.", FromItemNo);
        IF ExpiryDateFilter <> 0D THEN
            Rec.SETFILTER("Expiry Date", '<=%1', ExpiryDateFilter);
        Rec.SETRANGE(Posted, FALSE);
    end;
    //B2BDNROn19Apr2023<<
}


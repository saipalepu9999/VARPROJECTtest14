table 50010 "Payment Terms And Conditions"
{
    DataClassification = ToBeClassified;
    Caption = 'Terms & Conditions';
    fields
    {
        field(1; DocumentType; Option)
        {
            OptionMembers = Order,Invoice,Receipt,"Return Order","Credit Memo",Quote;
            OptionCaption = 'Order,Invoice,Receipt,Return Order,Credit Memo,Quote';
            DataClassification = ToBeClassified;

        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Purchase terms setup".Code;
            //ValidateTableRelation = false;
            //TestTableRelation = false;
            trigger OnValidate()
            var
                PurchaseTermsSetupLvar: Record "Purchase terms setup";
            begin
                PurchaseTermsSetupLvar.Reset();
                PurchaseTermsSetupLvar.SetRange("Code", Rec.Code);
                if PurchaseTermsSetupLvar.FindFirst() then
                    Description := PurchaseTermsSetupLvar.Description;

            end;

            trigger OnLookup()
            var
                PurchaseTermsSetupLvar: Record "Purchase terms setup";
            begin
                // PurchaseTermsSetupLvar.Reset();
                //PurchaseTermsSetupLvar.SetRange("Code", Rec.Code);
                //if PurchaseTermsSetupLvar.FindFirst() then begin
                if Page.RunModal(Page::PaymentTermsSetuplist, PurchaseTermsSetupLvar) = Action::LookupOK then
                    "code" := PurchaseTermsSetupLvar.Code;
                Description := PurchaseTermsSetupLvar.Description;
                //end;
            end;
        }
        Field(5; Description; Text[500])
        {

        }

        field(6; Sequence; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Version No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Doc. No. Occurrence"; Integer)
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; DocumentType, "Document No.", "Version No.", "Doc. No. Occurrence", LineNo)
        {
            Clustered = true;
        }

    }

    var
        myInt: Integer;
        Item: Record Item;
        //drdf: Record "Quotation Comparison";
        rpo: Page 99000883;
        ta: Record 38;
        cu: Codeunit 90;
        Pa: Page 99000883;
        Paq: Page 99000832;
        PaPin: Page "Purchase Invoice";
        re: Report 2;



    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
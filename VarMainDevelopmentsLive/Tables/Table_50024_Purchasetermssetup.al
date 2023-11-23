table 50024 "Purchase terms setup"
{
    Caption = 'Purchase terms & conditions setup';
    DataClassification = ToBeClassified;
    LookupPageId = PaymentTermsSetuplist;
    DrillDownPageId = PaymentTermsSetuplist;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Code"; Code[50])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[500])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; "Shortcut Dimension 1 Code_B2B"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SK; "code")
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
        fieldgroup(Brick; "Code", Description)
        {
        }
    }
    trigger OnInsert()
    begin
        PurchaseTermsSetup.Reset();
        if PurchaseTermsSetup.FindLast() then
            "Entry No." := PurchaseTermsSetup."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    var
        PurchaseTermsSetup: Record "Purchase terms setup";
        pa : Page 20252;
}

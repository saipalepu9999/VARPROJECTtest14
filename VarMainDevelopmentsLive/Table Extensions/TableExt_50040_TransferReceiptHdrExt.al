tableextension 50040 "Transfer Receipt Header Ext" extends "Transfer Receipt Header"
{
    fields
    {
        field(50000; "Approval Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,"Pending Approval",Released;
            OptionCaption = 'Open,Pending Approval,Released';
        }
        field(50001; "Production Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Production Order No.';
        }
        field(50002; "Sale Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sale Order No.';
        }
        field(50003; "Production Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Production Order Line No.';
        }
        field(50007; "Subcon Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Subocn Production Order No.';
            TableRelation = "Production Order"."No." where(Status = filter(Released));
        }
        field(50008; "Excess Material Returns"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Excess Material Returns';
            Editable = false;
        }
        field(50009; "Finished Good Transfer"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Finished Good Transfer';
            Editable = false;
        }

    }

    var
        myInt: Integer;
}
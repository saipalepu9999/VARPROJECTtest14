tableextension 50050 "SalesShipmentHeaderExt" extends "Sales Shipment Header"
{
    fields
    {
        field(50000; "Tender/Project"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Tender/Project Conformation By Customer';
            Editable = false;
        }
        field(50001; "Liquidated Damages"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Available,"Not Available";
            Editable = false;
        }
        field(50002; "Green Card Applicable"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Yes,No;
            // OptionCaption = ' ,Yes,No';
            Editable = false;
        }
        field(50003; "Green Card Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Technical,Commercial;
            // OptionCaption = ' ,Technical,Commercial';
            // Editable = EditableGvar;
            Editable = false;
        }
        field(50004; "Green Card Received"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Yes,No;
            //OptionCaption = ' ,Yes,No';
            Editable = false;
        }
        field(50005; "Green Card Receipt Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50007; "BG No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Guarantee"."BG No.";
            Editable = false;
        }
        field(50008; "Receipt Of Customer Po"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Of Customer Declaration Form(Cluster Munition)';
            OptionMembers = " ",Available,"Not Available";
            Editable = false;
        }
        field(50009; "Receipt Of Cust Drawings"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Receipt Of Customer Drawings';
            OptionMembers = " ",Available,"Not Available";
            Editable = false;
        }
        field(50010; "BG/FDR"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'BG/FDR';
            OptionMembers = " ",Required,"Not Required";
            Editable = false;
        }
        field(50011; "BG/FDR Availability"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Available,"Not Available";
            Editable = false;
        }
        field(50012; "BG/FDR No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        /*field(50013; "BG/FDR Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "BG/FDR Closure Date"; Date)
        {
            DataClassification = ToBeClassified;
        }*/
        field(50015; "Acceptance Letter"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Received,"Not Received",Pending;
            Editable = false;
        }
        field(50016; "QAP document"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'QAP Document Delivery & Customer Acknowledgment';
            OptionMembers = " ",Yes,No,Pending;
            Editable = false;
        }
        field(50017; "External Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50018; "Port Of Discharge"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50019; "Cluster Munition"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Required,"Not Required";
            Caption = 'Cluster Munition Certificate Requiremnt';
            Editable = false;
        }
        field(50020; "Type Of BG"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Security BG\FDR","Performance BG\FDR","Security&PerformanceBG\FDR";
            Editable = false;
        }
        field(50021; "SBG FDR No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50022; "PBG FDR No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50023; "SPBG FDR No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50024; "SBG Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50025; "PBG Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50026; "SPBG Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50027; "Extended Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Extended End Date';
            Editable = false;
        }
        field(50028; "SBG EndDate"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'SBG End Date';
            Editable = false;
        }
        field(50029; "PBG EndDate"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'PBG End Date';
            Editable = false;
        }
        field(50030; "SPBG EndDate"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'SPBG End Date';
            Editable = false;
        }
        field(50031; "Customer Po No."; Text[500])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50032; "Customer Po Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50033; "Remarks1"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Payment Terms';
        }
        field(50034; "Remarks2"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50035; "Final Destintion"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50036; "Amendment No."; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50037; "Amendment Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50039; "BG Margin"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'BG Margin';
        }
        field(50040; "BG Margin %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'BG Margin %';
        }
        field(50041; "GCA Exports"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'GCA Exports';
        }
        field(50042; "RPA Exports"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'RPA Exports';
        }
    }

    var
        myInt: Integer;
}
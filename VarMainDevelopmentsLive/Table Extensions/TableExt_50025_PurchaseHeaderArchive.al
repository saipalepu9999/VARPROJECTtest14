tableextension 50025 PurchaseHeaderArchiveExt extends "Purchase Header Archive"
{
    fields
    {
        field(50000; "MSME Certificate No."; Code[20])
        {
            Caption = 'MSME Certificate No.';
            DataClassification = ToBeClassified;

        }
        field(50001; "MSME Validity Date"; Date)
        {
            Caption = 'MSME Validity Date';
            DataClassification = ToBeClassified;

        }
        //4.12 >>
        field(50002; "Short Close Status"; Enum ShortCloseStatus)
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Short Closed By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Short Closed DateTime"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        //4.12 <<
        field(50005; "Pc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Procurement Certificate No.';
        }
        field(50006; "Pc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Procurement Certificate Date';
        }
        field(50007; "Dc No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan No.';
        }
        field(50008; "Dc Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Challan Date';
        }
        field(50009; "Quality Remarks"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(50010; "Duty Involved_B2B"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Duty Involved For Cleared';
        }
        field(50015; "Reference Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Vendor Invoice Date"; Date)
        {
            Caption = 'Vendor Invoice Date';
            DataClassification = ToBeClassified;
        }
        field(50018; "Vendor Quote No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Vendor Quote Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Order Type"; Option)
        {
            Caption = 'Order Type';
            OptionMembers = " ",Production,Quality,"Maintenance/Jigs & Fixtures Spares","General Items";
        }
        field(50024; "New Remarks"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remarks';
        }
        //B2BJKon10may2023 >>
        field(50026; "Service MRV"; boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Service MRV';
            Editable = false;
        }
        //B2BJKon10may2023 <<
        field(50027; "PO Ack.Date"; Date)
        {
            Caption = 'PO Ack.Date';
            DataClassification = ToBeClassified;
        }//B2BPROn03Jul2023
        field(50028; "Ack.Val"; Boolean)
        {
            Caption = 'Ack.Attachment';
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}
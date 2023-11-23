report 50076 "SBH Cheque"
{
    // version CHQP1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\SBIReportNew.rdl';

    dataset
    {
        dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
        {
            DataItemTableView = SORTING("Entry No.")
                                ORDER(Ascending);
            column(SubText1; SubText1)
            {
            }
            column(ChequeValText; '**' + ChequeValText)
            {
            }
            column(DataItem1000000000; FORMAT(PostDateString3 + '   ' + PostDateString6 + '    ' + PostDateString2 + '   ' + PostDateString5 + '   ' + '2   0  ' + PostDateString1 + '   ' + PostDateString4))
            {
            }
            column(Name; Name)
            {
            }
            column(AccountPayee; AccountPayee)
            {
            }
            column(SubText2; SubText2)
            {
            }
            column(Bank_Account_Ledger_Entry_Entry_No_; "Entry No.")
            {
            }
            column(Datetext_1; Datetext[1])
            { }
            column(Datetext_2; Datetext[2])
            { }
            column(Datetext_3; Datetext[3])
            { }
            column(Datetext_4; Datetext[4])
            { }
            column(Datetext_5; Datetext[5])
            { }
            column(Datetext_6; Datetext[6])
            { }
            column(Datetext_7; Datetext[7])
            { }
            column(Datetext_8; Datetext[8])
            { }

            trigger OnAfterGetRecord();
            begin
                /*
                IF "Cheque Printed" THEN BEGIN
                  IF NOT CONFIRM('Cheque is already printed do u want to print it again?',FALSE) THEN
                    CurrReport.SKIP;
                END ELSE BEGIN
                  "Cheque Printed" := TRUE;
                  "Cheque Printed By" := USERID;
                  MODIFY;
                END;
                */
                // to control reprint of cheque earlier original code commented
                //"Cheque Printed" := TRUE;
                //"Cheque Printed By" := USERID; //Commented By Vijay om Nov-22-2010
                //MODIFY;

                //Bank Account Ledger Entry, Footer (1) - OnPreSection()
                Clear(Datetext);
                for I := 1 to 8 do begin
                    Datetext[I] := Copystr(Format("Cheque Date", 0, '<Day,2><Month,2><Year4>'), I, 1);
                end;
                CLEAR(CheckRep);
                CLEAR(NoText);
                CheckRep.InitTextVariable;
                CheckRep.FormatNoText(NoText, ABS("Bank Account Ledger Entry".Amount), "Bank Account Ledger Entry"."Currency Code");

                // B2B 2.0 >>
                //ChequeValText := ReturnIndianAmountFormat(FORMAT(ABS("Bank Account Ledger Entry".Amount)));
                ChequeValText := ReturnIndianAmountFormat(FORMAT(BalAmount));

                /*
                ChequeValText  := FORMAT(ABS("Bank Account Ledger Entry".Amount));
                ChequeValText := DELCHR(ChequeValText,'=',',');
                ChequeValText := DELCHR(ChequeValText,'=','*');
                ChequeValText1 := ChequeValText;
                
                DotPosition := STRPOS(ChequeValText,'.');
                IF DotPosition > 0 THEN
                  ChequeValText := COPYSTR(ChequeValText,1,DotPosition-1);
                
                ChequeAmountText := ChequeValText;
                IF (FORMAT(ChequeValText[4]) <> '') THEN BEGIN
                  HundredCommaPosition := STRLEN(ChequeValText) - 3;
                  ChequeAmountText := ',' + COPYSTR(ChequeValText,HundredCommaPosition+1);
                END ELSE
                  ChequeAmountText := FORMAT(ABS("Bank Account Ledger Entry".Amount));
                
                IF (FORMAT(ChequeValText[6]) <> '') THEN BEGIN
                  ThousandCommaPosition := STRLEN(ChequeValText) - 5;
                  ChequeAmountText := ',' + COPYSTR(ChequeValText,ThousandCommaPosition+1,2) + ChequeAmountText;
                END ELSE
                  ChequeAmountText := FORMAT(ABS("Bank Account Ledger Entry".Amount));
                
                IF (FORMAT(ChequeValText[6]) <> '') AND (FORMAT(ChequeValText[1]) <> '') AND (FORMAT(ChequeValText[2]) <>'') AND
                   (STRLEN(ChequeValText) <= 7) THEN BEGIN
                  IF STRLEN(ChequeValText) = 7 THEN
                    ChequeAmountText := COPYSTR(ChequeValText,1,2) + ChequeAmountText
                  ELSE IF STRLEN(ChequeValText) = 6 THEN
                    ChequeAmountText := COPYSTR(ChequeValText,1,1) + ChequeAmountText;
                  // MESSAGE('L %1',ChequeAmountText);
                END;
                
                CroreText := '';
                IF STRLEN(ChequeValText) > 7 THEN BEGIN
                  CroreText := COPYSTR(ChequeValText,1,STRLEN(ChequeValText)-7);
                  ChequeAmountText := CroreText + ',' + ChequeAmountText;
                END;
                
                ChequeAmountText := '**' + ChequeAmountText;
                IF DotPosition = 0 THEN
                  ChequeAmountText += '.00';
                //ELSE
                  //ChequeAmountText += COPYSTR(ChequeValText1,DotPosition,3);
                
                // MESSAGE('%1 .. %2 .. %3',ChequeValText,ChequeValText1,ChequeAmountText);
                */
                // B2B 2.0 <<

            end;

            trigger OnPreDataItem();
            begin
                /*
                IF CurrReport.PREVIEW THEN
                  ERROR(Text001);
                *///Test
                COPYFILTERS(BankLedgerEntry);
                CompanyInformation.GET;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Name; Name)
                {
                    Caption = 'Name';
                    ApplicationArea = all;
                    // Editable = false;
                }
                field(BalAmount; BalAmount)
                {
                    Caption = 'Amount';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(PostingDate; PostingDate)
                {
                    Caption = 'Cheque Date';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(ChequeNo2; ChequeNo2)
                {
                    Caption = 'Cheque No';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(AccountPayee; AccountPayee)
                {
                    Caption = 'Account Payee';
                    ApplicationArea = all;
                }
                field(SubText1; SubText1)
                {
                    Caption = 'Text Line 1';
                    ApplicationArea = all;
                    Editable = false;
                }
                field(SubText2; SubText2)
                {
                    Caption = 'Text Line 2';
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        PostDateString := FORMAT(PostingDate, 0, 6);
        PostDateString1 := COPYSTR(PostDateString, 1, 1);
        PostDateString4 := COPYSTR(PostDateString, 2, 1);
        PostDateString2 := COPYSTR(PostDateString, 3, 1);
        PostDateString5 := COPYSTR(PostDateString, 4, 1);
        PostDateString3 := COPYSTR(PostDateString, 5, 1);
        PostDateString6 := COPYSTR(PostDateString, 6, 1);
    end;

    var
        CompanyInformation: Record 79;
        BankAccount: Record 270;
        Vendor: Record 23;
        ChequeDescription: Text[1024];
        NoText: array[2] of Text[80];
        CheckRep: Codeunit "Check Codeunit";
        ChequeNo2: Code[50];
        BalAmount: Decimal;
        PostingDate: Date;
        Name: Text[150];
        BankLedgerEntry: Record 271;
        BankAccountLedgerEntryADV: Record 271;
        AccountPayee: Option "A/C Payee","   ";
        Text001: Label 'Preview Not Available';
        TotalAmountText: Text[160];
        SubText1: Text[70];
        SubText2: Text[70];
        PostDateString: Text[30];
        PostDateString1: Text[30];
        PostDateString2: Text[30];
        PostDateString3: Text[30];
        PostDateString4: Text[30];
        PostDateString5: Text[30];
        PostDateString6: Text[30];

        ChequeValText: Text[30];
        ChequeValText1: Text[30];
        DotPosition: Integer;
        HundredCommaPosition: Integer;
        ThousandCommaPosition: Integer;
        LakhCommaPosition: Integer;
        CroreText: Text[30];
        ChequeAmountText: Text[30];
        Datetext: array[10] of Text;
        I: Integer;
        Pa: Page 18747;

    procedure GetValues(var Rec: Record 271; LineText1: Text[70]; LineText2: Text[70]; NewAmount: Decimal);
    var
        GLAccount: Record 15;
        Customer: Record 18;
        Vendor: Record 23;
        FixedAsset: Record 5600;
        BankAccount: Record 270;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        EmployeeRec: Record Employee;
    begin
        BankLedgerEntry.COPYFILTERS(Rec);
        // IF Rec."Source Code" = 'CONTRAV' THEN BEGIN
        // Name := 'Self';
        // AccountPayee := AccountPayee::"   ";
        //END ELSE BEGIN
        CASE Rec."Bal. Account Type" OF

            Rec."Bal. Account Type"::"G/L Account":
                BEGIN
                    GLAccount.RESET;
                    GLAccount.SETRANGE(GLAccount."No.", Rec."Bal. Account No.");
                    IF GLAccount.FINDFIRST THEN
                        Name := GLAccount.Name;
                END;
            Rec."Bal. Account Type"::Customer:
                BEGIN
                    Customer.RESET;
                    Customer.SETRANGE(Customer."No.", Rec."Bal. Account No.");
                    IF Customer.FINDFIRST THEN
                        Name := Customer.Name;
                END;
            Rec."Bal. Account Type"::Vendor:
                BEGIN
                    Vendor.RESET;
                    Vendor.SETRANGE(Vendor."No.", Rec."Bal. Account No.");
                    IF Vendor.FINDFIRST THEN
                        Name := Vendor.Name + Vendor."Name 2";
                END;
            Rec."Bal. Account Type"::"Bank Account":
                BEGIN
                    BankAccount.RESET;
                    BankAccount.GET(Rec."Bal. Account No.");
                    IF BankAccount.FINDFIRST THEN
                        Name := BankAccount.Name;
                END;
            Rec."Bal. Account Type"::"Fixed Asset":
                BEGIN
                    FixedAsset.RESET;
                    FixedAsset.GET(Rec."Bal. Account No.");
                    IF FixedAsset.FINDFIRST THEN
                        Name := FixedAsset.Description;
                END;
        // END;
        END;
        if Name = '' then begin
            VendorLedgerEntry.Reset();
            VendorLedgerEntry.SetRange("Document No.", Rec."Document No.");
            if VendorLedgerEntry.FindFirst() then begin
                Vendor.RESET;
                Vendor.SETRANGE(Vendor."No.", VendorLedgerEntry."Vendor No.");
                IF Vendor.FINDFIRST THEN
                    Name := Vendor.Name;
            end;
        end;
        Rec.CalcFields("Shortcut Dimension 3 Code");
        if Rec."Shortcut Dimension 3 Code" <> '' then begin
            EmployeeRec.Reset();
            EmployeeRec.SetRange("No.", Rec."Shortcut Dimension 3 Code");
            if EmployeeRec.FindFirst() then begin
                Name := EmployeeRec.Initials + '. ' + EmployeeRec."Last Name" + ' ' + EmployeeRec."First Name" + EmployeeRec."Middle Name";
            end;
        end;
        // BalAmount := ABS(Rec."Amount (LCY)");
        BalAmount := NewAmount;
        PostingDate := Rec."Cheque Date";
        ChequeNo2 := Rec."Cheque No.";
        SubText1 := LineText1;
        SubText2 := LineText2;
        //MESSAGE('%1 .. %2',LineText1,LineText2);
    end;



    procedure ReturnIndianAmountFormat(OriginalText: Text[30]): Text[30];
    var
        WholeNoText: Text[30];
        DecimalSubText: Text[30];
        BufferText: Text[30];
        BufferText2: Text[30];
        RequiredText: Text[30];
        J: Integer;
        I: Integer;
        DotPosition: Integer;
    begin
        // OriginalText := '42869.34';
        DotPosition := STRPOS(OriginalText, '.');
        IF DotPosition > 0 THEN BEGIN
            DecimalSubText := COPYSTR(OriginalText, DotPosition);
            WholeNoText := COPYSTR(OriginalText, 1, DotPosition - 1);
            IF STRLEN(DecimalSubText) = 2 THEN
                DecimalSubText += '0';
        END ELSE BEGIN
            WholeNoText := OriginalText;
            DecimalSubText := '.00';
        END;

        // MESSAGE('Original Text %1 .. Sub Text %2',OriginalText,DecimalSubText);
        WholeNoText := DELCHR(WholeNoText, '=', ',');
        // MESSAGE(WholeNoText);

        J := 0;
        FOR I := STRLEN(WholeNoText) DOWNTO 1 DO BEGIN
            J += 1;
            BufferText[J] := WholeNoText[I];
        END;

        IF (STRLEN(BufferText) > 3) AND (STRLEN(BufferText) < 6) THEN BEGIN
            BufferText2 := COPYSTR(BufferText, 1, 3) + ',' + COPYSTR(BufferText, 4, 2);
        END ELSE
            BufferText2 := BufferText;

        IF (STRLEN(BufferText) > 5) AND (STRLEN(BufferText) < 8) THEN BEGIN
            IF STRLEN(BufferText) = 7 THEN
                BufferText2 := COPYSTR(BufferText, 1, 3) + ',' + COPYSTR(BufferText, 4, 2) + ',' + COPYSTR(BufferText, 6, 2)
            ELSE
                BufferText2 := COPYSTR(BufferText, 1, 3) + ',' + COPYSTR(BufferText, 4, 2) + ',' + COPYSTR(BufferText, 6, 1);
        END;

        IF (STRLEN(BufferText) > 7) THEN BEGIN
            BufferText2 := COPYSTR(BufferText, 1, 3) + ',' + COPYSTR(BufferText, 4, 2) + ',' + COPYSTR(BufferText, 6, 2) + ',' +
                           COPYSTR(BufferText, 8);
        END;

        J := 0;
        FOR I := STRLEN(BufferText2) DOWNTO 1 DO BEGIN
            J += 1;
            RequiredText[J] := BufferText2[I];
        END;

        //MESSAGE('%1 .. %2  .. %3 .. %4',OriginalText,BufferText,BufferText2,RequiredText+DecimalSubText);
        EXIT(RequiredText + DecimalSubText);
    end;
}


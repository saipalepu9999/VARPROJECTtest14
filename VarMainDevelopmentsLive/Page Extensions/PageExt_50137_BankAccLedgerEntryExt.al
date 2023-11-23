pageextension 50137 BankAccLedgerEntryExt extends "Bank Account Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Report)
        {
            action("Print SBI")
            {
                ApplicationArea = All;
                Caption = 'Print SBI';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    StateBankChqPrint;
                end;
            }
            action("Print HDFC")
            {
                ApplicationArea = All;
                Caption = 'Print HDFC';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    HDFCChqPrint;
                end;
            }
        }
    }

    var
        myInt: Integer;

        CheckRep: Codeunit "Check Codeunit";
        NoText: array[2] of Text[80];
        TotalAmountText: Text[160];
        SplitText1: Text[70];
        SplitText2: Text[70];
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        BankAccLedgerEntryNew: Record "Bank Account Ledger Entry";
        TotalBankAmtGvar: Decimal;
        BankLedgerEntry2: Record "Bank Account Ledger Entry";
        PaymentAdviceChequeSBI: Report "SBH Cheque";
        PaymentAdviceChequeHDFC: Report "HDFC Cheque";

    procedure StateBankChqPrint()


    begin
        CLEAR(SplitText1);
        CLEAR(SplitText2);
        Clear(TotalBankAmtGvar);

        BankLedgerEntry.RESET;
        //BankLedgerEntry.SETFILTER("Bal. Account Type",'<>%1',BankLedgerEntry."Bal. Account Type"::Customer); //SREE241117
        BankLedgerEntry.SETRANGE("Entry No.", "Entry No.");
        //BankLedgerEntry.SETRANGE("Cheque Printed",FALSE);//Test
        IF BankLedgerEntry.FINDFIRST THEN BEGIN
            // CAX1.0 >>
            // to split the amount in words in two lines when printed
            CLEAR(NoText);

            if BankLedgerEntry."Source Code" <> 'CONTRA' then begin
                BankAccLedgerEntryNew.Reset();
                BankAccLedgerEntryNew.SetRange("Document No.", Rec."Document No.");
                if BankAccLedgerEntryNew.FindSet() then
                    repeat
                        TotalBankAmtGvar += abs(BankAccLedgerEntryNew.Amount);
                    until BankAccLedgerEntryNew.Next() = 0;
            end else begin
                BankAccLedgerEntryNew.Reset();
                BankAccLedgerEntryNew.SetRange("Document No.", Rec."Document No.");
                //BankAccLedgerEntryNew.SetFilter("Debit Amount", '>%1', 0);
                if BankAccLedgerEntryNew.FindSet() then
                    repeat
                        TotalBankAmtGvar := abs(BankAccLedgerEntryNew.Amount);
                    until BankAccLedgerEntryNew.Next() = 0;
            end;

            CheckRep.InitTextVariable;
            CheckRep.FormatNoText(NoText, TotalBankAmtGvar, BankLedgerEntry."Currency Code");
            TotalAmountText := NoText[1] + NoText[2];
            IF STRLEN(TotalAmountText) > 70 THEN BEGIN
                SplitText1 := SplitTextWords(COPYSTR(TotalAmountText, 1, 70));
                SplitText2 := COPYSTR(TotalAmountText, STRLEN(SplitText1) + 1);
            END ELSE
                SplitText1 := TotalAmountText;

            // end of splitting text
            PaymentAdviceChequeSBI.GetValues(BankLedgerEntry, Copystr(SplitText1, 7, StrLen(SplitText1)), SplitText2, TotalBankAmtGvar); //IcleanUPG Report Not developed
            PaymentAdviceChequeSBI.RUN;
        END ELSE BEGIN
            IF CONFIRM('Cheque already printed. Do u want to print it again?', TRUE) THEN BEGIN
                BankLedgerEntry2.RESET;
                BankLedgerEntry2.SETFILTER("Bal. Account Type", '<>%1', BankLedgerEntry2."Bal. Account Type"::Customer);
                BankLedgerEntry2.SETRANGE("Entry No.", "Entry No.");
                //BankLedgerEntry2.SETRANGE("Cheque Printed", TRUE);
                IF BankLedgerEntry2.FINDFIRST THEN BEGIN
                    // CAX1.0 >>
                    // to split the amount in words in two lines when printed
                    CLEAR(NoText);
                    CheckRep.InitTextVariable;
                    CheckRep.FormatNoText(NoText, ABS(BankLedgerEntry2.Amount), BankLedgerEntry2."Currency Code");
                    TotalAmountText := NoText[1] + NoText[2];
                    IF STRLEN(TotalAmountText) > 70 THEN BEGIN
                        SplitText1 := SplitTextWords(COPYSTR(TotalAmountText, 1, 70));
                        SplitText2 := COPYSTR(TotalAmountText, STRLEN(SplitText1) + 1);
                    END ELSE
                        SplitText1 := TotalAmountText;
                    // end of splitting text
                    PaymentAdviceChequeSBI.GetValues(BankLedgerEntry2, Copystr(SplitText1, 7, StrLen(SplitText1)), SplitText2, TotalBankAmtGvar); //IcleanUPG Report Not Developed
                    PaymentAdviceChequeSBI.RUN;
                END;
            END;
        END;
    end;

    procedure HDFCChqPrint()


    begin
        CLEAR(SplitText1);
        CLEAR(SplitText2);
        Clear(TotalBankAmtGvar);

        BankLedgerEntry.RESET;
        //BankLedgerEntry.SETFILTER("Bal. Account Type",'<>%1',BankLedgerEntry."Bal. Account Type"::Customer); //SREE241117
        BankLedgerEntry.SETRANGE("Entry No.", "Entry No.");
        //BankLedgerEntry.SETRANGE("Cheque Printed",FALSE);//Test
        IF BankLedgerEntry.FINDFIRST THEN BEGIN
            // CAX1.0 >>
            // to split the amount in words in two lines when printed
            CLEAR(NoText);


            if BankLedgerEntry."Source Code" <> 'CONTRA' then begin
                BankAccLedgerEntryNew.Reset();
                BankAccLedgerEntryNew.SetRange("Document No.", Rec."Document No.");
                if BankAccLedgerEntryNew.FindSet() then
                    repeat
                        TotalBankAmtGvar += abs(BankAccLedgerEntryNew.Amount);
                    until BankAccLedgerEntryNew.Next() = 0;
            end else begin
                BankAccLedgerEntryNew.Reset();
                BankAccLedgerEntryNew.SetRange("Document No.", Rec."Document No.");
                // BankAccLedgerEntryNew.SetFilter("Debit Amount", '>%1', 0);
                if BankAccLedgerEntryNew.FindSet() then
                    repeat
                        TotalBankAmtGvar := abs(BankAccLedgerEntryNew.Amount);
                    until BankAccLedgerEntryNew.Next() = 0;
            end;

            CheckRep.InitTextVariable;
            CheckRep.FormatNoText(NoText, TotalBankAmtGvar, BankLedgerEntry."Currency Code");
            TotalAmountText := NoText[1] + NoText[2];
            IF STRLEN(TotalAmountText) > 70 THEN BEGIN
                SplitText1 := SplitTextWords(COPYSTR(TotalAmountText, 1, 70));
                SplitText2 := COPYSTR(TotalAmountText, STRLEN(SplitText1) + 1);
            END ELSE
                SplitText1 := TotalAmountText;
            // end of splitting text
            PaymentAdviceChequeHDFC.GetValues(BankLedgerEntry, Copystr(SplitText1, 7, StrLen(SplitText1)), SplitText2, TotalBankAmtGvar); //IcleanUPG Report Not developed
            PaymentAdviceChequeHDFC.RUN;
        END ELSE BEGIN
            IF CONFIRM('Cheque already printed. Do u want to print it again?', TRUE) THEN BEGIN
                BankLedgerEntry2.RESET;
                BankLedgerEntry2.SETFILTER("Bal. Account Type", '<>%1', BankLedgerEntry2."Bal. Account Type"::Customer);
                BankLedgerEntry2.SETRANGE("Entry No.", "Entry No.");
                //BankLedgerEntry2.SETRANGE("Cheque Printed", TRUE);
                IF BankLedgerEntry2.FINDFIRST THEN BEGIN
                    // CAX1.0 >>
                    // to split the amount in words in two lines when printed
                    CLEAR(NoText);
                    CheckRep.InitTextVariable;
                    CheckRep.FormatNoText(NoText, ABS(BankLedgerEntry2.Amount), BankLedgerEntry2."Currency Code");
                    TotalAmountText := NoText[1] + NoText[2];
                    IF STRLEN(TotalAmountText) > 70 THEN BEGIN
                        SplitText1 := SplitTextWords(COPYSTR(TotalAmountText, 1, 70));
                        SplitText2 := COPYSTR(TotalAmountText, STRLEN(SplitText1) + 1);
                    END ELSE
                        SplitText1 := TotalAmountText;
                    // end of splitting text
                    PaymentAdviceChequeHDFC.GetValues(BankLedgerEntry2, Copystr(SplitText1, 7, StrLen(SplitText1)), SplitText2, TotalBankAmtGvar); //IcleanUPG Report Not Developed
                    PaymentAdviceChequeHDFC.RUN;
                END;
            END;
        END;
    end;

    procedure SplitTextWords(ActText: Text[70]) ReqText: Text[70]
    var
        J: Integer;
        OrgText: Text;
    begin
        J := 50;
        REPEAT
            IF ActText[J] = ' ' THEN BEGIN
                OrgText := COPYSTR(ActText, 1, J - 1);
                EXIT(OrgText);
            END ELSE
                J := J - 1;
        UNTIL J = 0;
    end;
}
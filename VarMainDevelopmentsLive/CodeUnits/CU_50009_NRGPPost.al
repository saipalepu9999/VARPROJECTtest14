codeunit 50009 "NRGP Post"
{

    trigger OnRun()
    begin
    end;

    var
        Item: Record 27;
        NRGPHeader: Record "NRGP Header";
        ItemJnlLine: Record 83;
        NRGPLine: Record "NRGP Line";
        ItemJnlPostLine: Codeunit 22;
        Text001: Label 'NRGP is posted successfully.';


    procedure NRGPPost(Rec: Record "NRGP Header")
    Var
        ReservationEntry3: Record "Reservation Entry";
    begin
        /* clear(ItemJnlPostLine);
         NRGPHeader.SETRANGE("No.", Rec."No.");
         IF NRGPHeader.FIND('-') THEN BEGIN
             NRGPLine.SETRANGE("Document No.", NRGPHeader."No.");
             NRGPLine.SETRANGE(Type, NRGPLine.Type::Item);
             IF NRGPLine.FIND('-') THEN BEGIN
                 REPEAT
                     //InsertItemLedgerEntries(NRGPLine, NRGPHeader);
                 UNTIL NRGPLine.NEXT = 0;
             END;
             // Deleteing tracking after posted>>
             ReservationEntry3.Reset;
             ReservationEntry3.setrange("Source ID", Rec."No.");
             ReservationEntry3.Setrange("Source Type", Database::"NRGP Line");
             IF ReservationEntry3.findset then
                 ReservationEntry3.DeleteAll();

             // Deleteing tracking after posted<<
             MESSAGE(Text001);
         END;*/
    end;


    procedure InsertItemLedgerEntries(NRGPLine: Record "NRGP Line"; NRGPHeader: Record "NRGP Header")
    begin
        ItemJnlLine.INIT;
        ItemJnlLine."Journal Template Name" := 'ITEM';
        ItemJnlLine."Journal Batch Name" := 'DEFAULT';
        ItemJnlLine."Entry Type" := ItemJnlLine."Entry Type"::"Negative Adjmt.";
        ItemJnlLine."Line No." := NRGPLine."Line No.";
        ItemJnlLine."Document No." := NRGPLine."Document No.";
        ItemJnlLine."Posting Date" := NRGPHeader."Posting Date";
        ItemJnlLine.Validate("Document Date", NRGPHeader."Posting Date");
        ItemJnlLine.VALIDATE("Item No.", NRGPLine."No.");
        ItemJnlLine.VALIDATE(Quantity, NRGPLine.Quantity);
        ItemJnlLine."Unit of Measure Code" := NRGPLine."Unit of Measure";
        ItemJnlLine."Location Code" := NRGPHeader."Location Code";
        Item.GET(NRGPLine."No.");
        ItemJnlLine."Gen. Prod. Posting Group" := Item."Gen. Prod. Posting Group";
        ItemJnlLine.Validate("Shortcut Dimension 1 Code", NRGPHeader."Global Dimension 1 Code");
        ItemJnlLine.Validate("Shortcut Dimension 2 Code", NRGPHeader."Global Dimension 2 Code");
        /*
        DocDim.SETRANGE("Table ID",50024);
        DocDim.SETRANGE("Document Type",DocDim."Document Type"::"10");
        DocDim.SETRANGE("Document No.",NRGPLine."Document No.");
        DocDim.SETRANGE("Line No.",NRGPLine."Line No.");
        IF DocDim.FIND('-') THEN BEGIN
          REPEAT
            JnlDim.INIT;
            JnlDim."Table ID" := 83;
            JnlDim."Journal Template Name" := ItemJnlLine."Journal Template Name";
            JnlDim."Journal Batch Name" := ItemJnlLine."Journal Batch Name";
            JnlDim."Journal Line No." := ItemJnlLine."Line No.";
            JnlDim."Dimension Code" := DocDim."Dimension Code";
            JnlDim."Dimension Value Code" := DocDim."Dimension Value Code";
            JnlDim.INSERT;
          UNTIL DocDim.NEXT = 0;
        END;
        */// upg

        if (NRGPLine.Type = NRGPLine.Type::Item) and (Item."Item Tracking Code" <> '') then
            UpdateResEntry(ItemJnlLine);

        ItemJnlPostLine.RunWithCheck(ItemJnlLine); 
        /*
        JnlDim2.SETRANGE("Table ID",83);
        JnlDim2.SETRANGE("Journal Template Name",JnlDim."Journal Template Name");
        JnlDim2.SETRANGE("Journal Batch Name",JnlDim."Journal Batch Name");
        IF JnlDim2.FIND('-') THEN
          JnlDim2.DELETEALL;
        */// UPG

    end;

    procedure UpdateResEntry(VAR ItemJournalLine2: Record "Item Journal Line");


    Var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        Entrynum: Integer;
    begin
        IF ReservationEntry2.FINDlast() THEN
            EntryNum := ReservationEntry2."Entry No." + 1
        ELSE
            EntryNum := 1;
        ReservationEntry2.Reset;
        ReservationEntry2.setrange("Source ID", ItemJournalLine2."Document No.");
        ReservationEntry2.Setrange("Source Type", Database::"NRGP Line");
        ReservationEntry2.SetRange("Source Ref. No.", ItemJournalLine2."Line No.");
        if ReservationEntry2.findset then begin
            repeat
                ReservationEntry.INIT();
                ReservationEntry."Entry No." := EntryNum;
                ReservationEntry.VALIDATE(Positive, FALSE);
                ReservationEntry.VALIDATE("Item No.", ItemJournalLine2."Item No.");
                ReservationEntry.VALIDATE("Location Code", ItemJournalLine2."Location Code");
                ReservationEntry.VALIDATE("Quantity (Base)", ReservationEntry2."Quantity (Base)");
                ReservationEntry.VALIDATE("Reservation Status", ReservationEntry."Reservation Status"::Prospect);
                ReservationEntry.VALIDATE("Creation Date", ItemJournalLine2."Posting Date");
                ReservationEntry.VALIDATE("Source Type", DATABASE::"Item Journal Line");
                ReservationEntry.VALIDATE("Source Subtype", 3);
                ReservationEntry.VALIDATE("Source ID", ItemJournalLine2."Journal Template Name");
                ReservationEntry.VALIDATE("Source Batch Name", ItemJournalLine2."Journal Batch Name");
                ReservationEntry.VALIDATE("Source Ref. No.", ItemJournalLine2."Line No.");
                ReservationEntry.VALIDATE("Shipment Date", ItemJournalLine2."Posting Date");
                ReservationEntry.VALIDATE("Serial No.", ReservationEntry2."Serial No.");
                ReservationEntry.VALIDATE("Suppressed Action Msg.", FALSE);
                ReservationEntry.VALIDATE("Planning Flexibility", ReservationEntry."Planning Flexibility"::Unlimited);
                ReservationEntry.VALIDATE("Lot No.", ReservationEntry2."Lot No.");
                ReservationEntry.Validate("Variant Code", ReservationEntry2."Variant Code");
                ReservationEntry.VALIDATE(Correction, FALSE);
                ReservationEntry.INSERT();
                EntryNum += 1;
            until ReservationEntry2.Next = 0;
        end;

    end;
}


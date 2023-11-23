pageextension 50025 ItemTrackingLiesExt extends "Item Tracking Lines"
{
    layout
    {
        addafter("Lot No.")
        {
            field("Vendor Lot No_B2B"; Rec."Vendor Lot No_B2B")
            {
                ApplicationArea = all;
                Caption = 'Vendor Lot No';
                ToolTip = 'Specifies the value of the Vendor Lot No field.';
            }


        }
        modify("Expiration Date")
        {
            Visible = true;
        }


    }

    actions
    {
        addafter("Create Customized SN")
        {
            action("Create Customized SN&Lot")
            {
                ApplicationArea = ItemTracking;
                Caption = 'Create Customized SN& Lot';
                Visible = FunctionsSupplyVisible;
                Image = CreateSerialNo;
                ToolTip = 'Automatically assign the required serial numbers based on a number series that you define.';

                trigger OnAction()
                begin
                    if InsertIsBlocked then
                        exit;
                    CreateCustomizedSNLotByPage();
                end;
            }
        }
    }


    local procedure CreateCustomizedSNLotByPage()
    var
        EnterCustomizedSN: Page "Enter Customized SN&Lot";
        QtyToCreate: Decimal;
        QtyToCreateInt: Integer;
        LotNoVar: Code[20];
        Increment: Integer;
        CreateLotNo: Boolean;
        CustomizedSN: Code[50];
        CreateSNInfo: Boolean;
    begin
        if ZeroLineExists() then
            Rec.Delete();

        QtyToCreate := UndefinedQtyArray[1] * QtySignFactor();
        if QtyToCreate < 0 then
            QtyToCreate := 0;

        if QtyToCreate mod 1 <> 0 then
            Error(Text008);

        QtyToCreateInt := QtyToCreate;
        //OnCreateCustomizedSNByPageOnAfterCalcQtyToCreate(Rec, QtyToCreate);

        Clear(EnterCustomizedSN);
        EnterCustomizedSN.SetFields(Rec."Item No.", Rec."Variant Code", QtyToCreate, false, false);
        if EnterCustomizedSN.RunModal() = ACTION::OK then begin
            //EnterCustomizedSN.GetFields(QtyToCreateInt, CreateLotNo, CustomizedSN, Increment, CreateSNInfo,LotNoVar);
            EnterCustomizedSN.GetFieldsNew(QtyToCreateInt, CreateLotNo, CustomizedSN, Increment, CreateSNInfo, LotNoVar);
            CreateCustomizedSNBatch(QtyToCreateInt, CreateLotNo, CustomizedSN, Increment, CreateSNInfo, LotNoVar);
        end;
        CalculateSums();
    end;

    local procedure CreateCustomizedSNBatch(QtyToCreate: Decimal; CreateLotNo: Boolean; CustomizedSN: Code[50]; Increment: Integer; CreateSNInfo: Boolean; LotNoPar: Code[20])
    var
        i: Integer;
        Counter: Integer;
    begin
        if IncStr(CustomizedSN) = '' then
            Error(StrSubstNo(UnincrementableStringErr, CustomizedSN));
        NoSeriesMgt.TestManual(Item."Serial Nos.");

        if QtyToCreate <= 0 then
            Error(Text009);
        if QtyToCreate mod 1 <> 0 then
            Error(Text008);

        /*if CreateLotNo then begin
            Rec.TestField("Lot No.", '');
            AssignNewLotNo();
            //OnAfterAssignNewTrackingNo(Rec, xRec, Rec.FieldNo("Lot No."));
        end;*/
        if LotNoPar <> '' then begin
            Rec.TestField("Lot No.", '');
            Rec.Validate("Lot No.", LotNoPar);
        end;

        for i := 1 to QtyToCreate do begin
            Rec.Validate("Quantity Handled (Base)", 0);
            Rec.Validate("Quantity Invoiced (Base)", 0);
            AssignNewCustomizedSerialNo(CustomizedSN);
            //OnAfterAssignNewTrackingNo(Rec, xRec, Rec.FieldNo("Serial No."));
            Rec.Validate("Quantity (Base)", QtySignFactor());
            Rec."Entry No." := NextEntryNo();
            if TestTempSpecificationExists() then
                Error('');
            Rec.Insert();
            //OnCreateCustomizedSNBatchOnAfterRecInsert(Rec, QtyToCreate);
            TempItemTrackLineInsert.TransferFields(Rec);
            TempItemTrackLineInsert.Insert();
            ItemTrackingDataCollection.UpdateTrackingDataSetWithChange(
              TempItemTrackLineInsert, CurrentSignFactor * SourceQuantityArray[1] < 0, CurrentSignFactor, 0);

            if CreateSNInfo then
                ItemTrackingMgt.CreateSerialNoInformation(Rec);

            if i < QtyToCreate then begin
                Counter := Increment;
                repeat
                    CustomizedSN := IncStr(CustomizedSN);
                    Counter := Counter - 1;
                until Counter <= 0;
            end;
        end;
        CalculateSums();
    end;

    local procedure AssignNewLotNo()
    var
        IsHandled: Boolean;
    begin
        //OnBeforeAssignNewLotNo(Rec, IsHandled, SourceTrackingSpecification);
        if IsHandled then
            exit;

        Item.TestField("Lot Nos.");
        Rec.Validate("Lot No.", NoSeriesMgt.GetNextNo(Item."Lot Nos.", WorkDate(), true));
    end;

    local procedure AssignNewCustomizedSerialNo(CustomizedSN: Code[50])
    var
        IsHandled: Boolean;
    begin
        //OnBeforeAssignNewCustomizedSerialNo(Rec, CustomizedSN, IsHandled);
        if IsHandled then
            exit;

        Rec.Validate("Serial No.", CustomizedSN);
    end;

    var
        Text008: Label 'The quantity to create must be an integer.';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text009: Label 'The quantity to create must be positive.';
        ItemTrackingMgt: Codeunit "Item Tracking Management";

        UnincrementableStringErr: Label 'The value in the %1 field must have a number so that we can assign the next number in the series.', Comment = '%1 = serial number';

}
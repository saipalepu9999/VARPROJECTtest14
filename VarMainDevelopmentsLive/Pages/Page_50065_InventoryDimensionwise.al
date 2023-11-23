page 50065 "Inventory Dimension wise"
{
    Caption = 'Inventory Dimension wise';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPlus;
    //SaveValues = true;
    SourceTable = Location;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                /*field(ShowInTransit; ShowInTransit)
                {
                    ApplicationArea = Location;
                    Caption = 'Show Items in Transit';
                    ToolTip = 'Specifies the items in transit between locations.';

                    trigger OnValidate()
                    begin
                        ShowInTransitOnAfterValidate;
                    end;
                }*/
                field(ShowColumnName; ShowColumnName)
                {
                    ApplicationArea = Location;
                    Caption = 'Show Column Name';
                    ToolTip = 'Specifies that the names of columns are shown in the matrix window.';

                    trigger OnValidate()
                    begin
                        ShowColumnNameOnAfterValidate;
                    end;
                }
                field(ItemNoGvar; ItemNoGvar)
                {
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the value of the ItemNoGvar field.';
                }
                field(FacilityCodeGvar; FacilityCodeGvar)
                {
                    ApplicationArea = all;
                    Caption = 'Division Code';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                    ToolTip = 'Specifies the value of the Facility Code field.';
                    trigger OnValidate()
                    begin
                        UpdateMatrixSubform();
                    end;
                }
                field(MATRIX_CaptionRange; MATRIX_CaptionRange)
                {
                    ApplicationArea = all;
                    Caption = 'Column Set';
                    Editable = false;
                    ToolTip = 'Specifies the range of values that are displayed in the matrix window, for example, the total period. To change the contents of the field, choose Next Set or Previous Set.';
                }
            }
            part(MatrixForm; "Invenotry Dimension Matrix")
            {
                ApplicationArea = Location;
                ShowFilter = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = Location;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction()
                begin
                    SetMatrixColumns("Matrix Page Step Type"::Previous);
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Location;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction()
                begin
                    SetMatrixColumns("Matrix Page Step Type"::Next);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        //TempMatrixLocation.GetLocationsIncludingUnspecifiedLocation(false, false);
    end;

    trigger OnOpenPage()
    begin
        SetMatrixColumns("Matrix Page Step Type"::Initial);
    end;

    var
        TempMatrixLocation: Record "Dimension Value" temporary;
        MatrixRecords: array[32] of Record "Dimension Value";
        MatrixRecordRef: RecordRef;
        ShowColumnName: Boolean;
        ShowInTransit: Boolean;
        MATRIX_CaptionSet: array[32] of Text[80];
        MATRIX_CaptionRange: Text;
        MATRIX_PKFirstRecInCurrSet: Text;
        MATRIX_CurrSetLength: Integer;
        UnspecifiedLocationCodeTxt: Label 'UNSPECIFIED', Comment = 'Code for unspecified location';
        ItemNoGvar: Code[20];
        FacilityCodeGvar: Code[20];


#if not CLEAN19
    [Obsolete('Replaced by SetMatrixType().', '19.0')]
    procedure SetColumns(SetType: Option)
    begin
        SetMatrixColumns("Matrix Page Step Type".FromInteger(SetType));
    end;
#endif

    procedure SetMatrixColumns(StepType: Enum "Matrix Page Step Type")
    var
        MatrixMgt: Codeunit "Matrix Management";
        CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
        DimValues: Record "Dimension Value";

    begin
        DimValues.Reset();
        DimValues.SetRange("Global Dimension No.", 2);
        if DimValues.FindSet() then
            repeat
                TempMatrixLocation.Init();
                TempMatrixLocation.TransferFields(DimValues);
                TempMatrixLocation.Insert();
            until DimValues.Next() = 0;
        SetTempMatrixLocationFilters();


        TempMatrixLocation.Reset();
        TempMatrixLocation.SetRange("Global Dimension No.", 2);
        TempMatrixLocation.FindSet();
        // OnSetColumnsOnAfterSetTempMatrixLocationFilters(TempMatrixLocation);

        Clear(MATRIX_CaptionSet);
        Clear(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecordRef.GetTable(TempMatrixLocation);
        MatrixRecordRef.SetTable(TempMatrixLocation);

        if ShowColumnName then
            CaptionFieldNo := TempMatrixLocation.FieldNo(Name)
        else
            CaptionFieldNo := TempMatrixLocation.FieldNo(Code);

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, StepType.AsInteger(), ArrayLen(MatrixRecords), CaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        if MATRIX_CaptionSet[1] = '' then begin
            MATRIX_CaptionSet[1] := UnspecifiedLocationCodeTxt;
            MATRIX_CaptionRange := StrSubstNo('%1%2', MATRIX_CaptionSet[1], MATRIX_CaptionRange);
        end;

        if MATRIX_CurrSetLength > 0 then begin
            TempMatrixLocation.SetPosition(MATRIX_PKFirstRecInCurrSet);
            TempMatrixLocation.Find;
            repeat
                MatrixRecords[CurrentMatrixRecordOrdinal].Copy(TempMatrixLocation);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (TempMatrixLocation.Next <> 1);
        end;

        // OnSetColumnsOnBeforeUpdateMatrixSubform(MATRIX_CaptionSet, MatrixRecords, TempMatrixLocation, MATRIX_CurrSetLength);
        UpdateMatrixSubform;
    end;

    local procedure SetTempMatrixLocationFilters()
    begin
        //TempMatrixLocation.SetRange("Use As In-Transit", ShowInTransit);
        //TempMatrixLocation.SetRange("Dimension Code", 'PROJECT');
        TempMatrixLocation.Reset();
        TempMatrixLocation.SetRange("Global Dimension No.", 2);
        TempMatrixLocation.FindSet();
        //TempMatrixLocation.setr
        //OnAfterSetTempMatrixLocationFilters(TempMatrixLocation);
    end;

    local procedure ShowColumnNameOnAfterValidate()
    begin
        SetMatrixColumns("Matrix Page Step Type"::Same);
    end;

    local procedure ShowInTransitOnAfterValidate()
    begin
        SetMatrixColumns("Matrix Page Step Type"::Initial);
    end;

    local procedure UpdateMatrixSubform()
    begin
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet, MatrixRecords, TempMatrixLocation, MATRIX_CurrSetLength, ItemNoGvar, FacilityCodeGvar);
        CurrPage.MatrixForm.PAGE.SetRecord(Rec);
        CurrPage.Update(false);
    end;

    procedure GetValues(ItemNoPar: Code[20])
    begin
        Clear(ItemNoGvar);
        ItemNoGvar := ItemNoPar;
    end;
}


report 50088 "QuantityExplosionofBOM"
//B2BDNROn21Apr2023>>
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Report\Layouts\QuantityExplosionofBOM.rdl';
    ApplicationArea = Manufacturing;
    Caption = 'Quantity Explosion of BOM Modified';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Search Description", "Inventory Posting Group";
            column(AsOfCalcDate; Text000 + Format(CalculateDate))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(ItemTableCaptionFilter; TableCaption + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; "No.")
            {
            }
            column(Desc_Item; Description)
            {
            }
            column(QtyExplosionofBOMCapt; QtyExplosionofBOMCaptLbl)
            {
            }
            column(CurrReportPageNoCapt; CurrReportPageNoCaptLbl)
            {
            }
            column(BOMQtyCaption; BOMQtyCaptionLbl)
            {
            }
            column(BomCompLevelQtyCapt; BomCompLevelQtyCaptLbl)
            {
            }
            column(BomCompLevelDescCapt; BomCompLevelDescCaptLbl)
            {
            }
            column(BomCompLevelNoCapt; BomCompLevelNoCaptLbl)
            {
            }
            column(LevelCapt; LevelCaptLbl)
            {
            }
            column(BomCompLevelUOMCodeCapt; BomCompLevelUOMCodeCaptLbl)
            {
            }
            column(ProductionOrderqtycap; ProductionOrderqtycap)
            {

            }
            column(Productionorderqty; Productionorderqty)
            { }
            column(CustNoGvar; CustNoGvar)
            { }
            column(CustNoLbl; CustNoLbl)
            { }
            column(DivisionCodeGvar; DivisionCodeGvar)
            { }
            column(DivisionLbl; DivisionLbl)
            { }
            column(ProjectCodeGvar; ProjectCodeGvar)
            { }
            column(ProjectLbl; ProjectLbl)
            { }
            column(BomNoGvar; BomNoGvar)
            { }
            column(BomNoLbl; BomNoLbl)
            { }
            column(RDProdGvar; RDProdGvar)
            { }
            column(IsoFormatNoGvar; IsoFormatNoGvar)
            { }
            column(IsoFormtCapLbl; IsoFormtCapLbl)
            { }
            column(DeliverableqtyGvar; DeliverableqtyGvar)
            { }
            column(DeliverableQtyLbl; DeliverableQtyLbl)
            { }
            column(DateLbl; DateLbl)
            { }
            column(UserIdLbl; UserIdLbl)
            { }
            column(RDProdLbl; RDProdLbl)
            { }
            column(RDProdQtyText; RDProdQtyText)
            { }
            column(RDBomText; RDBomText)
            { }
            column(CompanyInfo_Name; CompanyInfo.Name)
            { }
            dataitem(BOMLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem("Integer"; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    MaxIteration = 1;
                    column(BomCompLevelNo; BomComponent[Level]."No.")
                    {
                    }
                    column(BomCompLevelDesc; BomComponent[Level].Description)
                    {
                    }
                    column(BOMQty; BOMQty)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(FormatLevel; PadStr('', Level, ' ') + Format(Level))
                    {
                    }
                    column(BomCompLevelQty; BomComponent[Level].Quantity)
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(BomCompLevelUOMCode; BomComponent[Level]."Unit of Measure Code")
                    {
                    }
                    column(Productionorderqty1; Productionorderqty1)
                    {
                        DecimalPlaces = 0 : 5;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if Level = 1 then
                            ScrapBOMQTY := BomComponent[Level]."Scrap %";
                        BOMQty := (Quantity[Level] * QtyPerUnitOfMeasure * BomComponent[Level].Quantity);
                        //  if BomComponent[Level]."Scrap %" <> 0 then
                        BOMQty := BOMQty + ((BOMQty * ScrapBOMQTY) / 100);
                        Productionorderqty1 := BOMQty * Productionorderqty;
                    end;

                    trigger OnPostDataItem()
                    begin
                        Level := NextLevel;
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    BomItem: Record Item;
                begin
                    while BomComponent[Level].Next() = 0 do begin
                        Level := Level - 1;
                        if Level < 1 then
                            CurrReport.Break();
                    end;

                    NextLevel := Level;
                    Clear(CompItem);
                    QtyPerUnitOfMeasure := 1;
                    case BomComponent[Level].Type of
                        BomComponent[Level].Type::Item:
                            begin
                                CompItem.Get(BomComponent[Level]."No.");
                                if CompItem."Production BOM No." <> '' then begin
                                    ProdBOM.Get(CompItem."Production BOM No.");
                                    if ProdBOM.Status = ProdBOM.Status::Closed then
                                        CurrReport.Skip();
                                    NextLevel := Level + 1;
                                    if Level > 1 then
                                        if (NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1]) then
                                            Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                                    Clear(BomComponent[NextLevel]);
                                    Clear(ScrapBOMQTY);
                                    NoListType[NextLevel] := NoListType[NextLevel] ::Item;
                                    NoList[NextLevel] := CompItem."No.";
                                    VersionCode[NextLevel] :=
                                      VersionMgt.GetBOMVersion(CompItem."Production BOM No.", CalculateDate, true);
                                    BomComponent[NextLevel].SetRange("Production BOM No.", CompItem."Production BOM No.");
                                    BomComponent[NextLevel].SetRange("Version Code", VersionCode[NextLevel]);
                                    BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                                    BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                                end;
                                if Level > 1 then
                                    if BomComponent[Level - 1].Type = BomComponent[Level - 1].Type::Item then
                                        if BomItem.Get(BomComponent[Level - 1]."No.") then
                                            QtyPerUnitOfMeasure :=
                                              UOMMgt.GetQtyPerUnitOfMeasure(BomItem, BomComponent[Level - 1]."Unit of Measure Code") /
                                              UOMMgt.GetQtyPerUnitOfMeasure(
                                                BomItem, VersionMgt.GetBOMUnitOfMeasure(BomItem."Production BOM No.", VersionCode[Level]));
                            end;
                        BomComponent[Level].Type::"Production BOM":
                            begin
                                ProdBOM.Get(BomComponent[Level]."No.");
                                if ProdBOM.Status = ProdBOM.Status::Closed then
                                    CurrReport.Skip();
                                NextLevel := Level + 1;
                                if Level > 1 then
                                    if (NextLevel > 50) or (BomComponent[Level]."No." = NoList[Level - 1]) then
                                        Error(ProdBomErr, 50, Item."No.", NoList[Level], Level);
                                Clear(BomComponent[NextLevel]);
                                NoListType[NextLevel] := NoListType[NextLevel] ::"Production BOM";
                                NoList[NextLevel] := ProdBOM."No.";
                                VersionCode[NextLevel] := VersionMgt.GetBOMVersion(ProdBOM."No.", CalculateDate, true);
                                BomComponent[NextLevel].SetRange("Production BOM No.", NoList[NextLevel]);
                                BomComponent[NextLevel].SetRange("Version Code", VersionCode[NextLevel]);
                                BomComponent[NextLevel].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                                BomComponent[NextLevel].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                            end;
                    end;

                    if NextLevel <> Level then
                        Quantity[NextLevel] := BomComponent[NextLevel - 1].Quantity * QtyPerUnitOfMeasure * Quantity[Level];
                end;

                trigger OnPreDataItem()
                begin
                    Level := 1;

                    ProdBOM.Get(Item."Production BOM No.");

                    VersionCode[Level] := VersionMgt.GetBOMVersion(Item."Production BOM No.", CalculateDate, true);
                    Clear(BomComponent);
                    BomComponent[Level]."Production BOM No." := Item."Production BOM No.";
                    BomComponent[Level].SetRange("Production BOM No.", Item."Production BOM No.");
                    BomComponent[Level].SetRange("Version Code", VersionCode[Level]);
                    BomComponent[Level].SetFilter("Starting Date", '%1|..%2', 0D, CalculateDate);
                    BomComponent[Level].SetFilter("Ending Date", '%1|%2..', 0D, CalculateDate);
                    NoListType[Level] := NoListType[Level] ::Item;
                    NoList[Level] := Item."No.";
                    Quantity[Level] :=
                      UOMMgt.GetQtyPerUnitOfMeasure(Item, Item."Base Unit of Measure") /
                      UOMMgt.GetQtyPerUnitOfMeasure(
                        Item,
                        VersionMgt.GetBOMUnitOfMeasure(
                          Item."Production BOM No.", VersionCode[Level]));
                end;
            }

            trigger OnPreDataItem()
            begin
                ItemFilter := GetFilters();

                SetFilter("Production BOM No.", '<>%1', '');
                if BomNoGvar <> '' then
                    SetFilter("No.", BomNoGvar);
                CompanyInfo.get();
            end;

            trigger OnAfterGetRecord()
            begin
                RDProdQtyText := Format(RDProdGvar) + ' Qty';
                RDBomText := Format(RDProdGvar) + ' BOM';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(CalculateDate; CalculateDate)
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Calculation Date';
                        ToolTip = 'Specifies the date you want the program to calculate the quantity of the BOM lines.';
                    }
                    field(CustNoGvar; CustNoGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Customer No.';
                        TableRelation = Customer."No.";
                    }
                    field(DivisionCodeGvar; DivisionCodeGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Division Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
                    }
                    field(ProjectCodeGvar; ProjectCodeGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Project Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
                    }

                    field(BomNoGvar; BomNoGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Production BOM No';
                        TableRelation = "Production BOM Header"."No.";
                    }
                    field(IsoFormatNoGvar; IsoFormatNoGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'ISO Format No';
                    }
                    field(RDProdGvar; RDProdGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'R&D/Production QTY';
                    }
                    field(DeliverableqtyGvar; DeliverableqtyGvar)
                    {
                        ApplicationArea = all;
                        Caption = 'Deliverable QTY';
                    }
                    field(Productionorderqty; Productionorderqty)
                    {
                        ApplicationArea = All;
                        Caption = 'Production Order Quantity';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            CalculateDate := WorkDate();
        end;
    }

    labels
    {
    }

    var
        Text000: Label 'As of ';
        ProdBOM: Record "Production BOM Header";
        CompItem: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        ItemFilter: Text;
        CalculateDate: Date;
        NoList: array[99] of Code[20];
        VersionCode: array[99] of Code[20];
        Quantity: array[99] of Decimal;
        QtyPerUnitOfMeasure: Decimal;
        NextLevel: Integer;
        BOMQty: Decimal;
        QtyExplosionofBOMCaptLbl: Label 'Quantity Explosion of BOM';
        CurrReportPageNoCaptLbl: Label 'Page';
        BOMQtyCaptionLbl: Label 'Total Quantity';
        BomCompLevelQtyCaptLbl: Label 'BOM Quantity';
        BomCompLevelDescCaptLbl: Label 'Description';
        BomCompLevelNoCaptLbl: Label 'No.';
        LevelCaptLbl: Label 'Level';
        BomCompLevelUOMCodeCaptLbl: Label 'Unit of Measure Code';
        NoListType: array[99] of Option " ",Item,"Production BOM";
        ProdBomErr: Label 'The maximum number of BOM levels, %1, was exceeded. The process stopped at item number %2, BOM header number %3, BOM level %4.';
        Productionorderqty: Decimal;
        Productionorderqty1: Decimal;
        ProductionOrderqtycap: Label 'Production Order Quantity';

        //protected var
        BomComponent: array[99] of Record "Production BOM Line";
        Level: Integer;
        CustNoGvar: Code[20];
        CustNoLbl: Label 'Customer No.';
        DivisionCodeGvar: Code[20];
        DivisionLbl: Label 'Division Code';
        ProjectCodeGvar: Code[20];
        ProjectLbl: Label 'Project Code';
        BomNoGvar: Text;
        BomNoLbl: Label 'BOM NO';
        IsoFormatNoGvar: Text;
        IsoFormtCapLbl: Label 'Iso Format No.';
        RDProdLbl: Label 'R&D\ProductionQty';
        RDProdGvar: Option "R&D",Production;
        DeliverableqtyGvar: Decimal;
        DeliverableQtyLbl: Label 'Deliverable Qty';
        DateLbl: Label 'Date';
        UserIdLbl: Label 'VAR/USER ID';
        RDProdQtyText: Text;
        RDBomText: Text;
        CompanyInfo: Record "Company Information";
        ScrapBOMQTY: Decimal;//B2BPROn08May2023<<<


}  //B2BDNROn21Apr2023<<


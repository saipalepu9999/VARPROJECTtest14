page 50077 "Item Codification"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Item Code Generator';

    layout
    {
        area(Content)
        {
            group("Level-0")
            {
                field(Type1Value; Type1Value)
                {
                    ApplicationArea = all;
                    CaptionClass = Type1Caption;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Type1Value field.';

                    trigger OnDrillDown()
                    begin
                        Type1Value := LookupParameters(Type1Caption, '', Type1Description, '');
                    end;

                }
                field(Type1Description; Type1Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionClass = Type1Caption + ' Description';
                    ToolTip = 'Specifies the value of the Type1Description field.';
                }
            }
            group("Level-1")
            {
                field(Type2Value; Type2Value)
                {
                    ApplicationArea = all;
                    CaptionClass = Type2Caption;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Type2Value field.';

                    trigger OnDrillDown()
                    begin
                        Type2Value := LookupParameters(Type2Caption, '', Type2Description, '');
                    end;
                }
                field(Type2Description; Type2Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionClass = Type2Caption + ' Description';
                    ToolTip = 'Specifies the value of the Type2Description field.';
                }
            }
            group("Level-2")
            {
                field(Type3Value; Type3Value)
                {
                    ApplicationArea = all;
                    CaptionClass = Type3Caption;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Type3Value field.';
                    trigger OnDrillDown()
                    begin
                        Type3Value := LookupParameters(Type3Caption, Type2Value, Type3Description, '');
                    end;
                }
                field(Type3Description; Type3Description)
                {
                    ApplicationArea = all;
                    Editable = false;
                    CaptionClass = Type3Caption + ' Description';
                    ToolTip = 'Specifies the value of the Type3Description field.';
                }
            }
            group("Level-3")
            {
                field(Type4Value; Type4Value)
                {
                    ApplicationArea = all;
                    CaptionClass = Type4Caption;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Type4Value field.';
                    trigger OnDrillDown()
                    var
                        ItemParameters: Record "Item Parameters";
                    begin
                        Type4Value := LookupParameters(Type4Caption, Type3Value, Type4Description, Type2Value);
                        Clear(LotNoGvar);
                        ItemParameters.Reset();
                        ItemParameters.SetRange("Parameter Type", 5);
                        ItemParameters.SetRange("Parent Code New", Type2Value);
                        ItemParameters.SetRange("Parent Code", Type3Value);
                        ItemParameters.SetRange(Code, Type4Value);
                        if ItemParameters.FindFirst() then begin
                            LotNoGvar := ItemParameters."Lot Nos.";
                        end;
                    end;
                }
                field(Type4Description; Type4Description)
                {
                    ApplicationArea = all;
                    Editable = false;

                    CaptionClass = Type4Caption + ' Description';
                    ToolTip = 'Specifies the value of the Type4Description field.';
                }
            }
            group("Level-4")
            {

                field(DomesticCodeGvar; DomesticCodeGvar)
                {
                    ApplicationArea = all;
                    Caption = 'Domestic';
                    StyleExpr = StyleText;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Domestic field.';
                }
                field(EouCodeGvar; EouCodeGvar)
                {
                    ApplicationArea = all;
                    StyleExpr = StyleText;
                    Caption = 'Eou';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Eou field.';
                }

            }
            group("Mandatory Fields")
            {
                field(BlockedGvar; BlockedGvar)
                {
                    ApplicationArea = all;
                    Caption = 'Blocked';
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field(PlanningParametersRequiredGvar; PlanningParametersRequiredGvar)
                {
                    ApplicationArea = all;
                    Caption = 'PlanningParametersRequired';
                    ToolTip = 'Specifies the value of the PlanningParametersRequired field.';
                }
                field(DescriptionGvar; DescriptionGvar)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                }
                field(BaseUnitOfMeasure; BaseUnitOfMeasure)
                {
                    ApplicationArea = all;
                    Caption = 'Base Unit Of Measure';
                    TableRelation = "Unit of Measure";
                }
                field(ItemCategoryCodeGvar; ItemCategoryCodeGvar)
                {
                    ApplicationArea = all;
                    Caption = 'Item Category Code';
                    TableRelation = "Item Category";
                }
                field(GenProdPostingGroupGvar; GenProdPostingGroupGvar)
                {
                    ApplicationArea = all;
                    Caption = 'Gen Prod Posting Group-DOM';
                    TableRelation = "Gen. Product Posting Group";
                }
                field(GeneralProductpostingGroupGvar2; GeneralProductpostingGroupGvar2)
                {
                    ApplicationArea = all;
                    Caption = 'Gen Prod Posting Group-EOU';
                    TableRelation = "Gen. Product Posting Group";
                }
                field(VatProductPostingGroup; VatProductPostingGroup)
                {
                    ApplicationArea = all;
                    Caption = 'Vat Product Posting Group';
                    TableRelation = "VAT Product Posting Group";
                }
                field(InventoryPostingGroup; InventoryPostingGroup)
                {
                    ApplicationArea = all;
                    Caption = 'Inventory Posting Group';
                    TableRelation = "Inventory Posting Group";
                }
                field(ReplenishmentSystem; ReplenishmentSystem)
                {
                    ApplicationArea = all;
                    Caption = 'Relplinishment System';
                }
                field(ManufacturingPolicy; ManufacturingPolicy)
                {
                    ApplicationArea = all;
                    Caption = 'Manufacturing Policy';
                }
                field(LotNoGvar; LotNoGvar)
                {
                    ApplicationArea = all;
                    Caption = 'Item Tracking Codes';
                    Editable = false;
                    TableRelation = "Item Tracking Code";
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Create Item")
            {
                ApplicationArea = All;
                ToolTip = 'Executes the Create Item action.';

                trigger OnAction()
                var
                    FilterItem: Record Item;
                    FilterItem1: Record Item;
                    Item: Record Item;
                    ItemCode: Code[20];
                    ItemCode1: Code[20];
                    ZeroCount: Integer;
                    ZeroText: Text;
                    ZeroCount1: Integer;
                    ZeroText1: Text;
                    I: Integer;
                begin
                    if not Confirm('Do you want to generate Item ?', false) then
                        exit;
                    if ((Type1Value = '') or (Type2Value = '') or (Type3Value = '') or (Type4Value = '')  /*or (BlockedGvar = false)*/
                    or (DescriptionGvar = '') or (BaseUnitOfMeasure = '') or (ItemCategoryCodeGvar = '') or (GenProdPostingGroupGvar = '')
                    or (VatProductPostingGroup = '') or (InventoryPostingGroup = '') or (GeneralProductpostingGroupGvar2 = ''))

                    then
                        Error('Please select all levels & Fields');

                    //For Domestic >>
                    FilterItem.Reset();
                    FilterItem.SetCurrentKey("Parameter 5");
                    FilterItem.SetRange("Parameter 1", 'D');
                    FilterItem.SetRange("Parameter 2", Type2Value);
                    FilterItem.SetRange("Parameter 3", Type3Value);
                    FilterItem.SetRange("Parameter 4", Type4Value);
                    if FilterItem.FindLast() then begin
                        ZeroCount := 4 - StrLen(format(FilterItem."Parameter 5" + 1));
                        for I := 1 to ZeroCount do begin
                            ZeroText += '0';
                        end;
                        ItemCode := ('D' + Type2Value + Type3Value + Type4Value + '-')
                         + ZeroText + Format(FilterItem."Parameter 5" + 1)
                    end else
                        ItemCode := 'D' + Type2Value + Type3Value + Type4Value + '-' + '0001';
                    //Domestic <<



                    /* if Type1Value = 'D' then
                         Type1Value := 'E'
                     else
                         Type1Value := 'D';*/
                    //For Eou >>
                    FilterItem1.Reset();
                    FilterItem1.SetCurrentKey("Parameter 5");
                    FilterItem1.SetRange("Parameter 1", 'E');
                    FilterItem1.SetRange("Parameter 2", Type2Value);
                    FilterItem1.SetRange("Parameter 3", Type3Value);
                    FilterItem1.SetRange("Parameter 4", Type4Value);
                    if FilterItem1.FindLast() then begin
                        ZeroCount1 := 4 - StrLen(format(FilterItem."Parameter 5" + 1));
                        for I := 1 to ZeroCount1 do begin
                            ZeroText1 += '0';
                        end;
                        ItemCode1 := ('E' + Type2Value + Type3Value + Type4Value + '-')
                         + ZeroText1 + Format(FilterItem."Parameter 5" + 1)
                    end else
                        ItemCode1 := 'E' + Type2Value + Type3Value + Type4Value + '-' + '0001';
                    DomesticCodeGvar := ItemCode;
                    EouCodeGvar := ItemCode1;
                    if CopyStr(ItemCode, 2, StrLen(ItemCode)) <> CopyStr(ItemCode1, 2, StrLen(ItemCode1)) then begin
                        StyleText := 'UnFavorable';
                        Error('Domestic -%1 & Eou-%2 are not in sync.Check and Resolve', ItemCode, ItemCode1);
                    end;

                    Item.Init();
                    Item.Validate("No.", ItemCode);
                    Item.Validate("Parameter 1", 'D');
                    Item.Validate("Parameter 2", Type2Value);
                    Item.Validate("Parameter 3", Type3Value);
                    Item.Validate("Parameter 4", Type4Value);
                    Item.Validate("Parameter 5", FilterItem."Parameter 5" + 1);
                    Item."Item Family" := 'DOM' + '-->' + Type2Description + '-->' + Type3Description + '-->'
                                           + Type4Description;
                    Item.Insert(true);
                    Item.Validate(Blocked, BlockedGvar);
                    Item.Validate(PlanningParametersRequired_B2B, PlanningParametersRequiredGvar);
                    Item.Validate(Description, DescriptionGvar);
                    Item.Validate("Base Unit of Measure", BaseUnitOfMeasure);
                    Item.Validate("Item Category Code", ItemCategoryCodeGvar);
                    Item.Validate("Global Dimension 1 Code", 'DOM');
                    Item.Validate("Gen. Prod. Posting Group", GenProdPostingGroupGvar);
                    Item.Validate("VAT Prod. Posting Group", VatProductPostingGroup);
                    Item.Validate("Inventory Posting Group", InventoryPostingGroup);
                    if ReplenishmentSystem = ReplenishmentSystem::Assembly then
                        Item.Validate("Replenishment System", Item."Replenishment System"::Assembly)
                    else
                        if ReplenishmentSystem = ReplenishmentSystem::Purchase then
                            Item.Validate("Replenishment System", Item."Replenishment System"::Purchase)
                        else
                            if ReplenishmentSystem = ReplenishmentSystem::"Prod. Order" then
                                Item.Validate("Replenishment System", Item."Replenishment System"::"Prod. Order");
                    if ManufacturingPolicy = ManufacturingPolicy::"Make-To-Order" then
                        Item.Validate("Manufacturing Policy", Item."Manufacturing Policy"::"Make-to-Order")
                    else
                        Item.Validate("Manufacturing Policy", Item."Manufacturing Policy"::"Make-to-Stock");
                    Item.Validate("Item Tracking Code", LotNoGvar);
                    Item.Modify(true);
                    if ItemCode <> '' then
                        Message('Item %1 created Sucessully', ItemCode);

                    Item.Init();
                    Item.Validate("No.", ItemCode1);
                    Item.Validate("Parameter 1", 'E');
                    Item.Validate("Parameter 2", Type2Value);
                    Item.Validate("Parameter 3", Type3Value);
                    Item.Validate("Parameter 4", Type4Value);
                    Item.Validate("Parameter 5", FilterItem."Parameter 5" + 1);
                    Item."Item Family" := 'EOU' + '-->' + Type2Description + '-->' + Type3Description + '-->'
                                           + Type4Description;
                    Item.Insert(true);
                    Item.Validate(Blocked, BlockedGvar);
                    Item.Validate(PlanningParametersRequired_B2B, PlanningParametersRequiredGvar);
                    Item.Validate(Description, DescriptionGvar);
                    Item.Validate("Base Unit of Measure", BaseUnitOfMeasure);
                    Item.Validate("Item Category Code", ItemCategoryCodeGvar);
                    Item.Validate("Global Dimension 1 Code", 'EOU');
                    Item.Validate("Gen. Prod. Posting Group", GeneralProductpostingGroupGvar2);
                    Item.Validate("VAT Prod. Posting Group", VatProductPostingGroup);
                    Item.Validate("Inventory Posting Group", InventoryPostingGroup);
                    if ReplenishmentSystem = ReplenishmentSystem::Assembly then
                        Item.Validate("Replenishment System", Item."Replenishment System"::Assembly)
                    else
                        if ReplenishmentSystem = ReplenishmentSystem::Purchase then
                            Item.Validate("Replenishment System", Item."Replenishment System"::Purchase)
                        else
                            if ReplenishmentSystem = ReplenishmentSystem::"Prod. Order" then
                                Item.Validate("Replenishment System", Item."Replenishment System"::"Prod. Order");
                    if ManufacturingPolicy = ManufacturingPolicy::"Make-To-Order" then
                        Item.Validate("Manufacturing Policy", Item."Manufacturing Policy"::"Make-to-Order")
                    else
                        Item.Validate("Manufacturing Policy", Item."Manufacturing Policy"::"Make-to-Stock");
                    //Item.Validate(item, LotNoGvar);
                    Item.Validate("Item Tracking Code", LotNoGvar);
                    Item.Modify(true);
                    if ItemCode1 <> '' then
                        Message('Item %1 created Sucessully', ItemCode1);
                end;
            }
            action("Process Item Codes")
            {
                ApplicationArea = All;
                Image = Process;
                Visible = false;
                trigger OnAction()
                var
                    ItemCodification: Record "Item Parameters";
                    ItemCodification1: Record "Item Parameters";
                begin
                    //ItemCodification.Reset();
                    //if ItemCodification.FindSet() then
                    //    ItemCodification.DeleteAll();
                    ItemCodification.Reset();
                    ItemCodification.SetRange("Parameter Type", 5);
                    ItemCodification.SetFilter("Parent Code", '<>%1', '');
                    if ItemCodification.FindSet() then
                        repeat
                            ItemCodification1.Reset();
                            ItemCodification1.SetRange("Parameter Type", 4);
                            ItemCodification1.SetRange(Code, ItemCodification."Parent Code");
                            ItemCodification1.SetFilter("Parent Code", '<>%1', '');
                            if ItemCodification1.FindFirst() then begin
                                //if ItemCodification."Parent Code New" = '' then begin
                                ItemCodification."Parent Code New" := ItemCodification1."Parent Code";
                                ItemCodification.Modify();
                                // end;
                            end;
                        until ItemCodification.Next() = 0;
                    Message('Changes Updated Successfully');
                end;
            }
        }
    }

    var

        Type1Caption: Text;
        Type2Caption: Text;
        Type3Caption: Text;
        Type4Caption: Text;
        Type5Caption: Text;
        Type1Value: Text;
        Type2Value: Text;
        Type3Value: Text;
        Type4Value: Text;
        Type5Value: Text;
        Type1Description: text;
        Type1DescriptionCap: Text;
        Type2Description: text;
        Type2DescriptionCap: Text;
        Type3Description: text;
        Type3DescriptionCap: Text;
        Type4Description: text;
        Type4DescriptionCap: Text;
        Type5Description: text;
        Type5DescriptionCap: Text;
        BlockedGvar: Boolean;
        PlanningParametersRequiredGvar: Boolean;
        DomesticCodeGvar: Text;
        EouCodeGvar: Text;
        StyleText: Text;
        DescriptionGvar: text;
        BaseUnitOfMeasure: Code[20];
        ItemCategoryCodeGvar: Code[20];
        GenProdPostingGroupGvar: code[20];
        VatProductPostingGroup: Code[20];
        InventoryPostingGroup: code[20];
        ReplenishmentSystem: Option Purchase,"Prod. Order","Assembly";
        ManufacturingPolicy: Option "Make-To-Stock","Make-To-Order";
        LotNoGvar: Code[20];
        GeneralProductpostingGroupGvar2: Code[20];


    trigger OnOpenPage()
    var
        ItemParameters: Record "Item Parameters";
        UserSetup: Record "User Setup";
    begin
        if (UserSetup.Get(UserId)) and (not UserSetup."Items Access") then begin
            Error('You cannot access this page');
            CurrPage.Editable(false)
        end else
            CurrPage.Editable(true);
        ItemParameters.Reset();
        ItemParameters.SetCurrentKey("Coding Index");
        ItemParameters.SetFilter("Coding Index", '>%1', 1);
        if ItemParameters.FindSet() then begin
            repeat
                if Type1Caption = '' then
                    Type1Caption := ItemParameters.Code
                else
                    if Type2Caption = '' then
                        Type2Caption := ItemParameters.Code
                    else
                        if Type3Caption = '' then
                            Type3Caption := ItemParameters.Code
                        else
                            if Type4Caption = '' then
                                Type4Caption := ItemParameters.Code

            until ItemParameters.Next() = 0
        end;
    end;


    local procedure LookupParameters(Code: Code[20]; ParentCode: Code[20]; Var Description: Text; ParentCodeNew: Code[20]): Code[20]
    var
        ItemParameters: Record "Item Parameters";
        ItemParameters1: Record "Item Parameters";
    begin
        ItemParameters1.Reset();
        ItemParameters1.SetRange("Parameter Type", 1);
        ItemParameters1.SetRange(Code, Code);
        if ItemParameters1.FindFirst() then;

        ItemParameters.Reset();
        ItemParameters.SetRange("Parameter Type", ItemParameters1."Coding Index");
        ItemParameters.SetRange("Parent Code", ParentCode);
        if ParentCodeNew <> '' then
            ItemParameters.SetRange("Parent Code New", ParentCodeNew);
        if ItemParameters.FindSet() then begin
            if Page.RunModal(0, ItemParameters) = Action::LookupOK then begin
                Description := ItemParameters.Description;
                exit(ItemParameters.Code);
            end else begin
                Description := '';
                exit('');
            end;
        end;
    end;
}
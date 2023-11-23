pageextension 50072 "O365ActiviteisExt" extends "O365 Activities"
{
    layout
    {
        addafter("Incoming Documents")
        {
            cuegroup(Finance)
            {
                field(BGListGvar; BGListGvar)
                {
                    Caption = 'BG List';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the BGListGvar field.';
                    trigger OnDrillDown()
                    var
                        BGGrec: Record "Bank Guarantee";
                        BGList: Page "Bank Guarantee List";
                    begin
                        BGGrec.Reset();
                        if BGGrec.FindSet() then;
                        BGList.SetTableView(BGGrec);
                        BGList.RunModal();
                    end;
                }
                field(FDListGavr; FDListGavr)
                {
                    Caption = 'FD List';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the FDListGavr field.';
                    trigger OnDrillDown()
                    var
                        FDGrec: Record "Fixed Deposit_B2B";
                        FDList: Page FixedDepositList;
                    begin
                        FDGrec.Reset();
                        if FDGrec.FindSet() then;
                        FDList.SetTableView(FDGrec);
                        FDList.RunModal();
                    end;
                }
            }
            cuegroup(Indents)
            {
                Caption = 'Indents';
                field(OpenIndentGvar; OpenIndentGvar)
                {
                    Caption = 'Open Indents';
                    ApplicationArea = all;
                    DrillDown = true;
                    trigger OnDrillDown()
                    var
                        IndentHeader: Record "Indent Header";
                    begin
                        IndentHeader.Reset();
                        IndentHeader.SetRange("Indent Status", IndentHeader."Indent Status"::Indent);
                        if IndentHeader.FindSet() then begin
                            Page.RunModal(Page::"Indent List", IndentHeader);
                        end;
                    end;
                }
                field(CloseIndentGvar; CloseIndentGvar)
                {
                    Caption = 'Close Indent';
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        IndentHeader: Record "Indent Header";
                    begin
                        IndentHeader.Reset();
                        IndentHeader.SetRange("Indent Status", IndentHeader."Indent Status"::Close);
                        if IndentHeader.FindSet() then begin
                            Page.RunModal(Page::"Indent List", IndentHeader);
                        end;
                    end;
                }
            }
        }
    }

    actions
    {

    }
    trigger OnAfterGetRecord()
    var
        IndentHeader: Record "Indent Header";
    begin
        Clear(OpenIndentGvar);
        Clear(CloseIndentGvar);
        IndentHeader.Reset();
        IndentHeader.SetRange("Indent Status", IndentHeader."Indent Status"::Indent);
        if IndentHeader.FindSet() then begin
            OpenIndentGvar := IndentHeader.Count;
        end;

        IndentHeader.Reset();
        IndentHeader.SetRange("Indent Status", IndentHeader."Indent Status"::Close);
        if IndentHeader.FindSet() then begin
            CloseIndentGvar := IndentHeader.Count;
        end;
    end;

    var
        BGListGvar: Integer;
        FDListGavr: Integer;
        OpenIndentGvar: Integer;
        CloseIndentGvar: Integer;

    procedure FDListCount()
    var
        FDGrec: Record "Fixed Deposit_B2B";
    //FDList: Page FixedDepositList;
    begin
        FDGrec.Reset();
        if FDGrec.FindSet() then
            FDListGavr := FDGrec.Count();
        //FDList.SetTableView(FDGrec);
        //FDList.RunModal();
    end;

    procedure BGListCount()
    var
        BGGrec: Record "Bank Guarantee";
        BGList: Page "Bank Guarantee List";
    begin
        BGGrec.Reset();
        if BGGrec.FindSet() then;
        BGListGvar := BGGrec.Count;
    end;
}
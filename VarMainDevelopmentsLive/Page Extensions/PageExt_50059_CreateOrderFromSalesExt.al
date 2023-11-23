pageextension 50059 "CreateOrderFromSalesext" extends "Create Order From Sales"
{
    layout
    {
        modify(Status)
        {
            Visible = false;
        }
        modify(OrderType)
        {
            Visible = false;
        }
        addafter(OrderType)
        {
            field(StatusNew; CreateStatus)
            {
                ApplicationArea = Manufacturing;
                Caption = 'Prod. Order Status';
                ValuesAllowed = 0, 3;
                ToolTip = 'Specifies the value of the Prod. Order Status field.';
                trigger OnValidate()
                begin
                end;
            }
            field(OrderTypeNew; OrderType)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Order Type';
                ValuesAllowed = 0;
                ToolTip = 'Specifies the value of the Order Type field.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        CreateStatus := CreateStatus::Released;
        OrderStatus := CreateStatus;
    end;

    trigger OnClosePage()
    begin
        CreateStatus := CreateStatus::Released;
        OrderStatus := CreateStatus;
    end;

    procedure GetParametersNew(var NewStatus: Enum "Production Order Status"; var NewOrderType: Enum "Create Production Order Type")
    begin
        NewStatus := CreateStatus::Released;
        NewOrderType := OrderType::ItemOrder;
    end;

    var
        OrderStatus: Enum "Production Order Status";
        CreateStatus: Enum "Create Production Order Status";
        OrderType: Enum "Create Production Order Type";

}
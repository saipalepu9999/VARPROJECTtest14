codeunit 50006 ApprovalsCodeunit
{
    trigger OnRun()
    begin

    end;

    var



        //Gate Entry Variables Start >>
        GATEsendforapprovaleventdesctxt: Label 'Approval of a Gate entry document is requested';
        GATErequestcanceleventdescTxt: Label 'Approval of a Gate Entry document is Cancelled';
        GATECategoryTxt: Label 'Gate Entry';
        GATECategoryDescTxt: Label 'GATEDocuments';
        GATEDocOCRWorkflowCodeTxt: Label 'Gate Entry';
        GATEApprWorkflowDescTxt: Label 'Gate Entry';
        GATETypeCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="GATE">%1</DataItem></DataItems></ReportParameters>';
        //Gate Entry Variables End

        //B2BJk  Start Variables for Routing
        RoutingsendforapprovaleventdescTxt: Label 'Approval of a Routing Document is requested';
        RoutingCategoryDescTxt: Label 'RoutingDocuments';
        RoutingTypeCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=Routing>%1</DataItem></DataItems></ReportParameters>';
        RoutingrequestcanceleventdescTxt: Label 'Approval of a Routing Document is Cancelled';
        RoutingCategoryTxt: Label 'RoutingSpecifications';
        RoutingDocOCRWorkflowCodeTxt: Label 'Routing';
        RoutingApprWorkflowDescTxt: Label 'Routing Approval Workflow';

        //B2BJk  End Variables for Routing

        //B2BJk  Start Variables for ProductionBom
        ProductionBomsendforapprovaleventdescTxt: Label 'Approval of a ProductionBom Document is requested';
        ProductionBomCategoryDescTxt: Label 'ProductionBomDocuments';
        ProductionBomTypeCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=ProductionBom>%1</DataItem></DataItems></ReportParameters>';
        ProductionBomrequestcanceleventdescTxt: Label 'Approval of a ProductionBom Document is Cancelled';
        ProductionBomCategoryTxt: Label 'ProductionBomSpecifications';
        ProductionBomDocOCRWorkflowCodeTxt: Label 'ProductionBom';
        ProductionBomApprWorkflowDescTxt: Label 'ProductionBom Approval Workflow';
        //B2BJk  End Variables for ProductionBom
        //B2BJk  Start Variables for Specification
        SpecificationsendforapprovaleventdescTxt: Label 'Approval of a Specification Document is requested';
        SpecificationCategoryDescTxt: Label 'SpecificationDocuments';
        SpecificationTypeCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=Specification>%1</DataItem></DataItems></ReportParameters>';
        SpecificationrequestcanceleventdescTxt: Label 'Approval of a Specification Document is Cancelled';
        SpecificationCategoryTxt: Label 'SpecificationHeaderSpecifications';
        SpecificationDocOCRWorkflowCodeTxt: Label 'Specification';
        SpecificationApprWorkflowDescTxt: Label 'Specification Approval Workflow';
        //B2BJk  End Variables for Specification

        //B2BJk  Start Variables for Indent
        IndentsendforapprovaleventdescTxt: Label 'Approval of a Indent Document is requested';
        IndentCategoryDescTxt: Label 'IndentDocuments';
        IndentTypeCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=Indent>%1</DataItem></DataItems></ReportParameters>';
        IndentrequestcanceleventdescTxt: Label 'Approval of a Indent Document is Cancelled';
        IndentCategoryTxt: Label 'IndentHeaderDocument';
        IndentDocOCRWorkflowCodeTxt: Label 'Indent';
        IndentApprWorkflowDescTxt: Label 'Indent Approval Workflow';
        //B2BJK End Variables For Indent

        //B2BJk  Start Variables for PurchasePrice
        PurchasePricesendforapprovaleventdescTxt: Label 'Approval of a PurchasePrice Document is requested';
        PurchasePriceCategoryDescTxt: Label 'PurchasePriceDocuments';
        PurchasePriceTypeCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=PurchasePrice>%1</DataItem></DataItems></ReportParameters>';
        PurchasePricerequestcanceleventdescTxt: Label 'Approval of a PurchasePrice Document is Cancelled';
        PurchasePriceCategoryTxt: Label 'PurchasePriceDocument';
        PurchasePriceDocOCRWorkflowCodeTxt: Label 'PurchasePrice';
        PurchasePriceApprWorkflowDescTxt: Label 'PurchasePrice Approval Workflow';
        //B2BJk  End Variables for PurchasePrice
        //B2BJk  Start Variables for TransferOrder
        TransferOrdersendforapprovaleventdescTxt: Label 'Approval of a Transfer Order Document is requested';
        TransferOrderCategoryDescTxt: Label 'TransferOrderDocuments';
        TransferOrderTypeCondnTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name=TransferOrder>%1</DataItem></DataItems></ReportParameters>';
        TransferOrderrequestcanceleventdescTxt: Label 'Approval of a Transfer Order Document is Cancelled';
        TransferOrderCategoryTxt: Label 'TransferOrderHeaderDocument';
        TransferOrderDocOCRWorkflowCodeTxt: Label 'Transfer Order';
        TransferOrderApprWorkflowDescTxt: Label 'Transfer Order Approval Workflow';
        //B2BJK End Variables For TransferOrder
        //B2BJk  End Variables for Indent
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowevenHandling: Codeunit "Workflow Event Handling";
        workflowsetup: codeunit "Workflow Setup";
        NoworkfloweableErr: Label 'No Approval workflow for this record type is enabled.';
    //Approvals For Item Start >>

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnpopulateApprovalEntryArgument', '', true, true)]
    local procedure OnpopulateApprovalEntriesArgumentItem(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Item: Record Item;
        CustomerRec: Record Customer;
        VendorRec: Record Vendor;
    begin
        case RecRef.Number() of
            Database::Item:
                begin
                    RecRef.SetTable(Item);
                    ApprovalEntryArgument."Document No." := FORMAT(Item."No.");
                end;
            Database::Customer:
                begin
                    RecRef.SetTable(CustomerRec);
                    ApprovalEntryArgument."Document No." := FORMAT(CustomerRec."No.");
                end;
            Database::Vendor:
                begin
                    RecRef.SetTable(VendorRec);
                    ApprovalEntryArgument."Document No." := FORMAT(VendorRec."No.");
                end;
        end;
    end;

    //Handling workflow response

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onopendocument', '', true, true)]
    local procedure OnopendocumentItem(RecRef: RecordRef; var Handled: boolean)
    var
        Item: Record Item;
        CustomerRec: Record Customer;
        VendorRec: Record Vendor;
    begin
        case RecRef.Number() of
            Database::Item:
                begin
                    RecRef.SetTable(Item);
                    Item."Approval Status_B2B" := Item."Approval Status_B2B"::Open;
                    Item.Blocked := true;
                    Item.Modify();
                    Handled := true;
                end;
            Database::Customer:
                begin
                    RecRef.SetTable(CustomerRec);
                    CustomerRec."Approval Status_B2B" := CustomerRec."Approval Status_B2B"::Open;
                    CustomerRec.Blocked := CustomerRec.Blocked::All;
                    CustomerRec.Modify();
                    Handled := true;
                end;
            Database::Vendor:
                begin
                    RecRef.SetTable(VendorRec);
                    VendorRec."Approval Status_B2B" := VendorRec."Approval Status_B2B"::Open;
                    VendorRec.Blocked := VendorRec.Blocked::All;
                    VendorRec.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnreleaseDocument', '', true, true)]
    local procedure OnReleasedocumentItem(RecRef: RecordRef; var Handled: boolean)
    var
        Item: Record Item;
        CustomerRec: Record Customer;
        VendorRec: Record Vendor;
    begin
        case RecRef.Number() of
            Database::Item:
                begin
                    RecRef.SetTable(Item);
                    Item."Approval Status_B2B" := Item."Approval Status_B2B"::Released;
                    Item.Blocked := false;
                    Item.Modify();
                    Handled := true;
                end;
            Database::Customer:
                begin
                    RecRef.SetTable(CustomerRec);
                    CustomerRec."Approval Status_B2B" := CustomerRec."Approval Status_B2B"::Released;
                    CustomerRec.Blocked := CustomerRec.Blocked::" ";
                    CustomerRec.Modify();
                    Handled := true;
                end;
            Database::Vendor:
                begin
                    RecRef.SetTable(VendorRec);
                    VendorRec."Approval Status_B2B" := VendorRec."Approval Status_B2B"::Released;
                    VendorRec.Blocked := VendorRec.Blocked::" ";
                    VendorRec.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'Onsetstatustopendingapproval', '', true, true)]
    local procedure OnSetstatusToPendingApprovalItem(RecRef: RecordRef; var IsHandled: boolean)
    var
        Item: Record Item;
        CustomerRec: Record Customer;
        VendorRec: Record Vendor;
    begin
        case RecRef.Number() of
            Database::Item:
                begin
                    RecRef.SetTable(Item);
                    Item."Approval Status_B2B" := Item."Approval Status_B2B"::"Pending for Approval";
                    Item.Modify();
                    IsHandled := true;
                end;
            Database::Customer:
                begin
                    RecRef.SetTable(CustomerRec);
                    CustomerRec."Approval Status_B2B" := CustomerRec."Approval Status_B2B"::"Pending for Approval";
                    //CustomerRec.Blocked := CustomerRec.Blocked::" ";
                    CustomerRec.Modify();
                    IsHandled := true;
                end;
            Database::Vendor:
                begin
                    RecRef.SetTable(VendorRec);
                    VendorRec."Approval Status_B2B" := VendorRec."Approval Status_B2B"::"Pending for Approval";
                    //VendorRec.Blocked := VendorRec.Blocked::" ";
                    VendorRec.Modify();
                    IsHandled := true;
                end;
        end;
    end;
    //Approvals For Item End <<


    /*// Approvals For Gate Entry Start  >>
    [IntegrationEvent(false, false)]
    Procedure OnSendGATEForApproval(var GATE: Record "Gate Entry Header_B2B")
    begin
    end;

    [IntegrationEvent(false, false)]
    Procedure OnCancelGATEForApproval(var GATE: Record "Gate Entry Header_B2B")
    begin
    end;

    //Create events for workflow

    procedure RunworkflowOnSendGATEforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('RunworkflowOnSendGATEforApproval'), 1, 128));
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OnSendGATEForApproval', '', false, false)]
    local procedure RunworkflowonsendGATEForApproval(var GATE: Record "Gate Entry Header_B2B")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendGATEforApprovalCode(), GATE);
    end;

    procedure RunworkflowOnCancelGATEforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('OnCancelGATEForApproval'), 1, 128));
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OncancelGATEForApproval', '', false, false)]

    local procedure RunworkflowonCancelGATEForApproval(var GATE: Record "Gate Entry Header_B2B")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOncancelGATEforApprovalCode(), GATE);
    end;

    //Add events to library

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibraryGATE();
    begin
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnSendGATEforApprovalCode(), DATABASE::"Gate Entry Header_B2B",
          CopyStr(GATEsendforapprovaleventdesctxt, 1, 250), 0, FALSE);
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnCancelGATEforApprovalCode(), DATABASE::"Gate Entry Header_B2B",
          CopyStr(GATErequestcanceleventdesctxt, 1, 250), 0, FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddworkfloweventprodecessorstolibraryGATE(EventFunctionName: code[128]);
    begin
        case EventFunctionName of
            RunworkflowOnCancelGATEforApprovalCode():
                WorkflowevenHandling.AddEventPredecessor(RunworkflowOnCancelGATEforApprovalCode(), RunworkflowOnSendGATEforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendGATEforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendGATEforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendGATEforApprovalCode());
        end;
    end;

    procedure ISGATEWorkflowenabled(var GATE: Record "Gate Entry Header_B2B"): Boolean
    begin
        if GATE."Approval Status" <> GATE."Approval Status"::open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(GATE, RunworkflowOnSendGATEforApprovalCode()));
    end;

    Procedure CheckGATEApprovalsWorkflowEnabled(var GATE: Record "Gate Entry Header_B2B"): Boolean
    begin
        IF not ISGATEworkflowenabled(GATE) then
            Error((NoworkfloweableErr));
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnpopulateApprovalEntryArgument', '', false, false)]
    local procedure OnpopulateApprovalEntriesArgumentGATE(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GATE: Record "Gate Entry Header_B2B";
    begin
        case RecRef.Number() of
            Database::"Gate Entry Header_B2B":
                begin
                    RecRef.SetTable(GATE);
                    ApprovalEntryArgument."Document No." := FORMAT(GATE."No.");
                end;
        end;
    end;

    //Handling workflow response

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onopendocument', '', false, false)]
    local procedure OnopendocumentGATE(RecRef: RecordRef; var Handled: boolean)
    var
        GATE: Record "Gate Entry Header_B2B";
    begin
        case RecRef.Number() of
            Database::"Gate Entry Header_B2B":
                begin
                    RecRef.SetTable(GATE);
                    GATE."Approval Status" := GATE."Approval Status"::open;
                    GATE.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnreleaseDocument', '', false, false)]
    local procedure OnReleasedocumentGATE(RecRef: RecordRef; var Handled: boolean)
    var
        GATE: Record "Gate Entry Header_B2B";
    begin
        case RecRef.Number() of
            Database::"Gate Entry Header_B2B":
                begin
                    RecRef.SetTable(GATE);
                    GATE."Approval Status" := GATE."Approval Status"::Released;
                    GATE.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'Onsetstatustopendingapproval', '', false, false)]
    local procedure OnSetstatusToPendingApprovalGATE(RecRef: RecordRef; var IsHandled: boolean)
    var
        GATE: Record "Gate Entry Header_B2B";
    begin
        case RecRef.Number() of
            Database::"Gate Entry Header_B2B":
                begin
                    RecRef.SetTable(GATE);
                    GATE."Approval Status" := GATE."Approval Status"::"Pending for Approval";
                    GATE.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onaddworkflowresponsepredecessorstolibrary', '', false, false)]
    local procedure OnaddworkflowresponseprodecessorstolibraryGATE(ResponseFunctionName: Code[128])
    var
        workflowresponsehandling: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            workflowresponsehandling.SetStatusToPendingApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SetStatusToPendingApprovalCode(), RunworkflowOnSendGATEforApprovalCode());
            workflowresponsehandling.SendApprovalRequestForApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SendApprovalRequestForApprovalCode(), RunworkflowOnSendGATEforApprovalCode());
            workflowresponsehandling.CancelAllApprovalRequestsCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.CancelAllApprovalRequestsCode(), RunworkflowOnCancelGATEforApprovalCode());
            workflowresponsehandling.OpenDocumentCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.OpenDocumentCode(), RunworkflowOnCancelGATEforApprovalCode());
        end;
    end;

    //Setup workflow

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddworkflowcategoriestolibrary', '', false, false)]
    local procedure OnaddworkflowCategoryTolibraryGATE()
    begin
        workflowsetup.InsertWorkflowCategory(CopyStr(GATECategoryTxt, 1, 20), CopyStr(GATECategoryDescTxt, 1, 100));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Onafterinsertapprovalstablerelations', '', false, false)]
    local procedure OnInsertApprovaltablerelationsGATE()
    Var
        ApprovalEntry: record "Approval Entry";
    begin
        workflowsetup.InsertTableRelation(Database::"Gate Entry Header_B2B", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Oninsertworkflowtemplates', '', false, false)]
    local procedure OnInsertworkflowtemplateGATE()
    begin
        InsertGATEApprovalworkflowtemplate();
    end;


    local procedure InsertGATEApprovalworkflowtemplate();
    var
        workflow: record Workflow;
    begin
        workflowsetup.InsertWorkflowTemplate(workflow, CopyStr(GATEDocOCRWorkflowCodeTxt, 1, 17), CopyStr(GATEApprWorkflowDescTxt, 1, 100), CopyStr(GATECategoryTxt, 1, 20));
        InsertGATEApprovalworkflowDetails(workflow);
        workflowsetup.MarkWorkflowAsTemplate(workflow);
    end;

    local procedure InsertGATEApprovalworkflowDetails(var workflow: record Workflow);
    var
        GATE: Record "Gate Entry Header_B2B";
        workflowstepargument: record "Workflow Step Argument";
        Blankdateformula: DateFormula;
    begin
        workflowsetup.InitWorkflowStepArgument(workflowstepargument, workflowstepargument."Approver Type"::Approver, workflowstepargument."Approver Limit Type"::"Direct Approver", 0, '', Blankdateformula, true);

        //workflowsetup.InsertDocApprovalWorkflowSteps(workflow, BuildSCLtypecondition(GATE."Approval Status"::open), RunworkflowOnSendGATEforApprovalCode(), BuildGATEtypecondition(GATE."Approval Status"::"Pending for Approval"), RunworkflowOnCancelGATEforApprovalCode(), workflowstepargument, true);
    end;


    local procedure BuildGATEtypecondition(status: integer): Text
    var
        GATE: Record "Gate Entry Header_B2B";
    Begin
        GATE.SetRange("Approval Status", Status);
        exit(StrSubstNo(GATETypeCondnTxt, workflowsetup.Encode(GATE.GetView(false))));
    End;

    //Access record from the approval request page

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'Onaftergetpageid', '', false, false)]
    local procedure OnaftergetpageidGATE(RecordRef: RecordRef; var PageID: Integer)
    begin
        If RecordRef.Number() = database::"Gate Entry Header_B2B" then
            PageID := GetConditionalcardPageidGATE(RecordRef)
    end;

    local procedure GetConditionalcardPageidGATE(RecordRef: RecordRef): Integer
    begin
        Case RecordRef.Number() of
            database::"Gate Entry Header_B2B":
                exit(page::"Inward Gate Entry-NRGP"
                );
        end;
    end;

    //Approval for GateEntry Process <<
    */

    //B2BJK Start
    //Add QC Routing Approval Start >>

    [IntegrationEvent(false, false)]
    Procedure OnSendRoutingForApproval(var Routing: Record "Routing Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    Procedure OnCancelRoutingForApproval(var Routing: Record "Routing Header")
    begin
    end;

    //Create events for workflow
    procedure RunworkflowOnSendRoutingforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('RunworkflowOnSendRoutingforApproval'), 1, 128));
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OnSendRoutingForApproval', '', true, true)]
    local procedure RunworkflowonsendRoutingForApproval(var Routing: Record "Routing Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendRoutingforApprovalCode(), Routing);
    end;

    procedure RunworkflowOnCancelRoutingforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('OnCancelRoutingForApproval'), 1, 128));
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OncancelRoutingForApproval', '', true, true)]

    local procedure RunworkflowonCancelRoutingForApproval(var Routing: Record "Routing Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOncancelRoutingforApprovalCode(), Routing);
    end;

    //Add events to library

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibraryRouting();
    begin
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnSendRoutingforApprovalCode(), DATABASE::"Routing Header",
          CopyStr(Routingsendforapprovaleventdesctxt, 1, 250), 0, FALSE);
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnCancelRoutingforApprovalCode(), DATABASE::"Routing Header",
          CopyStr(Routingrequestcanceleventdesctxt, 1, 250), 0, FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddworkfloweventprodecessorstolibraryRouting(EventFunctionName: code[128]);
    begin
        case EventFunctionName of
            RunworkflowOnCancelRoutingforApprovalCode():
                WorkflowevenHandling.AddEventPredecessor(RunworkflowOnCancelRoutingforApprovalCode(), RunworkflowOnSendRoutingforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendRoutingforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendRoutingforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendRoutingforApprovalCode());
        end;
    end;

    procedure ISRoutingworkflowenabled(var Routing: Record "Routing Header"): Boolean
    begin
        if Routing.Status <> Routing.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(Routing, RunworkflowOnSendRoutingforApprovalCode()));
    end;

    Procedure CheckRoutingApprovalsWorkflowEnabled(var Routing: Record "Routing Header"): Boolean
    begin
        IF not ISRoutingworkflowenabled(Routing) then
            Error((NoworkfloweableErr));
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnpopulateApprovalEntryArgument', '', true, true)]
    local procedure OnpopulateApprovalEntriesArgumentRouting(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Routing: Record "Routing Header";
    begin
        case RecRef.Number() of
            Database::"Routing Header":
                begin
                    RecRef.SetTable(Routing);
                    ApprovalEntryArgument."Document No." := FORMAT(Routing."No.");
                end;
        end;
    end;

    //Handling workflow response

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onopendocument', '', true, true)]
    local procedure OnopendocumentRouting(RecRef: RecordRef; var Handled: boolean)
    var
        Routing: Record "Routing Header";
    begin
        case RecRef.Number() of
            Database::"Routing Header":
                begin
                    RecRef.SetTable(Routing);
                    Routing.Validate(Status, Routing.Status::New);
                    Routing.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnreleaseDocument', '', true, true)]
    local procedure OnReleasedocumentRouting(RecRef: RecordRef; var Handled: boolean)
    var
        Routing: Record "Routing Header";
    begin
        case RecRef.Number() of
            Database::"Routing Header":
                begin
                    RecRef.SetTable(Routing);
                    Routing.Validate(Status, Routing.Status::Certified);
                    Routing.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'Onsetstatustopendingapproval', '', true, true)]
    local procedure OnSetstatusToPendingApprovalRouting(RecRef: RecordRef; var IsHandled: boolean)
    var
        Routing: Record "Routing Header";
    begin
        case RecRef.Number() of
            Database::"Routing Header":
                begin
                    RecRef.SetTable(Routing);
                    Routing.Validate(Status, Routing.Status::"Under Development");
                    Routing.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onaddworkflowresponsepredecessorstolibrary', '', true, true)]
    local procedure OnaddworkflowresponseprodecessorstolibraryRouting(ResponseFunctionName: Code[128])
    var
        workflowresponsehandling: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            workflowresponsehandling.SetStatusToPendingApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SetStatusToPendingApprovalCode(), RunworkflowOnSendRoutingforApprovalCode());
            workflowresponsehandling.SendApprovalRequestForApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SendApprovalRequestForApprovalCode(), RunworkflowOnSendRoutingforApprovalCode());
            workflowresponsehandling.CancelAllApprovalRequestsCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.CancelAllApprovalRequestsCode(), RunworkflowOnCancelRoutingforApprovalCode());
            workflowresponsehandling.OpenDocumentCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.OpenDocumentCode(), RunworkflowOnCancelRoutingforApprovalCode());
        end;
    end;

    //Setup workflow

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddworkflowcategoriestolibrary', '', true, true)]
    local procedure OnaddworkflowCategoryTolibraryRouting()
    begin
        workflowsetup.InsertWorkflowCategory(CopyStr(RoutingCategoryTxt, 1, 20), CopyStr(RoutingCategoryDescTxt, 1, 100));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Onafterinsertapprovalstablerelations', '', true, true)]
    local procedure OnInsertApprovaltablerelationsRouting()
    Var
        ApprovalEntry: record "Approval Entry";
    begin
        workflowsetup.InsertTableRelation(Database::"Routing Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Oninsertworkflowtemplates', '', true, true)]
    local procedure OnInsertworkflowtemplateRouting()
    begin
        InsertRoutingApprovalworkflowtemplate();
    end;



    local procedure InsertRoutingApprovalworkflowtemplate();
    var
        workflow: record Workflow;
    begin
        workflowsetup.InsertWorkflowTemplate(workflow, CopyStr(RoutingDocOCRWorkflowCodeTxt, 1, 17), CopyStr(RoutingApprWorkflowDescTxt, 1, 100), CopyStr(RoutingCategoryTxt, 1, 20));
        InsertRoutingApprovalworkflowDetails(workflow);
        workflowsetup.MarkWorkflowAsTemplate(workflow);
    end;

    local procedure InsertRoutingApprovalworkflowDetails(var workflow: record Workflow);
    var
        Routing: Record "Routing Header";
        workflowstepargument: record "Workflow Step Argument";
        Blankdateformula: DateFormula;
    begin
        workflowsetup.InitWorkflowStepArgument(workflowstepargument, workflowstepargument."Approver Type"::Approver, workflowstepargument."Approver Limit Type"::"Direct Approver", 0, '', Blankdateformula, true);

        workflowsetup.InsertDocApprovalWorkflowSteps(workflow, BuildRoutingtypecondition(Routing.Status::New.AsInteger()), RunworkflowOnSendRoutingforApprovalCode(), BuildRoutingtypecondition(Routing.Status::"Under Development".AsInteger()), RunworkflowOnCancelRoutingforApprovalCode(), workflowstepargument, true);
    end;


    local procedure BuildRoutingtypecondition(status: integer): Text
    var
        Routing: Record "Routing Header";
    Begin
        Routing.SetRange(Status, status);
        exit(StrSubstNo(RoutingTypeCondnTxt, workflowsetup.Encode(Routing.GetView(false))));
    End;

    //Access record from the approval request page

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'Onaftergetpageid', '', true, true)]
    local procedure OnaftergetpageidRouting(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalcardPageidRouting(RecordRef)
    end;

    local procedure GetConditionalcardPageidRouting(RecordRef: RecordRef): Integer
    begin
        Case RecordRef.Number() of
            database::"Routing Header":
                exit(page::Routing);
        end;
    end;
    //Add QC Routing Approval End  <<
    //B2BJK  End


    //B2BJK Start
    //Add  ProductionBom Approval Start >>

    [IntegrationEvent(false, false)]
    Procedure OnSendProductionBomForApproval(var ProductionBom: Record "Production BOM Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    Procedure OnCancelProductionBomForApproval(var ProductionBom: Record "Production BOM Header")
    begin
    end;

    //Create events for workflow
    procedure RunworkflowOnSendProductionBomforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('RunworkflowOnSendProductionBomforApproval'), 1, 128));
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OnSendProductionBomForApproval', '', true, true)]
    local procedure RunworkflowonsendProductionBomForApproval(var ProductionBom: Record "Production BOM Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendProductionBomforApprovalCode(), ProductionBom);
    end;

    procedure RunworkflowOnCancelProductionBomforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('OnCancelProductionBomForApproval'), 1, 128));
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OncancelProductionBomForApproval', '', true, true)]

    local procedure RunworkflowonCancelProductionBomForApproval(var ProductionBom: Record "Production BOM Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOncancelProductionBomforApprovalCode(), ProductionBom);
    end;

    //Add events to library

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibraryProductionBom();
    begin
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnSendProductionBomforApprovalCode(), DATABASE::"Production BOM Header",
          CopyStr(ProductionBomsendforapprovaleventdesctxt, 1, 250), 0, FALSE);
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnCancelProductionBomforApprovalCode(), DATABASE::"Production BOM Header",
          CopyStr(ProductionBomrequestcanceleventdesctxt, 1, 250), 0, FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddworkfloweventprodecessorstolibraryProductionBom(EventFunctionName: code[128]);
    begin
        case EventFunctionName of
            RunworkflowOnCancelProductionBomforApprovalCode():
                WorkflowevenHandling.AddEventPredecessor(RunworkflowOnCancelProductionBomforApprovalCode(), RunworkflowOnSendProductionBomforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendProductionBomforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendProductionBomforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendProductionBomforApprovalCode());
        end;
    end;

    procedure ISProductionBomworkflowenabled(var ProductionBom: Record "Production BOM Header"): Boolean
    begin
        if ProductionBom.Status <> ProductionBom.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(ProductionBom, RunworkflowOnSendProductionBomforApprovalCode()));
    end;

    Procedure CheckProductionBomApprovalsWorkflowEnabled(var ProductionBom: Record "Production BOM Header"): Boolean
    begin
        IF not ISProductionBomworkflowenabled(ProductionBom) then
            Error((NoworkfloweableErr));
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnpopulateApprovalEntryArgument', '', true, true)]
    local procedure OnpopulateApprovalEntriesArgumentProductionBom(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ProductionBom: Record "Production BOM Header";
    begin
        case RecRef.Number() of
            Database::"Production BOM Header":
                begin
                    RecRef.SetTable(ProductionBom);
                    ApprovalEntryArgument."Document No." := FORMAT(ProductionBom."No.");
                end;
        end;
    end;

    //Handling workflow response

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onopendocument', '', true, true)]
    local procedure OnopendocumentProductionBom(RecRef: RecordRef; var Handled: boolean)
    var
        ProductionBom: Record "Production BOM Header";
    begin
        case RecRef.Number() of
            Database::"Production BOM Header":
                begin
                    RecRef.SetTable(ProductionBom);
                    ProductionBom.Validate(Status, ProductionBom.Status::New);
                    ProductionBom.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnreleaseDocument', '', true, true)]
    local procedure OnReleasedocumentProductionBom(RecRef: RecordRef; var Handled: boolean)
    var
        ProductionBom: Record "Production BOM Header";
    begin
        case RecRef.Number() of
            Database::"Production BOM Header":
                begin
                    RecRef.SetTable(ProductionBom);
                    ProductionBom.Validate(Status, ProductionBom.Status::Certified);
                    ProductionBom.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'Onsetstatustopendingapproval', '', true, true)]
    local procedure OnSetstatusToPendingApprovalProductionBom(RecRef: RecordRef; var IsHandled: boolean)
    var
        ProductionBom: Record "Production BOM Header";
    begin
        case RecRef.Number() of
            Database::"Production BOM Header":
                begin
                    RecRef.SetTable(ProductionBom);
                    ProductionBom.Validate(Status, ProductionBom.Status::"Under Development");
                    ProductionBom.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onaddworkflowresponsepredecessorstolibrary', '', true, true)]
    local procedure OnaddworkflowresponseprodecessorstolibraryProductionBom(ResponseFunctionName: Code[128])
    var
        workflowresponsehandling: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            workflowresponsehandling.SetStatusToPendingApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SetStatusToPendingApprovalCode(), RunworkflowOnSendProductionBomforApprovalCode());
            workflowresponsehandling.SendApprovalRequestForApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SendApprovalRequestForApprovalCode(), RunworkflowOnSendProductionBomforApprovalCode());
            workflowresponsehandling.CancelAllApprovalRequestsCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.CancelAllApprovalRequestsCode(), RunworkflowOnCancelProductionBomforApprovalCode());
            workflowresponsehandling.OpenDocumentCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.OpenDocumentCode(), RunworkflowOnCancelProductionBomforApprovalCode());
        end;
    end;

    //Setup workflow

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddworkflowcategoriestolibrary', '', true, true)]
    local procedure OnaddworkflowCategoryTolibraryProductionBom()
    begin
        workflowsetup.InsertWorkflowCategory(CopyStr(ProductionBomCategoryTxt, 1, 20), CopyStr(ProductionBomCategoryDescTxt, 1, 100));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Onafterinsertapprovalstablerelations', '', true, true)]
    local procedure OnInsertApprovaltablerelationsProductionBom()
    Var
        ApprovalEntry: record "Approval Entry";
    begin
        workflowsetup.InsertTableRelation(Database::"Production BOM Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Oninsertworkflowtemplates', '', true, true)]
    local procedure OnInsertworkflowtemplateProductionBom()
    begin
        InsertProductionBomApprovalworkflowtemplate();
    end;



    local procedure InsertProductionBomApprovalworkflowtemplate();
    var
        workflow: record Workflow;
    begin
        workflowsetup.InsertWorkflowTemplate(workflow, CopyStr(ProductionBomDocOCRWorkflowCodeTxt, 1, 17), CopyStr(ProductionBomApprWorkflowDescTxt, 1, 100), CopyStr(ProductionBomCategoryTxt, 1, 20));
        InsertProductionBomApprovalworkflowDetails(workflow);
        workflowsetup.MarkWorkflowAsTemplate(workflow);
    end;

    local procedure InsertProductionBomApprovalworkflowDetails(var workflow: record Workflow);
    var
        ProductionBom: Record "Production BOM Header";
        workflowstepargument: record "Workflow Step Argument";
        Blankdateformula: DateFormula;
    begin
        workflowsetup.InitWorkflowStepArgument(workflowstepargument, workflowstepargument."Approver Type"::Approver, workflowstepargument."Approver Limit Type"::"Direct Approver", 0, '', Blankdateformula, true);

        workflowsetup.InsertDocApprovalWorkflowSteps(workflow, BuildProductionBomtypecondition(ProductionBom.Status::New.AsInteger()), RunworkflowOnSendProductionBomforApprovalCode(), BuildProductionBomtypecondition(ProductionBom.Status::"Under Development".AsInteger()), RunworkflowOnCancelProductionBomforApprovalCode(), workflowstepargument, true);
    end;


    local procedure BuildProductionBomtypecondition(status: integer): Text
    var
        ProductionBom: Record "Production BOM Header";
    Begin
        ProductionBom.SetRange(Status, status);
        exit(StrSubstNo(ProductionBomTypeCondnTxt, workflowsetup.Encode(ProductionBom.GetView(false))));
    End;

    //Access record from the approval request page

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'Onaftergetpageid', '', true, true)]
    local procedure OnaftergetpageidProductionBom(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalcardPageidProductionBom(RecordRef)
    end;

    local procedure GetConditionalcardPageidProductionBom(RecordRef: RecordRef): Integer
    begin
        Case RecordRef.Number() of
            database::"Production BOM Header":
                exit(page::"Production BOM");
        end;
    end;
    //Add  ProductionBom Approval End  <<
    //B2BJK  End


    //B2BJK Start
    //Add  Specification Approval Start >>

    [IntegrationEvent(false, false)]
    Procedure OnSendSpecificationForApproval(var Specification: Record "Specification Header B2B")
    begin
    end;

    [IntegrationEvent(false, false)]
    Procedure OnCancelSpecificationForApproval(var Specification: Record "Specification Header B2B")
    begin
    end;

    //Create events for workflow
    procedure RunworkflowOnSendSpecificationforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('RunworkflowOnSendSpecificationforApproval'), 1, 128));
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OnSendSpecificationForApproval', '', true, true)]
    local procedure RunworkflowonsendSpecificationForApproval(var Specification: Record "Specification Header B2B")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendSpecificationforApprovalCode(), Specification);
    end;

    procedure RunworkflowOnCancelSpecificationforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('OnCancelSpecificationForApproval'), 1, 128));
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OncancelSpecificationForApproval', '', true, true)]

    local procedure RunworkflowonCancelSpecificationForApproval(var Specification: Record "Specification Header B2B")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOncancelSpecificationforApprovalCode(), Specification);
    end;

    //Add events to library

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrarySpecification();
    begin
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnSendSpecificationforApprovalCode(), DATABASE::"Specification Header B2B",
          CopyStr(Specificationsendforapprovaleventdesctxt, 1, 250), 0, FALSE);
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnCancelSpecificationforApprovalCode(), DATABASE::"Specification Header B2B",
          CopyStr(Specificationrequestcanceleventdesctxt, 1, 250), 0, FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddworkfloweventprodecessorstolibrarySpecification(EventFunctionName: code[128]);
    begin
        case EventFunctionName of
            RunworkflowOnCancelSpecificationforApprovalCode():
                WorkflowevenHandling.AddEventPredecessor(RunworkflowOnCancelSpecificationforApprovalCode(), RunworkflowOnSendSpecificationforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendSpecificationforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendSpecificationforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendSpecificationforApprovalCode());
        end;
    end;

    procedure ISSpecificationworkflowenabled(var Specification: Record "Specification Header B2B"): Boolean
    begin
        if Specification.Status <> Specification.Status::New then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(Specification, RunworkflowOnSendSpecificationforApprovalCode()));
    end;

    Procedure CheckSpecificationApprovalsWorkflowEnabled(var Specification: Record "Specification Header B2B"): Boolean
    begin
        IF not ISSpecificationworkflowenabled(Specification) then
            Error((NoworkfloweableErr));
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnpopulateApprovalEntryArgument', '', true, true)]
    local procedure OnpopulateApprovalEntriesArgumentSpecification(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Specification: Record "Specification Header B2B";
    begin
        case RecRef.Number() of
            Database::"Specification Header B2B":
                begin
                    RecRef.SetTable(Specification);
                    ApprovalEntryArgument."Document No." := FORMAT(Specification."Spec ID");
                end;
        end;
    end;

    //Handling workflow response

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onopendocument', '', true, true)]
    local procedure OnopendocumentSpecification(RecRef: RecordRef; var Handled: boolean)
    var
        Specification: Record "Specification Header B2B";
    begin
        case RecRef.Number() of
            Database::"Specification Header B2B":
                begin
                    RecRef.SetTable(Specification);
                    Specification.validate(Status, Specification.Status::New);
                    Specification.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnreleaseDocument', '', true, true)]
    local procedure OnReleasedocumentSpecification(RecRef: RecordRef; var Handled: boolean)
    var
        Specification: Record "Specification Header B2B";
    begin
        case RecRef.Number() of
            Database::"Specification Header B2B":
                begin
                    RecRef.SetTable(Specification);
                    Specification.validate(Status, Specification.Status::Certified);
                    Specification.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'Onsetstatustopendingapproval', '', true, true)]
    local procedure OnSetstatusToPendingApprovalSpecification(RecRef: RecordRef; var IsHandled: boolean)
    var
        Specification: Record "Specification Header B2B";
    begin
        case RecRef.Number() of
            Database::"Specification Header B2B":
                begin
                    RecRef.SetTable(Specification);
                    Specification.validate(Status, Specification.Status::"Under Development");
                    Specification.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onaddworkflowresponsepredecessorstolibrary', '', true, true)]
    local procedure OnaddworkflowresponseprodecessorstolibrarySpecification(ResponseFunctionName: Code[128])
    var
        workflowresponsehandling: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            workflowresponsehandling.SetStatusToPendingApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SetStatusToPendingApprovalCode(), RunworkflowOnSendSpecificationforApprovalCode());
            workflowresponsehandling.SendApprovalRequestForApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SendApprovalRequestForApprovalCode(), RunworkflowOnSendSpecificationforApprovalCode());
            workflowresponsehandling.CancelAllApprovalRequestsCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.CancelAllApprovalRequestsCode(), RunworkflowOnCancelSpecificationforApprovalCode());
            workflowresponsehandling.OpenDocumentCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.OpenDocumentCode(), RunworkflowOnCancelSpecificationforApprovalCode());
        end;
    end;

    //Setup workflow

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddworkflowcategoriestolibrary', '', true, true)]
    local procedure OnaddworkflowCategoryTolibrarySpecification()
    begin
        workflowsetup.InsertWorkflowCategory(CopyStr(SpecificationCategoryTxt, 1, 20), CopyStr(SpecificationCategoryDescTxt, 1, 100));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Onafterinsertapprovalstablerelations', '', true, true)]
    local procedure OnInsertApprovaltablerelationsSpecification()
    Var
        ApprovalEntry: record "Approval Entry";
    begin
        workflowsetup.InsertTableRelation(Database::"Specification Header B2B", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Oninsertworkflowtemplates', '', true, true)]
    local procedure OnInsertworkflowtemplateSpecification()
    begin
        InsertSpecificationApprovalworkflowtemplate();
    end;



    local procedure InsertSpecificationApprovalworkflowtemplate();
    var
        workflow: record Workflow;
    begin
        workflowsetup.InsertWorkflowTemplate(workflow, CopyStr(SpecificationDocOCRWorkflowCodeTxt, 1, 17), CopyStr(SpecificationApprWorkflowDescTxt, 1, 100), CopyStr(SpecificationCategoryTxt, 1, 20));
        InsertSpecificationApprovalworkflowDetails(workflow);
        workflowsetup.MarkWorkflowAsTemplate(workflow);
    end;

    local procedure InsertSpecificationApprovalworkflowDetails(var workflow: record Workflow);
    var
        Specification: Record "Specification Header B2B";
        workflowstepargument: record "Workflow Step Argument";
        Blankdateformula: DateFormula;
    begin
        workflowsetup.InitWorkflowStepArgument(workflowstepargument, workflowstepargument."Approver Type"::Approver, workflowstepargument."Approver Limit Type"::"Direct Approver", 0, '', Blankdateformula, true);

        workflowsetup.InsertDocApprovalWorkflowSteps(workflow, BuildSpecificationtypecondition(Specification.Status::New), RunworkflowOnSendSpecificationforApprovalCode(), BuildSpecificationtypecondition(Specification.Status::"Under Development"), RunworkflowOnCancelSpecificationforApprovalCode(), workflowstepargument, true);
    end;


    local procedure BuildSpecificationtypecondition(status: integer): Text
    var
        Specification: Record "Specification Header B2B";
    Begin
        Specification.SetRange(Status, status);
        exit(StrSubstNo(SpecificationTypeCondnTxt, workflowsetup.Encode(Specification.GetView(false))));
    End;

    //Access record from the approval request page

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'Onaftergetpageid', '', true, true)]
    local procedure OnaftergetpageidSpecification(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalcardPageidSpecification(RecordRef)
    end;

    local procedure GetConditionalcardPageidSpecification(RecordRef: RecordRef): Integer
    begin
        Case RecordRef.Number() of
            database::"Specification Header B2B":
                exit(page::"Specifications B2B");
        end;
    end;
    //Add  Specification Approval End  <<
    //B2BJK  End



    //B2BJK Start
    //Add  Indent Approval Start >>
    [IntegrationEvent(false, false)]
    Procedure OnSendIndentForApproval(var Indent: Record "Indent Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    Procedure OnCancelIndentForApproval(var Indent: Record "Indent Header")
    begin
    end;

    //Create events for workflow
    procedure RunworkflowOnSendIndentforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('RunworkflowOnSendIndentforApproval'), 1, 128));
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OnSendIndentForApproval', '', true, true)]
    local procedure RunworkflowonsendIndentForApproval(var Indent: Record "Indent Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendIndentforApprovalCode(), Indent);
    end;

    procedure RunworkflowOnCancelIndentforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('OnCancelIndentForApproval'), 1, 128));
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OncancelIndentForApproval', '', true, true)]

    local procedure RunworkflowonCancelIndentForApproval(var Indent: Record "Indent Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOncancelIndentforApprovalCode(), Indent);
    end;

    //Add events to library

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibraryIndent();
    begin
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnSendIndentforApprovalCode(), DATABASE::"Indent Header",
          CopyStr(Indentsendforapprovaleventdesctxt, 1, 250), 0, FALSE);
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnCancelIndentforApprovalCode(), DATABASE::"Indent Header",
          CopyStr(Indentrequestcanceleventdesctxt, 1, 250), 0, FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddworkfloweventprodecessorstolibraryIndent(EventFunctionName: code[128]);
    begin
        case EventFunctionName of
            RunworkflowOnCancelIndentforApprovalCode():
                WorkflowevenHandling.AddEventPredecessor(RunworkflowOnCancelIndentforApprovalCode(), RunworkflowOnSendIndentforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendIndentforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendIndentforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendIndentforApprovalCode());
        end;
    end;

    procedure ISIndentworkflowenabled(var Indent: Record "Indent Header"): Boolean
    begin
        if Indent."Released Status" <> Indent."Released Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(Indent, RunworkflowOnSendIndentforApprovalCode()));
    end;

    Procedure CheckIndentApprovalsWorkflowEnabled(var Indent: Record "Indent Header"): Boolean
    begin
        IF not ISIndentworkflowenabled(Indent) then
            Error((NoworkfloweableErr));
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnpopulateApprovalEntryArgument', '', true, true)]
    local procedure OnpopulateApprovalEntriesArgumentIndent(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Indent: Record "Indent Header";
    begin
        case RecRef.Number() of
            Database::"Indent Header":
                begin
                    RecRef.SetTable(Indent);
                    ApprovalEntryArgument."Document No." := FORMAT(Indent."No.");
                end;
        end;
    end;

    //Handling workflow response

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onopendocument', '', true, true)]
    local procedure OnopendocumentIndent(RecRef: RecordRef; var Handled: boolean)
    var
        Indent: Record "Indent Header";
    begin
        case RecRef.Number() of
            Database::"Indent Header":
                begin
                    RecRef.SetTable(Indent);
                    Indent."Released Status" := Indent."Released Status"::Open;
                    Indent.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnreleaseDocument', '', true, true)]
    local procedure OnReleasedocumentIndent(RecRef: RecordRef; var Handled: boolean)
    var
        Indent: Record "Indent Header";
    begin
        case RecRef.Number() of
            Database::"Indent Header":
                begin
                    RecRef.SetTable(Indent);
                    Indent."Released Status" := Indent."Released Status"::Released;
                    Indent.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'Onsetstatustopendingapproval', '', true, true)]
    local procedure OnSetstatusToPendingApprovalIndent(RecRef: RecordRef; var IsHandled: boolean)
    var
        Indent: Record "Indent Header";
    begin
        case RecRef.Number() of
            Database::"Indent Header":
                begin
                    RecRef.SetTable(Indent);
                    Indent."Released Status" := Indent."Released Status"::"Pending Approval";
                    Indent.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onaddworkflowresponsepredecessorstolibrary', '', true, true)]
    local procedure OnaddworkflowresponseprodecessorstolibraryIndent(ResponseFunctionName: Code[128])
    var
        workflowresponsehandling: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            workflowresponsehandling.SetStatusToPendingApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SetStatusToPendingApprovalCode(), RunworkflowOnSendIndentforApprovalCode());
            workflowresponsehandling.SendApprovalRequestForApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SendApprovalRequestForApprovalCode(), RunworkflowOnSendIndentforApprovalCode());
            workflowresponsehandling.CancelAllApprovalRequestsCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.CancelAllApprovalRequestsCode(), RunworkflowOnCancelIndentforApprovalCode());
            workflowresponsehandling.OpenDocumentCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.OpenDocumentCode(), RunworkflowOnCancelIndentforApprovalCode());
        end;
    end;

    //Setup workflow

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddworkflowcategoriestolibrary', '', true, true)]
    local procedure OnaddworkflowCategoryTolibraryIndent()
    begin
        workflowsetup.InsertWorkflowCategory(CopyStr(IndentCategoryTxt, 1, 20), CopyStr(IndentCategoryDescTxt, 1, 100));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Onafterinsertapprovalstablerelations', '', true, true)]
    local procedure OnInsertApprovaltablerelationsIndent()
    Var
        ApprovalEntry: record "Approval Entry";
    begin
        workflowsetup.InsertTableRelation(Database::"Indent Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Oninsertworkflowtemplates', '', true, true)]
    local procedure OnInsertworkflowtemplateIndent()
    begin
        InsertIndentApprovalworkflowtemplate();
    end;



    local procedure InsertIndentApprovalworkflowtemplate();
    var
        workflow: record Workflow;
    begin
        workflowsetup.InsertWorkflowTemplate(workflow, CopyStr(IndentDocOCRWorkflowCodeTxt, 1, 17), CopyStr(IndentApprWorkflowDescTxt, 1, 100), CopyStr(IndentCategoryTxt, 1, 20));
        InsertIndentApprovalworkflowDetails(workflow);
        workflowsetup.MarkWorkflowAsTemplate(workflow);
    end;

    local procedure InsertIndentApprovalworkflowDetails(var workflow: record Workflow);
    var
        Indent: Record "Indent Header";
        workflowstepargument: record "Workflow Step Argument";
        Blankdateformula: DateFormula;
    begin
        workflowsetup.InitWorkflowStepArgument(workflowstepargument, workflowstepargument."Approver Type"::Approver, workflowstepargument."Approver Limit Type"::"Direct Approver", 0, '', Blankdateformula, true);

        workflowsetup.InsertDocApprovalWorkflowSteps(workflow, BuildIndenttypecondition(Indent."Released Status"::Open), RunworkflowOnSendIndentforApprovalCode(), BuildIndenttypecondition(Indent."Released Status"::"Pending Approval"), RunworkflowOnCancelIndentforApprovalCode(), workflowstepargument, true);
    end;


    local procedure BuildIndenttypecondition(status: integer): Text
    var
        Indent: Record "Indent Header";
    Begin
        Indent.SetRange("Released Status", status);
        exit(StrSubstNo(IndentTypeCondnTxt, workflowsetup.Encode(Indent.GetView(false))));
    End;

    //Access record from the approval request page

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'Onaftergetpageid', '', true, true)]
    local procedure OnaftergetpageidIndent(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalcardPageidIndent(RecordRef)
    end;

    local procedure GetConditionalcardPageidIndent(RecordRef: RecordRef): Integer
    begin
        Case RecordRef.Number() of
            database::"Indent Header":
                exit(page::"Indent Header");
        end;
    end;
    //Add  Indent Approval End  <<
    //B2BJK  End


    //B2BJK Start
    //Add  PurchasePrice Approval Start >>

    [IntegrationEvent(false, false)]
    Procedure OnSendPurchasePriceForApproval(var PurchasePrice: Record "Purchase Price")
    begin
    end;

    [IntegrationEvent(false, false)]
    Procedure OnCancelPurchasePriceForApproval(var PurchasePrice: Record "Purchase Price")
    begin
    end;

    //Create events for workflow
    procedure RunworkflowOnSendPurchasePriceforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('RunworkflowOnSendPurchasePriceforApproval'), 1, 128));
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OnSendPurchasePriceForApproval', '', true, true)]
    local procedure RunworkflowonsendPurchasePriceForApproval(var PurchasePrice: Record "Purchase Price")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendPurchasePriceforApprovalCode(), PurchasePrice);
    end;

    procedure RunworkflowOnCancelPurchasePriceforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('OnCancelPurchasePriceForApproval'), 1, 128));
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OncancelPurchasePriceForApproval', '', true, true)]

    local procedure RunworkflowonCancelPurchasePriceForApproval(var PurchasePrice: Record "Purchase Price")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOncancelPurchasePriceforApprovalCode(), PurchasePrice);
    end;

    //Add events to library

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibraryPurchasePrice();
    begin
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnSendPurchasePriceforApprovalCode(), DATABASE::"Purchase Price",
          CopyStr(PurchasePricesendforapprovaleventdesctxt, 1, 250), 0, FALSE);
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnCancelPurchasePriceforApprovalCode(), DATABASE::"Purchase Price",
          CopyStr(PurchasePricerequestcanceleventdesctxt, 1, 250), 0, FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddworkfloweventprodecessorstolibraryPurchasePrice(EventFunctionName: code[128]);
    begin
        case EventFunctionName of
            RunworkflowOnCancelPurchasePriceforApprovalCode():
                WorkflowevenHandling.AddEventPredecessor(RunworkflowOnCancelPurchasePriceforApprovalCode(), RunworkflowOnSendPurchasePriceforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendPurchasePriceforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendPurchasePriceforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendPurchasePriceforApprovalCode());
        end;
    end;

    procedure ISPurchasePriceworkflowenabled(var PurchasePrice: Record "Purchase Price"): Boolean
    begin
        if PurchasePrice."Approval Status_B2B" <> PurchasePrice."Approval Status_B2B"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(PurchasePrice, RunworkflowOnSendPurchasePriceforApprovalCode()));
    end;

    Procedure CheckPurchasePriceApprovalsWorkflowEnabled(var PurchasePrice: Record "Purchase Price"): Boolean
    begin
        IF not ISPurchasePriceworkflowenabled(PurchasePrice) then
            Error((NoworkfloweableErr));
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnpopulateApprovalEntryArgument', '', true, true)]
    local procedure OnpopulateApprovalEntriesArgumentPurchasePrice(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        PurchasePrice: Record "Purchase Price";
    begin
        case RecRef.Number() of
            Database::"Purchase Price":
                begin
                    RecRef.SetTable(PurchasePrice);
                    ApprovalEntryArgument."Document No." := copystr(FORMAT(PurchasePrice.RecordId), 1, 20);
                end;
        end;
    end;

    //Handling workflow response

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onopendocument', '', true, true)]
    local procedure OnopendocumentPurchasePrice(RecRef: RecordRef; var Handled: boolean)
    var
        PurchasePrice: Record "Purchase Price";
    begin
        case RecRef.Number() of
            Database::"Purchase Price":
                begin
                    RecRef.SetTable(PurchasePrice);
                    PurchasePrice."Approval Status_B2B" := PurchasePrice."Approval Status_B2B"::Open;
                    PurchasePrice.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnreleaseDocument', '', true, true)]
    local procedure OnReleasedocumentPurchasePrice(RecRef: RecordRef; var Handled: boolean)
    var
        PurchasePrice: Record "Purchase Price";
    begin
        case RecRef.Number() of
            Database::"Purchase Price":
                begin
                    RecRef.SetTable(PurchasePrice);
                    PurchasePrice."Approval Status_B2B" := PurchasePrice."Approval Status_B2B"::Released;
                    PurchasePrice.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'Onsetstatustopendingapproval', '', true, true)]
    local procedure OnSetstatusToPendingApprovalPurchasePrice(RecRef: RecordRef; var IsHandled: boolean)
    var
        PurchasePrice: Record "Purchase Price";
    begin
        case RecRef.Number() of
            Database::"Purchase Price":
                begin
                    RecRef.SetTable(PurchasePrice);
                    PurchasePrice."Approval Status_B2B" := PurchasePrice."Approval Status_B2B"::"Pending Approval";
                    PurchasePrice.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onaddworkflowresponsepredecessorstolibrary', '', true, true)]
    local procedure OnaddworkflowresponseprodecessorstolibraryPurchasePrice(ResponseFunctionName: Code[128])
    var
        workflowresponsehandling: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            workflowresponsehandling.SetStatusToPendingApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SetStatusToPendingApprovalCode(), RunworkflowOnSendPurchasePriceforApprovalCode());
            workflowresponsehandling.SendApprovalRequestForApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SendApprovalRequestForApprovalCode(), RunworkflowOnSendPurchasePriceforApprovalCode());
            workflowresponsehandling.CancelAllApprovalRequestsCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.CancelAllApprovalRequestsCode(), RunworkflowOnCancelPurchasePriceforApprovalCode());
            workflowresponsehandling.OpenDocumentCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.OpenDocumentCode(), RunworkflowOnCancelPurchasePriceforApprovalCode());
        end;
    end;

    //Setup workflow

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddworkflowcategoriestolibrary', '', true, true)]
    local procedure OnaddworkflowCategoryTolibraryPurchasePrice()
    begin
        workflowsetup.InsertWorkflowCategory(CopyStr(PurchasePriceCategoryTxt, 1, 20), CopyStr(PurchasePriceCategoryDescTxt, 1, 100));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Onafterinsertapprovalstablerelations', '', true, true)]
    local procedure OnInsertApprovaltablerelationsPurchasePrice()
    Var
        ApprovalEntry: record "Approval Entry";
    begin
        workflowsetup.InsertTableRelation(Database::"Purchase Price", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Oninsertworkflowtemplates', '', true, true)]
    local procedure OnInsertworkflowtemplatePurchasePrice()
    begin
        InsertPurchasePriceApprovalworkflowtemplate();
    end;



    local procedure InsertPurchasePriceApprovalworkflowtemplate();
    var
        workflow: record Workflow;
    begin
        workflowsetup.InsertWorkflowTemplate(workflow, CopyStr(PurchasePriceDocOCRWorkflowCodeTxt, 1, 17), CopyStr(PurchasePriceApprWorkflowDescTxt, 1, 100), CopyStr(PurchasePriceCategoryTxt, 1, 20));
        InsertPurchasePriceApprovalworkflowDetails(workflow);
        workflowsetup.MarkWorkflowAsTemplate(workflow);
    end;

    local procedure InsertPurchasePriceApprovalworkflowDetails(var workflow: record Workflow);
    var
        PurchasePrice: Record "Purchase Price";
        workflowstepargument: record "Workflow Step Argument";
        Blankdateformula: DateFormula;
    begin
        workflowsetup.InitWorkflowStepArgument(workflowstepargument, workflowstepargument."Approver Type"::Approver, workflowstepargument."Approver Limit Type"::"Direct Approver", 0, '', Blankdateformula, true);

        workflowsetup.InsertDocApprovalWorkflowSteps(workflow, BuildPurchasePricetypecondition(PurchasePrice."Approval Status_B2B"::Open), RunworkflowOnSendPurchasePriceforApprovalCode(), BuildPurchasePricetypecondition(PurchasePrice."Approval Status_B2B"::"Pending Approval"), RunworkflowOnCancelPurchasePriceforApprovalCode(), workflowstepargument, true);
    end;


    local procedure BuildPurchasePricetypecondition(status: integer): Text
    var
        PurchasePrice: Record "Purchase Price";
    Begin
        PurchasePrice.SetRange("Approval Status_B2B", status);
        exit(StrSubstNo(PurchasePriceTypeCondnTxt, workflowsetup.Encode(PurchasePrice.GetView(false))));
    End;

    //Access record from the approval request page

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'Onaftergetpageid', '', true, true)]
    local procedure OnaftergetpageidPurchasePrice(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalcardPageidPurchasePrice(RecordRef)
    end;

    local procedure GetConditionalcardPageidPurchasePrice(RecordRef: RecordRef): Integer
    begin
        Case RecordRef.Number() of
            database::"Purchase Price":
                exit(page::"Purchase Prices");
        end;
    end;
    //Add  PurchasePrice Approval End  <<
    //B2BJK  End

    //B2BJK Start
    //Add  TransferOrder Approval Start >>
    [IntegrationEvent(false, false)]
    Procedure OnSendTransferOrderForApproval(var TransferOrder: Record "Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    Procedure OnCancelTransferOrderForApproval(var TransferOrder: Record "Transfer Header")
    begin
    end;

    //Create events for workflow
    procedure RunworkflowOnSendTransferOrderforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('RunworkflowOnSendTransferOrderforApproval'), 1, 128));
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OnSendTransferOrderForApproval', '', true, true)]
    local procedure RunworkflowonsendTransferOrderForApproval(var TransferOrder: Record "Transfer Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOnSendTransferOrderforApprovalCode(), TransferOrder);
    end;

    procedure RunworkflowOnCancelTransferOrderforApprovalCode(): code[128]
    begin
        exit(CopyStr(UpperCase('OnCancelTransferOrderForApproval'), 1, 128));
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalsCodeunit, 'OncancelTransferOrderForApproval', '', true, true)]

    local procedure RunworkflowonCancelTransferOrderForApproval(var TransferOrder: Record "Transfer Header")
    begin
        WorkflowManagement.HandleEvent(RunworkflowOncancelTransferOrderforApprovalCode(), TransferOrder);
    end;

    //Add events to library

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibraryTransferOrder();
    begin
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnSendTransferOrderforApprovalCode(), DATABASE::"Transfer Header",
          CopyStr(TransferOrdersendforapprovaleventdesctxt, 1, 250), 0, FALSE);
        WorkflowevenHandling.AddEventToLibrary(RunworkflowOnCancelTransferOrderforApprovalCode(), DATABASE::"Transfer Header",
          CopyStr(TransferOrderrequestcanceleventdesctxt, 1, 250), 0, FALSE);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddworkfloweventprodecessorstolibraryTransferOrder(EventFunctionName: code[128]);
    begin
        case EventFunctionName of
            RunworkflowOnCancelTransferOrderforApprovalCode():
                WorkflowevenHandling.AddEventPredecessor(RunworkflowOnCancelTransferOrderforApprovalCode(), RunworkflowOnSendTransferOrderforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnApproveApprovalRequestCode(), RunworkflowOnSendTransferOrderforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnRejectApprovalRequestCode(), RunworkflowOnSendTransferOrderforApprovalCode());
            WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode():
                WorkflowevenHandling.AddEventPredecessor(WorkflowevenHandling.RunWorkflowOnDelegateApprovalRequestCode(), RunworkflowOnSendTransferOrderforApprovalCode());
        end;
    end;

    procedure ISTransferOrderworkflowenabled(var TransferHeader: Record "Transfer Header"): Boolean
    begin
        if TransferHeader."Approval Status" <> TransferHeader."Approval Status"::Open then
            exit(false);
        exit(WorkflowManagement.CanExecuteWorkflow(TransferHeader, RunworkflowOnSendTransferOrderforApprovalCode()));
    end;

    Procedure CheckTransferOrderApprovalsWorkflowEnabled(var TransferHeader: Record "Transfer Header"): Boolean
    begin
        IF not ISTransferOrderworkflowenabled(TransferHeader) then
            Error((NoworkfloweableErr));
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnpopulateApprovalEntryArgument', '', true, true)]
    local procedure OnpopulateApprovalEntriesArgumentTransferOrder(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        TransferHeader: Record "Transfer Header";
    begin
        case RecRef.Number() of
            Database::"Transfer Header":
                begin
                    RecRef.SetTable(TransferHeader);
                    ApprovalEntryArgument."Document No." := FORMAT(TransferHeader."No.");
                end;
        end;
    end;

    //Handling workflow response

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onopendocument', '', true, true)]
    local procedure OnopendocumentTransferOrder(RecRef: RecordRef; var Handled: boolean)
    var
        TransferHeader: Record "Transfer Header";
    begin
        case RecRef.Number() of
            Database::"Transfer Header":
                begin
                    RecRef.SetTable(TransferHeader);
                    TransferHeader."Approval Status" := TransferHeader."Approval Status"::Open;
                    TransferHeader.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnreleaseDocument', '', true, true)]
    local procedure OnReleasedocumentTransferOrder(RecRef: RecordRef; var Handled: boolean)
    var
        TransferHeader: Record "Transfer Header";
    begin
        case RecRef.Number() of
            Database::"Transfer Header":
                begin
                    RecRef.SetTable(TransferHeader);
                    TransferHeader."Approval Status" := TransferHeader."Approval Status"::Released;
                    TransferHeader.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'Onsetstatustopendingapproval', '', true, true)]
    local procedure OnSetstatusToPendingApprovalTransferOrder(RecRef: RecordRef; var IsHandled: boolean)
    var
        TransferHeader: Record "Transfer Header";
    begin
        case RecRef.Number() of
            Database::"Transfer Header":
                begin
                    RecRef.SetTable(TransferHeader);
                    TransferHeader."Approval Status" := TransferHeader."Approval Status"::"Pending Approval";
                    TransferHeader.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'Onaddworkflowresponsepredecessorstolibrary', '', true, true)]
    local procedure OnaddworkflowresponseprodecessorstolibraryTransferOrder(ResponseFunctionName: Code[128])
    var
        workflowresponsehandling: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            workflowresponsehandling.SetStatusToPendingApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SetStatusToPendingApprovalCode(), RunworkflowOnSendTransferOrderforApprovalCode());
            workflowresponsehandling.SendApprovalRequestForApprovalCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.SendApprovalRequestForApprovalCode(), RunworkflowOnSendTransferOrderforApprovalCode());
            workflowresponsehandling.CancelAllApprovalRequestsCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.CancelAllApprovalRequestsCode(), RunworkflowOnCancelTransferOrderforApprovalCode());
            workflowresponsehandling.OpenDocumentCode():
                workflowresponsehandling.AddResponsePredecessor(workflowresponsehandling.OpenDocumentCode(), RunworkflowOnCancelTransferOrderforApprovalCode());
        end;
    end;

    //Setup workflow

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'OnAddworkflowcategoriestolibrary', '', true, true)]
    local procedure OnaddworkflowCategoryTolibraryTransferOrder()
    begin
        workflowsetup.InsertWorkflowCategory(CopyStr(TransferOrderCategoryTxt, 1, 20), CopyStr(TransferOrderCategoryDescTxt, 1, 100));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Onafterinsertapprovalstablerelations', '', true, true)]
    local procedure OnInsertApprovaltablerelationsTransferOrder()
    Var
        ApprovalEntry: record "Approval Entry";
    begin
        workflowsetup.InsertTableRelation(Database::"Transfer Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", 'Oninsertworkflowtemplates', '', true, true)]
    local procedure OnInsertworkflowtemplateTransferOrder()
    begin
        InsertTransferOrderApprovalworkflowtemplate();
    end;



    local procedure InsertTransferOrderApprovalworkflowtemplate();
    var
        workflow: record Workflow;
    begin
        workflowsetup.InsertWorkflowTemplate(workflow, CopyStr(TransferOrderDocOCRWorkflowCodeTxt, 1, 17), CopyStr(TransferOrderApprWorkflowDescTxt, 1, 100), CopyStr(TransferOrderCategoryTxt, 1, 20));
        InsertTransferOrderApprovalworkflowDetails(workflow);
        workflowsetup.MarkWorkflowAsTemplate(workflow);
    end;

    local procedure InsertTransferOrderApprovalworkflowDetails(var workflow: record Workflow);
    var
        TransferHeader: Record "Transfer Header";
        workflowstepargument: record "Workflow Step Argument";
        Blankdateformula: DateFormula;
    begin
        workflowsetup.InitWorkflowStepArgument(workflowstepargument, workflowstepargument."Approver Type"::Approver, workflowstepargument."Approver Limit Type"::"Direct Approver", 0, '', Blankdateformula, true);

        workflowsetup.InsertDocApprovalWorkflowSteps(workflow, BuildTransferOrdertypecondition(TransferHeader."Approval Status"::Open), RunworkflowOnSendTransferOrderforApprovalCode(), BuildTransferOrdertypecondition(TransferHeader."Approval Status"::"Pending Approval"), RunworkflowOnCancelTransferOrderforApprovalCode(), workflowstepargument, true);
    end;


    local procedure BuildTransferOrdertypecondition(status: integer): Text
    var
        TransferHeader: Record "Transfer Header";
    Begin
        TransferHeader.SetRange("Approval Status", status);
        exit(StrSubstNo(TransferOrderTypeCondnTxt, workflowsetup.Encode(TransferHeader.GetView(false))));
    End;

    //Access record from the approval request page

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'Onaftergetpageid', '', true, true)]
    local procedure OnaftergetpageidTransferOrder(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalcardPageidTransferOrder(RecordRef)
    end;

    local procedure GetConditionalcardPageidTransferOrder(RecordRef: RecordRef): Integer
    begin
        Case RecordRef.Number() of
            database::"Transfer Header":
                exit(page::"Transfer Order");
        end;
    end;
    //Add  TransferOrder Approval End  <<
    //B2BJK  End



}
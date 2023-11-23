permissionset 50001 "RGP Permissions"
{
    Assignable = true;
    Permissions =
        tabledata "Gate Pass Header" = RIMD,
        tabledata "Gate Pass Line" = RIMD,
        tabledata "GP Ledger Entry" = RIMD,

        tabledata "NRGP Header" = RIMD,
        tabledata "NRGP Line" = RIMD,
        tabledata "Posted Gate Pass Header" = RIMD,
        tabledata "Posted Gate Pass Line" = RIMD,

        table "Gate Pass Header" = X,
        table "Gate Pass Line" = X,
        table "GP Ledger Entry" = X,
        table "NRGP Header" = X,
        table "NRGP Line" = X,

        table "Posted Gate Pass Header" = X,
        table "Posted Gate Pass Line" = X,

        report IRRdcReport = X,

        report NonReturnableGatepass = X,

        report ReturnableGatepass = X,
        codeunit EventsSubscribers = X,

        codeunit "NRGP Post" = X,
        page "GP Ledger Entries" = X,
        page "NRGP Header" = X,
        page "NRGP List" = X,
        page "NRGP Sub Form" = X,

        page "Posted NRGP Header" = X,
        page "Posted NRGP List" = X,
        page "Posted RGP Header List" = X,
        page "Posted RGP In" = X,
        page "Posted RGP IN List" = X,
        page "Posted RGP In Subform" = X,
        page "Posted RGP Out" = X,
        page "Posted RGP Out List" = X,
        page "Posted RGP Out Subform" = X,
        page "RGP Header List" = X,
        page "RGP In" = X,
        page "RGP In List" = X,
        page "RGP In Subform" = X,
        page "RGP Out" = X,
        page "RGP OUT Line" = X,
        page "RGP Out List" = X,
        page "RGP Status" = X,
        page "RGPOut Subform" = X;
}
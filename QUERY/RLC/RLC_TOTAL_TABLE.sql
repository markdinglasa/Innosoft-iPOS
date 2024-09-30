INSERT INTO TmpRLCTotal (
    TenantId, 
    TerminalNumber, 
    GrossAmount, 
    TaxAmount, 
    VoidAmount, 
    VoidTransaction,
    DiscountAmount, 
    DiscountTransaction, 
    ReturnAmount, 
    ReturnTransaction, 
    AdjustmentAmount, 
    AdjustmentTransaction, 
    ServiceChargeAmount, 
    PreviousEOD, 
    PreviousAmount, 
    CurrentEOD, 
    CurrentEODAmount, 
    TransactionDate, 
    NoveltyItemAmount, 
    MiscItemAmount, 
    LocalTax, 
    CreditSalesAmount, 
    CreditTaxAmount, 
    NonVATSalesAmount, 
    PharmaItemSalesAmount, 
    NonPharmaItemSalesAmount, 
    DisabilityDiscount, 
    GrossSalesAmountNotSubjectToPercentageRent, 
    RePrintedAmount, 
    RePrintedTransaction
)

SELECT 
    DFirst("RLC_TenantId","SysCurrent") AS TenantId, 
    [TmpRLC].[TerminalNumber],
        FORMAT(MAX(Nz([TmpRLC].[GrossAmount], 0)), '0.00') AS [GrossAmount],
        FORMAT(((MAX(Nz([TmpRLC].[GrossAmount], 0)) - (
            SUM([TmpRLC].[AdjustmentAmount])
            + SUM(Nz([TmpRLC].[DisabilityDiscount], 0))
            + MAX(Nz([TmpRLC].[NonVATSalesAmount],0))
            + SUM(Nz([TmpRLC].[GrossSalesAmountNotSubjectToPercentageRent],0))
            )) /1.12)*0.12,'0.00')AS [TaxAmount],
        FORMAT(SUM((Nz([TmpRLC].[VoidAmount],0))), '0.00') AS [VoidAmount],
        SUM(Nz([TmpRLC].[VoidTransaction], 0)) AS [VoidTransaction],
        FORMAT(SUM(Nz([TmpRLC].[LineDiscountAmount],0)), '0.00') AS [DiscountAmount],
        SUM(Nz([TmpRLC].[DiscountTransaction],0)) AS [DiscountTransaction],
        FORMAT(MAX(Nz([TmpRLC].[ReturnAmount],0)), '0.00') AS [ReturnAmount],
        MAX(Nz([TmpRLC].[ReturnTransaction],0)) AS [ReturnTransaction],
        FORMAT(SUM([TmpRLC].[AdjustmentAmount]), '0.00') AS [AdjustmentAmount], 
        SUM(Nz([TmpRLC].[AdjustmentTransaction],0)) AS [AdjustmentTransaction], 
        FORMAT(SUM(Nz([TmpRLC].[ServiceChargeAmount],0)), '0.00') AS [ServiceChargeAmount],
        MAX(Nz([TmpRLC].[PreviousEOD],0)) AS [PreviousEOD], 
        MAX(Nz([TmpRLC].[PreviousAmount],0)) AS [PreviousAmount], 
        MAX(Nz([TmpRLC].[CurrentEOD],0)) AS [CurrentEOD], 
        FORMAT((MAX(Nz([TmpRLC].[CurrentEODAmount],0)) + SUM(Nz([TmpRLC].[PreviousAmount],0))) , '0.00') AS [CurrentEODAmount],
        [TmpRLC].[TransactionDate] AS [TransactionDate],
        0 AS [NoveltyItemAmount],
        0 AS [MiscItemAmount], 
        FORMAT(SUM(Nz([TmpRLC].[LocalTax], 0)), '0.00') AS [LocalTax],
        FORMAT(SUM(Nz([TmpRLC].[CreditSalesAmount], 0)), '0.00') AS [CreditSalesAmount],
        FORMAT(((SUM(Nz([TmpRLC].[CreditSalesAmount],0)))/1.12)*0.12, '0.00') AS [CreditTaxAmount],
        FORMAT(MAX(Nz([TmpRLC].[NonVATSalesAmount],0)), '0.00') AS [NonVATSalesAmount],
        0 AS [PharmaItemSalesAmount],
        0 AS [NonPharmaItemSalesAmount],
        FORMAT(SUM(Nz([TmpRLC].[DisabilityDiscount], 0)), '0.00') AS [DisabilityDiscount],
        SUM(Nz([TmpRLC].[GrossSalesAmountNotSubjectToPercentageRent],0)) AS [GrossSalesAmountNotSubjectToPercentageRent],
        SUM(Nz([TmpRLC].[RePrintedAmount],0)) AS [RePrintedAmount], 
        SUM(NZ([TmpRLC].[RePrintedTransaction],0)) AS [RePrintedTransaction]

FROM 
    [TmpRLC]

GROUP BY
    DFirst("RLC_TenantId","SysCurrent"),
    [TmpRLC].[TerminalNumber],
    [TmpRLC].[TransactionDate]

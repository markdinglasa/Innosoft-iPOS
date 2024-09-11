INSERT INTO TmpRLC ( TenantId, TerminalNumber, GrossAmount, TaxAmount, VoidAmount, VoidTransaction, DiscountAmount, DiscountTransaction, ReturnAmount, ReturnTransaction, AdjustmentAmount, AdjustmentTransaction, ServiceChargeAmount, PreviousEOD, PreviousAmount, CurrentEOD, CurrentEODAmount, TransactionDate, NoveltyItemAmount, MiscItemAmount, LocalTax, CreditSalesAmount, CreditTaxAmount, NonVATSalesAmount, PharmaItemSalesAmount, NonPharmaItemSalesAmount, DisabilityDiscount, GrossSalesAmountNotSubectToPercentageRent, RePrintedAmount, RePrintedTransaction )

SELECT 
DFirst("RLC_TenantId","SysCurrent") AS TenantId, 
[MstTerminal].[Id] AS [TerminalId], 
SUM(TrnDisbursement.Amount) AS ReturnAmount, SUM(1) AS ReturnTransaction
INTO [RLC_REFUND]
FROM ((TrnDisbursement INNER JOIN MstTerminal ON TrnDisbursement.TerminalId = MstTerminal.Id) LEFT JOIN TrnStockIn ON TrnDisbursement.StockInId = TrnStockIn.Id) LEFT JOIN (TrnCollection LEFT JOIN TrnSalesLine ON TrnCollection.SalesId = TrnSalesLine.SalesId) ON TrnStockIn.CollectionId = TrnCollection.Id
GROUP BY DFirst("RLC_TenantId","SysCurrent"), [MstTerminal].[Id], TrnDisbursement.Amount, [trndisbursement].[Amount]*-1, TrnDisbursement.DisbursementDate, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, TrnDisbursement.DisbursementDate, TrnDisbursement.TerminalId, TrnDisbursement.IsLocked, TrnDisbursement.IsReturn, TrnDisbursement.StockInId, TrnSalesLine.SalesId
HAVING (((TrnDisbursement.DisbursementDate)=[Forms]![SysSettings]![RLC_DateMem]) AND ((TrnDisbursement.TerminalId)=[Forms]![SysSettings]![RLC_TerminalIdMem]) AND ((TrnDisbursement.IsLocked)=True) AND ((TrnDisbursement.IsReturn)=True) AND ((TrnDisbursement.StockInId) Is Not Null) AND (Not (TrnSalesLine.SalesId) Is Null));

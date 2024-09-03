INSERT INTO TmpRLC ( 
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
GrossSalesAmountNotSubectToPercentageRent, 
RePrintedAmount, 
RePrintedTransaction )
SELECT 
DFirst("RLC_TenantId","SysCurrent") AS [TenantId], 
"00000000000000" & Right([MstTerminal].[Terminal],2) AS [TerminalNumber], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [GrossAmount], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000') AS [TaxAmount],
IIf([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, FORMAT([GrossSales].[GrossSalesAmount], '0.00000')) AS [VoidAmount], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, 1) AS [VoidTransaction], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [DiscountAmount], 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TotalDiscount].[TotalDiscountAmount] > 0),1,0) AS [DiscountTransaction], 
IIF([TrnCollection].[IsReturn] = 1, FORMAT([TrnCollection].[Amount],'0.00000'), 0) AS [ReturnAmount], 
IIF([TrnCollection].[IsReturn] = 1, 1, 0) AS [ReturnTransaction], 
0 AS [AdjustmentAmount],
0 AS [AdjustmentTransaction], 
MAX(IIf(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(Nz([TotalServiceCharge].[ServiceCharge], 0), '0.00000'), '0.00000')) AS [ServiceChargeAmount],
0 AS [PreviousEOD],
0 AS [PreviousAmount],
Nz(DCount("Id","trncollection","[CollectionDate] < " & [Forms]![SysSettings]![RLC_DateMem])+1) AS [CurrentEOD], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([GrossSales].[GrossSalesAmount]), '0.00000'),'0.00000') AS [CurrentEODAmount], 
FORMAT([TrnCollection].[CollectionDate], 'MM/dd/yyyy') AS [TransactionDate], 
0 AS [NoveltyItemAmount], 
0 AS [MiscItemAmount],
IIF([MstTax].[Tax] = 'LOCAL TAX', FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'), '0.00000') AS [LocalTax], 
[TmpPayTypeSales].[TotalCreditCardSales] AS [CreditSalesAmount],
[TmpPayTypeSales].[TotalCreditCardTax] AS [CreditTaxAmount],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnSalesLine].[TaxAmount] = 0), FORMAT(([GrossSales].[GrossSalesAmount] ), '0.00000'),'0.00000') AS [NonVATSalesAmount],
0 AS [PharmaItemSalesAmount], 
0 AS [NonPharmaItemSalesAmount], 
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'PWD'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [DisabilityDiscount], 
0 AS [GrossSalesAmountNotSubectToPercentageRent],
0 AS [RePrintedAmount],
0 AS [RePrintedTransaction]
FROM 
    (((((((((((((((TrnSales LEFT JOIN TrnSalesLine ON [TrnSalesLine].[SalesId] = [TrnSales].[Id]) 
    LEFT JOIN [TrnCollection] ON [TrnSales].[Id] = [TrnCollection].[SalesId]) 
    LEFT JOIN [TmpPayTypeSales] ON [TmpPayTypeSales].[SalesId] = [TrnSales].[Id])
    LEFT JOIN [TrnCollectionLine] ON [TrnCollectionLine].[CollectionId] = [TrnCollection].[Id]) 
    LEFT JOIN [SysCurrent] ON [TrnSales].[TerminalId] = [SysCurrent].[TerminalId]) 
    LEFT JOIN [MstTable] ON [TrnSales].[TableId] = [MstTable].[Id]) 
    LEFT JOIN [ItemsPurchase] ON [TrnSales].[Id] = ItemsPurchase.SalesId) 
    LEFT JOIN [MstTax] ON MstTax.Id = TrnSalesLine.TaxId) 
    LEFT JOIN [MstItem] ON MstItem.Id = [TrnSalesLine].ItemId) 
    LEFT JOIN [MstPayType] ON [MstPayType].[Id] = [TrnCollectionLine].[PayTypeId]) 
    LEFT JOIN [MstTerminal] ON [SysCurrent].[TerminalId] = [MstTerminal].[Id]) 
    LEFT JOIN [MstDiscount] ON [MstDiscount].[Id] = [TrnSalesLine].[DiscountId])
    LEFT JOIN (SELECT [SalesId], SUM([Amount]) AS GrossSalesAmount FROM TrnSalesLine GROUP BY [SalesId])  AS GrossSales ON [TrnSales].[Id] = GrossSales.[SalesId]) 
    LEFT JOIN (SELECT [SalesId], SUM([Amount]) AS ServiceCharge FROM TrnSalesLine WHERE [ItemId] = 1 GROUP BY [SalesId])  AS TotalServiceCharge ON [TrnSales].[Id] = [TotalServiceCharge].[SalesId]) 
    LEFT JOIN (SELECT [SalesId], SUM([TaxAmount]) AS TotalTaxAmount FROM TrnSalesLine GROUP BY [SalesId])  AS TotalTax ON [TrnSales].[Id] = TotalTax.[SalesId]) 
    LEFT JOIN (SELECT [SalesId], SUM(([DiscountAmount])*([Quantity])) AS TotalDiscountAmount FROM TrnSalesLine GROUP BY [SalesId])  AS TotalDiscount ON [TrnSales].[Id] = [TotalDiscount].[SalesId]
WHERE
    [TrnSales].[IsLocked] 
    AND MONTH([TrnSales].EntryDateTime) = MONTH(Date()) 
    AND YEAR([TrnSales].[EntryDateTime]) = YEAR(Date())
GROUP BY 
DFirst("RLC_TenantId","SysCurrent"), 
"00000000000000" & Right([MstTerminal].[Terminal],2), 
REPLACE([TrnSales].[SalesNumber], '-', ''), 
FORMAT([TrnCollection].[CollectionDate], 'MM/dd/yyyy'),
FORMAT([TrnSales].[EntryDateTime], 'yyyy-MM-dd HH:mm:ss'), 
FORMAT([TrnSales].[UpdateDateTime], 'yyyy-MM-dd HH:mm:ss'), 
[SysCurrent].[SMSaleType], 
Nz(DCount("Id","trncollection","[CollectionDate] < " & [Forms]![SysSettings]![RLC_DateMem])+1),
IIf([MstTable].[TableCode] IS NULL Or [MstTable].[TableCode] = "", "Walk-In", [MstTable].[TableCode]), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, 1), 
IIF([TrnCollection].[IsReturn] = 1, 1, 0), 
IIF([TrnCollection].[IsReturn] = 1, FORMAT([TrnCollection].[Amount],'0.00000'), 0), 
IIf([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, FORMAT([GrossSales].[GrossSalesAmount], '0.00000')),
IIf([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000')), 
IIF([TrnCollection].[IsReturn] = 2, 1, 0), IIF([TrnCollection].[IsReturn] = 2, FORMAT([TrnCollection].[Amount],'0.00000'), 0), 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TotalDiscount].[TotalDiscountAmount] > 0),1,0),
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([GrossSales].[GrossSalesAmount]), '0.00000'),'0.00000'), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000'), 
IIF([MstTax].[Tax] = 'LOCAL TAX', FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'), '0.00000'), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL AND [TrnSalesLine].[TaxAmount] = 0, FORMAT(([GrossSales].[GrossSalesAmount] ), '0.00000'),'0.00000'),
[MstTerminal].[Terminal],
[TmpPayTypeSales].[TotalCashSales],
[TmpPayTypeSales].[TotalGiftCertificateSales],
[TmpPayTypeSales].[TotalOnlineSales],
[TmpPayTypeSales].[TotalCreditCardSales],
[TmpPayTypeSales].[TotalCreditCardTax]
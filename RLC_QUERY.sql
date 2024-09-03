SELECT 
DFirst("RLC_TenantId","SysCurrent") AS [TenantId], 
"00000000000000" & Right([MstTerminal].[Terminal],2) AS [TerminalNumber], 
REPLACE([TrnSales].[SalesNumber], '-', '') AS [OrderNumber],
FORMAT([TrnCollection].[CollectionDate], 'MM/dd/yyyy') AS [TransactionDay], 
IIf([MstTable].[TableCode] IS NULL Or [MstTable].[TableCode] = "", "Walk-In",  [MstTable].[TableCode]) AS [TransactionType], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, 1) AS Void, 
IIf([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000')) AS [VoidAmount], 
IIF([TrnCollection].[IsReturn] = 2, 1, 0) AS [Refund], 
IIF([TrnCollection].[IsReturn] = 2, FORMAT([TrnCollection].[Amount],'0.00000'), 0) AS [RefundAmount], 
IIF([TrnCollection].[IsReturn] = 1, 1, 0) AS [Return], 
IIF([TrnCollection].[IsReturn] = 1, FORMAT([TrnCollection].[Amount],'0.00000'), 0) AS [ReturnAmount], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [GrossSalesAmount], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([GrossSales].[GrossSalesAmount]), '0.00000'),'0.00000') AS [NetSalesAmount], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000') AS [TotalTax], 
IIF([MstTax].[Tax] = 'LOCAL TAX', FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'), '0.00000') AS [OtherLocalTax], 
MAX(IIf(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(Nz([TotalServiceCharge].[ServiceCharge], 0), '0.00000'), '0.00000')) AS [TotalServiceCharge],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TotalDiscount].[TotalDiscountAmount] > 0),1,0) AS [DiscountTransaction], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [TotalDiscount], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([GrossSales].[GrossSalesAmount] - [TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000') AS [LessTaxAmount],
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Employee Discount' OR [MstDiscount].[Discount] = 'Employee Meal'), FORMAT([TotalDiscount].[TotalDiscountAmount],'0.00000'), 0)) AS [EmployeeDiscountAmount],
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [SeniorCitizenDiscountAmount], 
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'VIP Discount'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [VIPDiscountAmount], 
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'PWD'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [PWDDiscountAmount], 
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'National Athlete Representative'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [NationalAthleteDiscountAmount],
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnCollectionLine].[PayTypeId] = [MstPayType].[Id] AND [MstPayType].[PayType] = 'Credit Card'), FORMAT([TotalTax].[TotalTaxAmount], '0.00000'), 0)) AS [CreditTaxAmount], 
[TmpPayTypeSales].[TotalCashSales] AS [TotalCashSales],
[TmpPayTypeSales].[TotalGiftCertificateSales] AS [TotalGiftCertificateSales],
[TmpPayTypeSales].[TotalOnlineSales] AS [TotalOnlineSales],
[TmpPayTypeSales].[TotalCreditCardSales] AS [TotalCreditCardSales]

INTO [RLC_TABLE]
FROM ((
    ((((((((((((((TrnSales LEFT JOIN TrnSalesLine ON [TrnSalesLine].[SalesId] = [TrnSales].[Id]) 
    LEFT JOIN [TrnCollection] ON [TrnSales].[Id] = [TrnCollection].[SalesId]) 
    LEFT JOIN [TmpPayTypeSales] ON [TmpPayTypeSales].[SalesId] = [TrnSales].[Id]))
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
IIf([MstTable].[TableCode] IS NULL Or [MstTable].[TableCode] = "", "Walk-In", [MstTable].[TableCode]), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, 1), 
IIF([TrnCollection].[IsReturn] = 1, 1, 0), 
IIF([TrnCollection].[IsReturn] = 1, FORMAT([TrnCollection].[Amount],'0.00000'), 0), 
IIf([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000')), 
IIF([TrnCollection].[IsReturn] = 2, 1, 0), IIF([TrnCollection].[IsReturn] = 2, FORMAT([TrnCollection].[Amount],'0.00000'), 0), 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TotalDiscount].[TotalDiscountAmount] > 0),1,0),
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([GrossSales].[GrossSalesAmount]), '0.00000'),'0.00000'), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000'), 
IIF([MstTax].[Tax] = 'LOCAL TAX', FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'), '0.00000'), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([GrossSales].[GrossSalesAmount] - [TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000'), 
[MstTerminal].[Terminal],
[TmpPayTypeSales].[TotalCashSales],
[TmpPayTypeSales].[TotalGiftCertificateSales],
[TmpPayTypeSales].[TotalOnlineSales],
[TmpPayTypeSales].[TotalCreditCardSales],

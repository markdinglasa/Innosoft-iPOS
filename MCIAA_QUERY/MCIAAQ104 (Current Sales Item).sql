INSERT INTO TmpMCIAA_SalesItem ( [receiptNo], [sku], [qty], [unitPrice], [DiscountAmount], [senior], [pwd], [diplomat], [taxtype], [tax], [memo], [total] )

SELECT
Nz([TrnCollection].[CollectionNumber],"NA") AS [receiptNo],
[MstItem].[ItemCode] AS [sku],
Nz([TrnSalesLine].[Quantity],0) AS [qty],
Nz([MstItem].[Price],0) AS [unitPrice],
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] <> 'PWD' AND [MstDiscount].[Discount] <> 'Senior Citizen Discount'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [DiscountAmount], 
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [senior], 
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'PWD'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [pwd], 
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Diplomat' OR [MstDiscount].[Discount] = 'Diplomat Discount'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [diplomat], 
[MstTax].[Tax] AS [taxtype],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000') AS [tax],
Nz([TrnSales].[Remarks], "NA") AS [memo],
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [gross]
FROM 
    (((((((((((((((((
        TrnSales 
    LEFT JOIN TrnSalesLine ON [TrnSalesLine].[SalesId] = [TrnSales].[Id]) 
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
    LEFT JOIN [TrnPaxTable] ON [TrnPaxTable].[SaleId] = [TrnSalesLine].[SalesId])
    LEFT JOIN (SELECT [SalesId], FORMAT(SUM(IIF([TrnSalesLine].[TaxAmount] = 0, [Amount], 0)), '0.00000') AS [NonVATSalesAmount] FROM [TrnSalesLine] GROUP BY [SalesId])  AS [NonVATSales] ON [TrnSales].[Id] = [NonVATSales].[SalesId]) 
    LEFT JOIN (SELECT [SalesId], SUM([Amount]) AS [GrossSalesAmount], SUM([Price]*[Quantity]) AS [TotalAmount] FROM TrnSalesLine GROUP BY [SalesId])  AS GrossSales ON [TrnSales].[Id] = GrossSales.[SalesId]) 
    LEFT JOIN (SELECT [SalesId], SUM([Amount]) AS ServiceCharge FROM TrnSalesLine WHERE [ItemId] = 1 GROUP BY [SalesId])  AS TotalServiceCharge ON [TrnSales].[Id] = [TotalServiceCharge].[SalesId]) 
    LEFT JOIN (SELECT [SalesId], (SUM([TaxAmount])) AS TotalTaxAmount FROM TrnSalesLine GROUP BY [SalesId])  AS TotalTax ON [TrnSales].[Id] = TotalTax.[SalesId]) 
    LEFT JOIN (SELECT [SalesId], SUM(([DiscountAmount])*([Quantity])) AS TotalDiscountAmount FROM TrnSalesLine GROUP BY [SalesId])  AS TotalDiscount ON [TrnSales].[Id] = [TotalDiscount].[SalesId]
WHERE [TrnSales].[IsLocked] = True 
  AND [TrnCollection].[IsLocked] = True 
  AND DAY([TrnSales].[SalesDate]) = DAY([Forms]![SysSettings]![MCIAA_DateMem]) 
  AND MONTH([TrnSales].[SalesDate]) = MONTH([Forms]![SysSettings]![MCIAA_DateMem]) 
  AND YEAR([TrnSales].[SalesDate]) = YEAR([Forms]![SysSettings]![MCIAA_DateMem]) 
GROUP BY 
Nz([TrnCollection].[CollectionNumber],"NA"),
[MstItem].[ItemCode],
Nz([TrnSalesLine].[Quantity],0),
Nz([MstItem].[Price],0),
[MstTax].[Tax],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000'),
Nz([TrnSales].[Remarks], "NA"),
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000')

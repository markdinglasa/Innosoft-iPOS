SELECT 
[TrnSales].[Id] AS [SalesId], 
FORMAT(SUM(IIF( ([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnCollectionLine].[Amount] > 0 OR [TrnCollectionLine].[Amount] IS NOT NULL) AND ([TrnCollectionLine].[PayTypeId] = [MstPayType].[Id] AND [MstPayType].[PayType] = 'Cash'), [TrnCollectionLine].[Amount], 0)), '0.00') AS [TotalCashSales], 
FORMAT(SUM(IIF( ([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnCollectionLine].[Amount] > 0 OR [TrnCollectionLine].[Amount] IS NOT NULL) AND ([TrnCollectionLine].[PayTypeId] = [MstPayType].[Id] AND [MstPayType].[PayType] = 'Gift Certificate'), [TrnCollectionLine].[Amount], 0)), '0.00')  AS [TotalGiftCertificateSales],
FORMAT(SUM(IIF( ([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnCollectionLine].[Amount] > 0 OR [TrnCollectionLine].[Amount] IS NOT NULL) AND ([TrnCollectionLine].[PayTypeId] = [MstPayType].[Id] AND [MstPayType].[PayType] = 'Gcash' OR [MstPayType].[PayType] = 'PayMaya' OR [MstPayType].[PayType] = 'GrabPay' OR [MstPayType].[PayType] = 'FoodPanda') , [TrnCollectionLine].[Amount], 0)), '0.00')  AS [TotalOnlineSales],
FORMAT(SUM(IIF( ([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnCollectionLine].[Amount] > 0 OR [TrnCollectionLine].[Amount] IS NOT NULL) AND ([TrnCollectionLine].[PayTypeId] = [MstPayType].[Id] AND [MstPayType].[PayType] = 'Mastercard'), [TrnCollectionLine].[Amount], 0)), '0.00') AS [TotalMastercardSales],
FORMAT(SUM(IIF( ([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnCollectionLine].[Amount] > 0 OR [TrnCollectionLine].[Amount] IS NOT NULL) AND ([TrnCollectionLine].[PayTypeId] = [MstPayType].[Id] AND [MstPayType].[PayType] = 'Visa'), [TrnCollectionLine].[Amount], 0)), '0.00') AS [TotalVisaSales],
FORMAT(SUM(IIF( ([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnCollectionLine].[Amount] > 0 OR [TrnCollectionLine].[Amount] IS NOT NULL) AND ([TrnCollectionLine].[PayTypeId] = [MstPayType].[Id] AND [MstPayType].[PayType] = 'Diners'), [TrnCollectionLine].[Amount], 0)),'0.00') AS [TotalDinersSales], 
FORMAT(SUM(IIF( ([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnCollectionLine].[Amount] > 0 OR [TrnCollectionLine].[Amount] IS NOT NULL) AND ([TrnCollectionLine].[PayTypeId] = [MstPayType].[Id] AND [MstPayType].[PayType] = 'JCB'), [TrnCollectionLine].[Amount], 0)), '0.00') AS [TotalJCBSales], 
FORMAT(SUM(IIF( ([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnCollectionLine].[Amount] > 0 OR [TrnCollectionLine].[Amount] IS NOT NULL) AND ([TrnCollectionLine].[PayTypeId] = [MstPayType].[Id] AND [MstPayType].[PayType] = 'Credit Card'), [TrnCollectionLine].[Amount], 0)), '0.00') AS [TotalCreditCardSales], 
[MstTerminal].[Terminal] AS [Terminal Number], 
[SysCurrent].[SMPOSSerialNumber] AS [Serial Number] 
INTO [TmpPayTypeSales]
FROM ((((TrnSales LEFT JOIN TrnCollection ON [TrnSales].[Id] = [TrnCollection].[SalesId]) 
LEFT JOIN TrnCollectionLine ON [TrnCollectionLine].[CollectionId] = [TrnCollection].[Id]) 
LEFT JOIN SysCurrent ON [TrnSales].[TerminalId] = [SysCurrent].[TerminalId]) 
LEFT JOIN MstPayType ON MstPayType.Id = TrnCollectionLine.PayTypeId) 
LEFT JOIN MstTerminal ON SysCurrent.TerminalId = [MstTerminal].[Id]
GROUP BY [TrnSales].[Id], [MstTerminal].[Terminal], [SysCurrent].[SMPOSSerialNumber]
HAVING SUM(IIF(([TrnCollectionLine].[Amount] > 0 OR [TrnCollectionLine].[Amount] IS NOT NULL), [TrnCollectionLine].[Amount], 0));
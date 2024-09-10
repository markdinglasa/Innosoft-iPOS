
INSERT INTO [TmpMCIAA_Sales] ( 
    [receiptNo], 
    [salesDate], 
    [nrgt],
    [LineTimeStamp],
    [voidamount],
    [void],
    [cash], 
    [cashcnt],
    [credit],
    [creditcnt],
    [charge], 
    [giftcheck],
    [giftcheckcnt],
    [othertender], 
    [othertendercnt], 
    [linedisc], 
    [linedisccnt], 
    [linesenior], 
    [lineseniorcnt],
    [evat], 
    [linepwd], 
    [linepwdcnt], 
    [linediplomat], 
    [linediplomatcnt], 
    [subtotal], 
    [disc], 
    [senior], 
    [pwd], 
    [diplomat], 
    [vat], 
    [exvat], 
    [incvat], 
    [localtax], 
    [amusement], 
    [ewt],
    [service], 
    [servicecnt], 
    [taxsale], 
    [notaxsale], 
    [taxexsale], 
    [taxincsale], 
    [zerosale], 
    [vatexempt],
    [customercount],
    [gross], 
    [refund], 
    [refundcnt],
    [taxrate], 
    [posted], 
    [memo] )
SELECT
[TrnCollection].[CollectionNumber] AS [receiptNo], 
[TrnCollection].[CollectionDate] AS [salesDate],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] <> 'Senior Citizen Discount'), FORMAT([TrnSalesLine].[Price], '0.00000'), (([TrnSalesLine].[Price1]+[TrnSalesLine].[Price2LessTax])*[Quantity])) AS [nrgt],
Format([SalesLineTimeStamp],'yyyymmddhhnnss') AS [LineTimeStamp] ,
IIf([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, FORMAT([GrossSales].[GrossSalesAmount], '0.00000')) AS [voidamount], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, 1) AS [void],
Nz([TmpPayTypeSales].[TotalCashSales],0) AS [cash],
IIF((Nz([TmpPayTypeSales].[TotalCashSales],0) > 0), 1,0) AS [cashcnt],
Nz([TmpPayTypeSales].[TotalCreditCardSales],0)  AS [credit],
IIF((Nz([TmpPayTypeSales].[TotalCreditCardSales],0) > 0),1,0) AS [creditcnt],
0 AS [charge],
Nz([TmpPayTypeSales].[TotalGiftCertificateSales],0) AS [giftcheck],
IIF((Nz([TmpPayTypeSales].[TotalGiftCertificateSales],0) > 0),1,0) AS [giftcheckcnt],
Nz([TmpPayTypeSales].[TotalOtherTenderSales],0) AS [othertender],
IIF((Nz([TmpPayTypeSales].[TotalOtherTenderSales],0) > 0),1,0) AS [othertendercnt],
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] <> 'PWD' AND [MstDiscount].[Discount] <> 'Senior Citizen Discount'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [linedisc], 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] <> 'PWD' AND [MstDiscount].[Discount] <> 'Senior Citizen Discount'), Nz(1,0), 0) AS [linedisccnt], 
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [linesenior], 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount'), 1,0) AS [lineseniorcnt],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount'), FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [evat],
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'PWD'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [linepwd], 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'PWD'), 1,0) AS [linepwdcnt],
MAX(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Diplomat Discount' OR [MstDiscount].[Discount] = 'Diplomat'), FORMAT([TotalDiscount].[TotalDiscountAmount], '0.00000'), 0)) AS [linediplomat], 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Diplomat Discount' OR [MstDiscount].[Discount] = 'Diplomat'),1,0) AS [linediplomatcnt],
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [subtotal], 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [disc], 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount'), FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [senior],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'PWD'), FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [pwd],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Diplomat Discount'), FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [diplomat],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000') AS [vat],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstTax].[Tax] = 'VAT-EXCLUSIVE'), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000') AS [exvat],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstTax].[Tax] = 'VAT' AND [MstDiscount].[Discount] <> 'Senior Citizen Discount'), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000') AS [incvat],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstTax].[Tax] = 'LOCAL TAX'), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'), '0.00000') AS [localtax], 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstTax].[Tax] = 'AMUSEMENT TAX'), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'), '0.00000') AS [amusement], 
0 AS [ewt],

MAX(IIf(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(Nz([TotalServiceCharge].[ServiceCharge], 0), '0.00000'), '0.00000')) AS [service],
IIf(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TotalServiceCharge].[ServiceCharge] > 0), 1,0) AS [servicecnt],
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) - (Nz([NonVATSales].[NonVATSalesAmount], 0) + Nz([TotalTax].[TotalTaxAmount], 0))), '0.00000'),'0.00000') AS [taxsale], 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(([NonVATSales].[NonVATSalesAmount] ), '0.00000'),'0.00000') AS [notaxsale],
0 AS [taxexsale],

IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(([NonVATSales].[NonVATSalesAmount] ), '0.00000'),'0.00000') AS [taxincsale],
0 AS [zerosale],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount' OR [MstDiscount].[Discount] = 'PWD Discount') AND [TrnPaxTable].[TotalPax] > 0, FORMAT((((([GrossSales].[TotalAmount]/[TrnPaxTable].[TotalPax])*[TrnPaxTable].[DiscountedPax])/1.12) - (((([GrossSales].[TotalAmount]/[TrnPaxTable].[TotalPax])*[TrnPaxTable].[DiscountedPax])/1.12)*0.2)), '0.00000'), 0) AS [vatexempt],
1 AS [customercount],
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000') AS [gross], 
MAX(FORMAT(Nz([RLC_REFUND].[ReturnAmount],0),'0.00000')) AS [refund], 
IIF((Nz([RLC_REFUND].[ReturnAmount],0) > 0),1,0) AS [refundcnt], 
Nz([TrnSalesLine].[TaxRate],0) AS [taxrate],
Format(Now(),"yyyymmddhhnnss") AS [posted], 
[TrnSales].[Remarks] AS [memo]

FROM 
    ((((((((((((((((((
        TrnSales 
    LEFT JOIN [TrnSalesLine] ON [TrnSalesLine].[SalesId] = [TrnSales].[Id]) 
    LEFT JOIN [TrnCollection] ON [TrnSales].[Id] = [TrnCollection].[SalesId]) 
    LEFT JOIN [TmpPayTypeSales] ON [TmpPayTypeSales].[SalesId] = [TrnSales].[Id])
    LEFT JOIN [TrnCollectionLine] ON [TrnCollectionLine].[CollectionId] = [TrnCollection].[Id]) 
    LEFT JOIN [SysCurrent] ON [TrnSales].[TerminalId] = [SysCurrent].[TerminalId]) 
    LEFT JOIN [MstTable] ON [TrnSales].[TableId] = [MstTable].[Id]) 
    LEFT JOIN [ItemsPurchase] ON [TrnSales].[Id] = [ItemsPurchase].[SalesId]) 
    LEFT JOIN [MstTax] ON [MstTax].[Id] = [TrnSalesLine].[TaxId])
    LEFT JOIN [MstItem] ON [MstItem].[Id] = [TrnSalesLine].ItemId) 
    LEFT JOIN [MstPayType] ON [MstPayType].[Id] = [TrnCollectionLine].[PayTypeId]) 
    LEFT JOIN [MstTerminal] ON [SysCurrent].[TerminalId] = [MstTerminal].[Id]) 
    LEFT JOIN [MstDiscount] ON [MstDiscount].[Id] = [TrnSalesLine].[DiscountId])
    LEFT JOIN [TrnPaxTable] ON [TrnPaxTable].[SaleId] = [TrnSalesLine].[SalesId])
    LEFT JOIN [RLC_REFUND] ON [RLC_REFUND].[TerminalId] = [MstTerminal].[Id])
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
[TrnCollection].[CollectionNumber],
[TrnCollection].[CollectionDate],
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] <> 'Senior Citizen Discount'), FORMAT([TrnSalesLine].[Price], '0.00000'), (([TrnSalesLine].[Price1]+[TrnSalesLine].[Price2LessTax])*[Quantity])),
Format([SalesLineTimeStamp],'yyyymmddhhnnss'),
IIf([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, FORMAT([GrossSales].[GrossSalesAmount], '0.00000')),
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, 0, 1),
Nz([TmpPayTypeSales].[TotalCashSales],0),
IIF((Nz([TmpPayTypeSales].[TotalCashSales],0) > 0), 1,0),
Nz([TmpPayTypeSales].[TotalCreditCardSales],0),
IIF((Nz([TmpPayTypeSales].[TotalCreditCardSales],0) > 0),1,0),
Nz([TmpPayTypeSales].[TotalGiftCertificateSales],0),
IIF((Nz([TmpPayTypeSales].[TotalGiftCertificateSales],0) > 0),1,0),
Nz([TmpPayTypeSales].[TotalOtherTenderSales],0),
IIF((Nz([TmpPayTypeSales].[TotalOtherTenderSales],0) > 0),1,0),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] <> 'PWD' AND [MstDiscount].[Discount] <> 'Senior Citizen Discount'), Nz(1,0), 0),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount'), 1,0),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount'), FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'PWD'), 1,0),

IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Diplomat Discount' OR [MstDiscount].[Discount] = 'Diplomat'),1,0),
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'), 
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(([TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount'), FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'PWD'), FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Diplomat Discount'), FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000'),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstTax].[Tax] = 'VAT-EXCLUSIVE'), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000'),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstTax].[Tax] = 'VAT' AND [MstDiscount].[Discount] <> 'Senior Citizen Discount'), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'),'0.00000'),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstTax].[Tax] = 'LOCAL TAX'), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'), '0.00000'), 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstTax].[Tax] = 'AMUSEMENT TAX'), FORMAT(([TotalTax].[TotalTaxAmount]), '0.00000'), '0.00000'),

IIf(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TotalServiceCharge].[ServiceCharge] > 0), 1,0),
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) - (Nz([NonVATSales].[NonVATSalesAmount], 0) + Nz([TotalTax].[TotalTaxAmount], 0))), '0.00000'),'0.00000'), 
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(([NonVATSales].[NonVATSalesAmount] ), '0.00000'),'0.00000'),

IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL), FORMAT(([NonVATSales].[NonVATSalesAmount] ), '0.00000'),'0.00000'),
IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([MstDiscount].[Discount] = 'Senior Citizen Discount' OR [MstDiscount].[Discount] = 'PWD Discount') AND [TrnPaxTable].[TotalPax] > 0, FORMAT((((([GrossSales].[TotalAmount]/[TrnPaxTable].[TotalPax])*[TrnPaxTable].[DiscountedPax])/1.12) - (((([GrossSales].[TotalAmount]/[TrnPaxTable].[TotalPax])*[TrnPaxTable].[DiscountedPax])/1.12)*0.2)), '0.00000'), 0),
IIF([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL, FORMAT(((([GrossSales].[GrossSalesAmount])) + [TotalDiscount].[TotalDiscountAmount]), '0.00000'),'0.00000'),
IIF((Nz([RLC_REFUND].[ReturnAmount],0) > 0),1,0), 
Nz([TrnSalesLine].[TaxRate],0),
Format(Now(),"yyyymmddhhnnss"),
[TrnSales].[Remarks]

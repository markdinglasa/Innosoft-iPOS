SELECT 
DFirst("RLC_TenantId","SysCurrent") AS TenantId, 
[TrnSales].[TerminalId] AS TerminalId,
Sum(Round(IIf([MstDiscount].[Discount]<>"Senior Citizen Discount" And [MstDiscount].[Discount]<>"PWD" AND (Nz([TrnCollection].[IsReturn], 0) <> 2),[Price],[Price1]+[Price2LessTax])    *[Quantity],3)) AS GrossSales, 
Sum(IIf(([TrnSalesLine].[TaxRate] > 0) AND (Nz([TrnCollection].[IsReturn], 0) < 1), [TrnSalesLine].[TaxAmount], 0)) AS TaxAmount,
Sum(IIF(Nz([TrnCollection].[IsReturn], 0) = 2, 0, [TrnSalesLine].[Amount])) AS NetSales,
Sum(IIf([trnsalesline].[Price2]>0 AND (Nz([TrnCollection].[IsReturn], 0) < 1), [trnsalesline].[quantity]*([trnsalesline].[price2lesstax]-([trnsalesline].[price2lesstax]*([TrnSalesLine].[DiscountRate]/100))),IIf([TrnSalesLine].[TaxId]=5,[TrnSalesLine].[Amount],0))) AS VATExempt,
SUM(IIF(([TrnCollection].[IsCancelled] = 0 OR [TrnCollection].[IsCancelled] IS NULL) AND ([TrnSalesLine].[TaxAmount]<1) AND ([TrnSalesLine].[Discountid]<>4 And [TrnSalesLine].[Discountid]<>3),[TrnSalesLine].[Amount],0)) AS NONVATSales
INTO [RLC_GROSSSALES]
FROM TrnSales 
    INNER JOIN ((((TrnSalesLine 
    LEFT JOIN TrnCollection ON [TrnCollection].[SalesId] = [TrnSalesLine].[SalesId]) 
    INNER JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id) 
    LEFT JOIN [TrnPaxTable] ON [TrnPaxTable].[SaleId] = [TrnSalesLine].[SalesId])
    INNER JOIN MstTax ON TrnSalesLine.TaxId = MstTax.Id) ON TrnSales.Id = TrnSalesLine.SalesId
WHERE 
    [TrnSales].[IsLocked] = True 
    AND [TrnCollection].[IsLocked] = True 
    AND TrnSales.IsCancelled = False AND TrnCollection.IsCancelled = False  
    AND DAY([TrnSales].[SalesDate]) = DAY([Forms]![SysSettings]![RLC_DateMem]) 
    AND MONTH([TrnSales].[SalesDate]) = MONTH([Forms]![SysSettings]![RLC_DateMem]) 
    AND YEAR([TrnSales].[SalesDate]) = YEAR([Forms]![SysSettings]![RLC_DateMem]) 
GROUP BY 
DFirst("RLC_TenantId","SysCurrent"),
[TrnSales].[TerminalId]
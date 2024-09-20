SELECT 
DFirst("RLC_TenantId","SysCurrent") AS TenantId, 
[TrnSales].[TerminalId] AS TerminalId,
Sum(Round(IIf([MstDiscount].[Discount]<>"Senior Citizen Discount" And [MstDiscount].[Discount]<>"PWD" AND (Nz([TrnCollection].[IsReturn], 0) <> 2),[Price],[Price1]+[Price2LessTax])*[Quantity],3)) AS GrossSales, 
Sum(IIf(([TrnSalesLine].[TaxRate] > 0) AND (Nz([TrnCollection].[IsReturn], 0) < 1), [TrnSalesLine].[TaxAmount], 0)) AS TaxAmount,
Sum(IIF(Nz([TrnCollection].[IsReturn], 0) = 2, 0, [TrnSalesLine].[Amount])) AS NetSales
INTO [RLC_GROSSSALES]
FROM TrnSales 
    INNER JOIN (((TrnSalesLine 
    LEFT JOIN TrnCollection ON [TrnCollection].[SalesId] = [TrnSalesLine].[SalesId]) 
    INNER JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id) 
    INNER JOIN MstTax ON TrnSalesLine.TaxId = MstTax.Id) ON TrnSales.Id = TrnSalesLine.SalesId
WHERE 
    [TrnSales].[IsLocked] = True 
    AND [TrnCollection].[IsLocked] = True 
    AND DAY([TrnSales].[SalesDate]) = DAY([Forms]![SysSettings]![RLC_DateMem]) 
    AND MONTH([TrnSales].[SalesDate]) = MONTH([Forms]![SysSettings]![RLC_DateMem]) 
    AND YEAR([TrnSales].[SalesDate]) = YEAR([Forms]![SysSettings]![RLC_DateMem]) 
GROUP BY 
DFirst("RLC_TenantId","SysCurrent"),
[TrnSales].[TerminalId]
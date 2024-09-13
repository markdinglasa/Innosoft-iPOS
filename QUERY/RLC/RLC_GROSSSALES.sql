SELECT 
DFirst("RLC_TenantId","SysCurrent") AS TenantId, 
"00000000000000" & Right(TmpCollectionZReading.TerminalId,2) AS TerminalNumber, 
TmpCollectionZReading.TerminalId AS TerminalId, 
Sum(Round(IIf([MstDiscount].[Discount]<>"Senior Citizen Discount" And [MstDiscount].[Discount]<>"PWD" AND (Nz([TrnCollection].[IsReturn], 0) <> 2),[Price],[Price1]+[Price2LessTax])*[Quantity],3)) AS GrossSales, 
Sum(IIf(([TrnSalesLine].[TaxRate] > 0) AND (Nz([TrnCollection].[IsReturn], 0) < 1), [TrnSalesLine].[TaxAmount], 0)) AS TaxAmount,
Sum(IIF(Nz([TrnCollection].[IsReturn], 0) = 2, 0, [TrnSalesLine].[Amount])) AS NetSales
INTO [RLC_GROSSSALES]
FROM TrnSales 
    INNER JOIN ((((TrnSalesLine 
    LEFT JOIN TrnCollection ON [TrnCollection].[SalesId] = [TrnSalesLine].[SalesId]) 
    INNER JOIN TmpCollectionZReading ON TrnSalesLine.SalesId = TmpCollectionZReading.SalesId) 
    INNER JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id) 
    INNER JOIN MstTax ON TrnSalesLine.TaxId = MstTax.Id) ON TrnSales.Id = TrnSalesLine.SalesId
GROUP BY 
    TmpCollectionZReading.TerminalId, 
    TmpCollectionZReading.CollectionDate, 
    TmpCollectionZReading.IsLocked, 
    TmpCollectionZReading.PreparedBy,
    TmpCollectionZReading.IsCancelled
HAVING 
(((TmpCollectionZReading.TerminalId)=Forms!RepPOS!TerminalId) 
And ((TmpCollectionZReading.CollectionDate)=Forms!RepPOS!DateReading) 
And ((TmpCollectionZReading.IsLocked)=True) 
And ((TmpCollectionZReading.IsCancelled)=False));

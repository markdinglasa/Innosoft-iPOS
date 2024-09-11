

SELECT 
MstTerminal.Terminal, 
TrnCollection.CollectionDate AS TransactionDate, 
Min(TrnCollection.CollectionNumber) AS FirstOR, 
Max(TrnCollection.CollectionNumber) AS LastOR, 
0 AS PreviousSalesAmount, 
Sum(IIf([MstDiscount].[IsVatExempt]=True,Round([TrnSalesLine].[Price]/1.12,5),[TrnSalesLine].[Price])*IIf((([TrnCollection].[IsCancelled]=True) OR ([TrnCollection].[IsReturn]=2)),0,[TrnSalesLine].[Quantity])) AS GrossSalesAmount, 
Sum(IIf(([TrnCollection].[IsCancelled]=True OR [TrnCollection].[IsReturn]=2),0,[TrnSalesLine].[Amount])) AS SalesAmount, 
Sum(IIf([TrnCollection].[IsCancelled]=False,0,[TrnSalesLine].[Amount])) AS VoidSalesAmount, 
Sum(IIf([TrnSalesLine].[TaxAmount]>0,IIf(([TrnCollection].[IsCancelled]=True) OR ([TrnCollection].[IsReturn]=2),0,[TrnSalesLine].[Amount]),0)) AS SalesWithTaxAmount, 
Sum(IIf([TrnSalesLine].[TaxAmount]<=0,IIf(([TrnCollection].[IsCancelled]=True) OR ([TrnCollection].[IsReturn]=2),0,[TrnSalesLine].[Amount]),0)) AS SalesWithoutTaxAmount,
Sum(IIf(([TrnCollection].[IsCancelled]=True) OR ([TrnCollection].[IsReturn]=2),0,[TrnSalesLine].[TaxAmount])) AS TaxAmount, 
Sum(IIf(([TrnCollection].[IsCancelled]=True) OR ([TrnCollection].[IsReturn]=2),0,[TrnSalesLine].[DiscountAmount]*[TrnSalesLine].[Quantity])) AS DiscountAmount
FROM ((TrnCollection 
INNER JOIN MstTerminal ON TrnCollection.TerminalId = MstTerminal.Id) 
INNER JOIN TrnSalesLine ON TrnCollection.SalesId = TrnSalesLine.SalesId) 
INNER JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id
GROUP BY MstTerminal.Terminal, TrnCollection.CollectionDate, IIf([TrnCollection].[CollectionDate]>=[Forms]![RepCollection]![DateStart] And [TrnCollection].[CollectionDate]<=[Forms]![RepCollection]![DateEnd],True,False), TrnCollection.IsLocked, IIf(IsNull([TrnCollection].[SalesId]),False,True), TrnCollection.TerminalId
HAVING (((
    IIf([TrnCollection].[CollectionDate]>=[Forms]![RepCollection]![DateStart] 
    And [TrnCollection].[CollectionDate]<=[Forms]![RepCollection]![DateEnd],True,False))=True) 
    AND ((TrnCollection.IsLocked)=True) 
    AND ((IIf(IsNull([TrnCollection].[SalesId]),False,True))=True)
    AND ((TrnCollection.TerminalId)=[Forms]![RepCollection]![TerminalId]));

/*ORIGIN*/
SELECT MstTerminal.Terminal, TrnCollection.CollectionDate AS TransactionDate, Min(TrnCollection.CollectionNumber) AS FirstOR, Max(TrnCollection.CollectionNumber) AS LastOR, 0 AS PreviousSalesAmount, Sum(IIf([MstDiscount].[IsVatExempt]=True,Round([TrnSalesLine].[Price]/1.12,5),[TrnSalesLine].[Price])*IIf([TrnCollection].[IsCancelled]=True,0,[TrnSalesLine].[Quantity])) AS GrossSalesAmount, Sum(IIf([TrnCollection].[IsCancelled]=True,0,[TrnSalesLine].[Amount])) AS SalesAmount, Sum(IIf([TrnCollection].[IsCancelled]=False,0,[TrnSalesLine].[Amount])) AS VoidSalesAmount, Sum(IIf([TrnSalesLine].[TaxAmount]>0,IIf([TrnCollection].[IsCancelled]=True,0,[TrnSalesLine].[Amount]),0)) AS SalesWithTaxAmount, Sum(IIf([TrnSalesLine].[TaxAmount]<=0,IIf([TrnCollection].[IsCancelled]=True,0,[TrnSalesLine].[Amount]),0)) AS SalesWithoutTaxAmount, Sum(IIf([TrnCollection].[IsCancelled]=True,0,[TrnSalesLine].[TaxAmount])) AS TaxAmount, Sum(IIf([TrnCollection].[IsCancelled]=True,0,[TrnSalesLine].[DiscountAmount]*[TrnSalesLine].[Quantity])) AS DiscountAmount
FROM ((TrnCollection INNER JOIN MstTerminal ON TrnCollection.TerminalId = MstTerminal.Id) INNER JOIN TrnSalesLine ON TrnCollection.SalesId = TrnSalesLine.SalesId) INNER JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id
GROUP BY MstTerminal.Terminal, TrnCollection.CollectionDate, IIf([TrnCollection].[CollectionDate]>=[Forms]![RepCollection]![DateStart] And [TrnCollection].[CollectionDate]<=[Forms]![RepCollection]![DateEnd],True,False), TrnCollection.IsLocked, IIf(IsNull([TrnCollection].[SalesId]),False,True), TrnCollection.TerminalId
HAVING (((IIf([TrnCollection].[CollectionDate]>=[Forms]![RepCollection]![DateStart] And [TrnCollection].[CollectionDate]<=[Forms]![RepCollection]![DateEnd],True,False))=True) AND ((TrnCollection.IsLocked)=True) AND ((IIf(IsNull([TrnCollection].[SalesId]),False,True))=True) AND ((TrnCollection.TerminalId)=[Forms]![RepCollection]![TerminalId]));
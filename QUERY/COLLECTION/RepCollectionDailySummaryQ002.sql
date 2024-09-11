SELECT 
MstTerminal.Terminal, 
CVDate([Forms]![RepCollection]![DateStart]) AS TransactionDate, 
"" AS FirstOR, "" 
AS LastOR, 
Sum(TrnCollection.Amount) AS PreviousSalesAmount, 
0 AS GrossSalesAmount, 0 AS SalesAmount, 
0 AS VoidSalesAmount, 0 AS SalesWithTaxAmount, 
0 AS SalesWithoutTaxAmount,
 Sum(0) AS TaxAmount, 
 0 AS DiscountAmount
FROM TrnCollection INNER JOIN MstTerminal ON TrnCollection.TerminalId = MstTerminal.Id
GROUP BY 
MstTerminal.Terminal, CVDate([Forms]![RepCollection]![DateStart]), 
IIf([TrnCollection].[CollectionDate]<[Forms]![RepCollection]![DateStart],True,False), 
TrnCollection.IsCancelled,
TrnCollection.IsReturn, 
TrnCollection.IsLocked, 
IIf(IsNull([TrnCollection].[SalesId]),False,True), TrnCollection.TerminalId
HAVING (((
    IIf([TrnCollection].[CollectionDate]<[Forms]![RepCollection]![DateStart],True,False))=True) 
    AND ((TrnCollection.IsCancelled)=False)
    AND (Nz(TrnCollection.IsReturn,0)=0) 
    AND ((TrnCollection.IsLocked)=True) 
    AND ((IIf(IsNull([TrnCollection].[SalesId]),False,True))=True) 
    AND ((TrnCollection.TerminalId)=[Forms]![RepCollection]![TerminalId]));


/*ORIGIN*/
SELECT MstTerminal.Terminal, CVDate([Forms]![RepCollection]![DateStart]) AS TransactionDate, "" AS FirstOR, "" AS LastOR, Sum(TrnCollection.Amount) AS PreviousSalesAmount, 0 AS GrossSalesAmount, 0 AS SalesAmount, 0 AS VoidSalesAmount, 0 AS SalesWithTaxAmount, 0 AS SalesWithoutTaxAmount, Sum(0) AS TaxAmount, 0 AS DiscountAmount
FROM TrnCollection INNER JOIN MstTerminal ON TrnCollection.TerminalId = MstTerminal.Id
GROUP BY MstTerminal.Terminal, CVDate([Forms]![RepCollection]![DateStart]), IIf([TrnCollection].[CollectionDate]<[Forms]![RepCollection]![DateStart],True,False), TrnCollection.IsCancelled, TrnCollection.IsLocked, IIf(IsNull([TrnCollection].[SalesId]),False,True), TrnCollection.TerminalId
HAVING (((IIf([TrnCollection].[CollectionDate]<[Forms]![RepCollection]![DateStart],True,False))=True) AND ((TrnCollection.IsCancelled)=False) AND ((TrnCollection.IsLocked)=True) AND ((IIf(IsNull([TrnCollection].[SalesId]),False,True))=True) AND ((TrnCollection.TerminalId)=[Forms]![RepCollection]![TerminalId]));

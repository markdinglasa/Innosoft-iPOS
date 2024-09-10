SELECT "CurrentCollection" AS Document, 
TrnCollection.TerminalId, 
TrnCollection.CollectionDate, 
TrnCollection.IsLocked, 0 AS GrossSales, 
0 AS Discount, 
0 AS SeniorCitizenDiscount, 
0 AS PWDDiscount, 
0 AS NetSales, 
Sum(IIf([trncollection].[IsReturn]=1,[amount],0)) AS SalesReturn, 
Sum(IIf([trncollection].[IsReturn]=2,[amount],0)) AS SalesRefund, 
0 AS PreviousNetSales, 
0 AS VATSales, 
0 AS VATEXEMPTSales, 
0 AS NONVATSales, 
0 AS VATAmount, 
Min(TrnCollection.CollectionNumber) AS StartingCollectionNumber, 
Max(TrnCollection.CollectionNumber) AS EndingCollectionNumber,
Count(IIf(Nz([TrnCollection].[IsReturn], 0) <= 0, [TrnCollection].[CollectionNumber], Null))  AS NoOfTransaction, 
Sum(IIf([trncollection].[iscancelled]=True,1,0)) AS NoOfCancelledTransaction, 
Sum(IIf([trncollection].[iscancelled]=True,[amount],0)) AS TotalCancelledAmount, 
0 AS NoOfSKU, 0 AS TotalQuantity, TrnCollection.PreparedBy, Count(TrnCollection.collectionnumber) AS Zcounter
FROM TrnCollection
GROUP BY "CurrentCollection", TrnCollection.TerminalId, TrnCollection.CollectionDate, TrnCollection.IsLocked, 0, TrnCollection.PreparedBy
HAVING (((TrnCollection.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TrnCollection.CollectionDate)=[Forms]![RepPOS]![DateReading]) AND ((TrnCollection.IsLocked)=True));


/*ORIGIN*/
SELECT "CurrentCollection" AS Document, TrnCollection.TerminalId, TrnCollection.CollectionDate, TrnCollection.IsLocked, 0 AS GrossSales, 0 AS Discount, 0 AS SeniorCitizenDiscount, 0 AS PWDDiscount, 0 AS NetSales, 0 AS SalesReturn, 0 AS PreviousNetSales, 0 AS VATSales, 0 AS VATEXEMPTSales, 0 AS NONVATSales, 0 AS VATAmount, Min(TrnCollection.CollectionNumber) AS StartingCollectionNumber, Max(TrnCollection.CollectionNumber) AS EndingCollectionNumber, Count(TrnCollection.CollectionNumber) AS NoOfTransaction, Sum(IIf([trncollection].[iscancelled]=True,1,0)) AS NoOfCancelledTransaction, Sum(IIf([trncollection].[iscancelled]=True,[amount],0)) AS TotalCancelledAmount, 0 AS NoOfSKU, 0 AS TotalQuantity, TrnCollection.PreparedBy, Count(TrnCollection.collectionnumber) AS Zcounter
FROM TrnCollection
GROUP BY "CurrentCollection", TrnCollection.TerminalId, TrnCollection.CollectionDate, TrnCollection.IsLocked, 0, TrnCollection.PreparedBy
HAVING (((TrnCollection.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TrnCollection.CollectionDate)=[Forms]![RepPOS]![DateReading]) AND ((TrnCollection.IsLocked)=True));
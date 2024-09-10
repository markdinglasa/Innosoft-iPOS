SELECT "SalesReturn" AS Document, 
TrnCollection.TerminalId, 
TrnStockIn.StockInDate AS CollectionDate, 
TrnStockIn.IsLocked, 0 AS GrossSales, 
0 AS Discount,
0 AS SeniorCitizenDiscount, 
0 AS PWDDiscount, 
Sum(0) AS NetSales, 
Sum(IIF(Nz([TrnCollection].[IsReturn], 0) = 1, [TrnCollection].[Amount], 0)) AS SalesReturn, 
Sum(IIF(Nz([TrnCollection].[IsReturn], 0) = 2, [TrnCollection].[Amount], 0)) AS SalesRefund, 
0 AS PreviousNetSales, 
0 AS VATSales, 
0 AS VATEXEMPTSales, 
0 AS NONVATSales, 
0 AS VATAmount, "" AS StartingCollectionNumber, "" AS EndingCollectionNumber, 
0 AS NoOfTransaction, 
0 AS NoOfCancelledTransaction, 
0 AS TotalCancelledAmount, 
0 AS NoOfSKU, 
0 AS TotalQuantity, 
TrnCollection.PreparedBy, 
0 AS Zcounter
FROM TrnStockInLine INNER JOIN (TrnStockIn INNER JOIN TrnCollection ON TrnStockIn.CollectionId = TrnCollection.Id) ON TrnStockInLine.StockInId = TrnStockIn.Id
GROUP BY TrnCollection.TerminalId, TrnStockIn.StockInDate, TrnStockIn.IsLocked, TrnCollection.PreparedBy, TrnStockIn.IsReturn
HAVING (((TrnCollection.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TrnStockIn.StockInDate)=[Forms]![RepPOS]![DateReading]) AND ((TrnStockIn.IsLocked)=True) AND ((TrnStockIn.IsReturn)=True));

SELECT "SalesReturn" AS Document, TrnCollection.TerminalId, TrnStockIn.StockInDate AS CollectionDate, TrnStockIn.IsLocked, 0 AS GrossSales, 0 AS Discount, 0 AS SeniorCitizenDiscount, 0 AS PWDDiscount, Sum(0) AS NetSales, Sum(TrnStockInLine.Amount) AS SalesReturn, 0 AS PreviousNetSales, 0 AS VATSales, 0 AS VATEXEMPTSales, 0 AS NONVATSales, 0 AS VATAmount, "" AS StartingCollectionNumber, "" AS EndingCollectionNumber, 0 AS NoOfTransaction, 0 AS NoOfCancelledTransaction, 0 AS TotalCancelledAmount, 0 AS NoOfSKU, 0 AS TotalQuantity, TrnCollection.PreparedBy, 0 AS Zcounter
FROM TrnStockInLine INNER JOIN (TrnStockIn INNER JOIN TrnCollection ON TrnStockIn.CollectionId = TrnCollection.Id) ON TrnStockInLine.StockInId = TrnStockIn.Id
GROUP BY TrnCollection.TerminalId, TrnStockIn.StockInDate, TrnStockIn.IsLocked, TrnCollection.PreparedBy, TrnStockIn.IsReturn
HAVING (((TrnCollection.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TrnStockIn.StockInDate)=[Forms]![RepPOS]![DateReading]) AND ((TrnStockIn.IsLocked)=True) AND ((TrnStockIn.IsReturn)=True));


/*ORIGIN*/
SELECT "SalesReturn" AS Document, TrnCollection.TerminalId, TrnStockIn.StockInDate AS CollectionDate, TrnStockIn.IsLocked, 0 AS GrossSales, 0 AS Discount, 0 AS SeniorCitizenDiscount, 0 AS PWDDiscount, Sum(0) AS NetSales, 
Sum(TrnStockInLine.Amount) AS SalesReturn, 
0 AS PreviousNetSales, 0 AS VATSales, 0 AS VATEXEMPTSales, 0 AS NONVATSales, 0 AS VATAmount, "" AS StartingCollectionNumber, "" AS EndingCollectionNumber, 0 AS NoOfTransaction, 0 AS NoOfCancelledTransaction, 0 AS TotalCancelledAmount, 0 AS NoOfSKU, 0 AS TotalQuantity, TrnCollection.PreparedBy, 0 AS Zcounter
FROM TrnStockInLine INNER JOIN (TrnStockIn INNER JOIN TrnCollection ON TrnStockIn.CollectionId = TrnCollection.Id) ON TrnStockInLine.StockInId = TrnStockIn.Id
GROUP BY TrnCollection.TerminalId, TrnStockIn.StockInDate, TrnStockIn.IsLocked, TrnCollection.PreparedBy, TrnStockIn.IsReturn
HAVING (((TrnCollection.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TrnStockIn.StockInDate)=[Forms]![RepPOS]![DateReading]) AND ((TrnStockIn.IsLocked)=True) AND ((TrnStockIn.IsReturn)=True));

SELECT 
TrnCollection.CollectionDate, 
TrnCollection.CollectionNumber, 
MstCustomer.Customer, 
TrnCollectionLine.Amount, 
TrnCollectionLine.OtherInformation, "Terminal " & [MstTerminal].[Terminal] AS Terminal1
FROM (((((TrnCollection INNER JOIN MstCustomer ON TrnCollection.CustomerId = MstCustomer.Id) LEFT JOIN TrnSales ON TrnCollection.SalesId = TrnSales.Id) INNER JOIN MstTerminal ON TrnCollection.TerminalId = MstTerminal.Id) INNER JOIN TrnCollectionLine ON TrnCollection.Id = TrnCollectionLine.CollectionId) INNER JOIN MstPayType ON TrnCollectionLine.PayTypeId = MstPayType.Id) INNER JOIN TrnStockIn ON TrnCollectionLine.StockInId = TrnStockIn.Id
WHERE (((TrnCollection.CollectionDate) Between [Forms]![RepCollection]![DateStart] 
And [Forms]![RepCollection]![DateEnd]) 
AND ((TrnCollectionLine.Amount)>0) 
AND ((TrnCollection.IsLocked)=True)
AND ((TrnCollection.IsReturn)=2) 
AND ((TrnCollection.TerminalId)=[Forms]![RepCollection]![TerminalId]) 
AND ((MstPayType.PayType)="Rewards"));


/*ORIGIN*/
SELECT TrnCollection.CollectionDate, TrnCollection.CollectionNumber, MstCustomer.Customer, TrnCollectionLine.Amount, TrnCollectionLine.OtherInformation, "Terminal " & [MstTerminal].[Terminal] AS Terminal1
FROM (((((TrnCollection INNER JOIN MstCustomer ON TrnCollection.CustomerId = MstCustomer.Id) LEFT JOIN TrnSales ON TrnCollection.SalesId = TrnSales.Id) INNER JOIN MstTerminal ON TrnCollection.TerminalId = MstTerminal.Id) INNER JOIN TrnCollectionLine ON TrnCollection.Id = TrnCollectionLine.CollectionId) INNER JOIN MstPayType ON TrnCollectionLine.PayTypeId = MstPayType.Id) INNER JOIN TrnStockIn ON TrnCollectionLine.StockInId = TrnStockIn.Id
WHERE (((TrnCollection.CollectionDate) Between [Forms]![RepCollection]![DateStart] And [Forms]![RepCollection]![DateEnd]) AND ((TrnCollectionLine.Amount)>0) AND ((TrnCollection.IsLocked)=True) AND ((TrnCollection.TerminalId)=[Forms]![RepCollection]![TerminalId]) AND ((MstPayType.PayType)="Rewards"));

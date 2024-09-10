SELECT 
TrnCollection.CollectionDate, 
TrnCollection.CollectionNumber, 
MstCustomer.Customer, 
TrnCollection.Remarks, 
TrnSales.SalesNumber, 
MstUser.UserName AS [User], 
MstPayType.PayType, 
TrnCollectionLine.Amount, 
IIf([MstPayType].[PayType]="Cash",[TrnCollection].[ChangeAmount],0) AS ChangeAmount1, 
[TrnCollectionLine].[Amount]-[ChangeAmount1] AS Amount2, 
MstTerminal.Terminal AS Terminal1
FROM (((((TrnCollection 
INNER JOIN MstCustomer ON TrnCollection.CustomerId = MstCustomer.Id) 
LEFT JOIN TrnSales ON TrnCollection.SalesId = TrnSales.Id) 
INNER JOIN MstTerminal ON TrnCollection.TerminalId = MstTerminal.Id) 
INNER JOIN TrnCollectionLine ON TrnCollection.Id = TrnCollectionLine.CollectionId) 
INNER JOIN MstPayType ON TrnCollectionLine.PayTypeId = MstPayType.Id) 
INNER JOIN MstUser ON TrnCollection.PreparedBy = MstUser.Id
WHERE (((TrnCollection.CollectionDate) Between [Forms]![RepCollection]![DateStart] 
And [Forms]![RepCollection]![DateEnd]) 
AND ((TrnCollectionLine.Amount)>0) 
AND ((TrnCollection.TerminalId)=[Forms]![RepCollection]![TerminalId]) 
AND ((TrnCollection.IsCancelled)=False) 
AND (Nz(TrnCollection.IsReturn,0)=0) 
AND ((TrnCollection.IsLocked)=True));




/*ORIGIN*/
SELECT TrnCollection.CollectionDate, TrnCollection.CollectionNumber, MstCustomer.Customer, TrnCollection.Remarks, TrnSales.SalesNumber, MstUser.UserName AS [User], MstPayType.PayType, TrnCollectionLine.Amount, IIf([MstPayType].[PayType]="Cash",[TrnCollection].[ChangeAmount],0) AS ChangeAmount1, [TrnCollectionLine].[Amount]-[ChangeAmount1] AS Amount2, MstTerminal.Terminal AS Terminal1
FROM (((((TrnCollection INNER JOIN MstCustomer ON TrnCollection.CustomerId = MstCustomer.Id) LEFT JOIN TrnSales ON TrnCollection.SalesId = TrnSales.Id) INNER JOIN MstTerminal ON TrnCollection.TerminalId = MstTerminal.Id) INNER JOIN TrnCollectionLine ON TrnCollection.Id = TrnCollectionLine.CollectionId) INNER JOIN MstPayType ON TrnCollectionLine.PayTypeId = MstPayType.Id) INNER JOIN MstUser ON TrnCollection.PreparedBy = MstUser.Id
WHERE (((TrnCollection.CollectionDate) Between [Forms]![RepCollection]![DateStart] And [Forms]![RepCollection]![DateEnd]) AND ((TrnCollectionLine.Amount)>0) AND ((TrnCollection.TerminalId)=[Forms]![RepCollection]![TerminalId]) AND ((TrnCollection.IsCancelled)=False) AND ((TrnCollection.IsLocked)=True));

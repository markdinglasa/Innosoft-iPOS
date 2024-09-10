
SELECT 
TrnCollection.CollectionDate, 
TrnCollection.CollectionNumber, 
MstCustomer.Customer, 
TrnSales.SalesNumber, 
TrnCollection.Amount, 
TrnCollection.TenderAmount, 
TrnCollection.ChangeAmount, 
MstUser.UserName AS [User], 
MstTerminal.terminal AS Terminal1
FROM (((TrnCollection INNER JOIN MstCustomer ON TrnCollection.CustomerId = MstCustomer.Id) LEFT JOIN TrnSales ON TrnCollection.SalesId = TrnSales.Id) INNER JOIN MstTerminal ON TrnCollection.TerminalId = MstTerminal.Id) INNER JOIN MstUser ON TrnCollection.PreparedBy = MstUser.Id
WHERE 
(((TrnCollection.CollectionDate) Between Forms!RepCollection!DateStart 
And Forms!RepCollection!DateEnd) 
And ((TrnCollection.TerminalId)=Forms!RepCollection!TerminalId) 
And ((TrnCollection.IsLocked)=True) 
And ((TrnCollection.IsCancelled)=False) 
And ((TrnCollection.IsReturn)=0));




/*ORIGIN*/
SELECT TrnCollection.CollectionDate, TrnCollection.CollectionNumber, MstCustomer.Customer, TrnSales.SalesNumber, TrnCollection.Amount, TrnCollection.TenderAmount, TrnCollection.ChangeAmount, MstUser.UserName AS [User], MstTerminal.terminal AS Terminal1
FROM (((TrnCollection INNER JOIN MstCustomer ON TrnCollection.CustomerId = MstCustomer.Id) LEFT JOIN TrnSales ON TrnCollection.SalesId = TrnSales.Id) INNER JOIN MstTerminal ON TrnCollection.TerminalId = MstTerminal.Id) INNER JOIN MstUser ON TrnCollection.PreparedBy = MstUser.Id
WHERE (((TrnCollection.CollectionDate) Between Forms!RepCollection!DateStart And Forms!RepCollection!DateEnd) And ((TrnCollection.TerminalId)=Forms!RepCollection!TerminalId) And ((TrnCollection.IsLocked)=True) And ((TrnCollection.IsCancelled)=False) And ((TrnCollection.IsReturn)=2));




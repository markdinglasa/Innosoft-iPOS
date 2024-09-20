



SELECT 
TrnSales.SalesDate, 
TrnSales.SalesNumber, 
IIf([IsReturn] = 2 OR [IsCancelled] = True, 0, [trnSales].[Amount]) AS Amount1, 
TrnSales.CustomerId, Nz([TrnSales].[Remarks],"") AS Remarks1, 
TrnSales.Id, 
MstCustomer.Customer, 
MstUser.UserName, 
MstTerminal.Terminal, 
TrnSales.IsLocked, IIf([TrnSales].[PaidAmount]>0,True,False) AS IsCollected, 
TrnSales.IsCancelled, TrnSales.SalesDate, 
Format([trnsales].[SalesDate],"mm/dd/yyyy") AS SalesDateFilter, 
[salesnumber] & [mstcustomer].[customer] & [mstuser].[username] & [mstterminal].[terminal] & Format([trnsales].[salesdate],"mm/dd/yyyy") AS Filter, 
IIf([TrnSales].[IsLocked]=True,"True","False") AS IsLockedFilter, 
IIf([TrnSales].[PaidAmount]>0,"True","False") AS IsCollectedFilter, 
IIf([TrnSales].[IsCancelled]=True,"True","False") AS IsCancelledFilter, 
IIf([TrnSales].[IsLocked]=True,"Locked","Unlocked") AS IsLockFilter,
IIf([TrnSales].[IsCancelled]=True,"Cancelled","UnCancelled") AS IsCancelFilter, 
IIf([TrnSales].[PaidAmount]>0,"Tendered","Untendered") AS IsCollectFilter

FROM ((TrnSales INNER JOIN MstCustomer ON TrnSales.CustomerId = MstCustomer.Id) LEFT JOIN MstUser ON TrnSales.PreparedBy = MstUser.Id) LEFT JOIN MstTerminal ON TrnSales.TerminalId = MstTerminal.Id
WHERE (((TrnSales.SalesNumber) Like "*" & [Forms]![TrnSales]![SalesNumberFilter] & "*") 
AND ((IIf([IsReturn] = 2, 0, IIf([IsReturn] = 1, 0, IIf([IsCancelled] = True,0, [trnSales].[Amount])))) Like "*" & [Forms]![TrnSales]![AmountFilter] & "*") 
AND ((MstCustomer.Customer) Like "*" & [Forms]![TrnSales]![CustomerFilter] & "*") 
AND ((MstUser.UserName) Like "*" & [Forms]![TrnSales]![UserNameFilter] & "*") 
AND ((MstTerminal.Terminal) Like "*" & [Forms]![TrnSales]![TerminalFilter] & "*") 
AND ((TrnSales.SalesDate)=[Forms]![TrnSales]![SalesDateFilter]) 
AND ((IIf([TrnSales].[IsLocked]=True,"Locked","Unlocked")) Like [Forms]![TrnSales]![IsLockedFilter]) 
AND ((IIf([TrnSales].[IsCancelled]=True,"Cancelled","UnCancelled")) Like [Forms]![TrnSales]![IsCancelledFilter]) 
AND ((IIf([TrnSales].[PaidAmount]>0,"Tendered","Untendered")) Like [Forms]![TrnSales]![IsTenderedFilter]))
ORDER BY TrnSales.SalesNumber DESC , TrnSales.Id DESC;



/*ORIGIN*/
SELECT 
TrnSales.SalesDate, 
TrnSales.SalesNumber, 
IIf([trnsales].[iscancelled]=True,0,[trnsales].[amount]) AS Amount1, 
TrnSales.CustomerId, Nz([TrnSales].[Remarks],"") AS Remarks1, 
TrnSales.Id, 
MstCustomer.Customer, 
MstUser.UserName, 
MstTerminal.Terminal, 
TrnSales.IsLocked, IIf([TrnSales].[PaidAmount]>0,True,False) AS IsCollected, 
TrnSales.IsCancelled, TrnSales.SalesDate, 
Format([trnsales].[SalesDate],"mm/dd/yyyy") AS SalesDateFilter, 
[salesnumber] & [mstcustomer].[customer] & [mstuser].[username] & [mstterminal].[terminal] & Format([trnsales].[salesdate],"mm/dd/yyyy") AS Filter, 
IIf([TrnSales].[IsLocked]=True,"True","False") AS IsLockedFilter, 
IIf([TrnSales].[PaidAmount]>0,"True","False") AS IsCollectedFilter, 
IIf([TrnSales].[IsCancelled]=True,"True","False") AS IsCancelledFilter, 
IIf([TrnSales].[IsLocked]=True,"Locked","Unlocked") AS IsLockFilter,
IIf([TrnSales].[IsCancelled]=True,"Cancelled","UnCancelled") AS IsCancelFilter, 
IIf([TrnSales].[PaidAmount]>0,"Tendered","Untendered") AS IsCollectFilter

FROM ((TrnSales INNER JOIN MstCustomer ON TrnSales.CustomerId = MstCustomer.Id) LEFT JOIN MstUser ON TrnSales.PreparedBy = MstUser.Id) LEFT JOIN MstTerminal ON TrnSales.TerminalId = MstTerminal.Id
WHERE (((TrnSales.SalesNumber) Like "*" & [Forms]![TrnSales]![SalesNumberFilter] & "*") AND ((IIf([trnsales].[iscancelled]=True,0,[trnsales].[amount])) Like "*" & [Forms]![TrnSales]![AmountFilter] & "*") AND ((MstCustomer.Customer) Like "*" & [Forms]![TrnSales]![CustomerFilter] & "*") AND ((MstUser.UserName) Like "*" & [Forms]![TrnSales]![UserNameFilter] & "*") AND ((MstTerminal.Terminal) Like "*" & [Forms]![TrnSales]![TerminalFilter] & "*") AND ((TrnSales.SalesDate)=[Forms]![TrnSales]![SalesDateFilter]) AND ((IIf([TrnSales].[IsLocked]=True,"Locked","Unlocked")) Like [Forms]![TrnSales]![IsLockedFilter]) AND ((IIf([TrnSales].[IsCancelled]=True,"Cancelled","UnCancelled")) Like [Forms]![TrnSales]![IsCancelledFilter]) AND ((IIf([TrnSales].[PaidAmount]>0,"Tendered","Untendered")) Like [Forms]![TrnSales]![IsTenderedFilter]))
ORDER BY TrnSales.SalesNumber DESC , TrnSales.Id DESC;

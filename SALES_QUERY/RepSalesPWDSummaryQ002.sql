SELECT 
TrnSales.SalesDate, 
MstTerminal.Terminal, 
TrnSales.SalesNumber, 
IIf([IsCancelled]=0,"Locked","Cancelled") AS Status, 
TrnSales.SeniorCitizenId, 
TrnSales.SeniorCitizenName, 
TrnSales.SeniorCitizenAge, 
MstUser.username AS [User], MstUser_1.username AS 
Sales, MstTerm.Term, 
Sum(IIf([Iscancelled]=True,0,[trnSalesLine].[DiscountAmount]*[trnSalesLine].[Quantity])) AS DiscountAmount, 
IIf([IsReturn] = 2, 0, IIf([IsReturn] = 1, 0, IIf([IsCancelled] = True,0, [trnSales].[Amount]))) AS [Amount],
IIf([Forms]![RepSales]![FilterMem]=True,"Filtered","") AS FilterStatus
FROM (TrnSalesLine 
INNER JOIN (((((TrnSales 
INNER JOIN MstCustomer ON TrnSales.CustomerId = MstCustomer.Id) 
INNER JOIN MstTerminal ON TrnSales.TerminalId = MstTerminal.Id) 
INNER JOIN MstUser ON TrnSales.PreparedBy = MstUser.Id) 
INNER JOIN MstTerm ON TrnSales.TermId = MstTerm.Id)
 INNER JOIN MstUser AS MstUser_1 ON TrnSales.SalesAgent = MstUser_1.Id) ON TrnSalesLine.SalesId = TrnSales.Id) 
 INNER JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id
GROUP BY 
TrnSales.SalesDate, 
MstTerminal.Terminal, 
TrnSales.SalesNumber, 
IIf([IsCancelled]=0,"Locked","Cancelled"), 
TrnSales.SeniorCitizenId, 
TrnSales.SeniorCitizenName, 
TrnSales.SeniorCitizenAge, 
MstUser.username, 
MstUser_1.username, 
MstTerm.Term, 
IIf([IsReturn] = 2, 0, IIf([IsReturn] = 1, 0, IIf([IsCancelled] = True,0, [trnSales].[Amount]))),
IIf([Forms]![RepSales]![FilterMem]=True,"Filtered",""), 
TrnSales.IsLocked, 
Trim(Str([TrnSales].[TerminalId])), 
Trim(Str([TrnSales].[CustomerId])), 
Trim(Str([TrnSales].[PreparedBy])), 
Trim(Str([TrnSales].[SalesAgent])), 
MstDiscount.Discount
HAVING (((TrnSales.SalesDate) Between [Forms]![RepSales]![DateStart] 
And [Forms]![RepSales]![DateEnd]) 
AND ((TrnSales.SeniorCitizenId) Is Not Null) 
AND ((TrnSales.SeniorCitizenName) Is Not Null) 
AND ((TrnSales.SeniorCitizenAge) Is Not Null) 
AND ((TrnSales.IsLocked)=True) 
AND ((Trim(Str([TrnSales].[TerminalId]))) Like Nz([Forms]![RepSales]![T1_TerminalIdMem],"*")) 
AND ((Trim(Str([TrnSales].[CustomerId]))) Like Nz([Forms]![RepSales]![T1_CustomerIdMem],"*")) 
AND ((Trim(Str([TrnSales].[PreparedBy]))) Like Nz([Forms]![RepSales]![T1_UserIdMem],"*")) 
AND ((Trim(Str([TrnSales].[SalesAgent]))) Like Nz([Forms]![RepSales]![T1_SalesAgentMem],"*")) 
AND ((MstDiscount.Discount)="PWD"));


/*ORIGIN*/
SELECT TrnSales.SalesDate, MstTerminal.Terminal, TrnSales.SalesNumber, IIf([IsCancelled]=0,"Locked","Cancelled") AS Status, TrnSales.SeniorCitizenId, TrnSales.SeniorCitizenName, TrnSales.SeniorCitizenAge, MstUser.username AS [User], MstUser_1.username AS Sales, MstTerm.Term, Sum(IIf([Iscancelled]=True,0,[trnSalesLine].[DiscountAmount]*[trnSalesLine].[Quantity])) AS DiscountAmount, IIf([Iscancelled]=True,0,[trnSales].[Amount]) AS Amount, IIf([Forms]![RepSales]![FilterMem]=True,"Filtered","") AS FilterStatus
FROM (TrnSalesLine INNER JOIN (((((TrnSales INNER JOIN MstCustomer ON TrnSales.CustomerId = MstCustomer.Id) INNER JOIN MstTerminal ON TrnSales.TerminalId = MstTerminal.Id) INNER JOIN MstUser ON TrnSales.PreparedBy = MstUser.Id) INNER JOIN MstTerm ON TrnSales.TermId = MstTerm.Id) INNER JOIN MstUser AS MstUser_1 ON TrnSales.SalesAgent = MstUser_1.Id) ON TrnSalesLine.SalesId = TrnSales.Id) INNER JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id
GROUP BY TrnSales.SalesDate, MstTerminal.Terminal, TrnSales.SalesNumber, IIf([IsCancelled]=0,"Locked","Cancelled"), TrnSales.SeniorCitizenId, TrnSales.SeniorCitizenName, TrnSales.SeniorCitizenAge, MstUser.username, MstUser_1.username, MstTerm.Term, IIf([Iscancelled]=True,0,[trnSales].[Amount]), IIf([Forms]![RepSales]![FilterMem]=True,"Filtered",""), TrnSales.IsLocked, Trim(Str([TrnSales].[TerminalId])), Trim(Str([TrnSales].[CustomerId])), Trim(Str([TrnSales].[PreparedBy])), Trim(Str([TrnSales].[SalesAgent])), MstDiscount.Discount
HAVING (((TrnSales.SalesDate) Between [Forms]![RepSales]![DateStart] And [Forms]![RepSales]![DateEnd]) AND ((TrnSales.SeniorCitizenId) Is Not Null) AND ((TrnSales.SeniorCitizenName) Is Not Null) AND ((TrnSales.SeniorCitizenAge) Is Not Null) AND ((TrnSales.IsLocked)=True) AND ((Trim(Str([TrnSales].[TerminalId]))) Like Nz([Forms]![RepSales]![T1_TerminalIdMem],"*")) AND ((Trim(Str([TrnSales].[CustomerId]))) Like Nz([Forms]![RepSales]![T1_CustomerIdMem],"*")) AND ((Trim(Str([TrnSales].[PreparedBy]))) Like Nz([Forms]![RepSales]![T1_UserIdMem],"*")) AND ((Trim(Str([TrnSales].[SalesAgent]))) Like Nz([Forms]![RepSales]![T1_SalesAgentMem],"*")) AND ((MstDiscount.Discount)="PWD"));

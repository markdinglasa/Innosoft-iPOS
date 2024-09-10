SELECT 
TrnSales.SalesDate, 
MstTerminal.Terminal, 
TrnSales.SalesNumber, 
MstCustomer.Customer, 
IIf([IsReturn] = 2, "Refund", 
    IIf([IsReturn] = 1, "Return", 
        IIf([IsCancelled] = 0, "Locked", "Cancelled")
    )
) AS [Status],
MstUser.username AS [User], MstUser_1.username AS [Sales], 
MstTerm.Term, 
Sum(IIf([Iscancelled]=True,0,[trnSalesLine].[DiscountAmount]*[TrnSalesLine].[Quantity])) AS [DiscountAmount], 
Sum(IIf(([Iscancelled] = True) OR (Nz([IsReturn], 0) > 0), 0, [TrnSalesLine].[TaxAmount])) AS [Tax]

IIf([IsReturn] = 2, 0, 
    IIf([IsReturn] = 1, 0, 
        IIf([IsCancelled] = True,0, [trnSales].[Amount])
    )
) AS [Amount],
IIf([Forms]![RepSales]![FilterMem]=True,"Filtered","") AS [FilterStatus]

FROM TrnSalesLine INNER JOIN (((((
    TrnSales INNER JOIN MstCustomer ON TrnSales.CustomerId = MstCustomer.Id) 
    INNER JOIN MstTerminal ON TrnSales.TerminalId = MstTerminal.Id) 
    INNER JOIN MstUser ON TrnSales.PreparedBy = MstUser.Id) 
    INNER JOIN MstTerm ON TrnSales.TermId = MstTerm.Id) 
    INNER JOIN MstUser AS MstUser_1 ON TrnSales.SalesAgent = MstUser_1.Id) ON TrnSalesLine.SalesId = TrnSales.Id
GROUP BY 
TrnSales.SalesDate, 
MstTerminal.Terminal, 
TrnSales.SalesNumber, 
MstCustomer.Customer, 
IIf([IsReturn] = 2, "Refund", 
    IIf([IsReturn] = 1, "Return", 
        IIf([IsCancelled] = 0, "Locked", "Cancelled")
    )
),
MstUser.username, MstUser_1.username, 
MstTerm.Term, 
IIf([IsReturn] = 2, 0, IIf([IsReturn] = 1, 0, IIf([IsCancelled] = True, 0, [trnSales].[Amount]))),
IIf([Forms]![RepSales]![FilterMem]=True,"Filtered",""), 
Trim(Str([TrnSales].[TerminalId])), 
Trim(Str([TrnSales].[CustomerId])), 
Trim(Str([TrnSales].[PreparedBy])), 
Trim(Str([TrnSales].[SalesAgent])), 
TrnSales.IsLocked
HAVING (((TrnSales.SalesDate) Between [Forms]![RepSales]![DateStart] And [Forms]![RepSales]![DateEnd]) AND ((Trim(Str([TrnSales].[TerminalId]))) Like Nz([Forms]![RepSales]![T1_TerminalIdMem],"*")) AND ((Trim(Str([TrnSales].[CustomerId]))) Like Nz([Forms]![RepSales]![T1_CustomerIdMem],"*")) AND ((Trim(Str([TrnSales].[PreparedBy]))) Like Nz([Forms]![RepSales]![T1_UserIdMem],"*")) AND ((Trim(Str([TrnSales].[SalesAgent]))) Like Nz([Forms]![RepSales]![T1_SalesAgentMem],"*")) AND ((TrnSales.IsLocked)=True));



/*ORIGIN*/
SELECT TrnSales.SalesDate, MstTerminal.Terminal, TrnSales.SalesNumber, MstCustomer.Customer, IIf([IsReturn] = 2, "Refund",      IIf([IsReturn] = 1, "Return",          IIf([IsCancelled] = 0, "Locked", "Cancelled")     ) ) AS Status, MstUser.username AS [User], MstUser_1.username AS Sales, MstTerm.Term, Sum(IIf([Iscancelled]=True,0,[trnSalesLine].[DiscountAmount]*[TrnSalesLine].[Quantity])) AS DiscountAmount, Sum(TrnSalesLine.TaxAmount) AS Tax, IIf([IsReturn] = 2, 0,      IIf([IsReturn] = 1, 0,          IIf([IsCancelled] = True, [trnSales].[Amount])     ) ) AS Amount, IIf([Forms]![RepSales]![FilterMem]=True,"Filtered","") AS FilterStatus
FROM TrnSalesLine INNER JOIN (((((TrnSales INNER JOIN MstCustomer ON TrnSales.CustomerId = MstCustomer.Id) INNER JOIN MstTerminal ON TrnSales.TerminalId = MstTerminal.Id) INNER JOIN MstUser ON TrnSales.PreparedBy = MstUser.Id) INNER JOIN MstTerm ON TrnSales.TermId = MstTerm.Id) INNER JOIN MstUser AS MstUser_1 ON TrnSales.SalesAgent = MstUser_1.Id) ON TrnSalesLine.SalesId = TrnSales.Id
GROUP BY TrnSales.SalesDate, MstTerminal.Terminal, TrnSales.SalesNumber, MstCustomer.Customer, IIf([IsReturn] = 2, "Refund",      IIf([IsReturn] = 1, "Return",          IIf([IsCancelled] = 0, "Locked", "Cancelled")     ) ), MstUser.username, MstUser_1.username, MstTerm.Term, IIf([IsReturn] = 2, 0,      IIf([IsReturn] = 1, 0,          IIf([IsCancelled] = True, [trnSales].[Amount])     ) ), IIf([Forms]![RepSales]![FilterMem]=True,"Filtered",""), Trim(Str([TrnSales].[TerminalId])), Trim(Str([TrnSales].[CustomerId])), Trim(Str([TrnSales].[PreparedBy])), Trim(Str([TrnSales].[SalesAgent])), TrnSales.IsLocked
HAVING (((TrnSales.SalesDate) Between Forms!RepSales!DateStart And Forms!RepSales!DateEnd) And ((Trim(Str(TrnSales.TerminalId))) Like Nz(Forms!RepSales!T1_TerminalIdMem,"*")) And ((Trim(Str(TrnSales.CustomerId))) Like Nz(Forms!RepSales!T1_CustomerIdMem,"*")) And ((Trim(Str(TrnSales.PreparedBy))) Like Nz(Forms!RepSales!T1_UserIdMem,"*")) And ((Trim(Str(TrnSales.SalesAgent))) Like Nz(Forms!RepSales!T1_SalesAgentMem,"*")) And ((TrnSales.IsLocked)=True));

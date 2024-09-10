SELECT 
IIf(IsNull([trncollection].[Id]),"Uncollected","Collected") AS SalesStatus, 
IIf(IsNull([trncollection].[id]),"AR",[mstpaytype].[PayType]) AS PayType,
Sum(IIf(IsNull([trncollection].[id]),[TrnSales].[Amount],[TrnCollectionLine].[Amount]-IIf([MstPayType].[PayType]="Cash",[TrnCollection].[ChangeAmount],0))) AS SalesAmount, 
IIf([Forms]![RepSales]![FilterMem]=True,"Filtered","") AS FilterStatus

FROM TrnSales LEFT JOIN ((TrnCollection LEFT JOIN TrnCollectionLine ON TrnCollection.Id = TrnCollectionLine.CollectionId) LEFT JOIN MstPayType ON TrnCollectionLine.PayTypeId = MstPayType.Id) ON TrnSales.Id = TrnCollection.SalesId
GROUP BY 
IIf(IsNull([trncollection].[Id]),"Uncollected","Collected"), 
IIf(IsNull([trncollection].[id]),"AR",[mstpaytype].[PayType]), 
IIf([Forms]![RepSales]![FilterMem]=True,"Filtered",""), 
IIf(IsNull([Forms]![RepSales]![T3_UserIdMem]),"*",Trim(Str([TrnSales].[PreparedBy]))), 
IIf([trnSales].[SalesNumber]>=[Forms]![RepSales]![SalesNoStart] And [trnSales].[SalesNumber]<=[Forms]![RepSales]![SalesNoEnd],True,False), 
TrnSales.IsCancelled, 
TrnSales.IsLocked
HAVING (((
    Sum(IIf(IsNull([trncollection].[id]),[TrnSales].[Amount],[TrnCollectionLine].[Amount]-IIf([MstPayType].[PayType]="Cash",[TrnCollection].[ChangeAmount],0))))>0) 
    AND ((IIf(IsNull([Forms]![RepSales]![T3_UserIdMem]),"*",Trim(Str([TrnSales].[PreparedBy])))) Like Nz([Forms]![RepSales]![T3_UserIdMem],"*")) 
    AND ((IIf([trnSales].[SalesNumber]>=[Forms]![RepSales]![SalesNoStart] 
    And [trnSales].[SalesNumber]<=[Forms]![RepSales]![SalesNoEnd],True,False))=True) 
    AND ((TrnSales.IsCancelled)=False) 
    AND ((Nz(TrnSales.IsReturn, 0)) = 0) 
    AND ((TrnSales.IsLocked)=True));

/*ORIGIN*/
    SELECT IIf(IsNull([trncollection].[Id]),"Uncollected","Collected") AS SalesStatus, IIf(IsNull([trncollection].[id]),"AR",[mstpaytype].[PayType]) AS PayType, Sum(IIf(IsNull([trncollection].[id]),[TrnSales].[Amount],[TrnCollectionLine].[Amount]-IIf([MstPayType].[PayType]="Cash",[TrnCollection].[ChangeAmount],0))) AS SalesAmount, IIf([Forms]![RepSales]![FilterMem]=True,"Filtered","") AS FilterStatus
    FROM TrnSales LEFT JOIN ((TrnCollection LEFT JOIN TrnCollectionLine ON TrnCollection.Id = TrnCollectionLine.CollectionId) LEFT JOIN MstPayType ON TrnCollectionLine.PayTypeId = MstPayType.Id) ON TrnSales.Id = TrnCollection.SalesId
    GROUP BY IIf(IsNull([trncollection].[Id]),"Uncollected","Collected"), IIf(IsNull([trncollection].[id]),"AR",[mstpaytype].[PayType]), IIf([Forms]![RepSales]![FilterMem]=True,"Filtered",""), IIf(IsNull([Forms]![RepSales]![T3_UserIdMem]),"*",Trim(Str([TrnSales].[PreparedBy]))), IIf([trnSales].[SalesNumber]>=[Forms]![RepSales]![SalesNoStart] And [trnSales].[SalesNumber]<=[Forms]![RepSales]![SalesNoEnd],True,False), TrnSales.IsCancelled, TrnSales.IsLocked, TrnSales.IsCancelled
    HAVING (((Sum(IIf(IsNull([trncollection].[id]),[TrnSales].[Amount],[TrnCollectionLine].[Amount]-IIf([MstPayType].[PayType]="Cash",[TrnCollection].[ChangeAmount],0))))>0) AND ((IIf(IsNull([Forms]![RepSales]![T3_UserIdMem]),"*",Trim(Str([TrnSales].[PreparedBy])))) Like Nz([Forms]![RepSales]![T3_UserIdMem],"*")) AND ((IIf([trnSales].[SalesNumber]>=[Forms]![RepSales]![SalesNoStart] And [trnSales].[SalesNumber]<=[Forms]![RepSales]![SalesNoEnd],True,False))=True) AND ((TrnSales.IsCancelled)=False)  AND ((TrnSales.IsLocked)=True));

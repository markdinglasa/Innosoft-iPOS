SELECT 
TrnCollection.TerminalId, 
TrnCollection.CollectionDate, 
TrnCollection.PreparedBy, 
TrnCollection.IsLocked, 
MstPayType.PayType, 
Sum(
    IIf(
        [MstPayType].[PayType] = "Cash",
        IIf(
            Nz([TrnCollection].[IsReturn], 0) > 0,
            0,
            [TrnCollection].[Amount] - Nz(DSum("Amount", "TrnCollectionLine", "PayTypeId <> 1 AND CollectionId = " & [TrnCollection].[Id]), 0)
        ),
        IIf(
            Nz([TrnCollection].[IsReturn], 0) = 2,
            0,
            [TrnCollectionLine].[Amount]
        )
    )
) AS TotalAmount
FROM (TrnCollectionLine INNER JOIN TrnCollection ON TrnCollectionLine.CollectionId = TrnCollection.Id) INNER JOIN MstPayType ON TrnCollectionLine.PayTypeId = MstPayType.Id
WHERE (((TrnCollection.TerminalId)=[Forms]![RepPOS]![TerminalId]) 
AND ((TrnCollection.CollectionDate)=[Forms]![RepPOS]![DateReading]) 
AND ((TrnCollection.PreparedBy)=[Forms]![RepPOS]![PreparedBy]) 
AND ((TrnCollection.IsCancelled)=False) 
AND (TrnCollection.IsLocked)=True)
GROUP BY 
TrnCollection.TerminalId, 
TrnCollection.CollectionDate, 
TrnCollection.PreparedBy, 
TrnCollection.IsLocked, 
MstPayType.PayType, 
TrnCollection.IsCancelled, 
TrnCollection.IsReturn,
TrnCollection.IsLocked


/*ORIGIN*/
SELECT TrnCollection.TerminalId, TrnCollection.CollectionDate, TrnCollection.PreparedBy, TrnCollection.IsLocked, MstPayType.PayType, Sum(IIf([MstPayType].[PayType]="Cash",([TrnCollection].[Amount]-Nz(DSum("Amount","TrnCollectionLine","PayTypeId<>1 AND CollectionId=" & [TrnCollection].[Id]),0))*DeclareRate([Forms]![RepPOS]![DateReading]),[TrnCollectionLine].[Amount]*DeclareRate([Forms]![RepPOS]![DateReading]))) AS TotalAmount
FROM (TrnCollectionLine INNER JOIN TrnCollection ON TrnCollectionLine.CollectionId = TrnCollection.Id) INNER JOIN MstPayType ON TrnCollectionLine.PayTypeId = MstPayType.Id
WHERE (((TrnCollection.TerminalId)=[Forms]![RepPOS]![TerminalId]) 
AND ((TrnCollection.CollectionDate)=[Forms]![RepPOS]![DateReading]) 
AND ((TrnCollection.PreparedBy)=[Forms]![RepPOS]![PreparedBy]) 
AND ((TrnCollection.IsCancelled)=False) 
AND (TrnCollection.IsLocked)=True)
GROUP BY TrnCollection.TerminalId, TrnCollection.CollectionDate, TrnCollection.PreparedBy, TrnCollection.IsLocked, MstPayType.PayType, TrnCollection.IsCancelled, TrnCollection.IsLocked

HAVING (((TrnCollection.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TrnCollection.CollectionDate)=[Forms]![RepPOS]![DateReading]) AND ((TrnCollection.PreparedBy)=[Forms]![RepPOS]![PreparedBy]) AND ((TrnCollection.IsCancelled)=False) AND ((TrnCollection.IsLocked)=True And (TrnCollection.IsLocked)=True));


SELECT TrnCollection.TerminalId, 
IIf([trncollection].[CollectionNumber]>=[Forms]![RepPOS]![ORNoStart] 
And [trncollection].[CollectionNumber]<=[Forms]![RepPOS]![ORNoEnd],True) AS FilterOr, 
TrnCollection.IsLocked, MstPayType.PayType, 
Sum(
    IIf(
        [MstPayType].[PayType] = "Cash",
        IIf(
            Nz([TrnCollection].[IsReturn], 0) > 0,
            0,
            [TrnCollection].[Amount] - Nz(DSum("Amount", "TrnCollectionLine", "PayTypeId <> 1 AND CollectionId = " & [TrnCollection].[Id]), 0)
        ),
        IIf(
            Nz([TrnCollection].[IsReturn], 0) = 2,
            0,
            [TrnCollectionLine].[Amount]
        )
    )
) AS TotalAmount
FROM (TrnCollectionLine INNER JOIN TrnCollection ON TrnCollectionLine.CollectionId = TrnCollection.Id) INNER JOIN MstPayType ON TrnCollectionLine.PayTypeId = MstPayType.Id
WHERE (((TrnCollection.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((IIf([trncollection].[CollectionNumber]>=[Forms]![RepPOS]![ORNoStart] And [trncollection].[CollectionNumber]<=[Forms]![RepPOS]![ORNoEnd],True))=True) AND ((TrnCollection.IsLocked)=True And (TrnCollection.IsLocked)=True) AND ((TrnCollection.IsCancelled)=False))

GROUP BY TrnCollection.TerminalId, IIf([trncollection].[CollectionNumber]>=[Forms]![RepPOS]![ORNoStart] And [trncollection].[CollectionNumber]<=[Forms]![RepPOS]![ORNoEnd],True), TrnCollection.IsLocked, MstPayType.PayType, TrnCollection.IsLocked, TrnCollection.IsCancelled

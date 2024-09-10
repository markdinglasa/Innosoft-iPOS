SELECT 
[RepPOSQ100 (Z Reading)].TerminalId, 
[RepPOSQ100 (Z Reading)].IsLocked, 
Sum([RepPOSQ100 (Z Reading)].GrossSales) AS SumOfGrossSales, 
Sum([RepPOSQ100 (Z Reading)].Discount) AS SumOfDiscount, 
Sum([RepPOSQ100 (Z Reading)].SeniorCitizenDiscount) AS SumOfSeniorCitizenDiscount, 
Sum([RepPOSQ100 (Z Reading)].PWDDiscount) AS SumOfPWDDiscount, 
Sum([RepPOSQ100 (Z Reading)].NetSales)  AS SumOfNetSales, 
Sum([RepPOSQ100 (Z Reading)].SalesReturn) AS SumOfSalesReturn, 
Sum([RepPOSQ100 (Z Reading)].PreviousNetSales) AS SumOfPreviousNetSales, 
(Sum([RepPOSQ100 (Z Reading)].VATSales)-Max([RepPOSQ100 (Z Reading)].VATAmount)) AS SumOfVATSales, 
Sum([RepPOSQ100 (Z Reading)].NONVATSales) AS SumOfNONVATSales, 
Sum([RepPOSQ100 (Z Reading)].VATEXEMPTSales) AS SumOfVATEXEMPTSales, 
Max([RepPOSQ100 (Z Reading)].VATAmount) AS SumOfVATAmount, 
Max(IIf(Len([StartingCollectionNumber])=0,"0",[StartingCollectionNumber])) AS StartingCollectionNumber1, 
Max(IIf(Len([EndingCollectionNumber])=0,"0",[EndingCollectionNumber])) AS EndingCollectionNumber1, 
Sum([RepPOSQ100 (Z Reading)].NoOfTransaction) AS SumOfNoOfTransaction, 
Sum([RepPOSQ100 (Z Reading)].NoOfCancelledTransaction) AS SumOfNoOfCancelledTransaction,
Sum([RepPOSQ100 (Z Reading)].TotalCancelledAmount) AS SumOfTotalCancelledAmount, 
Sum([RepPOSQ100 (Z Reading)].NoOfSKU) AS SumOfNoOfSKU, 
Sum([RepPOSQ100 (Z Reading)].TotalQuantity) AS SumOfTotalQuantity, 
(DSum("expr1","RepPOS (Z Reading Z-Counter)")+Nz(DFirst("ZCounterEnd","SysCurrent"),0)) AS Zcounter
FROM [RepPOSQ100 (Z Reading)]
GROUP BY [RepPOSQ100 (Z Reading)].TerminalId, [RepPOSQ100 (Z Reading)].IsLocked;

/*SUBQUERY PAYTYPES*/
SELECT 
TrnCollection.TerminalId, 
TrnCollection.CollectionDate, 
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
            Nz([TrnCollection].[IsReturn], 0) > 0,
            0,
            [TrnCollectionLine].[Amount]
        )
    )
) AS TotalAmount

FROM (TrnCollectionLine INNER JOIN TrnCollection ON TrnCollectionLine.CollectionId = TrnCollection.Id) INNER JOIN MstPayType ON TrnCollectionLine.PayTypeId = MstPayType.Id
GROUP BY TrnCollection.TerminalId, TrnCollection.CollectionDate, TrnCollection.IsLocked, MstPayType.PayType, TrnCollection.IsCancelled, TrnCollection.IsLocked
HAVING (((TrnCollection.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TrnCollection.CollectionDate)=[Forms]![RepPOS]![DateReading]) AND ((TrnCollection.IsCancelled)=False) AND ((TrnCollection.IsLocked)=True And (TrnCollection.IsLocked)=True));


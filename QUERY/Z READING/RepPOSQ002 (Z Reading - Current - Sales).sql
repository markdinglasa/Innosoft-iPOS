
SELECT "CurrentSales" AS Document, 
TmpCollectionZReading.TerminalId, 
TmpCollectionZReading.CollectionDate, 
TmpCollectionZReading.IsLocked, 
Sum(Round(IIf([MstDiscount].[Discount]<>"Senior Citizen Discount" And [MstDiscount].[Discount]<>"PWD" AND (Nz([TrnCollection].[IsReturn], 0) <> 2),[Price],[Price1]+[Price2LessTax])*[Quantity],3)) AS GrossSales, 
Sum(IIf(Mid([MstDiscount].[Discount],1,23)<>"Senior Citizen Discount" And [MstDiscount].[Discount]<>"PWD",[trnsalesline].[DiscountAmount]*[trnsalesline].[Quantity],0)) AS Discount, 
Sum(IIf(Mid([MstDiscount].[Discount],1,23)="Senior Citizen Discount",[trnsalesline].[DiscountAmount]*[trnsalesline].[Quantity],0)) AS SeniorCitizenDiscount, 
Sum(IIf([MstDiscount].[Discount]="PWD",[trnsalesline].[DiscountAmount]*[trnsalesline].[Quantity],0)) AS PWDDiscount, 
Sum(IIF(Nz([TrnCollection].[IsReturn], 0) = 2, 0, [TrnSalesLine].[Amount])) AS NetSales, 
Sum(IIF(Nz([TrnCollection].[IsReturn], 0) = 1, [TrnCollection].[Amount], 0)) AS SalesReturn,
Sum(IIF(Nz([TrnCollection].[IsReturn], 0) = 2, [TrnCollection].[Amount], 0)) AS SalesRefund, 
0 AS PreviousNetSales, 
Sum(IIf([trnsalesline].[TaxRate]>0 AND (Nz([TrnCollection].[IsReturn], 0) < 1), [trnsalesline].[quantity]*IIf([trnsalesline].[price2]>0,[trnsalesline].[price1],[trnsalesline].[netprice]),0)) AS VATSales, 
Sum(IIf([trnsalesline].[Price2]>0 AND (Nz([TrnCollection].[IsReturn], 0) < 1), [trnsalesline].[quantity]*([trnsalesline].[price2lesstax]-([trnsalesline].[price2lesstax]*([TrnSalesLine].[DiscountRate]/100))),IIf([TrnSalesLine].[TaxId]=5,[TrnSalesLine].[Amount],0))) AS VATEXEMPTSales, 
Sum(IIf([TrnSalesLine].[TaxId]=2 And ([TrnSalesLine].[Discountid]<>4 And [TrnSalesLine].[Discountid]<>3),[TrnSalesLine].[Amount],0)) AS NONVATSales, 
Sum(IIf(([TrnSalesLine].[TaxRate] > 0) AND (Nz([TrnCollection].[IsReturn], 0) < 1), [TrnSalesLine].[TaxAmount], 0)) AS [VATAmount],
"" AS StartingCollectionNumber, "" AS [EndingCollectionNumber], 
0 AS [NoOfTransaction], 
0 AS [NoOfCancelledTransaction], 
0 AS [TotalCancelledAmount], 
Count(IIf(Nz([TrnCollection].[IsReturn], 0) <= 0, [TrnSalesLine].[ItemId], Null)) AS [NoOfSKU],
Sum(IIF((Nz([TrnCollection].[IsReturn], 0) > 0), 0,TrnSalesLine.Quantity)) AS [TotalQuantity], 
TmpCollectionZReading.PreparedBy, 
0 AS Zcounter
FROM 
TrnSales 
INNER JOIN ((((
    TrnSalesLine 
    LEFT JOIN [TrnCollection] ON [TrnCollection].[SalesId] = [TrnSalesLine].[SalesId])
    INNER JOIN TmpCollectionZReading ON TrnSalesLine.SalesId = TmpCollectionZReading.SalesId) 
    INNER JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id) 
    INNER JOIN MstTax ON TrnSalesLine.TaxId = MstTax.Id) ON TrnSales.Id = TrnSalesLine.SalesId
GROUP BY "CurrentSales", TmpCollectionZReading.TerminalId, 
TmpCollectionZReading.CollectionDate, 
TmpCollectionZReading.IsLocked, 
TmpCollectionZReading.PreparedBy, 0, 
TmpCollectionZReading.IsCancelled
HAVING (((TmpCollectionZReading.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TmpCollectionZReading.CollectionDate)=[Forms]![RepPOS]![DateReading]) AND ((TmpCollectionZReading.IsLocked)=True) AND ((TmpCollectionZReading.IsCancelled)=False));


/*ORIGIN*/
SELECT "CurrentSales" AS Document, TmpCollectionZReading.TerminalId, TmpCollectionZReading.CollectionDate, TmpCollectionZReading.IsLocked, Sum(Round(IIf([MstDiscount].[Discount]<>"Senior Citizen Discount" And [MstDiscount].[Discount]<>"PWD",[Price],[Price1]+[Price2LessTax])*[Quantity],3)) AS GrossSales, Sum(IIf(Mid([MstDiscount].[Discount],1,23)<>"Senior Citizen Discount" And [MstDiscount].[Discount]<>"PWD",[trnsalesline].[DiscountAmount]*[trnsalesline].[Quantity],0)) AS Discount, Sum(IIf(Mid([MstDiscount].[Discount],1,23)="Senior Citizen Discount",[trnsalesline].[DiscountAmount]*[trnsalesline].[Quantity],0)) AS SeniorCitizenDiscount, Sum(IIf([MstDiscount].[Discount]="PWD",[trnsalesline].[DiscountAmount]*[trnsalesline].[Quantity],0)) AS PWDDiscount, Sum(TrnSalesLine.Amount) AS NetSales, 0 AS SalesReturn, 0 AS PreviousNetSales, Sum(IIf([trnsalesline].[TaxRate]>0,[trnsalesline].[quantity]*IIf([trnsalesline].[price2]>0,[trnsalesline].[price1],[trnsalesline].[netprice]),0)) AS VATSales, Sum(IIf([trnsalesline].[Price2]>0,[trnsalesline].[quantity]*([trnsalesline].[price2lesstax]-([trnsalesline].[price2lesstax]*([TrnSalesLine].[DiscountRate]/100))),IIf([TrnSalesLine].[TaxId]=18,[TrnSalesLine].[Amount],0))) AS VATEXEMPTSales, Sum(IIf([TrnSalesLine].[TaxId]=9 And ([TrnSalesLine].[Discountid]<>16 And [TrnSalesLine].[Discountid]<>7),[TrnSalesLine].[Amount],0)) AS NONVATSales, Sum(TrnSalesLine.TaxAmount) AS VATAmount, "" AS StartingCollectionNumber, "" AS EndingCollectionNumber, 0 AS NoOfTransaction, 0 AS NoOfCancelledTransaction, 0 AS TotalCancelledAmount, Count(TrnSalesLine.ItemId) AS NoOfSKU, Sum(TrnSalesLine.Quantity) AS TotalQuantity, TmpCollectionZReading.PreparedBy, 0 AS Zcounter
FROM TrnSales INNER JOIN (((TrnSalesLine INNER JOIN TmpCollectionZReading ON TrnSalesLine.SalesId = TmpCollectionZReading.SalesId) INNER JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id) INNER JOIN MstTax ON TrnSalesLine.TaxId = MstTax.Id) ON TrnSales.Id = TrnSalesLine.SalesId
GROUP BY "CurrentSales", TmpCollectionZReading.TerminalId, TmpCollectionZReading.CollectionDate, TmpCollectionZReading.IsLocked, TmpCollectionZReading.PreparedBy, 0, TmpCollectionZReading.IsCancelled
HAVING (((TmpCollectionZReading.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TmpCollectionZReading.CollectionDate)=[Forms]![RepPOS]![DateReading]) AND ((TmpCollectionZReading.IsLocked)=True) AND ((TmpCollectionZReading.IsCancelled)=False));

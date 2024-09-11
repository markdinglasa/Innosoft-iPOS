SELECT "PreviousSales" AS Document, 
TmpCollectionZReading.TerminalId, 
[Forms]![RepPOS]![DateReading] AS CollectionDate, 
TmpCollectionZReading.IsLocked, 0 AS GrossSales, 
0 AS Discount, 
0 AS SeniorCitizenDiscount, 
0 AS PWDDiscount, 0 AS NetSales, 
0 AS SalesReturn, 
0 AS SalesRefund, 
Sum([Amount]*Nz([SysCurrentRate].[DeclareRate],Nz(DFirst("DeclareRate","SysCurrent"),1))) AS PreviousNetSales, 
0 AS VATSales, 
0 AS VATEXEMPTSales, 
0 AS NONVATSales, 
0 AS VATAmount, 
"" AS StartingCollectionNumber, 
"" AS EndingCollectionNumber, 
0 AS NoOfTransaction, 
0 AS NoOfCancelledTransaction, 
0 AS TotalCancelledAmount, 
0 AS NoOfSKU, 
0 AS TotalQuantity, 
TmpCollectionZReading.PreparedBy, 
Count(TmpCollectionZReading.collectionnumber) AS Zcounter
FROM (TmpCollectionZReading LEFT JOIN SysCurrentRate ON TmpCollectionZReading.CollectionDate = SysCurrentRate.ReadingDate) INNER JOIN TmpSalesLineZReading ON TmpCollectionZReading.SalesId = TmpSalesLineZReading.SalesId
GROUP BY "PreviousSales", TmpCollectionZReading.TerminalId, [Forms]![RepPOS]![DateReading], TmpCollectionZReading.IsLocked, 0, TmpCollectionZReading.PreparedBy, IIf(CVDate(Format([TmpCollectionZReading].[CollectionDate],"mm/dd/yyyy"))<CVDate(Format([Forms]![RepPOS]![DateReading],"mm/dd/yyyy")),True,False)
HAVING (((TmpCollectionZReading.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TmpCollectionZReading.IsLocked)=True) AND ((IIf(CVDate(Format([TmpCollectionZReading].[CollectionDate],"mm/dd/yyyy"))<CVDate(Format([Forms]![RepPOS]![DateReading],"mm/dd/yyyy")),True,False))=True));


/*ORIGIN*/
SELECT "PreviousSales" AS Document, TmpCollectionZReading.TerminalId, [Forms]![RepPOS]![DateReading] AS CollectionDate, TmpCollectionZReading.IsLocked, 0 AS GrossSales, 0 AS Discount, 0 AS SeniorCitizenDiscount, 0 AS PWDDiscount, 0 AS NetSales, 0 AS SalesReturn, Sum([Amount]*Nz([SysCurrentRate].[DeclareRate],Nz(DFirst("DeclareRate","SysCurrent"),1))) AS PreviousNetSales, 0 AS VATSales, 0 AS VATEXEMPTSales, 0 AS NONVATSales, 0 AS VATAmount, "" AS StartingCollectionNumber, "" AS EndingCollectionNumber, 0 AS NoOfTransaction, 0 AS NoOfCancelledTransaction, 0 AS TotalCancelledAmount, 0 AS NoOfSKU, 0 AS TotalQuantity, TmpCollectionZReading.PreparedBy, Count(TmpCollectionZReading.collectionnumber) AS Zcounter
FROM (TmpCollectionZReading LEFT JOIN SysCurrentRate ON TmpCollectionZReading.CollectionDate = SysCurrentRate.ReadingDate) INNER JOIN TmpSalesLineZReading ON TmpCollectionZReading.SalesId = TmpSalesLineZReading.SalesId
GROUP BY "PreviousSales", TmpCollectionZReading.TerminalId, [Forms]![RepPOS]![DateReading], TmpCollectionZReading.IsLocked, 0, TmpCollectionZReading.PreparedBy, IIf(CVDate(Format([TmpCollectionZReading].[CollectionDate],"mm/dd/yyyy"))<CVDate(Format([Forms]![RepPOS]![DateReading],"mm/dd/yyyy")),True,False)
HAVING (((TmpCollectionZReading.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TmpCollectionZReading.IsLocked)=True) AND ((IIf(CVDate(Format([TmpCollectionZReading].[CollectionDate],"mm/dd/yyyy"))<CVDate(Format([Forms]![RepPOS]![DateReading],"mm/dd/yyyy")),True,False))=True));
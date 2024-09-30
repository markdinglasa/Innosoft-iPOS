SELECT 
"PreviousSales" AS Document, 
TmpCollectionZReading.TerminalId, 
[Forms]![RepPOS]![DateReading] AS CollectionDate, 
TmpCollectionZReading.IsLocked, 
0 AS GrossSales, 
0 AS Discount, 
0 AS SeniorCitizenDiscount, 
0 AS PWDDiscount, 
0 AS NetSales, 
0 AS SalesReturn, 
0 AS SalesRefund, 
FORMAT(Sum(IIF(Nz([TrnSales].[IsReturn],0) <> 2,[TmpSalesLineZReading].[Amount],0)),'0.00') AS PreviousNetSales, 
0 AS VATSales, 
0 AS VATEXEMPTSales, 
0 AS NONVATSales,       
0 AS VATAmount, "" AS StartingCollectionNumber, "" 
AS EndingCollectionNumber, 
0 AS NoOfTransaction, 
0 AS NoOfCancelledTransaction, 
0 AS TotalCancelledAmount, 
0 AS NoOfSKU, 
0 AS TotalQuantity, 
TmpCollectionZReading.PreparedBy, 
Count(TmpCollectionZReading.collectionnumber) AS Zcounter
FROM (TmpCollectionZReading 
INNER JOIN TmpSalesLineZReading ON TmpCollectionZReading.SalesId = TmpSalesLineZReading.SalesId)
LEFT JOIN TrnSales ON TrnSales.Id = TmpSalesLineZReading.SalesId
GROUP BY "PreviousSales", 
TmpCollectionZReading.TerminalId, 
[Forms]![RepPOS]![DateReading], 
TmpCollectionZReading.IsLocked, 
TmpCollectionZReading.PreparedBy, 
IIf(CVDate(Format([TmpCollectionZReading].[CollectionDate],"mm/dd/yyyy"))<CVDate(Format([Forms]![RepPOS]![DateReading],"mm/dd/yyyy")),True,False)
HAVING (((TmpCollectionZReading.TerminalId)=Forms!RepPOS!TerminalId) 
And ((TmpCollectionZReading.IsLocked)=True) 
And ((IIf(CVDate(Format(TmpCollectionZReading.CollectionDate,"mm/dd/yyyy"))<CVDate(Format(Forms!RepPOS!DateReading,"mm/dd/yyyy")),True,False))=True));

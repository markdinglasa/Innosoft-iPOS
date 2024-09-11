
SELECT 
[RepPOSQ100 (Z Reading)].TerminalId, 
[RepPOSQ100 (Z Reading)].IsLocked, 
Sum([RepPOSQ100 (Z Reading)].GrossSales) AS SumOfGrossSales, 
Sum([RepPOSQ100 (Z Reading)].Discount) AS SumOfDiscount,
 Sum([RepPOSQ100 (Z Reading)].SeniorCitizenDiscount) AS SumOfSeniorCitizenDiscount, 
 Sum([RepPOSQ100 (Z Reading)].PWDDiscount) AS SumOfPWDDiscount, 
 Sum([RepPOSQ100 (Z Reading)].NetSales) AS SumOfNetSales, 
 Sum([RepPOSQ100 (Z Reading)].SalesReturn) AS SumOfSalesReturn, 
 Sum([RepPOSQ100 (Z Reading)].PreviousNetSales) AS SumOfPreviousNetSales, 
 (Sum([RepPOSQ100 (Z Reading)].VATSales)-MAX([RepPOSQ100 (Z Reading)].VATAmount)) AS SumOfVATSales, 
 Sum([RepPOSQ100 (Z Reading)].NONVATSales) AS SumOfNONVATSales, 
 Sum([RepPOSQ100 (Z Reading)].VATEXEMPTSales) AS SumOfVATEXEMPTSales, 
 MAX([RepPOSQ100 (Z Reading)].VATAmount) AS SumOfVATAmount, 
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

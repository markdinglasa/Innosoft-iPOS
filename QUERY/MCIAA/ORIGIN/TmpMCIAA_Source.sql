
sql1 = "INSERT INTO TmpMCIAA_Source ( TerminalId, CollectionDate, IsLocked, CollectionNumber, IsCancelled, ItemId, ItemCode, ItemDescription, IsInventory, Category, Price, Discount, DiscountRate, DiscountAmount, NetPrice, Quantity, Price1, Price2, Price2LessTax, Amount, Tax, TaxRate, TaxAmount, LineTimeStamp 
 TotalRefund, ServiceCharge,  TotalCash, TotalCharge, TotalGiftCertificate, TotalOnline,  TotalCreditCard, TotalOtherTender) "  
sql2 = "SELECT TrnCollection.TerminalId, TrnCollection.CollectionDate, TrnCollection.IsLocked, TrnCollection.CollectionNumber, TrnCollection.IsCancelled, TrnSalesLine.ItemId, MstItem.ItemCode, MstItem.ItemDescription, MstItem.IsInventory, MstItem.Category, MstItem.Price, MstDiscount.Discount, TrnSalesLine.DiscountRate, TrnSalesLine.DiscountAmount, TrnSalesLine.NetPrice, TrnSalesLine.Quantity, TrnSalesLine.Price1, TrnSalesLine.Price2, TrnSalesLine.Price2LessTax, TrnSalesLine.Amount, MstTax.Tax, TrnSalesLine.TaxRate, TrnSalesLine.TaxAmount, Format([SalesLineTimeStamp],'yyyymmddhhnnss') AS LineTimeStamp, SUM(IIF(TrnSales.IsReturn = 2,TrnSalesLine.Amount,0)) AS TotalRefund, SUM(IIF(TrnSalesLine.ItemId = 1,TrnSalesLine.Amount,0)) AS ServiceCharge, SUM(TmpPayTypeSales.TotalCashSales) AS TotalCash, SUM(TmpPayTypeSales.TotalChargeSales) AS TotalCharge, SUM(TmpPayTypeSales.TotalGiftCertificateSales) AS TotalGiftCertificate, SUM(TmpPayTypeSales.TotalOnlineSales) AS TotalOnline, SUM(TmpPayTypeSales.TotalCreditCardSales) AS TotalCreditCard, SUM(TmpPayTypeSales.TotalOtherTenderSales) AS TotalOtherTender"
sql3 = "FROM (((((TrnSalesLine INNER JOIN TrnSales ON TrnSalesLine.SalesId = TrnSales.Id) INNER JOIN TrnCollection ON TrnSales.Id = TrnCollection.SalesId) INNER JOIN MstItem ON TrnSalesLine.ItemId = MstItem.Id) INNER JOIN MstTax ON TrnSalesLine.TaxId = MstTax.Id) LEFT JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id) LEFT JOIN TmpPayTypeSales ON TmpPayTypeSales.SalesId = TrnSales.Id"
sql4 = "WHERE (((TrnCollection.TerminalId)=" & TerminalId & ") AND ((TrnCollection.CollectionDate)=#" & readingDate & "#) AND ((TrnCollection.IsLocked)=True))"
sql5 = "GROUP BY TrnCollection.TerminalId, TrnCollection.CollectionDate, TrnCollection.IsLocked, TrnCollection.CollectionNumber, TrnCollection.IsCancelled, TrnSalesLine.ItemId, MstItem.ItemCode, MstItem.ItemDescription,MstItem.IsInventory, MstItem.Category, MstItem.Price, MstDiscount.Discount, TrnSalesLine.DiscountRate, TrnSalesLine.DiscountAmount, TrnSalesLine.NetPrice, TrnSalesLine.Quantity, TrnSalesLine.Price1, TrnSalesLine.Price2, TrnSalesLine.Price2LessTax, TrnSalesLine.Amount, MstTax.Tax, TrnSalesLine.TaxRate, TrnSalesLine.TaxAmount, Format([SalesLineTimeStamp],'yyyymmddhhnnss');"


SELECT 
TrnCollection.TerminalId, 
TrnCollection.CollectionDate, 
TrnCollection.IsLocked, 
TrnCollection.CollectionNumber, 
TrnCollection.IsCancelled, 
TrnSalesLine.ItemId, 
MstItem.ItemCode, 
MstItem.ItemDescription,
MstItem.IsInventory, 
MstItem.Category, 
MstItem.Price, 
MstDiscount.Discount, 
TrnSalesLine.DiscountRate, 
TrnSalesLine.DiscountAmount, 
TrnSalesLine.NetPrice, 
TrnSalesLine.Quantity, 
TrnSalesLine.Price1, 
TrnSalesLine.Price2, 
TrnSalesLine.Price2LessTax, 
TrnSalesLine.Amount, 
MstTax.Tax, 
TrnSalesLine.TaxRate, 
TrnSalesLine.TaxAmount,
SUM(IIF(((Nz(TrnSales.IsReturn) <> 2) AND (TrnSales.IsCancelled=0)), TrnSalesLine.Amount,0)) AS GrossAmount,
Format([SalesLineTimeStamp],'yyyymmddhhnnss') AS LineTimeStamp,
SUM(IIF(TrnSales.IsReturn = 2,TrnSalesLine.Amount,0)) AS TotalRefund,
SUM(IIF(TrnSalesLine.ItemId = 1,TrnSalesLine.Amount,0)) AS ServiceCharge,
SUM(TmpPayTypeSales.TotalCashSales) AS TotalCash,
SUM(TmpPayTypeSales.TotalChargeSales) AS TotalCharge,
SUM(TmpPayTypeSales.TotalGiftCertificateSales) AS TotalGiftCertificate,
SUM(TmpPayTypeSales.TotalOnlineSales) AS TotalOnline,
SUM(TmpPayTypeSales.TotalCreditCardSales) AS TotalCreditCard,
SUM(TmpPayTypeSales.TotalOtherTenderSales) AS TotalOtherTender
FROM (((((TrnSalesLine 
INNER JOIN TrnSales ON TrnSalesLine.SalesId = TrnSales.Id) 
INNER JOIN TrnCollection ON TrnSales.Id = TrnCollection.SalesId) 
INNER JOIN MstItem ON TrnSalesLine.ItemId = MstItem.Id) 
INNER JOIN MstTax ON TrnSalesLine.TaxId = MstTax.Id) 
LEFT JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id)
LEFT JOIN TmpPayTypeSales ON TmpPayTypeSales.SalesId = TrnSales.Id
WHERE
(((TrnCollection.TerminalId)=" & TerminalId & ") 
AND ((TrnCollection.CollectionDate)=#" & readingDate & "#) 
AND ((TrnCollection.IsLocked)=True))
GROUP BY
TrnCollection.TerminalId, 
TrnCollection.CollectionDate, 
TrnCollection.IsLocked, 
TrnCollection.CollectionNumber, 
TrnCollection.IsCancelled, 
TrnSalesLine.ItemId, 
MstItem.ItemCode, 
MstItem.ItemDescription,
MstItem.IsInventory, 
MstItem.Category, 
MstItem.Price, 
MstDiscount.Discount, 
TrnSalesLine.DiscountRate, 
TrnSalesLine.DiscountAmount, 
TrnSalesLine.NetPrice, 
TrnSalesLine.Quantity, 
TrnSalesLine.Price1, 
TrnSalesLine.Price2, 
TrnSalesLine.Price2LessTax, 
TrnSalesLine.Amount, 
MstTax.Tax, 
TrnSalesLine.TaxRate, 
TrnSalesLine.TaxAmount,
Format([SalesLineTimeStamp],'yyyymmddhhnnss')
  


Public Sub CreateMCIAADataSource(SourceType As String, SalesId As Long, readingDate As Date, TerminalId As Long)
  Dim sql1 As String
  Dim sql2 As String
  Dim sql3 As String
  Dim sql4 As String
  
  DoCmd.SetWarnings False
  
  DoCmd.RunSQL "DELETE FROM TmpMCIAA_Source"
  
  If SourceType = "EOD" Then
      sql1 = " INSERT INTO TmpMCIAA_Source ( TerminalId, CollectionDate, IsLocked, CollectionNumber, IsCancelled, ItemId, ItemCode, ItemDescription, IsInventory, Category, Price, Discount, DiscountRate, DiscountAmount, NetPrice, Quantity, Price1, Price2, Price2LessTax, Amount, Tax, TaxRate, TaxAmount, LineTimeStamp, GrossAmount, TotalRefund, ServiceCharge,  TotalCash, TotalCharge, TotalGiftCertificate, TotalOnline,  TotalCreditCard, TotalOtherTender) "
      sql2 = " SELECT TrnCollection.TerminalId, TrnCollection.CollectionDate, TrnCollection.IsLocked, TrnCollection.CollectionNumber, TrnCollection.IsCancelled, TrnSalesLine.ItemId, MstItem.ItemCode, MstItem.ItemDescription, MstItem.IsInventory, MstItem.Category, MstItem.Price, MstDiscount.Discount, TrnSalesLine.DiscountRate, TrnSalesLine.DiscountAmount, TrnSalesLine.NetPrice, TrnSalesLine.Quantity, TrnSalesLine.Price1, TrnSalesLine.Price2, TrnSalesLine.Price2LessTax, TrnSalesLine.Amount, MstTax.Tax, TrnSalesLine.TaxRate, TrnSalesLine.TaxAmount,"
      sql3 = " Format([SalesLineTimeStamp],'yyyymmddhhnnss') AS LineTimeStamp, SUM(IIF(((Nz(TrnSales.IsReturn) <> 2) AND (TrnSales.IsCancelled=0)), TrnSalesLine.Amount,0)) AS GrossAmount, SUM(IIF(TrnSales.IsReturn = 2,TrnSalesLine.Amount,0)) AS TotalRefund, SUM(IIF(TrnSalesLine.ItemId = 1,TrnSalesLine.Amount,0)) AS ServiceCharge, SUM(TmpPayTypeSales.TotalCashSales) AS TotalCash, SUM(TmpPayTypeSales.TotalChargeSales) AS TotalCharge, SUM(TmpPayTypeSales.TotalGiftCertificateSales) AS TotalGiftCertificate, SUM(TmpPayTypeSales.TotalOnlineSales) AS TotalOnline, SUM(TmpPayTypeSales.TotalCreditCardS AS TotalCreditCard, SUM(TmpPayTypeSales.TotalOtherTenderSales) AS TotalOtherTender"
      sql4 = " FROM (((((TrnSalesLine INNER JOIN TrnSales ON TrnSalesLine.SalesId = TrnSales.Id) INNER JOIN TrnCollection ON TrnSales.Id = TrnCollection.SalesId) INNER JOIN MstItem ON TrnSalesLine.ItemId = MstItem.Id) INNER JOIN MstTax ON TrnSalesLine.TaxId = MstTax.Id) LEFT JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id) LEFT JOIN TmpPayTypeSales ON TmpPayTypeSales.SalesId = TrnSales.Id"
      sql5 = " WHERE (((TrnCollection.TerminalId)=" & TerminalId & ") AND ((TrnCollection.CollectionDate)=#" & readingDate & "#) AND ((TrnCollection.IsLocked)=True))"
      sql6 = " GROUP BY TrnCollection.TerminalId, TrnCollection.CollectionDate, TrnCollection.IsLocked, TrnCollection.CollectionNumber, TrnCollection.IsCancelled, TrnSalesLine.ItemId, MstItem.ItemCode, MstItem.ItemDescription,MstItem.IsInventory, MstItem.Category, MstItem.Price, MstDiscount.Discount, TrnSalesLine.DiscountRate, TrnSalesLine.DiscountAmount, TrnSalesLine.NetPrice, TrnSalesLine.Quantity, TrnSalesLine.Price1, TrnSalesLine.Price2, TrnSalesLine.Price2LessTax, TrnSalesLine.Amount, MstTax.Tax, TrnSalesLine.TaxRate, TrnSalesLine.TaxAmount, Format([SalesLineTimeStamp],'yyyymmddhhnnss');"
      DoCmd.RunSQL sql1 & sql2 & sql3 & sql4 & sql5 & sql6
  End If
  
  DoCmd.SetWarnings True
End Sub
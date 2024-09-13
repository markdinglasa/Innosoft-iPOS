INSERT INTO TmpMCIAA_SalesItem ( receiptNo, sku, qty, unitPrice, DiscountAmount, senior, pwd, diplomat, taxtype, tax, [memo], total )

SELECT TmpMCIAA_Source.CollectionNumber, 
TmpMCIAA_Source.ItemCode AS sku, 
TmpMCIAA_Source.Quantity AS qty, 
TmpMCIAA_Source.Price AS unitPrice,
 IIf([Discount]<>"Senior Citizen Discount" And [Discount]<>"PWD",[discountamount],0) AS DiscountAmount1, 
 IIf([Discount]="Senior Citizen Discount",[discountamount],0) AS senior, 
 IIf([Discount]="PWD",[discountamount],0) AS pwd, 
 IIf([Discount]="Diplomat" OR [Discount]="Diplomat Discount",[discountamount],0) AS diplomat, 
 TmpMCIAA_Source.Tax AS taxtype, TmpMCIAA_Source.TaxAmount AS tax, "" AS [memo], 
 IIf([Discount]="Senior Citizen Discount",([Quantity]*[Price])-[DiscountAmount],[Amount]) AS total
FROM TmpMCIAA_Source;

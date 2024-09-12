INSERT INTO TmpRLC ( 
TenantId, 
TerminalNumber, 

GrossAmount, 

TaxAmount, 
VoidAmount, 
VoidTransaction,
DiscountAmount, 
DiscountTransaction, 
ReturnAmount, 
ReturnTransaction, 
AdjustmentAmount, 
AdjustmentTransaction, 
ServiceChargeAmount, 
PreviousEOD, 
PreviousAmount, 
CurrentEOD, 
CurrentEODAmount, 
TransactionDate, 
NoveltyItemAmount, 
MiscItemAmount, 
LocalTax, 
CreditSalesAmount, 
CreditTaxAmount, 
NonVATSalesAmount, 
PharmaItemSalesAmount, 
NonPharmaItemSalesAmount, 
DisabilityDiscount, 
GrossSalesAmountNotSubectToPercentageRent, 
RePrintedAmount, 
RePrintedTransaction )

SELECT 
DFirst("RLC_TenantId","SysCurrent") AS [TenantId], 
"00000000000000" & Right([MstTerminal].[Terminal],2) AS [TerminalNumber], 
Sum(Round(IIf([MstDiscount].[Discount]<>"Senior Citizen Discount" And [MstDiscount].[Discount]<>"PWD" AND (Nz([TrnCollection].[IsReturn], 0) <> 2),[Price],[Price1]+[Price2LessTax])*[Quantity],3)) AS GrossSales, 
Sum(IIf(([TrnSalesLine].[TaxRate] > 0) AND (Nz([TrnCollection].[IsReturn], 0) < 1), [TrnSalesLine].[TaxAmount], 0)) AS [TaxAmount],
Sum(IIf(Mid([MstDiscount].[Discount],1,23)<>"Senior Citizen Discount" And [MstDiscount].[Discount]<>"PWD",[trnsalesline].[DiscountAmount]*[trnsalesline].[Quantity],0)) AS Discount, 
Sum(IIf(Mid([MstDiscount].[Discount],1,23)="Senior Citizen Discount",[trnsalesline].[DiscountAmount]*[trnsalesline].[Quantity],0)) AS SeniorCitizenDiscount, 
Sum(IIf([MstDiscount].[Discount]="PWD",[trnsalesline].[DiscountAmount]*[trnsalesline].[Quantity],0)) AS PWDDiscount, 
Sum(IIF(Nz([TrnCollection].[IsReturn], 0) = 2, 0, [TrnSalesLine].[Amount])) AS NetSales, 
Sum(IIF(Nz([TrnCollection].[IsReturn], 0) = 2, [TrnCollection].[Amount], 0)) AS SalesRefund, 
0 AS PreviousNetSales, 
Sum(IIf([trnsalesline].[TaxRate]>0 AND (Nz([TrnCollection].[IsReturn], 0) < 1), [trnsalesline].[quantity]*IIf([trnsalesline].[price2]>0,[trnsalesline].[price1],[trnsalesline].[netprice]),0)) AS VATSales, 
Sum(IIf([trnsalesline].[Price2]>0 AND (Nz([TrnCollection].[IsReturn], 0) < 1), [trnsalesline].[quantity]*([trnsalesline].[price2lesstax]-([trnsalesline].[price2lesstax]*([TrnSalesLine].[DiscountRate]/100))),IIf([TrnSalesLine].[TaxId]=5,[TrnSalesLine].[Amount],0))) AS VATEXEMPTSales, 
Sum(IIf([TrnSalesLine].[TaxId]=2 And ([TrnSalesLine].[Discountid]<>4 And [TrnSalesLine].[Discountid]<>3),[TrnSalesLine].[Amount],0)) AS NONVATSales, 

0 AS [NoOfTransaction], 
0 AS [NoOfCancelledTransaction], 
0 AS [TotalCancelledAmount], 
0 AS Zcounter
FROM 
TrnSales 
INNER JOIN ((((
    TrnSalesLine 
    LEFT JOIN [TrnCollection] ON [TrnCollection].[SalesId] = [TrnSalesLine].[SalesId])
    INNER JOIN TmpCollectionZReading ON TrnSalesLine.SalesId = TmpCollectionZReading.SalesId) 
    INNER JOIN MstDiscount ON TrnSalesLine.DiscountId = MstDiscount.Id) 
    INNER JOIN MstTax ON TrnSalesLine.TaxId = MstTax.Id) ON TrnSales.Id = TrnSalesLine.SalesId
GROUP BY  
TmpCollectionZReading.TerminalId, 
TmpCollectionZReading.CollectionDate, 
TmpCollectionZReading.IsLocked, 
TmpCollectionZReading.PreparedBy, 0, 
TmpCollectionZReading.IsCancelled
HAVING (((TmpCollectionZReading.TerminalId)=[Forms]![RepPOS]![TerminalId]) AND ((TmpCollectionZReading.CollectionDate)=[Forms]![RepPOS]![DateReading]) AND ((TmpCollectionZReading.IsLocked)=True) AND ((TmpCollectionZReading.IsCancelled)=False));

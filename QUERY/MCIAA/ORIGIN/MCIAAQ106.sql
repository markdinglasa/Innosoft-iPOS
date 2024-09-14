INSERT INTO TmpMCIAA_Summary ( salesDate, zcounter, previousnrgt, nrgt, previoustax, newtax, previoustaxsale, newtaxsale, prevousnotaxsale, newnotaxsale, opentime, closetime, gross, vat, localtax, amusement, taxsale, notaxsale, zerosale, void, voidcnt, disc, disccnt, refund, refundcnt, senior, seniorcnt, pwd, pwdcnt, diplomat, diplomatcnt, service, servicecnt, receiptstart, receiptend, trxcnt, cash, cashcnt, credit, creditcnt, charge, chargecnt, giftcheck, giftcheckcnt, othertender, othertendercnt )
SELECT Format([CollectionDate],"yyyymmdd") AS salesDate, 1 AS zcounter, 0 AS previousnrgt, Sum(IIf([Discount]<>"Senior Citizen Discount",[Price],[Price1]+[Price2LessTax])*[Quantity]) AS nrgt, 0 AS previoustax, Sum(IIf([IsCancelled]=False,[taxAmount],0)) AS newtax, 0 AS previoustaxsale, Sum(IIf([TaxRate]>0,[quantity]*IIf([price2]>0,[price1],[netprice]),0)) AS newtaxsale, 0 AS prevousnotaxsale, Sum(IIf([Price2]>0,[quantity]*([price2lesstax]-([price2lesstax]*([DiscountRate]/100))),0)) AS newnotaxsale, Min(TmpMCIAA_Source.LineTimeStamp) AS opentime, Max(TmpMCIAA_Source.LineTimeStamp) AS closetime, Sum(IIf([IsCancelled]=False,[Amount],0)) AS gross, Sum(IIf([IsCancelled]=False,[taxAmount],0)) AS vat, 0 AS localtax, 0 AS amusement, Sum(IIf([TaxRate]>0 And [IsCancelled]=False,[quantity]*IIf([price2]>0,[price1],[netprice]),0)) AS taxsale, Sum(IIf([Price2]>0 And [IsCancelled]=False,[quantity]*([price2lesstax]-([price2lesstax]*([DiscountRate]/100))),0)) AS notaxsale, 0 AS zerosale, Sum(IIf([IsCancelled]=True,[Amount],0)) AS void, Sum(IIf([IsCancelled]=True,1,0)) AS voidcnt, Sum(IIf([Discount]<>"Senior Citizen Discount" And [Discount]<>"PWD",[discountamount],0)) AS disc, DCount("receiptNo","TmpMCIAA_Sales","Void=0 AND linedisc>0")+0 AS disccnt, 0 AS refund, 0 AS refundcnt, Sum(IIf([Discount]="Senior Citizen Discount",[DiscountAmount],0)) AS senior, DCount("receiptNo","TmpMCIAA_Sales","Void=0 AND linesenior>0")+0 AS seniorcnt, Sum(IIf([Discount]="PWD",[DiscountAmount],0)) AS pwd, Sum(IIf([Discount]="PWD",1,0)) AS pwdcnt, 0 AS diplomat, 0 AS diplomatcnt, 0 AS service, 0 AS servicecnt, Min(TmpMCIAA_Source.CollectionNumber) AS receiptstart, Max(TmpMCIAA_Source.collectionnumber) AS receiptend, DCount("receiptNo","TmpMCIAA_Sales","Void=0") AS trxcnt, Sum(IIf([IsCancelled]=False,[Amount],0)) AS cash, DCount("receiptNo","TmpMCIAA_Sales","Void=0 and Cash>0") AS cashcnt, 0 AS credit, 0 AS creditcnt, 0 AS charge, 0 AS chargecnt, 0 AS giftcheck, 0 AS giftcheckcnt, 0 AS othertender, 0 AS othertendercnt
FROM TmpMCIAA_Source
GROUP BY Format([CollectionDate],"yyyymmdd"), 1, 0, 0, 0, 0, 0, 0, Format(Now(),"yyyymmddhhnnss"), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;


INSERT INTO TmpMCIAA_Summary ( salesDate, zcounter, previousnrgt, nrgt, previoustax, newtax, previoustaxsale, newtaxsale, prevousnotaxsale, newnotaxsale, opentime, closetime, gross, vat, localtax, amusement, taxsale, notaxsale, zerosale, void, voidcnt, disc, disccnt, refund, refundcnt, senior, seniorcnt, pwd, pwdcnt, diplomat, diplomatcnt, service, servicecnt, receiptstart, receiptend, trxcnt, cash, cashcnt, credit, creditcnt, charge, chargecnt, giftcheck, giftcheckcnt, othertender, othertendercnt )


SELECT 
Format([CollectionDate],"yyyymmdd") AS salesDate, 1 AS zcounter, 
0 AS previousnrgt, 
Sum(IIf([Discount]<>"Senior Citizen Discount",[Price],[Price1]+[Price2LessTax])*[Quantity]) AS nrgt, 
0 AS previoustax, Sum(IIf([IsCancelled]=False,[taxAmount],0)) AS newtax, 
0 AS previoustaxsale, 
Sum(IIf([TaxRate]>0,[quantity]*IIf([price2]>0,[price1],[netprice]),0)) AS newtaxsale, 
0 AS prevousnotaxsale, 
Sum(IIf([Price2]>0,[quantity]*([price2lesstax]-([price2lesstax]*([DiscountRate]/100))),0)) AS newnotaxsale,
Min(TmpMCIAA_Source.LineTimeStamp) AS opentime,
Max(TmpMCIAA_Source.LineTimeStamp) AS closetime, 
Sum(IIf([IsCancelled]=False,[Amount],0)) AS gross, 
Sum(IIf([IsCancelled]=False,[taxAmount],0)) AS vat, 
Sum(IIf([IsCancelled]=False AND Tax ="LOCAL-TAX",taxAmount,0)) AS localtax, 
Sum(IIf([IsCancelled]=False AND Tax ="AMUSEMENT",taxAmount,0)) AS amusement, 
Sum(IIf([TaxRate]>0 And [IsCancelled]=False,[quantity]*IIf([price2]>0,[price1],[netprice]),0)) AS taxsale,
Sum(IIf([Price2]>0 And [IsCancelled]=False,[quantity]*([price2lesstax]-([price2lesstax]*([DiscountRate]/100))),0)) AS notaxsale, 
0 AS zerosale,
Sum(IIf([IsCancelled]=True,[Amount],0)) AS void, 
Sum(IIf([IsCancelled]=True,1,0)) AS voidcnt, 
Sum(IIf([Discount]<>"Senior Citizen Discount" And [Discount]<>"PWD",[discountamount],0)) AS disc, 
DCount("receiptNo","TmpMCIAA_Sales","Void=0 AND linedisc>0")+0 AS disccnt, 
SUM(TmpMCIAA_Source.TotalRefund) AS refund, 
DCount("receiptNo","TmpMCIAA_Sales","Void=0 and refund > 0") AS refundcnt,
Sum(IIf([Discount]="Senior Citizen Discount",[DiscountAmount],0)) AS senior, 
DCount("receiptNo","TmpMCIAA_Sales","Void=0 AND linesenior>0")+0 AS seniorcnt, 
Sum(IIf([Discount]="PWD",[DiscountAmount],0)) AS pwd, 
Sum(IIf([Discount]="PWD",1,0)) AS pwdcnt, 
Sum(IIf([Discount]="Diplomat" OR [Discount]="Diplomat Discount",[DiscountAmount],0)) AS diplomat, 
Sum(IIf([Discount]="Diplomat" OR [Discount]="Diplomat Discount",1,0)) AS diplomatcnt, 
Sum(TmpMCIAA_Source.ServiceCharge) AS service, 
DCount("receiptNo","TmpMCIAA_Sales","Void=0 and service>0") AS servicecnt,
Min(TmpMCIAA_Source.CollectionNumber) AS receiptstart, 
Max(TmpMCIAA_Source.collectionnumber) AS receiptend, 
DCount("receiptNo","TmpMCIAA_Sales","Void=0") AS trxcnt,
Sum(Nz(TmpMCIAA_Source.TotalCash,0)) AS cash, 
DCount("receiptNo","TmpMCIAA_Sales","Void=0 and cash>0") AS cashcnt, 
Sum(Nz(TmpMCIAA_Source.TotalCreditCard,0)) AS credit, 
DCount("receiptNo","TmpMCIAA_Sales","Void=0 and credit >0") AS creditcnt, 
Sum(Nz(TmpMCIAA_Source.TotalCharge,0)) AS charge, 
DCount("receiptNo","TmpMCIAA_Sales","Void=0 and charge >0") AS chargecnt, 
Sum(Nz(TmpMCIAA_Source.TotalGiftCertificate,0)) AS giftcheck, 
DCount("receiptNo","TmpMCIAA_Sales","Void=0 and giftcheck >0") AS giftcheckcnt, 
Sum(Nz(TmpMCIAA_Source.TotalOtherTender,0)) AS othertender, 
DCount("receiptNo","TmpMCIAA_Sales","Void=0 and othertender >0") AS othertendercnt, 

FROM TmpMCIAA_Source
GROUP BY Format([CollectionDate],"yyyymmdd"), Format(Now(),"yyyymmddhhnnss")

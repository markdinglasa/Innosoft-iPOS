## Z-READING
- [Note] 
```
    NOTE!
        the `innosoft-POS` item price is already VAT included. it means that the PRICE has already vat with it. hence there were no automation on VAT inclusion on it.

        so this means, Item.Price = SRP + VAT 
```

- [GrossSales] 
```
    GROSS SALES:
        refer to the total revenue generated from all sales transactions before deducting any costs, taxes, discounts, or returns. It represents the full amount earned from selling goods or services.

    FORMULA:
        grossSales = (netSales + otherDiscount + seniorDiscount + pwdDiscount) - refundAmount

```

- [RegularDiscount] 
```
    REGULAR DISCOUNT:
        is a reduction applied to the original price of a product or service during a sales transaction. It is typically a fixed amount or percentage offered to customers as part of promotions, loyalty programs, or sales events. It also refers to the all discounts except the seniorDiscount and pwdDiscount.

    FORMULA:  Amount  * Discount Rate
    CODE:
        IF (TrnSales.IsCancelled = False) 
            AND (TrnSales.IsReturn = 2) // Refund
            AND (MstDiscount.Discount <> 'Senior Citizen Discount' 
            AND MstDiscount.Discount <> 'PWD') 
        THEN TrnSalesLine.DiscountAmount 
        ELSE 0
```

- [SeniorDiscount] 
```
    SENIOR DISCOUNT:  
        is a special price reduction offered to elderly customers, typically based on a minimum age requirement, such as 60 or 65 years old. This discount is applied as a percentage or fixed amount to the total purchase or specific items. Like a regular discount, the senior discount is deducted from the gross sales before calculating the final price that the customer needs to pay.
    
    FORMULA: ( Amount / VAT)  * Discount Rate
    CODE:
        IF (TrnSales.IsCancelled = False) 
            AND (TrnSales.IsReturn = 2) // Refund 
            AND (MstDiscount.Discount = 'Senior Citizen Discount') 
        THEN TrnSalesLine.DiscountAmount 
        ELSE 0
```

- [PWDDiscount] 
```
    PWD DISCOUNT: 
        (Persons with Disabilities) discount is a special price reduction granted to customers with disabilities, typically in accordance with laws or regulations in PH. This discount is usually a fixed percentage (e.g., 20%) off the total purchase or specific items. Like senior and regular discounts, the PWD discount is applied to the gross sales, reducing the total amount before taxes or other charges. Eligibility is typically verified with a government-issued PWD ID.

    FORMULA: ( Amount / VAT)  * Discount Rate
    CODE:
    IF (TrnSales.IsCancelled = False) 
        AND (TrnSales.IsReturn = 2) // Refund 
        AND (MstDiscount.Discount = 'PWD') 
    THEN TrnSalesLine.DiscountAmount 
    ELSE 0
```

- [NetSales] 

```
    NET SALES:
        refers to the total revenue after all discounts (such as regular, senior, or PWD discounts), returns, and allowances have been subtracted from the gross sales. It represents the actual income generated from sales transactions before deducting other costs like taxes and operating expenses.

    FORMULA: Net Sales = Gross Sales - Discounts
    IF ((TrnSales.IsCancelled = False) AND (TrnSales.IsReturn <> 2)) 
    THEN TrnSalesLine.Amount 
    ELSE 0
```

- [PayTypes & TotalCollection] 
```
    PAY TYPES [Cash, Check, Credit, Gift Check, etc.]:
        refers to the total paid amount.

    FORMULA: 
    Sum(
        IIf(
            Nz([TrnCollection].[IsReturn], 0) = 2,
            0, 
            IIf(
                [MstPayType].[PayType] = "Cash", 
                [TrnCollection].[Amount] - Nz(DSum("Amount", "TrnCollectionLine", "PayTypeId <> 1 AND CollectionId = " & [TrnCollection].[Id]), 0), 
                [TrnCollectionLine].[Amount]
            )
        )
    ) AS TotalAmount
```
- [AR]
```
    Net Sales
```

- [NonVATSales]
```
    NON VAT SALES:
        refers to the sales transactions that are exempt from Value Added Tax (VAT). These sales typically involve goods or services that are not subject to VAT under tax laws, such as basic necessities or specific services in PH. Non-VAT sales are not included in the computation of VAT but are still part of the total gross sales.

    FORMULA: 
        Sum(
            IIf([MstTax].[Tax] = 'NON-VAT'
                And ([MstDiscount].[Discount]<> 'Senior Citizen Discount'
                And [MstDiscount].[Discount]<> 'PWD Discount'))
            THEN [TrnSalesLine].[Amount]
            ELSE 0
        )

```


- [VATExemptSales]
```
    VAT EXEMPT SALES:
        refers to transactions involving goods or services that are not subject to Value Added Tax (VAT) under PH tax laws. These sales include specific items such as medical services, educational services, and certain basic necessities, depending on the jurisdiction. In VAT-exempt sales, the seller does not charge VAT, and they also cannot claim VAT credits on any expenses related to those exempt sales.

    FORMULA: 
        VATExemptSales = netSales - ( VATSales + VATAmount)
```

- [VATSales] 
```
    VAT SALES:
         is a consumption tax levied on goods and services at each stage of production or distribution where value is added. It is a percentage-based tax that consumers ultimately pay, but businesses collect and remit to the government.

    FORMULA:
        VATSales = (NetSales) - (VATAmount + VATExemptSales + NonVATSales)
```

- [VATAmount] 

```
    VALUE ADDED TAX:
         is a consumption tax levied on goods and services at each stage of production or distribution where value is added. It is a percentage-based tax that consumers ultimately pay, but businesses collect and remit to the government.

    FORMULA:
        // assuming the grosSsales is already deduct with the refundAmount
        VAT = (((grossSales ) - (seniorDisocunt + pwdDiscount + nonVatSales + saleGC )) / 1.12 ) * 0.12
```

- [CancelledTx] 

```
    CANCELLED TRANSACTIONS:
         a number of transactions that are cancelled

    FORMULA:
        CancelledTx = COUNT(TrnSales.IsCancelled = True, 1, null)
```

- [CancelledAmount] 

```
    CANCELLED AMOUNT:
        this refers to the total amount of the transactions that are cancelled

    FORMULA:
        CancelledAmount = SUM ( 
            IF(TrnSales.IsCancelled = True) 
                THEN TrnSalesLine.Amount, 
                ELSE 0
            )
```

- [NumberTransaction] 

```
    NUMBER OF TRANSACTIONS:
        this refers to the total number of the transactions on the said date

    FORMULA:
        NumberTransaction = COUNT ([TrnSales].[Id])
```

- [NumberSKU] 

```
    NUMBER OF SKU:
        this refers to the total number of the ItemCode in the TrnSales on the said date, excluding the Transaction that are cancelled or refunded

    FORMULA:
        NumberSKU = COUNT ([MstItem].[ItemCode])
```


- [TotalQuantity] 

```
    TOTAL QUANTITY
        this refers to the total amount of quantity in the TrnSalesLine on the said date, excluding the Transaction that are cancelled or refunded

    FORMULA:
        TotalQuantity = SUM ([TrnSalesLine].[Quantity])
```

- [ZCounter] 

```
    Z-COUNTER:
        the number of z-count, it just like an Id with an increment of 1

    FORMULA:
        zcount = prevZCount + 1
```

- [RunningTotal] 

```
    RUNNING TOTAL:
        the total amount of netSales including the previous reading

    FORMULA:
        //reading is netSales
        RunningTotal = prevReading + currentReading
```

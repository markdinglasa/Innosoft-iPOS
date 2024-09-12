# CHANGE LOGS
- [2024/03/15] Updated TrnCollection Table
```
    Add new field `IsReturn` to the TrnCollection, for Identifying a Returned or Refunded Collection, 1 Identifies as Returned, 2 Identifies as Refundend and 0 is the state where there were no actions yet. 
```

- [2024/03/15] Fix Function
``` 
    Fixed the creation of CVS in SIA
```

- [2024/06/03] Fix Function
``` 
    Fix the Filter sales summary of GCash sales where it only show the collection
```

- [2024/06/07] Fix Function
``` 
    Set the `F1 SearchItem` to SetFocus on SearchItem text-input
```

 
- [2024/07/16] Updated SM-SIA
``` 
    Fix SM Sales Insight and Analytics
```

- [2024/08/12] On-Progress ALLNC Sending
``` 
    Ongoing-development Alliance Sales (EOD) report sending, for E-Mall & MCIAA
```

- [2024/08/29] Updated RLC
``` 
    Updated Robinsons Mall Sales report sending
```

- [2024/08/31] Updated Database
```
    Updated Database from v2008 to v2022. Updated its corresponding functions of auto creation on click of Add Button. Fixed
```

- [2024/08/31] Updated license & expiry validator.
```
    Update the LicenseValidation to avoid pirate softwares
```

- [2024/08/31] Updated UI
```
    Updated the old footer ICON to the new Innosoft logo
```

- [2024/09/05] Updated RLC Sending
```
    Updated RLC Sending
```

- [2024/09/10] Updated ALLNCE Sending, for E-Mall & MCIAA
```
    Updated the queries into correct and enhance for ALLNC Sending
```

- [2024/09/10] Updated TrnSales Table
```
    Add new field `IsReturn` to the TrnSales, for Identifying a Returned or Refunded Sales, 1 Identifies as Returned, 2 Identifies as Refundend and 0 is the state where there were no actions yet. 
```

- [2024/09/10] Fix Function
```
     Updated Refund Form, to decline any duplication of Refund and prompt appropriate error message.
```

- [2024/09/10] Updated Reports
```
     Updated reports in regards of Refund, in which it this sales shouldnt be included on
        Z-Reading, 
        X-Reading, 
        Z-Reading by OR Number, 
        X-Reading By OR Number

        Sales Summary Report
        Sales Details Report
        Sales Detail Report (VAT SAles)
        Senior Citizen Sales Summary Report
        PWD Sales Summary Report
        Sales Reward Summary Report
        Sales Status Report
        Sales Status By Sales No.
        Sales Summary Report (All Fields)
        Sales Consumptioon Report

        Collection Summary Report
        Collection Detail Report

        Collection Detail Report - Checks
        Collection Detail Report - Credit Card
        Collection Detail Report - Gift Exchange
        Collection Detail Report - Rewards
        Collection Detail Report - Charges
        Collection Detail Report - Others

        Collection Daily Summary Report
```

- [2024/09/11] Updated RLC Sending
```
    based on Correction of RLC, corrected 
        GrossSales computation,
        VAT computation,
        DiscountCount - it should not include SeniorDiscount and PWDDiscount,
        RegularDiscountAmount computation - it should not include SeniorDiscount and PWDDiscount,
        OtherNegativeAdjusment is seniorDiscount but regarded as 0,
        counting of senior discount as NumberOtherNegativeAdjustments



```
- [2024/09/11] Remove Declarate in (Z-Reading, X-Reading, Z-Reading by OR Number, X-Reading By OR Number)

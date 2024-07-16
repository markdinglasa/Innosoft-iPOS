## VERSION 20240605
* Date completed Wednesday, March 03, 2024
* Date updated Friday, May 07, 2024

## SOFTWARE DEVELOPERS
*   Mark Gregory Pradilla
*   Mark Dinglasa

## PURPOSE
* This program is for SM Acreditation

## ADDED FUNCTION
* In POS Sales upon selecting an Item and tendering. The data would be saved in tmpSM(CSV) and the progam would automatically create a folder named SIA and a file of Transaction with a complete name of the cuurent month and year which is 03_2024_Transactions.csv . This file contains all of the transaction within that month.


## FILE LOCATION
Option 1. 
```bash
    C:\SIA\
    C:\pos13-sm.accde
```
-   The software automatically creates the SIA folder, but some instances it won't be able to create hence it needs administrator access to create a file in C dir

Option 2.
```bash
    D:\SIA\
    D:\pos13-sm.accde
```
-  Use D dir if option 1 is not applicable

## REQUIREMENT
1. Microsoft SQL Server 2008 R2
2. Microsoft Office 2010
3. Access Run Time 2010
4. pos13_clean backup
5. CSV Viewer/Reader

## DATABASE
- [TrnCollection] Add new column [IsReturn] for indication between Returned and Refunded items.

## TO START
*   Install the requirements first before starting the program
*   You can tender any item in the POS to test if the function is working as expected.

# LOGS
- [2024/03/15] Add new field [IsReturn] to the TrnCollection, for Identifying a Returned or Refunded Collection, 1 Identifies as Returned, 2 Identifies as Refundend and 0 is the state where there were no actions yet. 
- [2024/03/15] Fixed the creation of CVS in SIA
- [2024/06/03] Fix the Filter sales summary of GCash sales where it only show the collection
- [2024/06/03] Fix and Change the Delivery Report to Warranty
- [2024/06/07] Set the F1 SearchItem to SetFocus on SearchItem text-input 




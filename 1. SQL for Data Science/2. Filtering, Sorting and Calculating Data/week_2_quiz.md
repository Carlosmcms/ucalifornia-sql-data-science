# Module 2 - Quiz

This quiz is based on the [Chinook Database ER Diagram](https://ucde-rey.s3.amazonaws.com/DSV1015/ChinookDatabaseSchema.png).

## Questions

1. Find all the tracs that have a length of 5.000.000 milliseconds or more. How many tracks are returned?

```SQL
SELECT COUNT(TrackID)
FROM Tracks
WHERE Milliseconds >= 5000000

-- 2
```

2. Find all the invoicces whose total is between $5 and $15. How many total records there are?

```SQL
SELECT COUNT(InvoiceID)
-- SELECT InvoiceID, Total
FROM Invoices
WHERE Total BETWEEN 5 AND 15

-- 168
```

3. Find all the customers from the following states: RJ, DF, AB, BC, CA, WA, NY. What company does Jack Smith work for?

```SQL
SELECT FirstName, LastName, State, Company
FROM Customers
WHERE State IN ('RJ', 'DF', 'AB', 'BC', 'CA', 'WA', 'NY')
  AND FirstName = 'Jack'
  AND LastName = 'Smith'

-- Jack, Smith, WA, Microsoft Corporation
```

4. Find all the invoices for customer 56 and 58 where the toal was between $1.00 and $5.00. What was the invoice date for invoice ID 315?

```SQL
SELECT invoiceID, CustomerID, Total, InvoiceDate
FROM Invoices
WHERE (Total BETWEEN 1.00 and 5.00)
  AND InvoiceID = 315

-- 315, 58, 1.98, 2012-10-27 00:00:00
```

5. Find all the tracks whose name starts with 'All'. How many total records there are?

```SQL
SELECT COUNT(Name)
-- SELECT Name
FROM Tracks
WHERE Name LIKE 'All%'

-- 15
```

6. Find all the customer emails that start with 'J' and are from gmail.com.

```SQL
SELECT Email
FROM Customers
WHERE Email LIKE 'J@gmail.com'

-- jubarnett@gmail.com
```

7. Find all teh invoices from the billing city Brasília, Edmonton and Vancouver and sort in descending order by invoice ID. What is the total invoice amount of the first record returned?

```SQL
SELECT InvoiceID, BillingCity, Total
FROM Invoices
WHERE BillingCity IN('Brasilia', 'Edmonton', 'Vancouver')
ORDER BY InvoiceID DESC
LIMIT 1

-- 362, Edmonton, 13.86
```

8. Show the number of orders placed by each customer and sort the result by the number of orders in descending order. What is the number of items placed for the 8th person in this list?

```SQL
SELECT CustomerID, COUNT(*) AS customer_orders
FROM Invoices
GROUP BY CustomerID
ORDER BY customer_orders DESC
LIMIT 8

-- 8, 7
```

9. Find the albums with 12 or more tracks. How many records there are?

_Note: Consider to use subqueries on this one. This one is written in this way for quiz purposes._
```SQL
SELECT AlbumID, COUNT(*) AS number_of_tracks
FROM Tracks
GROUP BY AlbumID
HAVING number_of_tracks >= 12

-- (158 total rows shown)
```
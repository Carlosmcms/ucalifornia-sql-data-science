# Module 4 - Quiz

## Questions
1. Pull a list of customer ids with the customer's full name and address, along with combining their city and country together. Be sure to make a space in between these two and make it UPPER CASE (e.g. LOS ANGELES USA). What is the city and country result for CustomerID 16?

```
SELECT
  CustomerID
  , FirstName || ' ' || LastName AS FullName
  , Address
  , UPPER(City) || ' ' || UPPER(Country) AS City_Country
FROM Customers
WHERE CustomerID = 16

-- MOUNTAIN VIEW USA
```

2. Create new employee user id by combining the first 4 letters of the employee's first name with the first 2 letters of the employee's last name. Make the new field lower case and pull each individual step. What is the final result for Robert King?

```
  EmployeeId
  , FirstName
  , LastName
  , SUBSTR(FirstName, 1, 4) AS id_part_1
  , SUBSTR(LastName, 1, 2) AS id_part_2
  , SUBSTR(FirstName, 1, 4) || SUBSTR(LastName, 1, 2) AS new_id
  , LOWER(SUBSTR(FirstName, 1, 4) || SUBSTR(LastName, 1, 2))
    AS complete_new_id
FROM Employees
WHERE FirstName = 'Robert'
  AND LastName = 'King'

-- robeki
```

3. Show a list of employees who have worked for the company for 15 oro more years using the current date function. Sort by lastname ascending. What is the lastname of the last person on the list returned?

```
SELECT
  LastName
  , STRFTIME('%Y', HireDate)
  , STRFTIME('%Y', 'now')
  , STRFTIME('%Y', 'now') - STRFTIME('%Y', HireDate)
    AS YearsAtCompany
FROM Employees
WHERE STRFTIME('%Y', YearsAtCompany) >= 15
ORDER BY LastName ASC

-- Peacock
```

4. Profiling the Customers table. Are there any columns with null values?

```
SELECT *
FROM Customers
WHERE 
  -- Adress IS NULL
  -- Company IS NULL
  -- PostalCode IS NULL
  -- Fax IS NULL
  -- FirstName IS NULL
    Phone IS NULL

-- Company, PostalCode, Fax, Phone
```

5. Find the cities with the most customers and rank in descending order. Which cities have 2 customers?

```
SELECT
  City
  , COUNT(CustomerID) AS customers_quantity
FROM Customers
GROUP BY City
HAVING customers_quantity >= 2
ORDER BY customers_quantity DESC

-- Berlin, London, Mountain View, Paris, Prague, Sao Paulo
```

6. Create a new customer invoice id by combining customer first and last name and invoice id.

```
SELECT
  C.FirstName
  , C.LastName
  , I.InvoiceID
  , FirstName || LastName || InvoiceID AS new_invoice_id
FROM Customers C LEFT JOIN Invoices I
ON C.CustomerID = I.CustomerID
WHERE C.FirstName = 'Astrid'
  AND C.LastName = 'Gruber'
```
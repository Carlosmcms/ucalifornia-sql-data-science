-- WHERE example
SELECT ProductName, UnitPrice, SupplierID, UnitsUnStock
FROM Products
WHERE ProductName = 'Tofu'
  AND UnitPrice >= 75
  AND ProductName <> 'Alice Mutton'
  AND UnitsInStock BETWEEN 15 AND 80
  OR ProductName IS NULL;

-- IN example
SELECT ProductID, UnitPrice, SupplierID
FROM Products
WHERE SupplierID IN (9, 10, 11)
  AND ProductName = 'Tofu' OR 'Konbu';

-- SQL will process OR and avoid AND. To avoid this, it's required to use parenthesis.
SELECT ProductID, UnitPrice, SupplierID
FROM Products
WHERE SupplierID = 9 OR SupplierID = 11
  AND UnitPrice = 15;

SELECT ProductID, UnitPrice, SupplierID
FROM Products
WHERE (SupplierID = 9 OR SupplierID = 11)
  AND UnitPrice = 15;

-- NOT example
SELECT *
FROM Employees
WHERE NOT City = 'London'
  AND NOT City = 'Seattle';

-- Wildcards/LIKE example
SELECT *
FROM Employees
WHERE City LIKE 'Lon%' AND '%don' AND '%nd%' AND 'L%n'

-- Sorting example
SELECT ProductID, UnitPrice, SupplierID
FROM Products
ORDER BY ASC ProductID, DESC UnitPrice;

-- Math Operations
SELECT ProductID, UnitPrice, UnitsOnOrder,
  UnitsOnOrder * UnitPrice AS Total_Order_Cost
FROM Products;

-- "Please excuse my dear aunt Sally" to verify math precedence
-- Parenthesis > Exponents > Multiplication > Division > Addition, Substraction
SELECT ProductID, Quantity, UnitPrice, Discount
  (UnitPrice - Discount) / Quantity AS Total_Cost
FROM OrderDetails;

-- Aggregate function example: AVERAGE
-- Rows containing NULL values are ignored by this function.
SELECT AVG(UnitPrice) AS avg_price
FROM Products;

-- COUNT(*) - Counts all the rows in a table containing values or NULL values.
SELECT COUNT(*) AS total_customers
FROM Customers;

-- COUNT(column) - Counts all the rows in a specific column ignoring NULL values
SELECT COUNT(CustomerID) AS total_customers
FROM Customers;

-- SUM() - Can be used with math functions inside of it.
SELECT SUM(UnitPrice * UnitsInStock) AS total_price
FROM Products
WHERE SupplierID = 33;

-- GROUP BY example
SELECT Region, COUNT(CustomerID) AS total_customers
FROM Customers
GROUP BY Region;

-- HAVING example
-- Selects and groups customers that have greater than or equal to 2 orders.
SELECT CustomerID, COUNT(*) AS orders
FROM Orders
GROUP BY CustomerID
HAVING COUNT (*) >=2;
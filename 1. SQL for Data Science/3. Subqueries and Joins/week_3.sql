-- Subqueries example
-- Problem: Need to know the region each customer is form who has had an order with freigth over 100.

SELECT CustomerID, CompanyName, Region
FROM Customers
WHERE CustomerID IN (
  SELECT CustomerID
  FROM Orders
  WHERE Freight > 100);

-- Subqueries for calculation
SELECT COUNT(*) AS orders
FROM Orders
Where CustomerID = '143569';

SELECT CustomerName, CustomerState, (
  SELECT COUNT(*) AS orders
  FROM orders
  WHERE Order.CustomerID = Customers.CustomerID) AS orders
FROM Customers
ORDER BY CustomerName;

-- Cartesian (CROSS) JOIN example
SELECt ProductName, UnitPrice, CompanyName
FROM Suppliers
  CROSS JOIN Products;

-- INNER JOIN example
SELECT suppliers.CompanyName, ProductName, UnitPrice
FROM Suppliers INNER JOIN Products
  ON Suppliers.SupplierID = Products.SupplierID;

-- Multiple INNER JOIN example
SELECT o.OrderID, c.CompanyName, e.LastName
FROM (Orders o INNER JOIN Customers c
  ON o.CustomerID = c.CustomerID)
  INNER JOIN Employees
    ON o.EmployeeID = e.EmployeeID;

-- SELF JOIN example
SELECT column_name_n
FROM Table1 T1, Table2 T2
WHERE condition;

-- Query description: A list of customers with the same city.
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID = B.CustomerID
  AND A.City = B.City
ORDER BY A.City;

-- Query description: A list of employees and their managers.
SELECT e.FirstName + ' ' + e.LastName AS Employee,
  m.FirstName + ' ' + m.LastName AS Manager
FROM Employees AS e INNER JOIN Employees as m
  ON e.EmployeeID = m.ReportsTo;

-- LEFT JOIN example
-- Query description: A list of customers, even if they doesn't have an order.
SELECT C.CustomerName, O.OrderID
FROM Customers C LEFT JOIN Orders O
  ON C.CustomerID = O.CustomerID
ORDER BY C.CustomerName;

-- RIGHT JOIN example
-- Query description: A list of orders, even if they doesn't have a customer associated with them.
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders RIGHT JOIN Employees
  ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY O.OrderID;

-- FULL OUTER JOIN example
-- Query description: Select all customers and all orders
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers FULL OUTER JOIN Orders
  ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;

-- UNION example
SELECT column_n
FROM table1
UNION
SELECT column_n
FROM table2



-- Quiz Testing
SELECT AlbumID, Title
FROM Albums
WHERE ArtistID = (
    SELECT ArtistID
    FROM Artists
    WHERE Name = 'Audioslave'
)

-- AlbumID = 10, 11, 271

SELECT R.AlbumID, R.Title, T.COUNT(*), T.SUM(UnitPrice)
FROM Tracks T LEFT JOIN Albums R
    ON T.AlbumID = R.AlbumID
    WHERE R.ArtistID = (
        SELECT ArtistID
        FROM Artists
        WHERE Name = 'AudioSlave'
    )
GROUP BY R.AlbumID
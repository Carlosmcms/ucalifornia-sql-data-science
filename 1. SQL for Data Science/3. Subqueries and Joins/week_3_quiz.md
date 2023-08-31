# Module 3 - Quiz

## Questions

1. Using a subquery, find the names of all the tracks for the album "Californication". What is the title of the 8th track?

```SQL
SELECT TrackID, Name, AlbumID
FROM Tracks
WHERE AlbumID IN (
    SELECT AlbumID
    FROM Albums
    WHERE Title = 'Californication'
)
LIMIT 8

-- Porcelain
```

2. Find the total number of invoices for each customer along with customer's full name, city and email. What is the email address of the 5th person, Frantisek Wichterlová?

```SQL
SELECT C.FirstName || ' ' || C.LastName AS full_name,
    C.City,
    C.Email,
    COUNT(I.InvoiceID) AS Invoices
FROM Customers C LEFT JOIN Invoices I
ON C.CustomerID = I.CustomerID
GROUP BY C.CustomerID
LIMIT 5

-- frantisekw@jetbrains.com
```

3. Retrieve the track name, album, artistID and trackID for all the albums. What is the song title of trackID 12 for the "For Those About to Rock We Salute You" album?

```SQL
SELECT T.Name, R.Title, R.ArtistID, T.TrackID
FROM Tracks T LEFT JOiN Albums R
ON T.AlbumID = R.AlbumID
WHERE T.TrackID = 12
```

4. Retrieve a list with the managers last name, and the last name of the employees who report to him or her. Who are the reports for the manager named Mitchell?

```SQL
SELECT M.LastName AS manager,
E.LastName AS employee
FROM Employees M LEFT JOIN Employees E
ON M.EmployeeID = E.ReportsTo
WHERE manager = 'Mitchell'

-- Callahan, King
```

5. Find the name and ID of the artists who do not have albums. Two of the records returned have the same last name. Enter that name below.

```SQL
SELECT A.ArtistID, A.Name
FROM Artists A LEFT JOIN Albums R
ON A.ArtistID = R.ArtistID
WHERE R.ArtistID IS NULL

-- Gilberto
```

6. Use a UNION to create a list of all teh employee's and customer's first names and last names ordered by the last name in descending order.

```SQL
SELECT FirstName, LastName
FROM Employees
UNION
SELECT FirstName, LastName
FROM Customers
ORDER BY LastName DESC
```

7. See if there are any customer who have a different city listed in their billing city versus their customer city.

```SQL
SELECT C.CustomerID, C.City, I.BillingCity
FROM Customers C LEFT JOIN Invoices I
ON C.CustomerID = I.CustomerID
WHERE C.City <> I.BillingCity

-- (No results)
```
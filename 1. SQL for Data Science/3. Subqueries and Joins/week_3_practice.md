# Module 3 - Practice

## Questions

1. How many albums does the artist Led Zeppelin have?

```SQL
--SELECT A.ArtistID, A.Name
SELECT COUNT(A.ArtistID)
FROM Artists A INNER JOIN Albums R
    ON A.ArtistID = R.ArtistID
WHERE A.Name = 'Led Zeppelin';
```

2. Create a list of album titles and the unit prices for the artist "Audioslave".

```SQL
SELECT R.AlbumID, T.Name, T.UnitPrice
FROM (Tracks T LEFT JOIN Albums R
  ON T.AlbumID = R.AlbumID) LEFT JOIN Artists A
  ON R.ArtistID = A.ArtistID
WHERE A.Name = 'Audioslave'
```

3. Find the first and last name of any customer who does not have an invoice. Are there any customers returned from the query?

```SQL
SELECT C.CustomerID, C.FirstName, C.LastName
FROM Customers C LEFT JOIN Invoices I 
ON C.CustomerID = I.CustomerID
WHERE I.CustomerID IS NULL

-- (No Results)
```

4. Find the total price of each album. What is the total price for the album "Big Ones"?

```SQL
SELECT R.AlbumID, R.Title, COUNT(R.AlbumID), SUM(T.UnitPrice)
FROM Tracks T LEFT JOIN Albums R
    ON T.AlbumID = R.AlbumID
WHERE R.Title = 'Big Ones'
GROUP BY R.AlbumID

-- 14.85
```


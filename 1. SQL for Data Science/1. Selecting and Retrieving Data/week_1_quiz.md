# Module 1 - Quiz

## Questions

1. Retrieve all the records for the Employees table. What's' Robert King's mailing address?

```SQL
SELECT *
FROM Employees
WHERE FirstName = 'Robert' AND LastName = 'King'

-- 590 Columbia Boulevard West...
```

2. Retrieve the FirstName, LastName, Birthdate, Address, City and State from the employees table. Which of the employees listed below has a birthdate of 3-3-1965?

```SQL
SELECT FirstName, LastName, Birthdate, Address, City, State
FROM Employees

-- Steve
```

3. Retrieve all teh columns from the Tracks table, but only return 20 rows. What is the runtime in milliseconds for the 5th track, entitled "Princess of the Dawn"

```SQL
SELECT *
FROM Tracks
WHERE TrackID = 5
LIMIT 20

-- 375418
```
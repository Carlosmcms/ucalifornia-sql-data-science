-- Concatenate string example
SELECT CompanyName,
  ContactName,
  CompanyName || ' (' || ContactName ')'
FROM Customers;

-- Trim example
SELECT TRIM("       You the best.   ") AS TrimmedString

-- Substring example
SUBSTR(string_name, string_position, number_of_characters)

SELECT first_name, SUBSTR(first_name, 2, 3)
FROM Employees
WHERE department_id = 60;

-- Upper and Lower example
SELECT UPPER (column_name)
-- UCASE(column_name)
FROM TableName;

-- Date Time Functions (Check on every technology to use)
DATE(timestring, modifier_a, modifier_n)
TIME(timestring, modifier_a, modifier_n)
DATETIME(timestring, modifier_a, modifier_n)
JULIANDAY(timestring, modifier_a, modifier_n)

-- String Format Time function
STRFTIME(format, timestring, modifier_a, modifier_n)

SELECT Birthdate,
STRFTIME('%Y', Birthdate) AS Year,
STRFTIME('%m', Birthdate) AS Month,
STRFTIME('%d', Birthdate) AS Day
FROM Employees

-- Compute current date
SELECT DATE('now')
SELECT STRFTIME('%Y %m %d', 'now')

-- Cumpute current time
SELECT STRFTIME('%H %M %S %s', 'now')

-- Calculate age
SELECT Birthdate,
STRFTIME('%Y', Birthdate) AS Year,
STRFTIME('%m', Birthdate) AS Month,
STRFTIME('%d', Birthdate) AS Day,
DATE(('now') - Birthdate) AS Age
FROM Employees;

-- CASE Statements examples
SELECT employeeId,
  firstname,
  lastname,
  city,
  CASE City
  WHEN 'Calgary' THEN 'Calgary'
  ELSE 'Other'
  END calgary
FROM Employees
ORDER BY lastname, firstname;

SELECT
TrackID,
Name,
Bytes,
CASE
  WHEN bytes < 300000 THEN 'small'
  WHEN bytes >= 300001 AND bytes <= 500000 THEN 'medium'
  WHEN bytes >= 500001 THEN 'large'
  ELSE 'other'
  END bytescategory
FROM Tracks;

-- VIEW example
CREATE [TEMP] VIEW [IF NOT EXISTS] view_name(column_a, column_n)
AS SELECT_STATEMENT;

CREATE VIEW my_view AS
  SELECT
  r.regiondescription,
  t.territorydescription,
  e.lastname,
  e.firstname,
  e.hiredate,
  e.reportsto,
  FROM Region r
    INNER JOIN Territories t ON r.regionId = t.regionId
    INNER JOIN EmployeeTerritories et ON t.territoryId = et.territoryId
    INNER JOIN Employees e ON et.employeeId = e.employeeId;


-- SELECT example
SELECT <columns>
FROM <specific table>
LIMIT <number of records/row>

-- CREATE TABLE example
CREATE TABLE Shoes 
(
  id CHAR(10) PRIMARY KEY,
  brand CHAR(10) NOT NULL,
  type CHAR(250) NOT NULL,
  color CHAR(250) NOT NULL,
  price DECIMAL(8,2) NOT NULL,
  discount VARCHAR(750) NULL
);

-- INSERT INTO example
INSERT INTO Shoes (id, brand, type, color, price, discount)
VALUES ('14535974', 'Gucci', 'Slippers', 'Pink', 695.00, NULL);

-- TEMPORARY example
CREATE TEMPORARY TABLE Sandals AS
(
  SELECT *
  FROM Shoes
  WHERE Shoes.type = 'sandals
)
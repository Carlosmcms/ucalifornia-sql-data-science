# Create a User Snapshot Table

## Starting Point

```SQL
{% assign ds = '2018-01-01'}
SELECT
  id,
  '{{ds}}' AS variable_column
FROM users
```

## Exercise 1
Create the query for `user_info` table with the required columns.

### Solution
```SQL
{% assign ds = '2018-01-01'}

WITH
users_with_orders AS (
    SELECT DISTINCT user_id
    FROM orders
    WHERE created_at <= '{{ds}}'
),
users_with_orders_today AS (
  SELECT DISTINCT user_id
  FROM orders
  WHERE created_at = '{{ds}}'
)

SELECT
  users.id AS user_id,
  IF(users.created_at = '{{ds}}', 1, 0) AS created_today,
  IF(users.deleted_at <= '{{ds}}', 1, 0) AS is_deleted,
  IF(users.created_at = '{{ds}}', 1, 0) AS deleted_today,
  IF(users_with_orders.user_id IS NOT NULL, 1, 0) AS has_ever_ordered,
  IF(users_with_orders_today.user_id IS NOT NULL, 1, 0) AS ordered_today,
  '{{ds}}' AS ds
FROM users
LEFT OUTER JOIN users_with_orders
  ON users_with_orders.user_id = users.id
LEFT OUTER JOIN users_with_orders_today
  ON users_with_orders_today.user_id = users.id
WHERE
  users.created_at <= '{{ds}}'
```

## Exercise 2
Create the `user_info` table.

### Solution
```SQL
CREATE TABLE IF NOT EXISTS user_info
(
  user_id             INT(10) NOT NULL,
  created_today       INT(1) NOT NULL,
  is_deleted          INT(1) NOT NULL,
  is_deleted_today    INT(1) NOT NULL,
  has_ever_ordered    INT(1) NOT NULL,
  ordered_today       INT(1) NOT NULL,
  ds                  DATE NOT NULL
);

DESCRIBE user_info;
```

## Exercise 3
Insert into the `user_info` table the query from the exercise 1.

### Solution
```SQL
INSERT INTO user_info
-- Put query here
```

## Extra Questions
1. How do you check that the table contains what you expect?
2. How do insert by day?
3. How to backfill the data?
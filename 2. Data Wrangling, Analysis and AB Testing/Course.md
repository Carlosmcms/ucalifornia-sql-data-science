# Course Overview

## Identifying Unreliable Data & Nulls

Check for empty
 ```SQL
SELECT
  categorical_column
  , COUNT(*)
FROM
  table_name
GROUP BY
  categorical_column
```

To get previous join
```SQL
SELECT *
FROM example table_ et
JOIN other_example_table oet
ON et.user_id = oet.user_id
AND et_user_id IS NOT NULL
```

To exclude NULL for JOIN
```SQL
SELECT
  COALESCE(parent_user_id, user_id) AS original_user_id
  , parent_user_id
  , user_id
FROM
  dsv1069.users
```

## Get dates by full date, only the date, only the year.

```SQL
SELECT
  --DATE(event_time) AS event_date
  TO_CHAR(event_time, 'dd-mm-yyyy') AS event_date
  --EXTRACT(YEAR, MONTH, DAY FROM event_time) AS year
  , COUNT(*) AS date_count
FROM 
  dsv1069.events_201701
GROUP BY
  event_date
ORDER BY
  event_date ASC
```

```SQL
SELECT
  orders.item_category,
  COUNT(DISTINCT COALESCE(parent_user_id, user_id)) AS users_with_orders
FROM Orders
JOIN Users
  ON Users.id = orders.user_id
GROUP BY orders.item_category
```
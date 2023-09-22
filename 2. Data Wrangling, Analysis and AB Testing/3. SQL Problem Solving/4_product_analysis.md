# Product Analysis

Refers to the [Mode Analytics workspace](https://app.mode.com/editor/carlosmcms_personal/reports/c404655ab2b2/queries/c59b223ab110) to complete the activity.

## Exercise 0
Count how many users we have.

### Starting Point
```SQL
SELECT *
FROM dsv1069.users
LIMIT 100
```

### Solution
```SQL
SELECT COUNT(*)
FROM dsv1069.users
```

## Exercise 1
Find out how many users have ever ordered.

### Starting Point
```SQL
SELECT *
FROM dsv1069.orders
```

### Solution
```SQL
SELECT
  user_id,
  COUNT(DISTINCT user_id) AS users_with_orders
FROM dsv1069.orders
GROUP BY user_id
```

## Exercise 2
Find how many users have reordered the same item.

### Starting Point
```SQL
SELECT *
FROM dsv1069.orders
```

### Solution
```SQL
WITH user_level_orders AS (
  SELECT
    user_id,
    item_id,
    COUNT(DISTINCT line_item_id) AS times_user_ordered
  FROM dsv1069.orders
  GROUP BY
    user_id,
    item_id
)

SELECT COUNT(DISTINCT user_id) AS users_who_reordered
FROM user_level_orders
WHERE times_user_ordered > 1
```

## Exercise 3
Do users even order more than once?

### Starting Point
```SQL
SELECT *
FROM dsv1069.orders
```

### Solution
Yes, as follows:

```SQL
SELECT
  user_id,
  COUNT(user_id) AS orders_per_user
FROM dsv1069.orders
GROUP BY user_id
HAVING COUNT(user_id) > 1
```

## Exercise 4
Orders per item.

### Starting Point
```SQL
SELECT *
FROM dsv1069.orders
```

### Solution
```SQL
SELECT
  item_id,
  COUNT(item_id) AS item_count
FROM dsv1069.orders
GROUP BY item_id
```

## Exercise 5
Orders per category.

### Starting Point
```SQL
SELECT *
FROM dsv1069.orders
```

### Solution
```SQL
SELECT
  item_category,
  COUNT(item_id) AS item_count
FROM dsv1069.orders
GROUP BY item_category
```

## Exercise 6
Do user order multiple things from the same category?

### Starting Point
```SQL
SELECT
  user_id,
  item_id,
  COUNT(line_item_id) AS items_ordered
FROM dsv1069.orders
GROUP BY
  user_id,
  item_id
```

### Solution
```SQL
SELECT
  user_id,
  item_category,
  COUNT(DISTINCT line_item_id) AS times_category_ordered
FROM dsv1069.orders
GROUP BY
  user_id,
  item_category
```

## Exercise 7
Find the average time between orders. Decide if this analysis is necessary.

### Starting Point
```SQL
WITH first_orders AS (
  SELECT
    user_id,
    invoice_id,
    paid_at,
    DENSE_RANK() OVER (
      PARTITION BY user_id
      ORDER BY paid_at ASC
    ) AS order_num
  FROM dsv1069.orders
),
second_orders AS (
  SELECT
    user_id,
    invoice_id,
    paid_at,
    DENSE_RANK() OVER (
      PARTITION BY user_id
      ORDER BY paid_at ASC
    ) AS order_num
  FROM dsv1069.orders
)

SELECT
  first_orders.user_id,
  DATE(first_orders.paid_at) AS first_order_date,
  DATE(second_orders.paid_at) AS second_order_date,
  DATE(second_orders.paid_at) - DATE(first_orders.paid_at) AS date_diff
FROM first_orders
JOIN second_orders
ON first_orders.user_id = second_orders.user_id
WHERE
  first_orders.order_num = 1
  AND second_orders.order_num = 2
```

### Solution
```SQL
-- Not Necessary
```
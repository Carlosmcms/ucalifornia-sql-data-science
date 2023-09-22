# Create a Rollup Table
Refers to the [Mode Analytics workspace](https://app.mode.com/editor/carlosmcms_personal/reports/c404655ab2b2/queries/c59b223ab110) to complete the activity.

## Exercise 1
Create a subtable of orders per day. Make sure you decide whether you are counting invoices or line items.

### Starting Point
```SQL
SELECT *
FROM dsv1069.orders
```

### Solution
```SQL
SELECT
  DATE(paid_at) AS day,
  COUNT(DISTINCT invoice_id) AS orders,
  COUNT(DISTINCT line_item_id) AS items_ordered
FROM
  dsv1069.orders
GROUP BY
  DATE(paid_at)
```

## Exercise 2
__Check your joins__. We are still trying to count orders per day. In this step join the subtable from the prepvious exercise to the dates rollup table so we can get a row for every date. Check that the join works by just running a `SELECT *` query.

### Solution
```SQL
WITH daily_orders AS (
  -- Exercise 1 code
)

SELECT *
FROM dsv1069.dates_rollup
LEFT OUTER JOIN daily_orders
ON daily_orders.day = dates_rollup.day
```

## Exercise 3
__Clean up your columns__. In this step be sure to specify the columns you actually want to return and, if necessary, do any aggregation needed to get a count of the orders made per day.

### Solution
```SQL
WITH daily_orders AS (
  -- Exercise 1 code
)

SELECT
  DATE(dates_rollup.date) AS date,
  COALESCE(SUM(orders), 0) AS orders,
  COALESCE(SUM(items_ordered), 0) AS items_ordered
FROM dsv1069.dates_rollup
LEFT OUTER JOIN daily_orders
ON daily_orders.day = dates_rollup.date
GROUP BY dates_rollup.date
```

## Exercise 4
__Weekly rollup__. Figure out which parts of the join condition need to be edited create 7 day rolling orders table.

### Solution
```SQL
WITH daily_orders AS (
  -- Exercise 1 code
)

SELECT
  *
FROM dsv1069.dates_rollup
LEFT OUTER JOIN daily_orders
ON daily_orders.day <= dates_rollup.date
  AND daily_orders.day > dates_rollup.d7_ago
```

## Exercise 5
__Column cleanup__. Finish creating the weekly rolling orders table by performing any aggregation steps and naming your columns appropriately.

### Solution
```SQL
WITH daily_orders AS (
  -- Exercise 1 code
)

SELECT
  DATE(dates_rollup.date) AS date,
  COALESCE(SUM(orders), 0) AS orders,
  COALESCE(SUM(items_ordered), 0) AS items_ordered,
  COUNT(*) AS full_week_days_with_orders
FROM dsv1069.dates_rollup
LEFT OUTER JOIN daily_orders
ON daily_orders.day <= dates_rollup.date
  AND daily_orders.day > dates_rollup.d7_ago
GROUP BY
  dates_rollup.date
```
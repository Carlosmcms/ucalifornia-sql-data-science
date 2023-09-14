# Identifying Unreliable Data & NULL

## Exercise 1
Using any methods you like, determine if you can trust this events table.

```SQL
SELECT *
FROM dsv1069.events_201701
```

### Solution
As the table name suggests, this one only contains data from events on Jan-2017. Unless it's required to get data ONLY from that period, this table should not be considered for the analysis, even if the query below shows there's no empty columns by date.

_NOTE: Commented code used to get the date in different formats._

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

## Exercise 2
Using any methods you like, determin if you can trust this events table. (HINT: When did we start recording events on mobile).

```SQL
SELECT *
FROM dsv1069.events_ex2
```

### Solution
Because mobile logging was implemented a considerable time after the other events record, it can be a problem if it's involved into the general analysis. To verify this:

```SQL
SELECT
  DATE(event_time) AS date
  , event_name
  , platform
  , COUNT(*)
FROM
  dsv1069.events_ex2
GROUP BY
  date
  , platform
  , event_name
```

## Exercise 3
Imagine that you need to count item views by day. You found this table item_views_by_category_temp. Should you use ut to answer your question?

```SQL
SELECT *
FROM dsv1069.item_views_by_category_temp
```

### Solution
The table has "temp" in the name, so it can be created for a specific reason; therefore, it shouldn't be considered for a different analysis. Also for this case, it's recommended to compare how many events are expected to be. There's a big mismatch there, so don't consider the "temp" table.

```SQL
SELECT
  'item_views_by_category_temp' AS table_name
  , SUM(view_events) AS event_count
FROM
  dsv1069.item_views_by_category_temp
UNION
SELECT
  'events' AS table_name
  , COUNT(DISTINCT event_id) AS event_count
FROM dsv1069.events
WHERE event_name = 'view_item'
```

## Exercise 4
Using any methods you like, decide if this table is ready to be used as a source of truth.

```SQL
SELECT *
FROM dsv1069.raw_events
```

### Solution
It seems the table doesn't exist in the schema. Even so, the code to verify if the `user_id` is NULL for web events:

```SQL
SELECT
  DATE(event_time) AS date
  , platform
  , COUNT(*) as row_count
  , COUNT(event_id) AS event_count
  , COUNT(user_id) AS user_count
FROM
  ds1069.raw_events
GROUP BY
  date
  , platform
```

## Exercies 5
Is this the right way to join orders to users?

```SQL
SELECT *
FROM dsv1069.orders
JOIN dsv1069.users
ON orders.user_id = users.parent_user_id
```

### Solution
Since there are some NULLs in `parent_user_id`, it's better to use the `COALESCE` function to apply the join with `users.id` if `users.parent_user_id` is NULL.

```SQL
SELECT COUNT(*)
FROM dsv1069.orders
JOIN dsv1069.users
ON orders.user_id = COALESCE(users.parent_user_id, users.id)
```
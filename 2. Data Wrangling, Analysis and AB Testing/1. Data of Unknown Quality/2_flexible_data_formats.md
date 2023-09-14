# Flexible Data Formats

## Step 1
Write a query to format the `view_item` event into a table with the appropriate columns.

### Starting Point
```SQL
SELECT
  *
FROM
  dsv1069.events
WHERE
  event_name = 'view_items'
```

### Solution
Choose the right columns. Use CASE clause to create a new column named `item_id` using `parameter_name = 'item_id'` and `parameter_value`, ELSE in other case.

```SQL
SELECT
  event_id
  , event_time
  , user_id
  , platform
  , (CASE
    WHEN parameter_name = 'item_id' THEN CAST(parameter_value AS INT)
    ELSE NULL
    END) AS item_id
    , (CASE
    WHEN parameter_name = 'referrer' THEN parameter_value
    ELSE NULL
    END) AS referrer
FROM dsv1069.events
WHERE event_name = 'view_item'
ORDER BY event_id
```

## Step 2
Write a query to format the `view_item` event into a table with the appropriate columns (This replicates what we had in the slides, but it is missing a column). Cast the new column as integer for further treatment.


### Starting Point
```SQL
SELECT
  event_id
  , event_time
  , user_id
  , platform
  , (CASE WHEN parameter_name = 'item_id'
    THEN CAST(parameter_value AS INT)
    ELSE NULL
    END) AS item_id
FROM
  dsv1069.events
WHERE
  event_name = 'view_item'
ORDER BY
  event_id
```

### Solution
Do the same as previous step, but `parameter_name = 'referrer` to create _referrer_ column. Don't cast the new column since it's retrieved a string.

```SQL
SELECT
  event_id
  , event_time
  , user_id
  , platform
  , (CASE
    WHEN parameter_name = 'item_id' THEN CAST(parameter_value AS INT)
    ELSE NULL
    END) AS item_id
  , (CASE
    WHEN parameter_name = 'referrer' THEN parameter_value
    ELSE NULL
    END) AS referrer
FROM dsv1069.events
WHERE event_name = 'view_item'
ORDER BY
  event_id
```

## Step 3
Use the result from the previous exercise, but make sure...

### Starting Point
```SQL
SELECT
  event_id
  , event_time
  , user_id
  , platform
  , (CASE WHEN parameter_name = 'item_id'
    THEN CAST(parameter_value AS INT)
    ELSE NULL
    END) AS item_id
  , (CASE WHEN parameter_name = 'referrer'
    THEN paramter_value
    ELSEE NULL
    END) AS referrer
FROM
  dsv1069.events
WHERE
  event_name = 'view_item'
ORDER BY
  event_id
```

### Solution
Use MAX aggregate function on the new columns to select the NON-NULL value for the row since there are currently 2 rows: one for the `item_id` value and the other with the `referrer` value; the other column is NULL. There are an aggregate function, so use the GROUP BY clause taking the other columns to finally set the rows back onto the right format.

```SQL
SELECT
  event_id
  , event_time
  , user_id
  , platform
  , MAX(CASE
    WHEN parameter_name = 'item_id' THEN CAST(parameter_value AS INT)
    ELSE NULL
    END) AS item_id
  , MAX(CASE
    WHEN parameter_name = 'referrer' THEN parameter_value
    ELSE NULL
    END) AS referrer
FROM dsv1069.events
WHERE event_name = 'view_item'
GROUP BY
  event_id
  , event_time
  , user_id
  , platform
```



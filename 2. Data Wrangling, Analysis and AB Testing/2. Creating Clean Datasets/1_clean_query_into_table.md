# Turn a Clean Query Into a Table
Refers to the [Mode Analytics workspace](https://app.mode.com/editor/carlosmcms_personal/reports/c404655ab2b2/queries/c59b223ab110) to complete the activity.

## Exercise 1
Create the `view_item_events_1` table by using the clean query made in previous exercise.

### Solution
```SQL
CREATE TABLE
  view_item_events_1
AS
  SELECT
    event_id,
    event_time,
    user_id,
    platform,
    MAX(CASE
      WHEN parameter_name = 'item_id'
      THEN parameter_value
      ELSE NULL
      END) AS item_id,
    MAX(CASE
      WHEN parameter_name = 'referrer'
      THEN parameter_value
      ELSE NULL
      END) AS referrer
  FROM
    events
  WHERE
    event_name = 'view_item'
  GROUP BY
  event_id,
  event_time,
  user_id,
  platform
```

## Exercise 2
Check the previous table to confirm it was created successfully. Once you confirm it, delete the `view_item_events_1` table. Are the data types coming it right?

### Solution
No, the `event_id` column can be NULL, so it must be modified.

```SQL
DESCRIBE view_item_events_1;

-- Method 2
SELECT *
FROM view_item_events_1
LIMIT 10

-- Delete table
DROP TABLE view_item_events_1
```

## Exercise 3
Modify the query to make sure the data types comes it right.

### Solution
Added TIMESTAMP conversion to `event_time` to ensure the data type to this column.

```SQL
CREATE TABLE
  view_item_events_2
AS
  SELECT
    event_id,
    TIMESTAMP(event_time) AS event_time,
    user_id,
    platform,
    MAX(CASE
      WHEN parameter_name = 'item_id'
      THEN parameter_value
      ELSE NULL
      END) AS item_id,
    MAX(CASE
      WHEN parameter_name = 'referrer'
      THEN parameter_value
      ELSE NULL
      END) AS referrer
  FROM
    events
  WHERE
    event_name = 'view_item'
  GROUP BY
  event_id,
  event_time,
  user_id,
  platform
```

## Exercise 4
Create a new table to ensure the data right data type.

### Solution
Now the `event_id` will never be null.

```SQL
CREATE TABLE view_item_events (
  event_id VARCHAR(32) NOT NULL PRIMARY KEY,
  event_time VARCHAR(26),
  user_id INT(10),
  platform VARCHAR(10),
  item_id INT(10),
  referrer VARCHAR(17)
)
```

## Exercise 5
Insert into the new table the results from the previous query and create table IF NOT EXISTS.

### Solution
```SQL

CREATE TABLE IF NOT EXISTS view_item_events (
  event_id VARCHAR(32) NOT NULL PRIMARY KEY,
  event_time VARCHAR(26),
  user_id INT(10),
  platform VARCHAR(10),
  item_id INT(10),
  referrer VARCHAR(17)
)
INSERT INTO view_item_events
  SELECT
    event_id,
    TIMESTAMP(event_time) AS event_time,
    user_id,
    platform,
    MAX(CASE
      WHEN parameter_name = 'item_id'
      THEN parameter_value
      ELSE NULL
      END) AS item_id,
    MAX(CASE
      WHEN parameter_name = 'referrer'
      THEN parameter_value
      ELSE NULL
      END) AS referrer
  FROM
    events
  WHERE
    event_name = 'view_item'
  GROUP BY
  event_id,
  event_time,
  user_id,
  platform
```
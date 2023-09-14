# Counting Users

## Exercise 1
We'll be using the users table to answer the question: _How many new users are added each day?_ Start by making sure you understand the columns in the table.

### Starting Code
```SQL
SELECT *
FROM dsv1069.users
```

### Solution
It's required to verify if the user was not merged in the parent user (`merged_at` is not null), after cleaning this by "substract" a user each time a user is merged, it's possible to see how many users are added each day.

```SQL
SELECT
  id,
  parent_user_id,
  merged_at
FROM dsv1069.users
ORDER BY parent_user_id ASC
```

## Exercise 2
Without worrying about deleted user or merged users, count the number of users added each day.

### Solution

```SQL
SELECT
  DATE(created_at) AS day,
  COUNT(*) AS users
FROM dsv1069.users
GROUP BY DATE(created_at)
```

## Exercise 3
Consider the following query, is this the right way to count merged or deleted users? If all of our users were deleted tomorrow what would the result look like?

### Solution

```SQL
SELECT
  DATE(created_at) AS day,
  COUNT(*) AS users
FROM
  dsv1069.users
WHERE
  deleted_at IS NULL
  AND (id <> parent_user_id
    OR parent_user_id IS NULL)
GROUP BY
  DATE(created_at)
```

## Exercise 4
Count the number of users deleted each day. Then count the number of users removed due to merging in a similar way. Use the result from exercise 2 as a guide.

### Solution

```SQL
SELECT
  'deleted' AS user_state,
  DATE(deleted_at) AS day,
  COUNT(*) AS users
FROM dsv1069.users
WHERE deleted_at IS NOT NULL
GROUP BY DATE(deleted_at)
UNION
SELECT
  'merged' AS user_state,
  DATE(merged_at) AS day,
  COUNT(*) AS users
FROM dsv1069.users
WHERE merged_at IS NOT NULL
GROUP BY DATE(merged_at)
```

## Exercise 5
Use the pieces you've built as subtables and create a table that has a column for the date, the number of users created, the number of users deleted and the number of users merged that day.

### Solution

```SQL
WITH
created AS (
  SELECT
    DATE(created_at) AS day,
    COUNT(*) AS new_users
  FROM dsv1069.users
  GROUP BY DATE(created_at)
),
deleted AS (
  SELECT
    DATE(deleted_at) AS day,
    COUNT(*) AS deleted_users
  FROM dsv1069.users
  WHERE deleted_at IS NOT NULL
  GROUP BY DATE(deleted_at)
),
merged AS (
  SELECT
    DATE(merged_at) AS day,
    COUNT(*) AS merged_users
  FROM dsv1069.users
  WHERE merged_at IS NOT NULL
  GROUP BY DATE(merged_at)
)

SELECT
  created.day,
  created.new_users,
  deleted.deleted_users,
  merged.merged_users
FROM
  created
  LEFT JOIN deleted
    ON created.day = deleted.day
  LEFT JOIN merged
    ON deleted.day = merged.day
```

## Exercise 6
Refine your query from previous exercise to have informative column names and so that null columns return 0.

### Solution

```SQL
WITH
created AS (
  SELECT
    DATE(created_at) AS day,
    COUNT(*) AS new_users
  FROM dsv1069.users
  GROUP BY DATE(created_at)
),
deleted AS (
  SELECT
    DATE(deleted_at) AS day,
    COUNT(*) AS deleted_users
  FROM dsv1069.users
  WHERE deleted_at IS NOT NULL
  GROUP BY DATE(deleted_at)
),
merged AS (
  SELECT
    DATE(merged_at) AS day,
    COUNT(*) AS merged_users
  FROM dsv1069.users
  WHERE merged_at IS NOT NULL
  GROUP BY DATE(merged_at)
)

SELECT
  created.day,
  COALESCE(created.new_users, 0) AS new_users,
  COALESCE(deleted.deleted_users, 0) AS deleted_users,
  COALESCE(merged.merged_users, 0) AS merged_users
FROM
  created
  LEFT JOIN deleted
    ON created.day = deleted.day
  LEFT JOIN merged
    ON deleted.day = merged.day
```

## Exercise 7
What if there were days where no users were created, but some users were deleted or merged? Does the previous query still work? No, it doesn't. Use the `dates_rollup` as a backbone for this query, so that we won't miss any dates. 

### Solution
This is a way to pull up all the modifications on dates.

```SQL
WITH
generated_dates AS (
  SELECT DATE(GENERATE_SERIES(
    (SELECT created_at
      FROM dsv1069.users
      ORDER BY created_at ASC
      LIMIT 1), 
    (SELECT created_at
      FROM dsv1069.users
      ORDER BY created_at DESC
      LIMIT 1),
      '1 day'::INTERVAL)) AS day
),
created AS (
  SELECT
    DATE(created_at) AS day,
    COUNT(*) AS new_users
  FROM dsv1069.users
  GROUP BY DATE(created_at)
),
deleted AS (
  SELECT
    DATE(deleted_at) AS day,
    COUNT(*) AS deleted_users
  FROM dsv1069.users
  WHERE deleted_at IS NOT NULL
  GROUP BY DATE(deleted_at)
),
merged AS (
  SELECT
    DATE(merged_at) AS day,
    COUNT(*) AS merged_users
  FROM dsv1069.users
  WHERE merged_at IS NOT NULL
  GROUP BY DATE(merged_at)
)

SELECT
  generated_dates.day,
  COALESCE(created.new_users, 0) AS new_users,
  COALESCE(deleted.deleted_users, 0) AS deleted_users,
  COALESCE(merged.merged_users, 0) AS merged_users,
  COALESCE(created.new_users, 0)
    - COALESCE(deleted.deleted_users, 0)
    - COALESCE(merged.merged_users, 0) AS net_new_users
FROM
  generated_dates
  LEFT JOIN created
    ON generated_dates.day = created.day
  LEFT JOIN deleted
    ON created.day = deleted.day
  LEFT JOIN merged
    ON deleted.day = merged.day
ORDER BY COALESCE(created.day, deleted.day, merged.day)
```
# Promo Email

Refers to the [Mode Analytics workspace](https://app.mode.com/editor/carlosmcms_personal/reports/c404655ab2b2/queries/c59b223ab110) to complete the activity.

## Exercise 1
Create the right subtable for recently viewed events using the view_item_events table.

### Starting Point
```SQL
SELECT *
FROM dsv1069.view_item_events
```

## Solution
```SQL
SELECT
  user_id,
  item_id,
  event_time,
  ROW_NUMBER() OVER (
    PARTITION BY user_id ORDER BY event_time DESC
  ) AS view_number
FROM dsv1069.view_item_events
```

## Exercise 2
__Check your joins__. Join your tables together `recent_views`, `users`, `items` 


### Solution
```SQL
WITH recent_views AS (
  -- Code from exercise 1
)

SELECT *
FROM recent_views
JOIN dsv1069.users
  ON users.id = recent_views.user_id
JOIN dsv1069.items
  ON items.id = recent_views.item_id
```

## Exercise 3
__Clean up your columns__. The goal of all this is to return all of the information we'll need to send users an email about the item they viewed more recently. Clean up this query outline from the outline in exercise 2 and pull only the columns you need. Make sure they are named appropriately so another human can read and understand their contents.

### Solution
```SQL
WITH recent_views AS (
  -- Code from exercise 1
)

SELECT
  COALESCE(users.parent_user_id, users.id) AS user_id,
  users.email_address AS user_email,
  items.id AS item_id,
  items.name AS item_name
FROM recent_views
JOIN dsv1069.users
  ON users.id = recent_views.user_id
JOIN dsv1069.items
  ON items.id = recent_views.item_id
```

## Exercise 4
__Consider any edge cases__. If we sent an email to everyone in the results of this query, what wiuld we want to filter out. Add any extra filtering that you think would make this email better. For example, should we include deleted users? Should we sent this email to users who already ordered the item they viewed most recently?

### Solution
```SQL
WITH recent_views AS (
  SELECT
    user_id,
    item_id,
    event_time,
    ROW_NUMBER() OVER (
      PARTITION BY user_id ORDER BY event_time DESC
    ) AS view_number
  FROM dsv1069.view_item_events
  WHERE event_time >= '2017-01-01'
)

SELECT
  COALESCE(users.parent_user_id, users.id) AS user_id,
  users.email_address AS user_email,
  items.id AS item_id,
  items.name AS item_name
FROM recent_views
JOIN dsv1069.users
  ON users.id = recent_views.user_id
JOIN dsv1069.items
  ON items.id = recent_views.item_id
LEFT OUTER JOIN
  ON orders.item_id = recent_views.item_id
  AND orders.user_id = recent_views.user_id
WHERE
  view_number = 1
  AND users.deleted_at IS NOT NULL
  AND orders.item_id IS NULL
```
# Error Codes
Refers to the [Mode Analytics workspace](https://app.mode.com/editor/carlosmcms_personal/reports/c404655ab2b2/queries/c59b223ab110) to complete the activity.

## Exercise 1
Here we use _users_ table to pull a list of user email addresses. Edit the query to pull email addresses, but only for non-deleted users.

### Starting Point
```SQL
SELECT *
FROM dsv1069.users
```

### Solution
Retrieve only the required columns. Apply WHERE clause for deleted_at column if it is null.

```SQL
SELECT 
  id AS user_id
  , email_address
FROM dsv1069.users
WHERE deleted_at IS NULL;
```

## Exercise 2
Use the _items_ table to count the number of items for sale in each category.

### Starting Point
```
(none)
```

### Solution
```SQL
SELECT
  category
  , COUNT(*) AS item_count
FROM dsv1069.items
GROUP BY category
```

## Exercise 3
Select all of the columns from the result when you JOIN the _users_ table to the _orders_ table.

### Starting Point
```
(none)
```

### Solution
```SQL
SELECT *
FROM dsv1069.users u
JOIN dsv1069.orders o
ON u.id = o.user_id
```

## Exercise 4
Check out the query below. This is not the right way to count the number of `viewed_item` events. Determine what is wrong and correct the error.

### Starting Point
```SQL
SELECT COUNT(event_id) AS events
FROM dsv1069.events
WHERE event_name = 'view_item'
```

### Solution
Since `event_id` is not unique, add the DISTINCT clause.

```SQL
SELECT COUNT(DISTINCT event_id) AS events
FROM dsv1069.events
WHERE event_name = 'view_item'
```

## Exercise 5
Compute the number of items in the _items_ table which have been ordered. The query below runs, but it isn't right. Determine what is wrong and correct the error or start from scratch.

### Starting Point
```SQL
SELECT COUNT(item_id) AS item_count
FROM dsv1069.orders
INNER JOIN dsv1069.items
ON orders.item_id = items.id
```

### Solution
Since `event_id` is not unique, add the DISTINCT clause. Remove INNER JOIN clause since it is unnecesary.

```SQL
SELECT COUNT(DISTINCT item_id) AS item_count
FROM dsv1069.orders
```

## Exercise 6
For each user figure out IF a user has ordered something, and when their first purchase was. The query below doesn't return info for any of the users who haven't ordered anything.

### Starting Point
```SQL
SELECT
  users.id AS user_id
  , MIN(orders.paid_at) AS min_paid_at
FROM
  dsv1069.orders
INNER JOIN
  dsv1069.users
ON
  orders.user_id = users.id
GROUP BY
  users.id
```

### Solution
Change the INNER JOIN clause for LEFT [OUTER] JOIN and switch the tables order. Another way to fix this is to change INNER JOIN for RIGHT [OUTER] JOIN.

```SQL
SELECT
  u.id AS user_id
  , MIN(o.paid_at) AS min_paid_at
FROM dsv1069.users u
LEFT JOIN dsv1069.orders o
ON o.user_id = u.id
GROUP BY u.id
```

## Exercise 7
Figure out what percent of users have ever viewed the user profile page, but this query isn't right. Check to make sure the number of users adds up, and if not, fix the query.

### Starting Point
```SQL
SELECT
(CASE WHEN first_view IS NULL THEN false
ELSE true END) AS has_viewed_profile page,
COUNT(user_id) AS users
FROM
  (SELECT
    users.id AS user_id,
    MIN(event_time) AS first_view
  FROM
    dsv1069.users
  LEFT OUTER JOIN
    ds1069.events
  ON
    events.user_id = users.id
  WHERE
    event_name = 'view_user_profile'
  GROUP BY
    users.id
  ) first_profile_views
GROUP BY
  (CASE WHEN first_view IS NULL THEN false
    ELSE true END)
```

### Solution
Change the WHERE clause in the subquery for the AND clause to make this part of the JOIN condition. Consider the usage of alias for all the tables involved.

```SQL
SELECT
  (CASE
    WHEN first_view IS NULL THEN false
    ELSE true
    END) AS has_viewed_profile_page
  , COUNT(user_id) AS users
FROM
  (SELECT
    u.id AS user_id
    , MIN(event_time) AS first_view
  FROM dsv1069.users u
  LEFT JOIN dsv1069.events e
  ON e.user_id = u.id
--  WHERE e.event_name = 'view_user_profile'
  AND e.event_name = 'view_user_profile'
  GROUP BY u.id) first_profile_views
GROUP BY (CASE
  WHEN first_view IS NULL THEN false
  ELSE true
  END)
```











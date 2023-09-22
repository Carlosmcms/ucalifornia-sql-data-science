# Interest Information

This will contain info about the course

## Liquid Tags
It's the way to add variables onto a query.

```SQL
{% assign ds = '2018-01-01' %}

SELECT id,
'{{ds}}' AS variable_column
FROM table_name
```

## Test Queries vs Final Queries

First, simple query:

```SQL
SELECT
  COUNT(DISTINCT user_id)
FROM Orders
WHERE item_category = 'widget'
```

Final, reusable query:
```SQL
SELECT
  orders.item_category,
  COUNT(DISTINCT COALESCE(parent_user_id, user_id)) AS users_with_orders
FROM Orders
JOIN Users
  ON Users.id = orders.user_id
GROUP BY orders.item_category
```

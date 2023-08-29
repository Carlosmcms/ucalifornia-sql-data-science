
SELECT
    '2 to 3 stars' AS stars_range
    , COUNT(b.id) AS restaurant_count
    , COUNT(h.hours) AS availability_days
    , COUNT(h.hours) / COUNT(b.id) AS avg_availability_days
    , SUM(b.review_count) AS reviews
FROM (business b INNER JOIN category c ON b.id = c.business_id)
    INNER JOIN hours h ON b.id = h.business_id
WHERE
    b.city = 'Toronto'
    AND c.category = 'Restaurants'
    AND b.stars BETWEEN 2.0 AND 3.0
UNION
SELECT
    '4 to 5 stars' AS stars_range
    , COUNT(b.id) AS restaurant_count
    , COUNT(h.hours) AS availability_days
    , AVG(h.hours) AS avg_availability_days
    , SUM(b.review_count) AS reviews
FROM (business b INNER JOIN category c ON b.id = c.business_id)
    INNER JOIN hours h ON b.id = h.business_id
WHERE
    b.city = 'Toronto'
    AND c.category = 'Restaurants'
    AND b.stars BETWEEN 4.0 AND 5.0
  
-- Check restaurants in Las Vegas
SELECT
    b.city,
    b.name
--    COUNT(c.category) AS category_count
FROM business b INNER JOIN category c
ON b.id = c.business_id
WHERE b.city = 'Las Vegas' AND c.category = 'Restaurants'
--GROUP BY b.name

SELECT
    b.city,
    b.name,
    b.stars,
    COUNT(h.hours)
--    COUNT(c.category) AS category_count
FROM (business b INNER JOIN category c ON b.id = c.business_id)
INNER JOIN hours h ON b.id = h.business_id
WHERE b.city = 'Toronto' AND c.category = 'Restaurants'
GROUP BY b.name
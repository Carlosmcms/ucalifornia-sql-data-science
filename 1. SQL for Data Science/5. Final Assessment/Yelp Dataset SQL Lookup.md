# Final Assessment: Data Scientist Role Play

## Part 1: Yelp Dataset Profiling and Understanding

1. Profile the data by finding the total number of records for each of the tables below.

- Attribute table = 10000
- Business table = 10000
- Category table = 10000
- Checkin table = 10000
- elite_years table = 10000
- friend table = 10000
- hours table = 10000
- photo table = 10000
- review table = 10000
- tip table = 10000
- user table = 10000

```SQL
SELECT COUNT(*)
FROM [table]
```
<br>

2. Find the total distinct records by either the foreign key or primary key for each table. If two foreign keys are listed in the table, please specify which foreign key.

- Business = 10000
- Hours = 1562
- Category = 2643
- Attribute = 1115
- Review = 10000
- Checkin = 493
- Photo = 10000
- Tip = 3979
- User = 10000
- Friend = 11
- Elite_years = 2780

Note: Primary Keys are denoted in the ER-Diagram with a yellow key icon.

```SQL
SELECT COUNT(DISTINCT [primary_key])
FROM [Table]
```

3. Are there any columns with null values in the Users table? Indicate "yes," or "no."

	Answer: No
	SQL code used to arrive at answer:

```SQL
SELECT *
FROM user
WHERE
    id IS NULL
    OR name IS NULL
    OR review_count IS NULL
    OR yelping_since IS NULL
    OR useful IS NULL
    OR funny IS NULL
    OR cool IS NULL
    OR fans IS NULL
    OR average_stars IS NULL
    OR compliment_hot IS NULL
    OR compliment_more IS NULL
    OR compliment_profile IS NULL
    OR compliment_cute IS NULL
    OR compliment_list IS NULL
    OR compliment_note IS NULL
    OR compliment_plain IS NULL
    OR compliment_cool IS NULL
    OR compliment_funny IS NULL
    OR compliment_writer IS NULL
    OR compliment_photos IS NULL
```

	
4. For each table and column listed below, display the smallest (minimum), largest (maximum), and average (mean) value for the following fields:

	i. Table: Review, Column: Stars
	
		min: 1		max: 5		avg: 3.7082
		
	
	ii. Table: Business, Column: Stars
	
		min: 1.0	max: 5.0	avg: 3.6549
		
	
	iii. Table: Tip, Column: Likes
	
		min:0 	    max: 2  	avg: 0.0144
		
	
	iv. Table: Checkin, Column: Count
	
		min: 1		max: 53		avg: 1.9414
		
	
	v. Table: User, Column: Review_count
	
		min: 0		max: 2000	avg: 24.2995

```SQL
SELECT MIN([column_name]), MAX([column_name]), AVG([column_name])
FROM [Table]
```


5. List the cities with the most reviews in descending order:

	SQL code used to arrive at answer:
```SQL
SELECT city, review_count
FROM business
GROUP BY city
ORDER BY review_count DESCC
```

Copy and Paste the Result Below:

```
+------------------------+--------------+
| city                   | review_count |
+------------------------+--------------+
| Woodmere Village       |          242 |
| Mount Lebanon          |          138 |
| Charlotte              |          120 |
| McMurray               |          112 |
| North York             |          109 |
| Enterprise             |           89 |
| Matthews               |           77 |
| Munroe Falls           |           74 |
| Ahwatukee              |           69 |
| Pittsburgh             |           68 |
| Woodmere               |           68 |
| Tolleson               |           65 |
| Pineville              |           63 |
| Carnegie               |           61 |
| Macedonia              |           58 |
| Markham                |           54 |
| Whitchurch-Stouffville |           52 |
| Windsor                |           50 |
| Goodyear               |           49 |
| Gibsonia               |           45 |
| Summerlin              |           44 |
| Peninsula              |           42 |
| Richfield              |           42 |
| Dormont                |           40 |
| nboulder city          |           40 |
+------------------------+--------------+
(Output limit exceeded, 25 of 362 total rows shown)
```

6. Find the distribution of star ratings to the business in the following cities:

i. Avon

```
+-------+--------------+
| stars | COUNT(stars) |
+-------+--------------+
|   1.5 |            1 |
|   2.5 |            2 |
|   3.5 |            3 |
|   4.0 |            2 |
|   4.5 |            1 |
|   5.0 |            1 |
+-------+--------------+
```

SQL code used to arrive at answer:

```SQL
SELECT stars, COUNT(stars)
FROM business
WHERE city = 'Avon'
GROUP BY stars
```

Copy and Paste the Resulting Table Below (2 columns â€“ star rating and count):


ii. Beachwood

SQL code used to arrive at answer:

```SQL
SELECT stars, COUNT(stars)
FROM business
WHERE city = 'Beachwood'
GROUP BY stars
```

Copy and Paste the Resulting Table Below (2 columns â€“ star rating and count):

```
+-------+--------------+
| stars | COUNT(stars) |
+-------+--------------+
|   2.0 |            1 |
|   2.5 |            1 |
|   3.0 |            2 |
|   3.5 |            2 |
|   4.0 |            1 |
|   4.5 |            2 |
|   5.0 |            5 |
+-------+--------------+
```

7. Find the top 3 users based on their total number of reviews:
		
	SQL code used to arrive at answer:

```SQL
SELECT name, review_count
FROM user
ORDER BY review_count DESC
LIMIT 3
```

Copy and Paste the Result Below:

```
+--------+--------------+
| name   | review_count |
+--------+--------------+
| Gerald |         2000 |
| Sara   |         1629 |
| Yuri   |         1339 |
+--------+--------------+
```


8. Does posing more reviews correlate with more fans?

Please explain your findings and interpretation of the results:

No. Even if there is a downward trendd for fans field, the same does not happen with review count, so there is no correlation between fans an review count.

Results

```
+-----------+------+--------------+
| name      | fans | review_count |
+-----------+------+--------------+
| Amy       |  503 |          609 |
| Mimi      |  497 |          968 |
| Harald    |  311 |         1153 |
| Gerald    |  253 |         2000 |
| Christine |  173 |          930 |
| Lisa      |  159 |          813 |
| Cat       |  133 |          377 |
| William   |  126 |         1215 |
| Fran      |  124 |          862 |
| Lissa     |  120 |          834 |
| Mark      |  115 |          861 |
| Tiffany   |  111 |          408 |
| bernice   |  105 |          255 |
| Roanna    |  104 |         1039 |
| Angela    |  101 |          694 |
| .Hon      |  101 |         1246 |
| Ben       |   96 |          307 |
| Linda     |   89 |          584 |
| Christina |   85 |          842 |
| Jessica   |   84 |          220 |
| Greg      |   81 |          408 |
| Nieves    |   80 |          178 |
| Sui       |   78 |          754 |
| Yuri      |   76 |         1339 |
| Nicole    |   73 |          161 |
+-----------+------+--------------+
(Output limit exceeded, 25 of 10000 total rows shown)
```
	
9. Are there more reviews with the word "love" or with the word "hate" in them?

	Answer: Yes, there are 1780 reviews with the word 'love' in them versus 232 reviews with the word 'hate'. This means, there are 1548 more reviews with the word 'love' in them.
	
	SQL code used to arrive at answer:

```SQL
SELECT
    COUNT(l.text) AS love_count
    , (SELECT COUNT(h.text)
       FROM review h
       WHERE h.text LIKE '%hate%'
    ) AS hate_count
    , COUNT(l.text) - (SELECT COUNT(h.text) AS hate_count
       FROM review h
       WHERE h.text LIKE '%hate%'
    ) AS difference
FROM review l
WHERE l.text LIKE '%love%'
```
	
10. Find the top 10 users with the most fans:

	SQL code used to arrive at answer:

```SQL
SELECT name, fans
FROM user
ORDER BY fans DESC
LIMIT 3
```
	
	Copy and Paste the Result Below:

```
+--------+------+
| name   | fans |
+--------+------+
| Amy    |  503 |
| Mimi   |  497 |
| Harald |  311 |
+--------+------+
```


## Part 2: Inferences and Analysis

1. Pick one city and category of your choice and group the businesses in that city or category by their overall star rating. Compare the businesses with 2-3 stars to the businesses with 4-5 stars and answer the following questions. Include your code.

To select the city with more than 2 businesses:
```SQL
SELECT
    b.city
    ,COUNT(DISTINCT b.id) AS business_count
    ,COUNT(c.category) AS business_category
FROM business b INNER JOIN category c
ON b.id = c.business_id
GROUP BY b.city
HAVING business_category >= 2
ORDER BY business_count DESC
```

With this, the chosen city is Toronto and the category is Restaurants.

i. _Do the two groups you chose to analyze have a different distribution of hours?_

Yes, business in range of 2.0 to 3.0 stars are open one more day than the other group.

ii. _Do the two groups you chose to analyze have a different number of reviews?_

Yes, more reviews are posted for 4.0 to 5.0 stars restaurants.

iii. Are you able to infer anything from the location data provided between these two groups? Explain.

There is no correlation between average opening days and number of reviews.

SQL code used for analysis:

```SQL
SELECT
    '2 to 3' AS stars_range
    , COUNT(DISTINCT b.name) AS business_count
    , COUNT(h.hours) AS opening_days
    , COUNT(h.hours) / COUNT(DISTINCT b.name) AS avg_opening_days
    , SUM(b.review_count) AS range_reviews
FROM (business b INNER JOIN category c ON b.id = c.business_id)
INNER JOIN hours h ON b.id = h.business_id
WHERE b.city = 'Toronto'
    AND c.category = 'Restaurants'
    AND b.stars BETWEEN 2.0 AND 3.0
GROUP BY b.city
UNION
SELECT
    '4 to 5' AS stars_range
    , COUNT(DISTINCT b.name) AS business_count
    , COUNT(h.hours) AS opening_days
    , COUNT(h.hours) / COUNT(DISTINCT b.name) AS avg_opening_days
    , SUM(b.review_count) AS range_reviews
FROM (business b INNER JOIN category c ON b.id = c.business_id)
INNER JOIN hours h ON b.id = h.business_id
WHERE b.city = 'Toronto'
    AND c.category = 'Restaurants'
    AND b.stars BETWEEN 4.0 AND 5.0
GROUP BY b.city
```
```
+-------------+----------------+--------------+------------------+---------------+
| stars_range | business_count | opening_days | avg_opening_days | range_reviews |
+-------------+----------------+--------------+------------------+---------------+
| 2 to 3      |              3 |           21 |                7 |           602 |
| 4 to 5      |              3 |           19 |                6 |           683 |
+-------------+----------------+--------------+------------------+---------------+
```
		
2. Group business based on the ones that are open and the ones that are closed. What differences can you find between the ones that are still open and the ones that are closed? List at least two differences and the SQL code you used to arrive at your answer.
		
i. Difference 1:

There are more open business than closed ones.

ii. Difference 2:

Businesses have more reviews if they are open.

SQL code used for analysis:

```SQL
SELECT
    is_open
    , COUNT(DISTINCT id) AS business_count
    , AVG(stars) AS average_stars
    , SUM(review_count) AS reviews
FROM business
GROUP BY is_open
```
	
3. For this last part of your analysis, you are going to choose the type of analysis you want to conduct on the Yelp dataset and are going to prepare the data for analysis.

Ideas for analysis include: Parsing out keywords and business attributes for sentiment analysis, clustering businesses to find commonalities or anomalies between them, predicting the overall star rating for a business, predicting the number of fans a user will have, and so on. These are just a few examples to get you started, so feel free to be creative and come up with your own problem you want to solve. Provide answers, in-line, to all of the following:
	
i. _Indicate the type of analysis you chose to do:_

How crowded are the state businesses based on reviews. 

ii. _Write 1-2 brief paragraphs on the type of data you will need for your analysis and why you chose that data:_

The analysis calculates how many reviews are posted for the businesses, the number of businesses in that state and the average number of reviews considering these two variables, grouping it by state.

According to the results, there is a decreasing correlation between the number of reviews and the number of businesses in a state, considering NV as an exception since its average number of reviews per business is higher than the state with the highest numbers of reviews and business, which is AZ.

iii. Output of your finished dataset:

```
+-------+-------------------+----------------+--------------------------+
| state | reviews_per_state | business_count | avg_reviews_per_business |
+-------+-------------------+----------------+--------------------------+
| AZ    |            100548 |           3042 |                       33 |
| NV    |             96494 |           1921 |                       50 |
| ON    |             36373 |           1664 |                       21 |
| NC    |             17140 |            722 |                       23 |
| OH    |             14814 |            747 |                       19 |
| PA    |             13211 |            553 |                       23 |
| QC    |             10738 |            465 |                       23 |
| WI    |              6410 |            253 |                       25 |
| EDH   |              2742 |            237 |                       11 |
| IL    |              2571 |            108 |                       23 |
| BW    |              2412 |            202 |                       11 |
| SC    |               764 |             39 |                       19 |
| HLD   |               130 |             12 |                       10 |
| MLN   |                81 |              8 |                       10 |
| ELN   |                28 |              6 |                        4 |
| NY    |                23 |              3 |                        7 |
| FIF   |                21 |              5 |                        4 |
| C     |                15 |              3 |                        5 |
| NYK   |                14 |              3 |                        4 |
| WLN   |                11 |              2 |                        5 |
| ST    |                 9 |              2 |                        4 |
| ESX   |                 6 |              1 |                        6 |
| NI    |                 6 |              2 |                        3 |
+-------+-------------------+----------------+--------------------------+
```

iv. Provide the SQL code you used to create your final dataset:

```SQL
SELECT
    state
    , SUM(review_count) AS reviews_per_state
    , COUNT(DISTINCT id) AS business_count
    , SUM(review_count) / COUNT(DISTINCT id) AS avg_reviews_per_business
FROM business
GROUP BY state
ORDER BY reviews_per_state DESC
```
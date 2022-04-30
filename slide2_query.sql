/* Query for the second slide */

/*
  Find the rental duration percentiles for all the movies in each family
  category. Percentiles here are created from shortest to longest duration.
  This means, 1 for shortest 25 percentile, 2 for shortest 25 - 50 percentile...
*/
WITH t AS
(SELECT c.name AS category_name,
	NTILE(4) OVER (ORDER BY rental_duration) AS rental_length_category
   FROM category c
	JOIN film_category fc --- Include the family categories in join condition.
	  ON c.category_id = fc.category_id AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
	JOIN film f
	  ON f.film_id = fc.film_id)
/*
  Find the number of movies in each family category and rental duration
  percentile, i.e. rental length category.
*/
SELECT category_name, rental_length_category, COUNT(*) event_count
  FROM t
 GROUP BY 1, 2
 ORDER BY 1, 2;

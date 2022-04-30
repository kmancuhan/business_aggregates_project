/* Query for the first slide */
/*
  Family categories include Animation, Children, Classics, Comedy,
  Family and Music
*/

/*
  Find the rental count, number of times each movie is rented out, for each
  movie in family category
*/
WITH t1 AS
(SELECT f.title AS film_title,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
   FROM category c
        JOIN film_category fc
          ON c.category_id = fc.category_id --- Include the family categories in the join condition
             AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')
        JOIN film f
          ON f.film_id = fc.film_id
        JOIN inventory i
          ON f.film_id = i.film_id
        JOIN rental r
          ON i.inventory_id = r.inventory_id
  GROUP BY 1, 2),
t2 AS --- Find the maximum rental count in each family category
(SELECT category_name, MAX(rental_count) AS max_rental_count
   FROM t1
  GROUP BY 1)
/*
  Join the CTEs to find the movie in each family category which has
  the highest rental count.
*/
SELECT CONCAT(t1.category_name,
              '_',
              t1.film_title) AS category_filmtitle,
       t2.max_rental_count AS highest_rental_count_in_category
  FROM t1
       JOIN t2
         ON t1.category_name = t2.category_name
            AND t1.rental_count = t2.max_rental_count;

/* Query for the third slide */

/*
  Find the top 10 paying customers
*/
 WITH t AS
 (SELECT customer_id, SUM(amount) AS total_payment
    FROM payment
   GROUP BY 1
   ORDER BY 2 DESC
   LIMIT 10)
/*
  For each month, year; compute the number of payments made and the total
  amount paid for every customer. Include in the report the full name for
  every top 10 paying customer.
*/
 SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name,
        DATE_TRUNC('month', p.payment_date) AS payment_year_month,
        COUNT(p.payment_id) AS payment_count,
        SUM(p.amount) AS total_payment
 	FROM payment p
	JOIN customer c --- Join condition limits customer_id field w.r.t top 10 paying and the year 2007
	  ON c.customer_id = p.customer_id AND c.customer_id IN (SELECT customer_id FROM t) AND DATE_PART('year', p.payment_date) = 2007
  GROUP BY 1, 2
  ORDER BY 1, 2;

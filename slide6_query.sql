/* Query for the fourth slide */

/*
  Find the top 10 paying customers
*/
WITH t1 AS
(SELECT customer_id, SUM(amount) AS total_payment
   FROM payment
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 10),
/*
  For each month, year; compute the number of payments made and the total
  amount paid for every customer. Include in the report the full name for
  every top 10 paying customer.
*/
t2 AS
(SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name,
       DATE_TRUNC('month', p.payment_date) AS payment_year_month,
       SUM(p.amount) AS total_payment
  FROM payment p
  JOIN customer c --- Join condition constrains the customer_id to be in the top 10 paying customer.
    ON c.customer_id = p.customer_id AND c.customer_id IN (SELECT customer_id FROM t1) AND DATE_PART('year', p.payment_date) = 2007
 GROUP BY 1, 2)
/*
  Find the top 5 customer with highest monthly payment difference during
  2007, where each customer is among the top 10 paying customers.
*/
SELECT full_name, payment_year_month, previous_payment_year_month,
       total_payment - previous_total_payment AS monthly_difference, total_payment, previous_total_payment
  FROM (SELECT full_name,
      	       payment_year_month,
               /*
                Use window to match the current month date with the prior month date
               */
      	       LAG(payment_year_month) OVER w AS previous_payment_year_month,
      	       total_payment,
               /*
                Use window to match the current month payment with the prior month
                payment.
               */
      	       LAG(total_payment) OVER w AS previous_total_payment
      	  FROM t2
       	WINDOW w AS (PARTITION BY full_name ORDER BY payment_year_month)) t3
/*
  Eliminate the first row from each window that doesn't have a previous month
  value
*/
 WHERE previous_total_payment IS NOT NULL
 ORDER BY monthly_difference DESC
 LIMIT 5;

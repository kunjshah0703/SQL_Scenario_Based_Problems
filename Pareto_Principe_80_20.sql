/*
The Pareto principle states that for many outcomes, roughly 80 % of consequences come from 20 % of
causes. Eg : 
1 - 80 % of the productivity come from 20 % of the employees.
2- 80 % of your sales come from 20 % of your clients.
3- 80 % of decisions in a meeting are made in20 % of the time.
4 - 80 % of your sales comes from 20 % of your products or services.
*/

-- Q. Find 20 % of products which are giving 80 % sales revenue.
SELECT SUM(Sales) * 0.8 FROM cust_orders
-- 1837760

WITH product_wise_sales AS
(SELECT Product_ID, SUM(Sales) AS product_sales
FROM cust_orders
GROUP BY Product_ID)
, calc_sales AS(
SELECT product_id, product_sales
,SUM(product_sales) OVER(ORDER BY product_sales DESC ROWS BETWEEN UNBOUNDED PRECEDING AND 0 PRECEDING)
AS running_Sales
,0.8*SUM(product_sales) OVER() AS total_sales
FROM product_wise_sales)
SELECT * FROM calc_sales WHERE running_sales <= total_sales


-- Q.
--CREATE TABLE entries
--( name varchar(20),
--address varchar(20),
--email varchar(20),
--floor int,
--resources varchar(10)
--);

--INSERT INTO entries VALUES
--( 'A', 'Bangalore', 'A@gmail.com', 1, 'CPU'),
--('A', 'Bangalore', 'A1@gmail.com', 1, 'CPU'),
--('A', 'Bangalore', 'A2@gmail.com', 2, 'DESKTOP'),
--('B', 'Bangalore', 'B@gmail.com', 2, 'DESKTOP'),
--('B', 'Bangalore', 'B1@gmail.com', 2, 'DESKTOP'),
--('B', 'Bangalore', 'B2@gmail.com', 1, 'MONITOR');

-- SELECT * FROM entries;

-- Find the number of visits by each person and also find the floor which is frequently visited and 
-- resources used by that person ?


WITH 
distinct_resources AS -- CTE 3
(SELECT DISTINCT name, resources FROM entries),
aggregated_resources AS -- CTE 4
(SELECT name, string_agg(resources, ',') AS resources_used FROM distinct_resources GROUP BY name),
total_visits AS -- CTE 2
(SELECT name, COUNT(1) AS total_visits, string_agg(resources, ',') AS resources_used
FROM entries
GROUP BY name),
floor_visit AS -- CTE 1
(SELECT name, floor, COUNT(1) AS no_of_floor_visit,
RANK() OVER(PARTITION BY name ORDER BY COUNT(1) DESC) AS rn
FROM entries
GROUP BY name, floor)
SELECT fv.name, fv.floor AS most_visited_floor, tv.total_visits, ar.resources_used
FROM floor_visit AS fv 
INNER JOIN total_visits AS tv
ON fv.name = tv.name
INNER JOIN aggregated_resources AS ar
ON fv.name = ar.name
WHERE rn = 1


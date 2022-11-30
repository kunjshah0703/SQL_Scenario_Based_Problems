/* Write a query to find personID, Name, number of friends, sum of marks
of person who have friends with total score greater than 100.*/

CREATE TABLE person
(PersonID int,
Name varchar(50),
Email varchar(50),
Score int
);

CREATE TABLE friend
(PersonID int,
FriendID int
);

INSERT INTO person VALUES
(1, 'Alice', 'alice2018@hotmail.com', 88),
(2, 'Bob', 'bob2018@hotmail.com', 11),
(3, 'Davis', 'davis2018@hotmail.com', 27),
(4, 'Tara', 'tara2018@hotmail.com', 45),
(5, 'John', 'john2018@hotmail.com', 63);

INSERT INTO friend VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 3),
(3, 5),
(4, 2),
(4, 3),
(4, 5);

SELECT * FROM person;
SELECT * FROM friend;

WITH score_details AS(
SELECT f.PersonID, SUM(p.Score) AS total_friend_Score, COUNT(1) AS no_of_friends
FROM friend AS f
INNER JOIN person AS p
ON f.FriendID = p.PersonID
-- WHERE total_friend_score > 100
GROUP BY f.PersonID
HAVING SUM(p.Score) > 100
-- WHERE total_friend_score > 100
)
SELECT s.*, p.Name as person_name
FROM person AS p
INNER JOIN score_details AS s
ON p.PersonID = s.PersonID
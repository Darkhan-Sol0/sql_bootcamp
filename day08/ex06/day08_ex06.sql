-- Session #1
-- STEP #1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- STEP #3
SELECT SUM(rating)
FROM pizzeria;
-- STEP #6
SELECT SUM(rating)
FROM pizzeria;
-- STEP #7
COMMIT;
-- STEP #8
SELECT SUM(rating)
FROM pizzeria;
-- Session #2
-- STEP #2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- STEP #4
INSERT INTO pizzeria
VALUES (11, 'Kazan Pizza 2', 4);
-- STEP #5
COMMIT;
-- STEP #9
SELECT *
FROM pizzeria
WHERE name = 'Pizza Hut';
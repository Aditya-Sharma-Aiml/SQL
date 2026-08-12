-- 1. Find all the movies that have a rating higher than the average rating of movies in the same genre.[Animation]
SELECT * 
FROM person.movie m1
WHERE score > (SELECT AVG(score) 
				FROM person.movie m2  
                WHERE m1.genre = m2.genre);

-- 2. Find the favorite food of each customer
WITH FAV_FOOD AS(
			SELECT t2.user_id, t1.name, t4.f_name, COUNT(*) AS frequency
			FROM Zomato.users t1
			JOIN zomato.orders t2
				ON t1.user_id = t2.user_id
			JOIN zomato.order_details t3
				ON t2.order_id=t3.order_id
			JOIN zomato.food t4
				ON t3.f_id=t4.f_id
			GROUP BY t1.name, t4.f_name, t2.user_id, t3.f_id
            )
SELECT * 
FROM FAV_FOOD F1 
WHERE frequency = (
					SELECT MAX(frequency) 
                    FROM FAV_FOOD F2 
                    WHERE F1.user_id  = F2.user_id);




/*
==========================================================
           CORRELATED SUBQUERY ALGORITHM
==========================================================

Definition:
A Correlated Subquery executes ONCE for EVERY ROW
processed by the OUTER query.

==========================================================
Algorithm
==========================================================

START

    FOR each row in the OUTER query table

        1. Pick the current row from the OUTER query.

        2. Substitute the current OUTER row value
           into the INNER query.

        3. Execute the INNER query independently.

        4. Calculate the required value
           (AVG(), MAX(), MIN(), COUNT(), etc.).

        5. Replace the INNER query
           with the calculated value.

        6. Evaluate the WHERE clause condition.

            IF condition is TRUE

                Add current row to the RESULT.

            ELSE

                Ignore the current row.

        7. Move to the NEXT OUTER row.

    Repeat until all OUTER rows are processed.

STOP

==========================================================
FLOW
==========================================================

START
   │
   ▼
FOR each OUTER row
   │
   ▼
Substitute OUTER value
into INNER query
   │
   ▼
Execute INNER query
   │
   ▼
Calculate Result
   │
   ▼
Replace Subquery
with Calculated Value
   │
   ▼
Evaluate WHERE Condition
   │
   ▼
+-----------------------+
|  Condition TRUE ?     |
+-----------------------+
      │          │
    YES          NO
      │          │
      ▼          ▼
 Add Row      Ignore Row
      │
      ▼
Next OUTER Row
      │
      ▼
Repeat
      │
      ▼
STOP

==========================================================
IMPORTANT POINTS
==========================================================

✔ The INNER query depends on the current row
  of the OUTER query.

✔ The INNER query executes once for EVERY
  OUTER row.

✔ The OUTER query waits for the INNER query
  to return a value.

✔ Correlated Subqueries are generally slower
  than normal subqueries because the INNER
  query executes repeatedly.

==========================================================
MEMORY TRICK
==========================================================

Outer Row
    ↓
Substitute Value
    ↓
Execute Inner Query
    ↓
Calculate Value
    ↓
Replace Subquery
    ↓
Check WHERE
    ↓
TRUE ? Add : Ignore
    ↓
Next Row
    ↓
Repeat

==========================================================
*/

-- ***************************************************
-- EXPLAIN PLAN OF CORRELATED SUBQUERY WITH EXAMPLE
-- ***************************************************

/*
==========================================================
CORRELATED SUBQUERY ALGORITHM
==========================================================

Query:

SELECT EName, Dept, Salary
FROM Employee E1
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employee E2
    WHERE E2.Dept = E1.Dept
);

==========================================================
Illustrative Algorithm
==========================================================

Step 1
----------------------------------------------------------
For EACH row in the OUTER query table.

Current Row:

James Potter
Dept = ICP
Salary = 75000


Step 2
----------------------------------------------------------
Substitute the OUTER value into the INNER query.

Replace

E1.Dept

↓

ICP

Inner Query becomes

SELECT AVG(Salary)
FROM Employee E2
WHERE Dept = 'ICP';


Step 3
----------------------------------------------------------
Execute the INNER query independently.

ICP Employees

James Potter      75000
Ayaz Mohammad     40000

Average Salary

(75000 + 40000)/2

=

57500


Step 4
----------------------------------------------------------
Substitute the INNER query with the calculated value.

Outer Query becomes

WHERE Salary > 57500


Step 5
----------------------------------------------------------
If WHERE clause condition is TRUE

75000 > 57500

↓

TRUE

Add current row to RESULT.

Result

James Potter


==========================================================

Move to NEXT OUTER ROW

==========================================================

Current Row

Ethan McCarty

Dept = ETA

Salary = 90000


Step 2
----------------------------------------------------------
Substitute value into INNER query.

Dept

↓

ETA


Step 3
----------------------------------------------------------
Execute INNER query.

ETA Employees

90000
30000

Average

60000


Step 4
----------------------------------------------------------
Replace INNER query

↓

60000


Step 5
----------------------------------------------------------
WHERE

90000 > 60000

↓

TRUE

Add Ethan McCarty


==========================================================

Next Row

Jack Abraham

Salary = 30000

Dept = ETA

----------------------------------------------------------

Substitute

↓

ETA

↓

Average = 60000

↓

30000 > 60000

↓

FALSE

Do NOT add.


==========================================================

Next Row

Ayaz Mohammad

Salary = 40000

Dept = ICP

----------------------------------------------------------

Substitute

↓

ICP

↓

Average = 57500

↓

40000 > 57500

↓

FALSE

Do NOT add.


==========================================================
FINAL RESULT
==========================================================

James Potter

Ethan McCarty


==========================================================
VISUALIZATION
==========================================================

for each row in outer query table
            │
            ▼
substitute value in inner query
            │
            ▼
execute inner query independently
            │
            ▼
substitute inner query by calculated value
            │
            ▼
if where clause condition is met
      │
 ┌────┴────┐
 │         │
TRUE     FALSE
 │         │
 ▼         ▼
add row   ignore row
to result


==========================================================
MEMORY TRICK
==========================================================

Outer Row
     ↓
Substitute Value
     ↓
Execute Inner Query
     ↓
Calculate Value
     ↓
Replace Subquery
     ↓
Check WHERE
     ↓
TRUE ? Add : Ignore
     ↓
Move to Next Row

==========================================================

Golden Rule:

A correlated subquery executes once for
EVERY row of the outer query.
*/
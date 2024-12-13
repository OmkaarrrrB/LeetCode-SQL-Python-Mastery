-- SELECT --
/*
QUESTION LINK
https://leetcode.com/problems/recyclable-and-low-fat-products/?envType=study-plan-v2&envId=top-sql-50

Question 1757
Write a solution to find the ids of products that are both low fat and recyclable.Return the result table in any order
*/
SELECT 
    product_id
FROM
    Products
WHERE
    low_fats = 'Y' AND recyclable = 'Y';

/*
QUESTION LINK
https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50

Question no:584
Find the names of the customer that are not referred by the customer with id = 2.
Return the result table in any order.
*/

SELECT 
    name
FROM
    Customer
WHERE
    id NOT IN (SELECT 
            id
        FROM
            Customer
        WHERE
            referee_id = 2);

/*
Question Link
https://leetcode.com/problems/big-countries/description/?envType=study-plan-v2&envId=top-sql-50

Question no:595
A country is big if:
it has an area of at least three million (i.e., 3000000 km2), or
it has a population of at least twenty-five million (i.e., 25000000).
Write a solution to find the name, population, and area of the big countries.
*/
SELECT 
    name, population, area
FROM
    World
WHERE
    area >= 3000000
        OR population >= 25000000;


/*
Question Link
https://leetcode.com/problems/article-views-i/description/?envType=study-plan-v2&envId=top-sql-50

Question No:1148
Write a solution to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.
*/
select distinct(author_id) as id from Views where author_id=viewer_id order by author_id ;



/*
Question Link
https://leetcode.com/problems/invalid-tweets/description/?envType=study-plan-v2&envId=top-sql-50

Question No:1683
Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.
Return the result table in any order.
*/
SELECT 
    tweet_id
FROM
    Tweets
WHERE
    LENGTH(content) > 15;


-- JOINS --

/*
Question Link
https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/?envType=study-plan-v2&envId=top-sql-50

Question No:1378
Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.
Return the result table in any order.
*/
SELECT 
    u.unique_id, e.name
FROM
    EmployeeUNI u
        RIGHT JOIN
    Employees e ON u.id = e.id; 


/*
Question Link
https://leetcode.com/problems/product-sales-analysis-i/description/?envType=study-plan-v2&envId=top-sql-50

Question No 1068
Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
*/
SELECT 
    p.product_name, s.year, s.price
FROM
    Sales s
        JOIN
    Product p ON s.product_id = p.product_id;


/*
Question Link
https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/?envType=study-plan-v2&envId=top-sql-50

Question No 1581
Write a solution to find the IDs of the users who visited without making any transactions 
and the number of times they made these types of visits.
*/
SELECT 
    customer_id, COUNT(customer_id) AS count_no_trans
FROM
    Visits v
        LEFT JOIN
    Transactions t ON v.visit_id = t.visit_id
WHERE
    t.transaction_id IS NULL
GROUP BY customer_id;


/*
Question Link
https://leetcode.com/problems/rising-temperature/description/?envType=study-plan-v2&envId=top-sql-50

Question No:197
Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).
*/

-- using self-join
SELECT 
    t1.id
FROM
    Weather t1
        JOIN
    Weather t2 ON DATE_ADD(t1.recordDate,
        INTERVAL -1 DAY) = t2.recordDate
WHERE
    t1.temperature > t2.temperature;

-- using Lag()
select id from (select id,temperature,lag(temperature,1)over (order by recordDate) as prev_temp from Weather)
as id where temperature>prev_temp;


/*
Question Link
https://leetcode.com/problems/average-time-of-process-per-machine/description/?envType=study-plan-v2&envId=top-sql-50

Question no:1661
There is a factory website that has several machines each running the same number of processes. Write a solution to find the average 
time each machine takes to complete a process.The time to complete a process is the 'end' timestamp minus the 'start' timestamp. 
The average time is calculated by the total time to complete every process on the machine divided by the number of processes that 
were run.The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 
3 decimal places.Return the result table in any order.
*/
# Write your MySQL query statement below
SELECT 
    a.machine_id,
    ROUND(AVG(b.timestamp - a.timestamp), 3) AS processing_time
FROM
    Activity a
        JOIN
    Activity b ON a.machine_id = b.machine_id
        AND a.process_id = b.process_id
        AND a.activity_type = 'start'
        AND b.activity_type = 'end'
GROUP BY 1;

/*
Question Link
https://leetcode.com/problems/employee-bonus/description/?envType=study-plan-v2&envId=top-sql-50

Question no:577
Write a solution to report the name and bonus amount of each employee with a bonus less than 1000.
*/
select e.name,b.bonus from Employee e left join Bonus b on e.empId=b.empId where bonus<1000 or bonus is null;


/*
Question Link
https://leetcode.com/problems/students-and-examinations/description/?envType=study-plan-v2&envId=top-sql-50

Question No:1280
Write a solution to find the number of times each student attended each exam.
Return the result table ordered by student_id and subject_name.
*/
SELECT 
    s.student_id,
    s.student_name,
    su.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM
    Students s
        CROSS JOIN
    Subjects su
        LEFT JOIN
    Examinations e ON s.student_id = e.student_id
        AND su.subject_name = e.subject_name
GROUP BY s.student_id , su.subject_name
ORDER BY s.student_id , su.subject_name;


/*
Question Link
https://leetcode.com/problems/managers-with-at-least-5-direct-reports/submissions/1477875963/?envType=study-plan-v2&envId=top-sql-50

Question No:570
Write a solution to find managers with at least five direct reports.
*/
SELECT 
    e1.name
FROM
    Employee e1
        JOIN
    Employee e2 ON e1.id = e2.managerId
GROUP BY e2.managerId
HAVING COUNT(e2.managerId) >= 5;


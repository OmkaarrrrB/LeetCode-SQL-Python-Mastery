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


-- Basic Aggregate Functions

/*
Question Link
https://leetcode.com/problems/not-boring-movies/description/?envType=study-plan-v2&envId=top-sql-50

Question NO:620
Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
Return the result table ordered by rating in descending order.
*/
SELECT 
    *
FROM
    Cinema
WHERE
    id % 2 != 0 AND description != 'boring'
ORDER BY rating DESC;



/*
Question Link
https://leetcode.com/problems/average-selling-price/?envType=study-plan-v2&envId=top-sql-50

Question No:1251
Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places. If a product does not have any sold units, its average selling price is assumed to be 0.
Return the result table in any order.
*/
SELECT 
    p.product_id AS product_id,
    IFNULL(ROUND(SUM(p.price * u.units) / NULLIF(SUM(u.units), 0),
                    2),
            0) AS average_price
FROM
    Prices p
        LEFT JOIN
    UnitsSold u ON u.product_id = p.product_id
        AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id ;


/*
Question Link:
https://leetcode.com/problems/project-employees-i/?envType=study-plan-v2&envId=top-sql-50

Question No:1075
Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
Return the result table in any order.
*/
SELECT 
    project_id, ROUND(AVG(experience_years), 2) AS average_years
FROM
    Project p
        JOIN
    Employee e ON p.employee_id = e.employee_id
GROUP BY p.project_id;


/*
Question Link:
https://leetcode.com/problems/percentage-of-users-attended-a-contest/submissions/1484729890/?envType=study-plan-v2&envId=top-sql-50

Question no :1633
Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.
*/
SELECT DISTINCT
    (contest_id),
    ROUND(COUNT(r.user_id) / (SELECT 
                    COUNT(DISTINCT (user_id))
                FROM
                    Users) * 100,
            2) AS percentage
FROM
    Users u
        JOIN
    Register r ON u.user_id = r.user_id
GROUP BY contest_id
ORDER BY percentage DESC , contest_id ASC;

/*
Question Link:
https://leetcode.com/problems/queries-quality-and-percentage/description/?envType=study-plan-v2&envId=top-sql-50

Question No:1211
We define query quality as:
The average of the ratio between query rating and its position.
We also define poor query percentage as:
The percentage of all queries with rating less than 3.
Write a solution to find each query_name, the quality and poor_query_percentage.
Both quality and poor_query_percentage should be rounded to 2 decimal places.
Return the result table in any order.
*/
SELECT 
    query_name,
    ROUND(AVG(rating / position), 2) AS quality,
    ROUND(SUM(rating < 3) / COUNT(rating) * 100, 2) AS poor_query_percentage
FROM
    Queries
GROUP BY query_name;


/*
Question Link:
https://leetcode.com/problems/monthly-transactions-i/description/?envType=study-plan-v2&envId=top-sql-50

Question No:1193
Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.
Return the result table in any order.
*/
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(id) AS trans_count,
    SUM(IF(state = 'approved', 1, 0)) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
FROM
    Transactions
GROUP BY month , country;


-- Sorting and Grouping

/*
Question Link:
https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/?envType=study-plan-v2&envId=top-sql-50

Question No:2356
Write a solution to calculate the number of unique subjects each teacher teaches in the university.
*/
SELECT DISTINCT
    teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM
    Teacher
GROUP BY teacher_id;


/*
Question Link:
https://leetcode.com/problems/product-sales-analysis-iii/description/?envType=study-plan-v2&envId=top-sql-50

Question No:1070
Write a solution to select the product id, year, quantity, and price for the first year of every product sold.
Return the resulting table in any order.
*/
SELECT 
    product_id, year AS first_year, quantity, price
FROM
    Sales
WHERE
    (product_id , year) IN (SELECT 
            product_id, MIN(year)
        FROM
            Sales
        GROUP BY product_id);
        

/*
Question Link:
https://leetcode.com/problems/classes-more-than-5-students/submissions/1485605347/?envType=study-plan-v2&envId=top-sql-50

Question No:596
Write a solution to find all the classes that have at least five students.
Return the result table in any order.
*/        
SELECT 
    class
FROM
    Courses
GROUP BY class
HAVING COUNT(student) >= 5;

/*
Question Link:
https://leetcode.com/problems/find-followers-count/submissions/1485607984/?envType=study-plan-v2&envId=top-sql-50*

Question No:729
Write a solution that will, for each user, return the number of followers.
Return the result table ordered by user_id in ascending order.
*/

SELECT 
    user_id, COUNT(follower_id) AS followers_count
FROM
    Followers
GROUP BY user_id
ORDER BY user_id;
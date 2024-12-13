/*
QUESTION LINK
https://leetcode.com/problems/recyclable-and-low-fat-products/?envType=study-plan-v2&envId=top-sql-50

Question 1757
Write a solution to find the ids of products that are both low fat and recyclable.Return the result table in any order
*/
select product_id from Products where low_fats = "Y" and recyclable ="Y";

/*
QUESTION LINK
https://leetcode.com/problems/find-customer-referee/description/?envType=study-plan-v2&envId=top-sql-50

Question no:584
Find the names of the customer that are not referred by the customer with id = 2.
Return the result table in any order.
*/

select name from Customer where id not in(select id from Customer where referee_id=2);

/*
Question Link
https://leetcode.com/problems/big-countries/description/?envType=study-plan-v2&envId=top-sql-50

Question no:595
A country is big if:
it has an area of at least three million (i.e., 3000000 km2), or
it has a population of at least twenty-five million (i.e., 25000000).
Write a solution to find the name, population, and area of the big countries.
*/
select name ,population, area from World where area >=3000000 or population >=25000000;


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
select tweet_id from Tweets where length(content)>15;
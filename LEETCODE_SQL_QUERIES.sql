/*
QUESTION LINK
https://leetcode.com/problems/recyclable-and-low-fat-products/?envType=study-plan-v2&envId=top-sql-50

Question 1757
Write a solution to find the ids of products that are both low fat and recyclable.Return the result table in any 
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


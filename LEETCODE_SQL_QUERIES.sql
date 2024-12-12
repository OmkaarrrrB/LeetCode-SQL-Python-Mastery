/*QUESTION LINK
https://leetcode.com/problems/recyclable-and-low-fat-products/?envType=study-plan-v2&envId=top-sql-50

Question:Write a solution to find the ids of products that are both low fat and recyclable.Return the result table in any order.*/

select product_id from Products where low_fats = "Y" and recyclable ="Y";






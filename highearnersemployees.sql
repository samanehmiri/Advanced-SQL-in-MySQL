/*
Write a solution to find the employees who are high earners in each of the departments.
Return the result table in any order.

A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Tables:

Employee
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.

Department
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.

*/

select d.name as Department, T.name as Employee, salary from 
(
    select e.*, 
    DENSE_RANK() OVER(PARTITION BY departmentId order by salary desc) as rnk
    from Employee e
) T
JOIN Department d 
ON T.departmentId = d.id
where rnk <= 3

/*
The DENSE_RANK() function is a window function in SQL that assigns a unique rank to 
each distinct row within a result set based on the values in one or more specified columns. 
This function is often used to calculate rankings while allowing for duplicate rankings in cases of ties. Here's how it works:

Syntax:
The basic syntax of the DENSE_RANK() function is:

DENSE_RANK() OVER (PARTITION BY partition_expression ORDER BY sort_expression [ASC|DESC])

*/


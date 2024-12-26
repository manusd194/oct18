create database interview_prep;

use interview_prep;

CREATE TABLE employees (emp_id INT PRIMARY KEY,name VARCHAR(50),department_id INT);
INSERT INTO employees VALUES(1, 'Karthik', 101),(2, 'Veena', 102),(3, 'Meena', NULL),(4, 'Veer', 103),
(5, 'Ajay', 104),(6, 'Vijay', NULL),(7, 'Keerthi', 105);

CREATE TABLE departments (department_id INT PRIMARY KEY,department_name VARCHAR(50));
INSERT INTO departments VALUES(101, 'HR'),(102, 'Finance'),(103, 'IT'),(104, 'Marketing'),(106, 'Operations');

-- 1. Find employees who are assigned to a department.
select e.name , d.department_name from employees e inner join departments d on e.department_id = d.department_id;

-- 2. List all employees, including those not assigned to any department, and their department details (if available)
select e.name , d.department_name from employees e left join departments d on e.department_id = d.department_id;

-- 3. List all departments, including those with no employees assigned, along with the employee details (if available).
select e.name , d.department_name from employees e right join departments d on e.department_id = d.department_id;

-- 4. List all employees and departments, ensuring no data is missed from either table
SELECT * FROM employees e left join departments d ON e.department_id = d.department_id union 
SELECT * FROM employees e right join departments d ON e.department_id = d.department_id;

-- 5. Find employees whose department name starts with the letter 'F'
SELECT e.name, d.department_name FROM employees e left join departments d ON e.department_id = d.department_id
where d.department_name like "F%";

-- 6. Retrieve employee details along with the department name for departments with IDs greater than 102
SELECT e.name, d.department_name FROM employees e left join departments d ON e.department_id = d.department_id
where d.department_id > 102;

-- 7. Find employees working in the 'IT' or 'Marketing' departments.
SELECT e.name, d.department_name FROM employees e left join departments d ON e.department_id = d.department_id
where d.department_name = "IT" or d.department_name = "Marketing";

-- 8. List department names and the total number of employees in each department. (Hint: Use GROUP BY with INNER JOIN)
SELECT count(e.name), d.department_name FROM employees e right join departments d ON e.department_id = d.department_id
group by d.department_id;

-- 9. List all employees, including those without a department, and their department details.
SELECT e.name, d.department_name FROM employees e left join departments d ON e.department_id = d.department_id;

-- 10. Find employees not assigned to any department.
SELECT name FROM employees where department_id is NULL;

-- 11. Fetch all employees and their departments, replacing missing department names with 'Not Assigned'.
select name,
case
when e.department_id is null then "Not Assigned"
else d.department_name
end as "Status"
from employees e left join departments d on e.department_id = d.department_id;

-- 12. List employees along with department details for those working in departments with IDs less than 104.
SELECT e.name, d.department_name FROM employees e left join departments d ON e.department_id = d.department_id
where d.department_id < 104;

-- 13. Find employees with names starting with 'V' and their corresponding departments (if available).
SELECT e.name, e.department_id ,d.department_name FROM employees e left join departments d ON e.department_id = d.department_id
where e.name like "V%";

-- 14. List all departments and their employee details, including departments with no employees.
SELECT d.department_id ,d.department_name FROM employees e right join departments d ON e.department_id = d.department_id;

-- 15. Find departments without any employees assigned to them.
SELECT e.name, d.department_id, d.department_name FROM employees e right join departments d ON e.department_id = d.department_id
where e.name is null;

-- 16. Fetch the names of all departments along with employee names, where department names contain the letter 'O'.
SELECT e.name, d.department_id, d.department_name FROM employees e right join departments d ON e.department_id = d.department_id
where d.department_name like "%o%";

-- 17. Retrieve department details along with employees whose names end with 'a'.
SELECT e.name, d.department_id, d.department_name FROM employees e right join departments d ON e.department_id = d.department_id
where d.department_name like "%a";

-- 18. List all departments with fewer than two employees
SELECT count(e.name), d.department_name FROM employees e right join departments d ON e.department_id = d.department_id 
group by d.department_id having count(e.name) < 2;

-- 19. List all employees and departments, ensuring no record is missed.
SELECT e.emp_id, e.name, e.department_id as id, d.department_id, d.department_name FROM employees e left join departments d ON e.department_id = d.department_id union 
SELECT e.emp_id, e.name, e.department_id as id, d.department_id, d.department_name FROM employees e right join departments d ON e.department_id = d.department_id;

-- 20. Find all departments and employees where there is no match between the two tables.
SELECT * FROM employees e left join departments d ON e.department_id = d.department_id where d.department_id is null union 
SELECT * FROM employees e right join departments d ON e.department_id = d.department_id where e.name is null;

-- 21. Fetch details of all employees and departments, showing 'No Department' for missing department details and 
-- 'No Employee' for missing employee details.
SELECT * FROM employees e left join departments d ON e.department_id = d.department_id where d.department_id is null union 
SELECT * FROM employees e right join departments d ON e.department_id = d.department_id where e.name is null;

-- 22. List employees and departments, ensuring departments with names ending in 's' are included even if no employees are assigned.
SELECT * FROM employees e left join departments d ON e.department_id = d.department_id where d.department_name like "%s" union 
SELECT * FROM employees e right join departments d ON e.department_id = d.department_id where d.department_name like "%s";

with full_join as (
SELECT e.emp_id, e.name, e.department_id as id, d.department_id, d.department_name FROM employees e left join departments d ON e.department_id = d.department_id union 
SELECT e.emp_id, e.name, e.department_id as id, d.department_id, d.department_name FROM employees e right join departments d ON e.department_id = d.department_id
) 
select *  from full_join where department_name like "%s";

-- 23. Find departments and employees where department_id does not match, showing mismatched rows explicitly.
SELECT * FROM employees e left join departments d ON e.department_id = d.department_id where d.department_id is null union 
SELECT * FROM employees e right join departments d ON e.department_id = d.department_id where e.name is null;

-- 24. Combine INNER JOIN with aggregate functions to find the average number of employees per department.
select d.department_name, count(e.name) as emp_count from employees e inner join departments d 
on e.department_id = d.department_id group by d.department_name;

-- 25. Use LEFT OUTER JOIN to identify which employees are not assigned to a department and suggest a default 
-- department ('General').
select e.name, case
when e.department_id is null then "General"
else e.department_id
end as "dept_name"
from employees e left join departments d 
on e.department_id = d.department_id where e.department_id is null;

-- 26. Fetch employees assigned to the 'HR' department or employees with no department assigned.
select e.name, d.department_name from employees e left join departments d 
on e.department_id = d.department_id where e.department_id is null or d.department_name = "HR";

-- 27. Find all departments along with the employee count, even if the department has zero employees.
select d.department_name, count(e.name) as emp_count from employees e right join departments d 
on e.department_id = d.department_id group by d.department_name;

-- 28. List employees and their departments for employees whose emp_id is even, using any join.
select e.emp_id, e.name, d.department_name from employees e inner join departments d on e.department_id = d.department_id 
where e.emp_id % 2 = 0;

CREATE TABLE employees_2 (emp_id INT PRIMARY KEY,name VARCHAR(50),manager_id INT);
INSERT INTO employees_2 VALUES (1, 'Karthik', NULL), -- Karthik is the CEO and has no manager
(2, 'Veena', 1), -- Veena reports to Karthik 
(3, 'Meena', 1), -- Meena reports to Karthik
(4, 'Veer', 2), -- Veer reports to Veena 
(5, 'Ajay', 2), -- Ajay reports to Veena
(6, 'Vijay', 3), -- Vijay reports to Meena 
(7, 'Keerthi', 4); -- Keerthi reports to Veer

-- 1. Find all employees and their managers.
SELECT e.name AS employee_name, m.name AS manager_name FROM employees_2 e LEFT JOIN employees_2 m 
ON e.manager_id = m.emp_id;

-- 2. List employees who are managers and the employees reporting to them.
SELECT m.name AS manager_name, e.name AS employee_name FROM employees_2 e INNER JOIN employees_2 m 
ON e.manager_id = m.emp_id;

-- 3. Find employees who do not have a manager.
SELECT name AS employee_name FROM employees_2 WHERE manager_id IS NULL;

-- 4. Find the hierarchy level (manager and subordinate) for all employees.
SELECT e.name AS employee_name, m.name AS manager_name FROM employees_2 e LEFT JOIN employees_2 m 
ON e.manager_id = m.emp_id WHERE m.name IS NOT NULL;

-- 5. Find employees who are managers and have more than one subordinate.
SELECT m.name AS manager_name, COUNT(e.emp_id) AS subordinate_count
FROM employees_2 e INNER JOIN employees_2 m ON e.manager_id = m.emp_id
GROUP BY m.name HAVING COUNT(e.emp_id) > 1;

--                                  3 Table Join
CREATE TABLE employees3 (emp_id INT AUTO_INCREMENT PRIMARY KEY, emp_name VARCHAR(100), department_id INT);
INSERT INTO employees3 (emp_name, department_id) VALUES('Karthik', 1),('Veer', 2),('Veena', 3),('Meera', 1),
('Pratik', NULL);

CREATE TABLE departments3 (department_id INT PRIMARY KEY,department_name VARCHAR(100));
INSERT INTO departments3 (department_id, department_name) VALUES(1, 'HR'),(2, 'IT'),(3, 'Finance'),(4, 'Marketing');

CREATE TABLE salaries3 (emp_id INT,salary DECIMAL(10, 2),pay_date DATE,PRIMARY KEY (emp_id, pay_date));
INSERT INTO salaries3 (emp_id, salary, pay_date) VALUES(1, 50000, '2024-12-01'),(2, 60000, '2024-12-01'),
(3, 55000, '2024-12-01'),(1, 52000, '2024-12-15'),(2, 62000, '2024-12-15');

-- 1. Basic INNER JOIN
-- Write a query to display employee names, their department names, and their salaries.
select e.emp_name, d.department_name, s.salary from employees3 e inner join departments3 d 
on e.department_id = d.department_id inner join salaries3 s on e.emp_id = s.emp_id;

-- 2. LEFT JOIN for Missing Data
-- List all employees and their departments, including employees without a department or salary.
select e.emp_name, d.department_name, s.salary from employees3 e left join departments3 d 
on e.department_id = d.department_id left join salaries3 s on e.emp_id = s.emp_id;

-- 3. Salary Details for a Specific Date
-- Retrieve employee names, department names, and salaries paid on 2024-12-01.
select e.emp_name, d.department_name, s.salary, s.pay_date from employees3 e inner join departments3 d 
on e.department_id = d.department_id inner join salaries3 s on e.emp_id = s.emp_id where pay_date = "2024-12-01";

-- 4. Total Salary by Department
-- Calculate the total salary paid to each department.
select d.department_name, sum(s.salary) as total_salary from employees3 e inner join departments3 d 
on e.department_id = d.department_id inner join salaries3 s on e.emp_id = s.emp_id group by d.department_name;


-- 5. Employees Without Salary
-- Find employees who haven’t received any salary.
select e.emp_name, s.salary from employees3 e left join departments3 d 
on e.department_id = d.department_id left join salaries3 s on e.emp_id = s.emp_id where s.salary is null;

-- 6. Department with No Employees
-- Find departments with no employees assigned.
select e.emp_name, e.department_id from employees3 e left join departments3 d 
on e.department_id = d.department_id left join salaries3 s on e.emp_id = s.emp_id where e.department_id is null;


-- 7. Employees With Salaries in HR
-- List the names and salaries of employees in the HR department.
select e.emp_name, d.department_name, s.salary, s.pay_date from employees3 e inner join departments3 d 
on e.department_id = d.department_id inner join salaries3 s on e.emp_id = s.emp_id where d.department_name = "HR";

-- 8. Average Salary by Department
-- Calculate the average salary paid to employees in each department.
select d.department_name, avg(s.salary) from employees3 e inner join departments3 d 
on e.department_id = d.department_id inner join salaries3 s on e.emp_id = s.emp_id group by d.department_id;

-- 9. Latest Salary by Employee
-- For each employee, display their most recent salary payment.
select e.emp_name, max(s.salary) from employees3 e left join departments3 d 
on e.department_id = d.department_id inner join salaries3 s on e.emp_id = s.emp_id group by e.emp_name;


-- 10. Employees With Salaries Above Average
-- List employees whose salaries are above the overall average salary.
select e.emp_name, s.salary from employees3 e inner join departments3 d 
on e.department_id = d.department_id inner join salaries3 s on e.emp_id = s.emp_id where s.salary > (select avg(salary) from salaries3);

-- 11. Count Employees by Department
-- Count the number of employees in each department.
select d.department_name, count(e.emp_name) as emp_count from employees3 e right join departments3 d 
on e.department_id = d.department_id left join salaries3 s on e.emp_id = s.emp_id 
group by d.department_name;

-- 12. Missing Department Information
-- Identify employees who are missing department information.
select e.department_id, e.emp_name from employees3 e left join departments3 d 
on e.department_id = d.department_id left join salaries3 s on e.emp_id = s.emp_id where e.department_id is null;

-- 13. Salary Payments Across Departments
-- Show the total salary payments grouped by department and payment date.
select d.department_name, sum(s.salary), s.pay_date from employees3 e inner join departments3 d
on e.department_id = d.department_id inner join salaries3 s on e.emp_id = s.emp_id 
group by d.department_name, s.pay_date;

-- 14. Employees Paid Multiple Times
-- Find employees who have been paid more than once.
select e.emp_name from employees3 e inner join departments3 d on e.department_id = d.department_id 
inner join salaries3 s on e.emp_id = s.emp_id group by e.emp_name having count(s.salary) > 1;

-- 15. Join All Tables with Filters
-- Write a query to display employees who work in IT or Finance, their salaries, and payment dates
select e.emp_name, d.department_name, s.salary, s.pay_date from employees3 e inner join departments3 d
on e.department_id = d.department_id inner join salaries3 s on e.emp_id = s.emp_id 
where d.department_name = "IT" or d.department_name = "Finance";









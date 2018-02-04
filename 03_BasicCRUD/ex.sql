-- USE soft_uni;

-- 02. Find All Information About Departments

SELECT * FROM `departments`
ORDER BY `department_id`;


-- 03. Find all Department Names

SELECT `name` FROM `departments`
ORDER BY `department_id`;


-- 04. Find Salary of Each Employee

SELECT `first_name`, `last_name`, `salary` FROM `employees`
ORDER BY `employee_id`;


-- 05. Find Full Name of Each Employee

SELECT `first_name`, `middle_name`, `last_name`
FROM `employees`
ORDER BY `employee_id`;


-- 06. Find Email Address of Each Employee

SELECT CONCAT(`first_name`, '.', `last_name`, '@softuni.bg')
AS `full_ email_address`
FROM `employees`;
    
    
-- 07. Find All Different Employee’s Salaries

SELECT DISTINCT(`salary`) FROM `employees` ORDER BY `employee_id`;


-- 08. Find all Information About Employees

SELECT * FROM `employees`
WHERE `job_title` = 'Sales Representative'
ORDER BY `employee_id`;


-- 09. Find Names of All Employees by Salary in Range

SELECT e.first_name, e.last_name, e.job_title
FROM `employees` AS e
WHERE e.salary BETWEEN 20000 AND 30000
ORDER BY e.employee_id;


-- 10. Find Names of All Employees

SELECT CONCAT(e.first_name, " ", e.middle_name, " ", e.last_name)
	AS `Full Name`
	FROM `employees` AS e
	WHERE e.salary = 25000 
		OR e.salary = 14000 
		OR e.salary = 12500 
		OR e.salary = 23600;


-- 11. Find All Employees Without Manager

SELECT `first_name`, `last_name` FROM `employees`
WHERE `manager_id` IS NULL;


-- 12. Find All Employees with Salary More Than

SELECT e.first_name, e.last_name, e.salary
	FROM `employees` AS e
    WHERE e.salary > 50000
    ORDER BY e.salary DESC;
    
    
-- 13. Find 5 Best Paid Employees

SELECT e.first_name, e.last_name 
	FROM `employees` AS e
	ORDER BY e.salary DESC
    LIMIT 5;
    
    
-- 14. Find All Employees Except Marketing

SELECT e.first_name, e.last_name
	FROM `employees` AS e
    WHERE e.department_id != 4;
    
    
-- 15. Sort Employees Table

SELECT * FROM `employees` AS e
	ORDER BY 
			 e.salary DESC,
             e.first_name,
             e.last_name DESC,
             e.middle_name;
             
             
-- 16. Create View Employees with Salaries

CREATE VIEW `v_employees_salaries` AS
    SELECT 
        e.first_name, e.last_name, e.salary
    FROM
        employees AS e;


-- 17. Create View Employees with Job Titles

CREATE VIEW `v_employees_job_titles` AS
    SELECT 
        CONCAT_WS(" ", e.first_name, IFNULL(e.middle_name, ''), e.last_name)
        AS `full_name`,
        e.job_title
    FROM
        `employees` AS e;

SELECT * FROM v_employees_job_titles;


-- 18. Distinct Job Titles

SELECT DISTINCT(`job_title`) FROM `employees`
ORDER BY `job_title`;


-- 19. Find First 10 Started Projects 

-- id	Name	Description	start_date	end_date

SELECT 
    pr.project_id AS `id`, pr.name AS `Name`, pr.description AS `Description`,
    pr.start_date, pr.end_date
FROM
    `projects` AS pr
    ORDER BY `start_date`, `name`, `id`
    LIMIT 10;
    
    
-- 20. Last 7 Hired Employees 

SELECT 
    `first_name`, `last_name`, `hire_date`
FROM
    `employees`
ORDER BY `hire_date` DESC
LIMIT 7;


-- 21. Increase Salaries

UPDATE `employees` 
SET 
    `salary` = 1.12 * `salary`
WHERE
           `department_id` = 1
        OR `department_id` = 2
        OR `department_id` = 4
        OR `department_id` = 11;
	
SELECT `salary` FROM `employees`;


-- 22. All Mountain Peaks

-- USE `geography`;

SELECT `peak_name` FROM `peaks`
ORDER BY `peak_name`;


-- 23. Biggest Countries by Population

SELECT `country_name`, `population` FROM `countries`
WHERE `continent_code` = "EU"
ORDER BY `population` DESC, `country_name`
LIMIT 30;


-- 24. Countries and Currency

SELECT 
    `country_name`,
    `country_code`,
    IF(`currency_code` = 'EUR', 'Euro', 'Not Euro') AS `currency`
FROM
    `countries`
ORDER BY `country_name`;

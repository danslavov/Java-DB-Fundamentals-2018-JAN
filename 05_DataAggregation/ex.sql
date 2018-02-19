USE gringotts;

-- 01. Records’ Count

SELECT COUNT(*) AS `count` FROM wizzard_deposits;


-- 02. Longest Magic Wand

SELECT MAX(w.magic_wand_size) AS `longest_magic_wand`
FROM wizzard_deposits AS w;


-- 03. Longest Magic Wand per Deposit Groups

SELECT w.deposit_group, MAX(w.magic_wand_size) AS `longest_magic_wand`
FROM wizzard_deposits AS w
GROUP BY w.deposit_group
ORDER BY longest_magic_wand, w.deposit_group;


-- 04. Smallest Deposit Group per Magic Wand Size

SELECT w.deposit_group
FROM `wizzard_deposits` AS `w`
GROUP BY w.deposit_group
ORDER BY avg(w.magic_wand_size)
LIMIT 1;


-- 05. Deposits Sum

SELECT w.deposit_group, SUM(w.deposit_amount) AS `total_sum`
FROM `wizzard_deposits` AS `w`
GROUP BY w.deposit_group
ORDER BY total_sum;


-- 06. Deposits Sum for Ollivander Family

SELECT deposit_group as `d`, SUM(w.deposit_amount) AS `total_sum`
FROM `wizzard_deposits` AS `w`
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY d;


-- 07. Deposits Filter

SELECT deposit_group, SUM(deposit_amount) AS `sum`
FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING SUM(deposit_amount) < 150000
ORDER BY `sum` DESC;


-- 08. Deposit Charge

SELECT w.deposit_group AS dg, w.magic_wand_creator AS mwc, MIN(w.deposit_charge) AS mdc
FROM wizzard_deposits AS w
GROUP BY dg, mwc
ORDER BY mwc, dg;


-- 09. Age Groups

SELECT 
    CASE
		WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
        WHEN age > 60 THEN '[61+]'
	END AS `age_group`,
    COUNT(*)
FROM
    wizzard_deposits AS w
GROUP BY `age_group`;


-- 10. First Letter

SELECT LEFT(w.first_name, 1) AS `first_letter`
FROM `wizzard_deposits` AS w
WHERE w.deposit_group = 'Troll Chest'
GROUP BY first_letter;


-- 11. Average Interest

SELECT
	w.deposit_group AS `group`,
    w.is_deposit_expired AS `exp`,
    avg(w.deposit_interest) AS `avg_i`    
FROM `wizzard_deposits` AS w
WHERE w.deposit_start_date > '19850101'
GROUP BY `group`, `exp`
ORDER BY `group` DESC, `exp`;


-- 12. Rich Wizard, Poor Wizard

SELECT SUM(host_wiz.deposit_amount - guest_wiz.deposit_amount)
FROM `wizzard_deposits` AS `host_wiz`, `wizzard_deposits` AS `guest_wiz`
WHERE host_wiz.id = guest_wiz.id - 1;


-- 13. Employees Minimum Salaries

-- USE soft_uni;

SELECT e.department_id AS `d`, MIN(e.salary) AS `min_s`
FROM `employees` AS `e`
WHERE e.hire_date > '2000-01-01' AND e.department_id IN(2, 5, 7)
GROUP BY d;


-- 14. Employees Average Salaries

CREATE TABLE `new_table` AS SELECT * FROM
    `employees` AS `e`
WHERE
    e.salary > 30000;

DELETE FROM new_table 
WHERE
    employee_id > 0 AND manager_id = 42;

UPDATE new_table 
SET 
    salary = salary + 5000
WHERE
    employee_id > 0 AND department_id = 1;
    
SELECT department_id, AVG(salary) FROM new_table
GROUP BY department_id;


-- 15. Employees Maximum Salaries

SELECT 
    e.department_id AS `dep`, MAX(e.salary) AS `maks`
FROM
    `employees` AS `e`
GROUP BY dep
HAVING maks NOT BETWEEN 30000 AND 70000;


-- 16. Employees Count Salaries

SELECT COUNT(*) FROM employees AS `e`
WHERE e.manager_id IS NULL;


-- TODO: 17. 3rd Highest Salary

SELECT 
    department_id,
    (SELECT DISTINCT
            salary
        FROM
            employees AS e2
        WHERE
            e2.department_id = e1.department_id
        ORDER BY salary DESC
        LIMIT 2 , 1) AS `third_highest_salary`
FROM
    employees AS e1
GROUP BY department_id
HAVING `third_highest_salary` IS NOT NULL
ORDER BY department_id;


-- 18. Salary Challenge

SELECT 
    e.first_name, e.last_name, e.department_id
FROM
    `employees` AS `e`,
    (SELECT 
        e.department_id AS `d_id`, AVG(e.salary) AS `avg_s`
    FROM
        `employees` AS `e`
    GROUP BY d_id) AS `nested`
WHERE
    e.department_id = nested.d_id
        AND e.salary > nested.avg_s
ORDER BY e.department_id
LIMIT 10;


-- 19. Departments Total Salaries

SELECT e.department_id, SUM(e.salary)
FROM `employees` AS `e`
GROUP BY e.department_id;
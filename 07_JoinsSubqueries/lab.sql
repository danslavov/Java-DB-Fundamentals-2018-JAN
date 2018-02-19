-- 1. Managers

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    d.department_id,
    d.name
FROM
    employees AS e
        INNER JOIN
    departments AS d ON e.employee_id = d.manager_id
ORDER BY e.employee_id
LIMIT 5;


-- 2. Towns and Addresses

SELECT
    t.town_id, t.name, a.address_text
FROM
    towns AS t
        INNER JOIN
    addresses AS a ON t.town_id = a.town_id
WHERE
    t.name IN('San Francisco','Sofia','Carnation')
ORDER BY t.town_id , a.address_id;


-- 3. Employees Without Managers

SELECT DISTINCT
	e.employee_id,
    e.first_name,
    e.last_name,
    e.department_id,
    e.salary
FROM employees AS e
INNER JOIN employees AS e1 ON e.manager_id IS NULL;


-- 4. High Salary

SELECT count(*)
FROM employees AS e_out
WHERE e_out.salary >
(SELECT avg(e.salary) AS avg_s
FROM employees AS e);
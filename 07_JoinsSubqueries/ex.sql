-- 01. Employee Address

SELECT 
    e.employee_id, e.job_title, a.address_id, a.address_text
FROM
    employees AS e
        INNER JOIN
    addresses AS a ON e.address_id = a.address_id
ORDER BY a.address_id
LIMIT 5;


-- 02. Addresses with Towns

SELECT 
    e.first_name, e.last_name, t.name, a.address_text
FROM
    employees AS e
        INNER JOIN
    addresses AS a ON e.address_id = a.address_id
        INNER JOIN
    towns AS t ON a.town_id = t.town_id
ORDER BY e.first_name, e.last_name
LIMIT 5;


-- 03. Sales Employee

SELECT e.employee_id, e.first_name, e.last_name, d.name
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id
WHERE d.name = 'Sales'
ORDER BY e.employee_id DESC;
	

-- 04. Employee Departments

SELECT e.employee_id, e.first_name, e.salary, d.name
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id
WHERE e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;


-- 05. Employees Without Project

SELECT 
    e.employee_id, e.first_name
FROM
    employees AS e
        LEFT OUTER JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
WHERE ep.project_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;


-- 06. Employees Hired After

SELECT e.first_name, e.last_name, e.hire_date, d.name
FROM employees AS e
INNER JOIN departments AS d ON e.department_id = d.department_id
AND d.name IN ('Sales', 'Finance')
AND DATE(e.hire_date) > '1999-01-01'
ORDER BY e.hire_date;


-- 07. Employees with Project

SELECT 
    e.employee_id, e.first_name, p.name
FROM
    employees AS e
        INNER JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        INNER JOIN
    projects AS p ON ep.project_id = p.project_id
        AND DATE(p.start_date) > '2002-08-13'
        AND p.end_date IS NULL
ORDER BY e.first_name , p.name
LIMIT 5;


-- 08. Employee 24

SELECT 
    e.employee_id, e.first_name, p.name
FROM
    employees AS e
        INNER JOIN
    employees_projects AS ep ON e.employee_id = ep.employee_id
        AND e.employee_id = 24
        LEFT OUTER JOIN
    projects AS p ON ep.project_id = p.project_id
        AND YEAR(p.start_date) < 2005
ORDER BY p.name;


-- 09. Employee Manager

SELECT 
    e.employee_id,
    e.first_name,
    e.manager_id,
    m.first_name AS manager_name
FROM
    employees AS e
        INNER JOIN
    employees AS m ON e.manager_id = m.employee_id
        AND e.manager_id IN (3 , 7)
ORDER BY e.first_name;


-- 10. Employee Summary

SELECT 
    e.employee_id,
    concat(e.first_name, ' ', e.last_name) AS employee_name,
    concat(m.first_name, ' ', m.last_name) AS manager_name,
    d.name AS department_name
FROM
    employees AS e
        INNER JOIN
    employees AS m ON e.manager_id = m.employee_id
        INNER JOIN
    departments AS d ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;


-- 11. Min Average Salary

SELECT 
    MIN(avg_sal)
FROM
    (SELECT 
        AVG(e.salary) AS avg_sal
    FROM
        employees AS e
    GROUP BY e.department_id) AS inner_table;
    
    
-- 12. Highest Peaks in Bulgaria

SELECT 
    c.country_code, m.mountain_range, p.peak_name, p.elevation
FROM
    countries AS c
        INNER JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        AND c.country_code = 'BG'
        INNER JOIN
    mountains AS m ON mc.mountain_id = m.id
        INNER JOIN
    peaks AS p ON m.id = p.mountain_id
        AND p.elevation > 2835
ORDER BY p.elevation DESC;


-- 13. Count Mountain Ranges

SELECT
	c.country_code, count(mc.mountain_id) AS mount_count
FROM
	countries AS c
		INNER JOIN
	mountains_countries AS mc ON c.country_code = mc.country_code
		AND c.country_name IN ('United States', 'Russia', 'Bulgaria')
GROUP BY c.country_code
ORDER BY mount_count DESC;


-- 14. Countries with Rivers

SELECT 
    c.country_name, r.river_name
FROM
    countries AS c
        LEFT OUTER JOIN
    countries_rivers AS cr ON c.country_code = cr.country_code
        LEFT OUTER JOIN
    rivers AS r ON cr.river_id = r.id
WHERE c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;


-- TODO: 15. Continents and Currencies

SELECT 
    c.continent_code,
    c.currency_code,
    COUNT(*) AS currency_usage
FROM
    countries AS c
GROUP BY c.continent_code , c.currency_code
HAVING COUNT(*) > 1;


-- 16. Countries without any Mountains

SELECT
	count(*)
FROM
	countries AS c
		LEFT OUTER JOIN
	mountains_countries AS mc ON c.country_code = mc.country_code
WHERE mc.country_code IS NULL;


-- 17. Highest Peak and Longest River by Country
	
SELECT 
    c.country_name,
    max(p.elevation) AS highest_peak_elevation,
    max(r.length) AS longest_river_length
FROM
    countries AS c
        LEFT OUTER JOIN
    mountains_countries AS mc ON c.country_code = mc.country_code
        LEFT OUTER JOIN
    mountains AS m ON mc.mountain_id = m.id
        LEFT OUTER JOIN
    peaks AS p ON m.id = p.mountain_id
		LEFT OUTER JOIN
	countries_rivers AS cr ON c.country_code = cr.country_code
		LEFT OUTER JOIN
	rivers AS r ON cr.river_id = r.id
GROUP BY c.country_name
ORDER BY
	highest_peak_elevation DESC,
    longest_river_length DESC
LIMIT 5;
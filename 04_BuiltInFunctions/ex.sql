-- USE `soft_uni`;

-- 01. Find Names of All Employees by First Name

SELECT `first_name`, `last_name`
FROM `employees`
WHERE LEFT(`first_name`, 2) = 'Sa';


-- 02. Find Names of All Employees by Last Name

SELECT `first_name`, `last_name`
FROM `employees`
WHERE LOCATE('ei', `last_name`) > 0;


-- 03. Find First Names of All Employess

SELECT 
    `first_name`
FROM
    `employees`
WHERE
    `department_id` IN (3 , 10)
        AND YEAR(`hire_date`) BETWEEN 1995 AND 2005;
        
        
-- 04. Find All Employees Except Engineers

SELECT 
    `first_name`, `last_name`
FROM
    `employees`
WHERE
    LOCATE('engineer', `job_title`) = 0;


-- 05. Find Towns with Name Length

SELECT `name` FROM `towns`
WHERE CHAR_LENGTH(`name`) IN(5, 6)
ORDER BY `name`;


-- 06. Find Towns Starting With

SELECT `town_id`, `name` FROM `towns`
WHERE LEFT(`name`, 1) IN ('M', 'K', 'B', 'E')
ORDER BY `name`;


-- 07. Find Towns Not Starting With

SELECT `town_id`, `name` FROM `towns`
WHERE LEFT(`name`, 1) NOT IN ('R', 'B', 'D')
ORDER BY `name`;


-- 08. Create View Employees Hired After

CREATE VIEW `v_employees_hired_after_2000` AS
SELECT `first_name`, `last_name` FROM `employees`
WHERE YEAR(`hire_date`) > 2000;


-- 09. Length of Last Name

SELECT `first_name`, `last_name` FROM `employees`
WHERE CHAR_LENGTH(`last_name`) = 5;


-- 10. Countries Holding 'A'

-- USE `geography`;

SELECT 
    `country_name`, `iso_code`
FROM
    `countries`
WHERE
    CHAR_LENGTH(`country_name`) - CHAR_LENGTH(REPLACE(LOWER(`country_name`), 'a', '')) >= 3
ORDER BY `iso_code`;


-- 11. Mix of Peak and River Names

SELECT
	`p`.`peak_name`,
    `r`.`river_name`,
	CONCAT(LOWER(`p`.`peak_name`), LOWER(SUBSTRING(`r`.`river_name`, 2))) AS `mix`
FROM `peaks` AS `p`, `rivers` AS `r`
WHERE RIGHT(`p`.`peak_name`, 1) = LOWER(LEFT(`r`.`river_name`, 1))
ORDER BY `mix`;

-- 12. Games From 2011 and 2012 Year

-- USE `diablo`;

SELECT 
    `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS `start`
FROM
    `games`
WHERE
    YEAR(`start`) IN (2011 , 2012)
ORDER BY DATE(`start`) , `name`
LIMIT 50;


-- 13. User Email Providers

SELECT 
    `user_name`,
    SUBSTRING(`email`, LOCATE('@', `email`) + 1) AS `Email Provider`
FROM
    `users`
ORDER BY `Email Provider` , `user_name`;


-- 14. Get Users with IP Address Like Pattern

SELECT `user_name`, `ip_address` FROM `users`
WHERE `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;


-- 15. Show All Games with Duration

SELECT
	`name` AS `game`,
    
    CASE
		WHEN TIME(`start`) BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
        WHEN TIME(`start`) BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
        ELSE 'Evening' -- BETWEEN 18 AND 24
	END
	AS `Part of the Day`,
        
    CASE
		WHEN `duration` <= 3 THEN 'Extra Short'
        WHEN `duration` BETWEEN 4 AND 6 THEN 'Short'
        WHEN `duration` BETWEEN 7 AND 10 THEN 'Long'
        ELSE 'Extra Long'
	END
    AS `Duration`

FROM `games`
ORDER BY `name`, `Part of the Day`;


-- 16. Orders Table

SELECT 
    `product_name`,
    `order_date`,
    DATE_ADD(`order_date`, INTERVAL 3 DAY) AS `pay_due`,
    DATE_ADD(`order_date`, INTERVAL 1 MONTH) AS `deliver_due`
FROM
    `orders`;

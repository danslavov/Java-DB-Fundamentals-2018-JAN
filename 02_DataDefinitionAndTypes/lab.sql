CREATE DATABASE gamebar;
USE gamebar;

-- 2 ----

CREATE TABLE employees (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL
);

CREATE TABLE categories (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
category_id INT
);


-- 3 ----

INSERT INTO employees(first_name, last_name) VALUES
("Pesho", "Peshov"), ("Pesho", "Peshov"), ("Pesho", "Peshov");


-- 4 ---- no points from Judge

ALTER TABLE employees
ADD COLUMN middle_name VARCHAR(50) NOT NULL AFTER first_name;
 
 
-- 5 ----

ALTER TABLE products
ADD CONSTRAINT fk_product_category FOREIGN KEY(category_id) REFERENCES categories(id);


-- 6 ----

ALTER TABLE employees
MODIFY middle_name VARCHAR(100);


DROP DATABASE gamebar;
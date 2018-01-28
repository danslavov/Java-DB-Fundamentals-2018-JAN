-- 2 ----

CREATE TABLE minions
(
id INT,
name VARCHAR(50),
age INT
);

CREATE TABLE towns
(
id INT,
name VARCHAR(50)
);

ALTER TABLE minions
ADD PRIMARY KEY(id);

ALTER TABLE towns
ADD PRIMARY KEY(id);


-- 3 ----

ALTER TABLE minions
ADD COLUMN town_id INT NOT NULL DEFAULT 0;

ALTER TABLE minions
ADD CONSTRAINT fk_town_id FOREIGN KEY(town_id) REFERENCES towns(id);


-- 4 ----

INSERT INTO towns VALUES
(1, "Sofia"), (2, "Plovdiv"), (3, "Varna");
                         
INSERT INTO minions VALUES
(1, "Kevin", 22, 1), (2, "Bob", 15, 3), (3, "Steward", NULL, 2);


-- 5 ----

TRUNCATE TABLE minions;


-- 6 ----

DROP TABLE minions;
DROP TABLE towns;


-- 7 ----

CREATE TABLE people
(
id INT UNIQUE AUTO_INCREMENT,
name VARCHAR(200) NOT NULL,
picture BLOB(2000000),
height FLOAT(3, 2),
weight FLOAT(5, 2),
gender ENUM("m", "f") NOT NULL,
-- gender CHAR(1) CHECK(gender = "m" OR gender = "f") NOT NULL,
birthdate DATE NOT NULL,
biography TEXT
);

ALTER TABLE people
ADD PRIMARY KEY(id);

INSERT INTO people(name, gender, birthdate)
VALUES
("Pesho", "m", CURDATE()),
("Gosho", "m", CURDATE()),
("Mara", "f", CURDATE()),
("Fichka", "f", CURDATE()),
("Prasi", "m", CURDATE());


-- 8 ----

CREATE TABLE users
(
id BIGINT UNIQUE AUTO_INCREMENT,
username VARCHAR(30) UNIQUE NOT NULL,
password VARCHAR(26) NOT NULL,
profile_picture BLOB(900000),
last_login_time DATETIME,
is_deleted ENUM("true", "false")
);

ALTER TABLE users
ADD PRIMARY KEY(id);

INSERT INTO users(username, password)  VALUES
("Pesho", "pepeto"),
("Gosho", "gosheto"),
("Mara", "mara-kozara"),
("Ginka", "gugu"),
("Ficho", "ficheto");


-- 9 ----

ALTER TABLE users
DROP PRIMARY KEY,
ADD PRIMARY KEY(id, username);


-- 10 ---

ALTER TABLE users
CHANGE COLUMN last_login_time
last_login_time DATETIME DEFAULT CURRENT_TIMESTAMP;


-- 11 ---

ALTER TABLE users
DROP PRIMARY KEY,
ADD PRIMARY KEY(id),

-- the following creates duplicate UNIQUE index but is needed for Judge:
CHANGE username username VARCHAR(30) UNIQUE;


-- 12 ---

CREATE DATABASE movies;
USE movies;

CREATE TABLE directors
(
id INT AUTO_INCREMENT PRIMARY KEY,
director_name VARCHAR(200) NOT NULL,
notes TEXT
);

CREATE TABLE genres
(
id INT AUTO_INCREMENT PRIMARY KEY,
genre_name VARCHAR(200) NOT NULL,
notes TEXT
);

CREATE TABLE categories
(
id INT AUTO_INCREMENT PRIMARY KEY,
category_name VARCHAR(200) NOT NULL,
notes TEXT
);

-- for Judge: director, genre and category names should not be UNIQUE !!!

CREATE TABLE movies
(
id INT AUTO_INCREMENT PRIMARY KEY,
title VARCHAR(200) NOT NULL,	-- for Judge: title should not be UNIQUE !!!
director_id INT NOT NULL,
copyright_year SMALLINT,
length TIME NOT NULL,
genre_id INT NOT NULL,
category_id INT NOT NULL,
rating TINYINT NOT NULL,
notes TEXT
-- FOREIGN KEY(director_id) REFERENCES directors(id),
-- FOREIGN KEY(genre_id) REFERENCES genres(id),
-- FOREIGN KEY(category_id) REFERENCES categories(id)
);


-- insert

INSERT INTO directors(director_name) VALUES
("Pesho"),
("Gosho"),
("Mara"),
("Pena"),
("Noone");

INSERT INTO genres(genre_name) VALUES
("comedy"),
("parody"),
("grotesque"),
("comedy horor"),
("unspecified");

INSERT INTO categories(category_name) VALUES
("all ages"),
("children"),
("adult"),
("elderly"),
("unspecified");

INSERT INTO movies(title, director_id, copyright_year, length, genre_id, category_id, rating) VALUES
("Filma", 1, 2000, "01:00:00", 1, 1, 1),
("Filma2", 1, 2000, "01:00:00", 1, 1, 1),
("Filma3", 1, 2000, "01:00:00", 1, 1, 1),
("Filma4", 1, 2000, "01:00:00", 1, 1, 1),
("Filma5", 1, 2000, "01:00:00", 1, 1, 1);


-- 13 ---

-- create

CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE categories
(
id INT AUTO_INCREMENT PRIMARY KEY,
category VARCHAR(20) NOT NULL,
daily_rate FLOAT(7, 2),
weekly_rate FLOAT(7, 2),
monthly_rate FLOAT(7, 2),
weekend_rate FLOAT(7, 2)
);

CREATE TABLE cars
(
id INT AUTO_INCREMENT PRIMARY KEY,
plate_number SMALLINT NOT NULL UNIQUE,
make VARCHAR(20) NOT NULL,
model VARCHAR(20),
car_year SMALLINT,
category_id INT,
doors TINYINT,
picture BLOB,
car_condition VARCHAR(10),
available BIT(1)
);

CREATE TABLE employees
(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20),
title VARCHAR(20),
notes TEXT
);

CREATE TABLE customers
(
id INT AUTO_INCREMENT PRIMARY KEY,
driver_licence_number INT,
full_name VARCHAR(50),
address VARCHAR(200),
city VARCHAR(30) NOT NULL,
zip_code INT,
notes TEXT
);

CREATE TABLE rental_orders
(
id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT DEFAULT 1,
customer_id INT DEFAULT 1,
car_id INT DEFAULT 1,
car_condition VARCHAR(10),
tank_level TINYINT,
kilometrage_start INT DEFAULT 0,
kilometrage_end INT DEFAULT 0,
total_kilometrage INT DEFAULT 0,  -- calulate instead of insert ?
start_date DATE DEFAULT "2000-01-01",
end_date DATE DEFAULT "2000-01-01",
total_days INT DEFAULT 0,  -- calulate instead of insert ?
rate_applied FLOAT(7, 2) DEFAULT 0.00,
tax_rate FLOAT(4, 2) DEFAULT 0.00,
order_status VARCHAR(50), -- what type ?
notes TEXT
);


-- insert

INSERT INTO categories VALUES
(1, "cat1", 1.00, 1.00, 1.00, 1.00),
(2, "cat2", 1.00, 1.00, 1.00, 1.00),
(3, "cat3", 1.00, 1.00, 1.00, 1.00);

INSERT INTO cars(plate_number, make, model, car_year, category_id, doors, available)
VALUES
(1111, "Lada", "Kalina", 2000, 1, 4, 1),
(2222, "Lada", "Kalina", 2000, 1, 4, 0),
(3333, "Lada", "Kalina", 2000, 1, 4, 0);

INSERT INTO employees(first_name, last_name, title)
VALUES
("Pesho", "Shefcheto", "dabos"),
("Gosho", "Pishlemeto", "agent"),
("Mara", "Marcheva", "typewriter");

INSERT INTO customers(city)
VALUES
("Sofia"),
("Plovdiv"),
("Varna");

INSERT INTO rental_orders(notes)
VALUES
("one"),
("two"),
("three");


-- 14 ---

CREATE DATABASE hotel;
USE hotel;

CREATE TABLE employees (
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50),
title VARCHAR(50),
notes TEXT
);

INSERT INTO employees(first_name) VALUES
("Pesho"), ("Gosho"), ("Mara");


CREATE TABLE customers (
account_number INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50),
phone_number VARCHAR(50),
emergency_name VARCHAR(50),
emergency_number VARCHAR(50),
notes TEXT
);

INSERT INTO customers(first_name) VALUES
("Pesho"), ("Gosho"), ("Mara");


CREATE TABLE room_status (
room_status INT PRIMARY KEY,
notes TEXT
);

INSERT INTO room_status(room_status) VALUES
(1), (2), (3);


CREATE TABLE room_types (
room_type INT PRIMARY KEY,
notes TEXT
);

INSERT INTO room_types(room_type) VALUES
(1), (2), (3);


CREATE TABLE bed_types (
bed_type INT PRIMARY KEY,
notes TEXT
);

INSERT INTO bed_types(bed_type) VALUES
(1), (2), (3);


CREATE TABLE rooms (
room_number INT PRIMARY KEY,
room_type VARCHAR(20),
bed_type VARCHAR(20),
room_status VARCHAR(20),
rate FLOAT(5, 2),
notes TEXT
);

INSERT INTO rooms(room_number) VALUES
(1), (2), (3);


CREATE TABLE payments (
id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT,
payment_date DATE,
account_number INT,
first_date_occupied DATE,
last_date_occupied DATE,
total_days INT,
amount_charged FLOAT(5, 2),
tax_rate INT,
tax_amount FLOAT(5, 2),
payment_total FLOAT(5, 2),
notes TEXT
);

INSERT INTO payments(employee_id) VALUES
(1), (1), (1);


CREATE TABLE occupancies (
id INT AUTO_INCREMENT PRIMARY KEY,
employee_id INT,
date_occupied DATE,
account_number INT,
room_number INT,
rate_applied FLOAT(5, 2),
phone_charge FLOAT(5, 2),
notes TEXT
);

INSERT INTO payments(employee_id) VALUES
(1), (1), (1);


-- 15 ---

CREATE DATABASE softuni;
USE softuni;

CREATE TABLE towns (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50)
);

CREATE TABLE addresses (
id INT PRIMARY KEY AUTO_INCREMENT,
address_text VARCHAR(200),
town_id INT,
CONSTRAINT fk_address_town FOREIGN KEY(town_id) REFERENCES towns(id)
);

CREATE TABLE departments (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50)
);

CREATE TABLE employees (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50),
middle_name VARCHAR(50),
last_name VARCHAR(50),
job_title VARCHAR(50),
department_id INT,
hire_date DATE,
salary FLOAT(6, 2),
address_id INT,
CONSTRAINT fk_employee_department FOREIGN KEY(department_id) REFERENCES departments(id),
CONSTRAINT fk_employee_address FOREIGN KEY(address_id) REFERENCES addresses(id)
);


-- 17 ---

INSERT INTO departments(name) VALUES
("Engineering"), ("Sales"), ("Marketing"), ("Software Development"), ("Quality Assurance");

INSERT INTO towns(name) VALUES
("Sofia"), ("Plovdiv"), ("Varna"), ("Burgas");

INSERT INTO employees (
first_name, middle_name, last_name, job_title, department_id, hire_date, salary
) VALUES
("Ivan", "Ivanov", "Ivanov", ".NET Developer", 4, "20130201", 3500.00),
("Petar", "Petrov", "Petrov", "Senior Engineer", 1, "20040302", 4000.00),
("Maria", "Petrova", "Ivanova", "Intern", 5, "20160828", 525.25),
("Georgi", "Terziev", "Ivanov", "CEO", 2, "20071209", 3000.00),
("Peter", "Pan", "Pan", "Intern", 3, "20160828", 599.88);


-- 18 ---

SELECT * FROM towns AS t
ORDER BY t.name;

SELECT * FROM departments AS d
ORDER BY d.name;

SELECT * FROM employees AS e
ORDER BY e.salary DESC;


-- 20 ---

SELECT name FROM towns AS t ORDER BY t.name;
SELECT name FROM departments AS d ORDER BY d.name;
SELECT first_name, last_name, job_title, salary FROM employees AS e ORDER BY e.salary DESC;


-- 21 ---

UPDATE employees
SET salary = salary * 1.1;

SELECT salary FROM employees;


-- 22 ---

UPDATE payments
SET tax_rate = 0.97 * tax_rate;

SELECT tax_rate FROM payments;
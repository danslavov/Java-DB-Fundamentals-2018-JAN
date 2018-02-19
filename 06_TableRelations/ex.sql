CREATE DATABASE ex;
USE ex;


-- 01. One-To-One Relationship

CREATE TABLE persons(
person_id INT PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
salary DECIMAL(7, 2),
passport_id INT UNIQUE
);

CREATE TABLE passports(
passport_id INT PRIMARY KEY,
passport_number VARCHAR(10) NOT NULL
);

ALTER TABLE persons
ADD CONSTRAINT fk_persons_passports
FOREIGN KEY(passport_id) REFERENCES passports(passport_id);

INSERT INTO passports VALUES
(101, 'N34FG21B'), (102, 'K65LO4R7'), (103, 'ZE657QP2');

INSERT INTO persons VALUES
(1,'Roberto',43300.00,102),
(2,'Tom',56100.00,103),
(3,'Yana',60200.00,101);


-- 02. One-To-Many Relationship

CREATE TABLE manufacturers(
manufacturer_id INT PRIMARY KEY,
`name` VARCHAR(20),
established_on DATETIME
);

CREATE TABLE models(
model_id INT PRIMARY KEY,
`name` VARCHAR(20),
manufacturer_id INT,
CONSTRAINT fk_models_manufacturers
FOREIGN KEY(manufacturer_id) REFERENCES manufacturers(manufacturer_id)
);

INSERT INTO manufacturers VALUES
(1,'BMW','19160301'),
(2,'Tesla','20030101'),
(3,'Lada','19660501');

INSERT INTO models VALUES
(101,'X1',1),
(102,'i6',1),
(103,'Model S',2),
(104,'Model X',2),
(105,'Model 3',2),
(106,'Nova',3);


-- 03. Many-To-Many Relationship

CREATE TABLE students(
student_id INT PRIMARY KEY,
`name` VARCHAR(50)
);

CREATE TABLE exams(
exam_id INT PRIMARY KEY,
`name` VARCHAR(50)
);

CREATE TABLE students_exams(
student_id INT,
exam_id INT,
PRIMARY KEY(student_id, exam_id),
CONSTRAINT `fk_students_exams_students`
FOREIGN KEY(student_id) REFERENCES students(student_id),
CONSTRAINT `fk_students_exams_exams`
FOREIGN KEY(exam_id) REFERENCES exams(exam_id)
);

INSERT INTO students VALUES
(1, 'Mila'), (2, 'Toni'), (3, 'Ron');

INSERT INTO exams VALUES
(101, 'Spring MVC'), (102, 'Neo4j'), (103, 'Oracle 11g');

INSERT INTO students_exams VALUES
(1,101),(1,102),(2,101),(3,103),(2,102),(2,103);


-- 04. Self-Referencing

CREATE TABLE teachers(
teacher_id INT PRIMARY KEY,
`name` VARCHAR(50),
manager_id INT
);

INSERT INTO teachers VALUES
(101,'John', NULL),
(102,'Maya',106),
(103,'Silvia',106),
(104,'Ted',105),
(105,'Mark',101),
(106,'Greta',101);

ALTER TABLE teachers
ADD CONSTRAINT `teachers_teachers`
FOREIGN KEY(manager_id) REFERENCES teachers(teacher_id);


-- 05. Online Store Database

CREATE DATABASE online_store;
USE online_store;

CREATE TABLE item_types(
item_type_id INT(11) PRIMARY KEY,
`name` VARCHAR(50)
);

CREATE TABLE items(
item_id INT PRIMARY KEY,
`name` VARCHAR(50),
item_type_id INT(11),
CONSTRAINT `items_item_types`
FOREIGN KEY(item_type_id) REFERENCES item_types(item_type_id)
);

CREATE TABLE cities(
city_id INT(11) PRIMARY KEY,
`name` VARCHAR(50)
);

CREATE TABLE customers(
customer_id INT(11) PRIMARY KEY,
`name` VARCHAR(50),
birthday DATE,
city_id INT(11),
CONSTRAINT `customers_cities`
FOREIGN KEY(city_id) REFERENCES cities(city_id)
);

CREATE TABLE orders(
order_id INT(11) PRIMARY KEY,
customer_id INT(11),
CONSTRAINT `orders_customers`
FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items(	-- 'order' (i.e. singular) needed for Judge 
order_id INT(11),
item_id INT(11),
PRIMARY KEY(order_id, item_id),
CONSTRAINT `orders_items_orders` FOREIGN KEY(order_id)
REFERENCES orders(order_id),
CONSTRAINT `orders_items_items` FOREIGN KEY(item_id)
REFERENCES items(item_id)
);


-- 06. University Database

CREATE DATABASE university;
USE university;

CREATE TABLE majors(
major_id INT(11) PRIMARY KEY,
`name` VARCHAR(50)
);

CREATE TABLE students(
student_id INT(11) PRIMARY KEY,
student_number VARCHAR(12),
student_name VARCHAR(50),
major_id INT(11),
CONSTRAINT `students_majors`
FOREIGN KEY(major_id) REFERENCES majors(major_id)
);

CREATE TABLE payments(
payment_id INT(11) PRIMARY KEY,
payment_date DATE,
payment_amount DECIMAL(8,2),
student_id INT(11),
CONSTRAINT `payments_students`
FOREIGN KEY(student_id) REFERENCES students(student_id)
);

CREATE TABLE subjects(
subject_id INT(11) PRIMARY KEY,
subject_name VARCHAR(50)
);

CREATE TABLE agenda(
student_id INT(11),
subject_id INT(11),
PRIMARY KEY(student_id, subject_id),
CONSTRAINT `agenda_students`
FOREIGN KEY(student_id) REFERENCES students(student_id),
CONSTRAINT `agenda_subjects`
FOREIGN KEY(subject_id) REFERENCES subjects(subject_id)
);


-- 09. Peaks in Rila

SELECT m.mountain_range, p.peak_name, p.elevation
FROM mountains AS m
JOIN peaks AS p
ON m.id = p.mountain_id
WHERE m.mountain_range = 'Rila'
ORDER BY p.elevation DESC;
-- 1. Mountains and Peaks

CREATE TABLE mountains(
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);

CREATE TABLE peaks(
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
mountain_id INT NOT NULL,
CONSTRAINT fk_peaks_mountains
FOREIGN KEY(mountain_id) REFERENCES mountains(mountain_id)
);


-- 2. Books and Authors

CREATE TABLE authors (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE books (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    author_id INT NOT NULL,
    CONSTRAINT fk_books_authors FOREIGN KEY (id)
        REFERENCES authors(id)
);


-- 3. Trip Organization

SELECT 
    v.driver_id,
    v.vehicle_type,
    CONCAT(c.first_name, ' ', c.last_name)
FROM
    campers AS c,
    vehicles AS v
WHERE
    v.driver_id = c.id;
    
    
-- 4. SoftUni Hiking

SELECT 
    r.starting_point,
    r.end_point,
    r.leader_id,
    CONCAT(c.first_name, ' ', c.last_name) AS leader_name
FROM
    routes AS r,
    campers AS c
WHERE
    r.leader_id = c.id;
    
    
-- 5. Project Management DB

CREATE TABLE clients(
id INT(11) PRIMARY KEY,
client_name VARCHAR(100) NOT NULL,
project_id INT(11)
);

CREATE TABLE projects(
id INT(11) PRIMARY KEY,
client_id INT(11),
project_lead_id INT(11)
);

CREATE TABLE employees(
id INT(11) PRIMARY KEY,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
project_id INT(11)
);

ALTER TABLE clients
ADD CONSTRAINT fk_clients_projects
FOREIGN KEY (project_id) REFERENCES projects(id);

ALTER TABLE projects
ADD CONSTRAINT fk_projects_clients
FOREIGN KEY (client_id) REFERENCES clients(id),
ADD CONSTRAINT fk_projects_employees
FOREIGN KEY (project_lead_id) REFERENCES employees(id);

ALTER TABLE employees
ADD CONSTRAINT fk_employees_projects
FOREIGN KEY (project_id) REFERENCES projects(id);
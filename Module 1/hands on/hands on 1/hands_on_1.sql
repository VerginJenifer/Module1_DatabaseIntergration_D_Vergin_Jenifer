-- ======================================================
-- Task !: Create database and table
-- ======================================================
CREATE DATABASE College_db;
USE College_db;
CREATE TABLE departments(
department_id INT PRIMARY KEY AUTO_INCREMENT,
dept_name VARCHAR(100) NOT NULL,
hod_name VARCHAR(100),
budget DECIMAL(10,2));
CREATE TABLE students(
student_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
date_of_birth DATE,
department_id INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id),
enrollment_year INT);
CREATE TABLE courses(
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(100) NOT NULL,
course_code VARCHAR(100) UNIQUE,
credits INT,
department_id INT,
FOREIGN KEY (department_id) REFERENCES departments(department_id));
CREATE TABLE enrollments(
enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
student_id INT,
course_id INT,
enrollment_date DATE,
grade CHAR(2),
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
CREATE TABLE professors(
professor_id INT PRIMARY KEY AUTO_INCREMENT,
prof_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE,
department_id INT,
salary DECIMAL(10,2),
FOREIGN KEY (department_id) REFERENCES departments(department_id));
INSERT INTO departments (dept_name, hod_name, budget) VALUES
('Computer Science', 'Dr. Ramesh Kumar', 858000.08),
('Electronics', 'Dr. Priya Nair', 620800.00),
('Mechanical', 'Dr. Suresh Iyer', 540800.00),
('Civil', 'Dr. Ananya Sharma', 430008.00);
INSERT INTO students (first_name, last_name, email, date_of_birth, department_id,enrollment_year) VALUES
( 'Arjun','Mehta','arjun.mehta@college.edu','2003-04-12', 1, 2022),
('Priya','Suresh','priya. suresh@college.edu','2003-07-25', 1, 2022),
( 'Rohan','Verma','rohan . verma@college.edu','2002-11-08', 2, 2021),
( 'Sneha','Patel','sneha.patel@college.edu','2004-01-30', 3, 2023),
('Vikram','Das','vikram.das@college.edu','2003-09-14', 1, 2022),
( 'Kavya','Menon','kavya.menon@college.edu','2002-05-17', 2, 2021),
( 'Aditya','singh','aditya. singh@college.edu','2004-03-22', 4, 2023),
('Deepika', 'Rao','deepika.rao@college.edu','2003-08-09', 1, 2022);
INSERT INTO courses (course_name, course_code, credits, department_id) VALUES
('Data Structures & Algorithms','CS101', 4, 1),
('Database Management Systems','CS102', 3, 1),
('Object Oriented Programming','CS103', 4, 1),
('circuit Theory','EC101', 3, 2),
('Thermodynamics','ME101', 3, 3);
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade) VALUES
(1, 1, '2022-07-01','A'), (1, 2, '2022-07-01', 'B'),
(2, 1, '2022-07-01','B'), (2, 3, '2022-07-01', 'A'),
(3, 4, '2021-07-01', 'A'), (4, 5, '2023-07-01', NULL),
(5, 1, '2022-07-01', 'C'), (5, 2, '2022-07-01', 'A'),
(6, 4,'2021-07-01','B'), (7, 5, '2023-07-01', NULL),
(8, 1,'2022-07-01','A'), (8, 3,'2022-07-01','B');
INSERT INTO professors (prof_name, email, department_id, salary) VALUES
('Dr. Anand Krishnan','anand. k@college.edu',1, 95000.00),
('Dr. Meena Pillai','meena. p@college.edu',1, 88000.00),
('Dr. Sunil Rajan','sunil. r@college.edu',2, 82000.00),
('Dr. Latha Gopal','latha. g@college.edu',3, 79000.00),
( 'Dr. Kartik Bose','kartik.b@college.edu',4, 76000.00);
-- ======================================================
-- Task 2: Verify Normalisation
-- ======================================================

-- 1NF (First Normal Form)
-- All tables satisfy 1NF because every column stores only
-- a single (atomic) value. There are no repeating groups
-- or multiple values in a single column.
--
-- Example violation:
-- If phone_number stored '9876543210,9123456789' in one field,
-- it would violate 1NF.

-- 2NF (Second Normal Form)
-- The schema satisfies 2NF because all non-key attributes
-- are fully dependent on their respective primary keys.
--
-- In the enrollments table, the candidate key
-- (student_id, course_id) uniquely identifies an enrollment.
-- The attributes enrollment_date and grade depend on the
-- complete enrollment and not on student_id or course_id alone.
-- Therefore, there are no partial dependencies.

-- 3NF (Third Normal Form)
-- The schema satisfies 3NF because there are no transitive
-- dependencies.
--
-- The students table stores only department_id, while
-- department details such as dept_name, hod_name and budget
-- are stored in the departments table.
--
-- If dept_name were stored in the students table,
-- it would create the transitive dependency:
--
-- student_id -> department_id -> dept_name
--
-- which would violate 3NF.

-- 3NF Analysis for Enrollments
-- The enrollments table satisfies 3NF because the non-key
-- attributes (enrollment_date and grade) depend directly on
-- the enrollment record. No non-key attribute depends on
-- another non-key attribute, so there are no transitive
-- dependencies.
-- ======================================================
-- Task 3: Alter and extend schema
-- ======================================================
ALTER TABLE students
ADD phone_number VARCHAR(15);
ALTER TABLE courses
ADD max_seats INT DEFAULT 60;
ALTER TABLE enrollments
ADD CONSTRAINT chk_grade
CHECK (grade IN ('A', 'B', 'C', 'D', 'F') OR grade IS NULL);
ALTER TABLE departments
CHANGE hod_name head_of_dept VARCHAR(100);
ALTER TABLE students
DROP COLUMN phone_number;





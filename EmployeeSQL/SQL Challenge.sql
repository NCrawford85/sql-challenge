DROP TABLE departments;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;

CREATE TABLE departments (
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR NOT NULL
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE salaries (
	emp_no INT   NOT NULL PRIMARY KEY,
    salary INT   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

CREATE TABLE titles (
    emp_no INT   NOT NULL,
    title VARCHAR   NOT NULL,
    from_date DATE   NOT NULL,
    to_date DATE   NOT NULL
);

SELECT * FROM employees
--Employee number, last name, first name, gender, salary
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, s.salary
FROM employees
JOIN salaries AS s
	ON employees.emp_no = s.emp_no;

--Eployees hired in 1986
SELECT employees.first_name, employees.last_name
FROM employees
WHERE hire_date between '1986-1-1' and '1986-12-31';

--Manager of each department with employee number, last name, first name and department name
SELECT d.dept_name, d.dept_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager dm
JOIN departments d
	on dm.dept_no = d.dept_no
JOIN employees as e
	on dm.emp_no = e.emp_no;
	
--Select Managers with employee number, first, last name, stard date, end date, & department name
SELECT dm.emp_no, e.last_name, e.first_name, de.from_date, de.to_date, d.dept_name
FROM employees e
JOIN dept_manager dm ON dm.emp_no = e.emp_no
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN departments d ON d.dept_no = de.dept_no

--Select all employees named Hercules with a last name that starts with B
SELECT first_name, last_name
FROM employees
WHERE 
	first_name LIKE 'Hercules'
AND
	last_name LIKE 'B%';

--List employees' department, eployee id, first, last name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales'

--List all employees' department, eployee id, first, last name for sales and development
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE dept_name in ('Sales','Development');

--List occurence of employee last names by most frequent descending
SELECT last_name, count(*)
FROM employees
Group By last_name
ORDER BY count DESC




	






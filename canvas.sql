

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

--NARROW THE SEARCH FOR RETIREMENT ELIGIBILITY
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');



SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--CREATE NEW TABLES
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

--JOIN TABLES:

DROP TABLE retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;


--USING INNER jOIN FROm DEPARTMENTS AND DEPT-MANAGER
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no=dm.dept_no;

--USE LEFT JOIN TO CAPT RETIREMENT INFO TABLE
--employye number, employee name, if the person is presently employed with ph

SELECT retirement_info.emp_no,
retirement_info.first_name,
retirement_info.last_name,
dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no=dept_emp.emp_no;

--USE ALIASES FOR CODE READABILITY

SELECT ri.emp_no,
ri.first_name,
ri.last_name,
de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no=de.emp_no;


--USE LEFT JOIN FOR RETIREMENT_INFO AND DEPT_EMP TABLES
SELECT ri.emp_no,
ri.first_name,
ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no=de.emp_no
WHERE de.to_date=('9999-01-01');

SELECT * FROM current_emp;

--USE COUNT,GROUP BY, AND ORDER BY
--needs a count of employees for each department
--Join current_emp and dept_emp tables
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no=de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--CREATE ADDITIONAL LISTS
--Employee Information: A list of employees containing their unique employee number, their last name, first name, gender, and salary
--Management: A list of managers for each department, including the department number, name, and the manager's employee number, last name, first name, and the starting and ending employment dates
--Department Retirees: An updated current_emp list that includes everything it currently has, but also the employee's departments

--1. EMPLOYEE INFO
SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no=s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no=de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date='9999-01-01');


--2. MANAGEMENT
--DEPARTMENTS (dept_name), MANAGERS (from_date,to_date), EMPLOYEES (first_name,last_name)


SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
--INTO manager_info
FROM dept_manager as dm
INNER JOIN departments as d
ON (dm.dept_no=d.dept_no)
INNER JOIN current_emp as ce
ON (dm.emp_no=ce.emp_no);


--DEPARTMENT RETIREES

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
--INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp as de
ON (ce.emp_no=de.emp_no)
INNER JOIN departments as d
ON (de.dept_no=d.dept_no);

--What's going on with the salaries?
--Why are there only five active managers for nine departments?
--Why are some employees appearing twice?
--Thats why we R goin to use TAYLORED LISTS:

--TAYLORED LISTS:
--create a query only return info to sales team of employee numbers,first_name,last_name and department name

--cretae a query of sales and develp team of employee numbers,first_name,last_name and department name











	




SELECT emp_no, first_name, last_name
FROM employees;

SELECT title, from_date, to_date
FROM titles;

SELECT e.emp_no, first_name, last_name, title, from_date, to_date
INTO employees_titles
FROM employees as e
JOIN titles as t ON e.emp_no = t.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-01-01'


DROP TABLE employees_titles;
SELECT * FROM employees_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,first_name,last_name,title
INTO unique_titles
FROM employees_titles
WHERE to_date='9999-01-01'
ORDER BY emp_no, to_date DESC;

DROP TABLE unique_titles;
SELECT * FROM unique_titles;



SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC

SELECT * FROM retiring_titles;



-- DELIVERABLE 2:

SELECT DISTINCT ON (emp_no) e.emp_no, first_name, last_name, 
birth_date, de.from_date, de.to_date, title
--INTO mentorship
FROM employees as e
JOIN dept_emp as de ON e.emp_no=de.emp_no
JOIN titles as t ON e.emp_no=t.emp_no
WHERE de.to_date='9999-01-01'
AND birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp_no










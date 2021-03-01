
CREATE TABLE employees(
	emp_no INT NOT NULL,
	emp_title_id VARCHAR(6) NOT NULL,
	birth_date VARCHAR(15) NOT NULL,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(2),
	hire_date DATE
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(5) NOT NULL,
	emp_no INT
);

CREATE TABLE salaries(
	emp_no INT NOT NULL,
	salary INT
);

CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR(6)
);

CREATE TABLE title_id(
	title_id VARCHAR(6),
	title VARCHAR(30)
);

CREATE TABLE departments(
	dept_no VARCHAR(6),
	dept_name VARCHAR(30)
);
CREATE VIEW departments_view AS
	SELECT * FROM departments;
CREATE VIEW dept_emp AS
	SELECT * FROM dept_emp;
CREATE VIEW deptmgt_view AS
	SELECT * FROM dept_manager;
CREATE VIEW employees_view AS
	SELECT * FROM employees;
CREATE VIEW salaries_view AS
	SELECT * FROM salaries;
CREATE VIEW titleid_view AS
	SELECT * FROM title_id;

DROP TABLE departments;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE title_id;

--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT em.emp_no,em.last_name,em.first_name,em.sex,salaries.salary
FROM employees AS em
JOIN salaries
ON (em.emp_no=salaries.emp_no);

CREATE VIEW emp_details AS
	SELECT em.emp_no,em.last_name,em.first_name,em.sex,salaries.salary
	FROM employees AS em
	JOIN salaries
	ON (em.emp_no=salaries.emp_no);

-- List first name, last name, and hire date for employees who were hired in 1986.

SELECT em.emp_no,em.last_name,em.hire_date
FROM employees AS em
WHERE EXTRACT(YEAR FROM em.hire_date) = 1986;

CREATE VIEW _1986_view AS
	SELECT em.emp_no,em.last_name,em.hire_date
	FROM employees AS em
	WHERE EXTRACT(YEAR FROM em.hire_date) = 1986;

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name.
SELECT mgt.dept_no, dept.dept_name,mgt.emp_no, emp.last_name, emp.first_name
FROM dept_manager AS mgt
JOIN departments AS dept
ON mgt.dept_no=dept.dept_no
JOIN employees AS emp
ON mgt.emp_no=emp.emp_no;

CREATE VIEW manager_info AS
	SELECT mgt.dept_no, dept.dept_name,mgt.emp_no, emp.last_name, emp.first_name
	FROM dept_manager AS mgt
	JOIN departments AS dept
	ON mgt.dept_no=dept.dept_no
	JOIN employees AS emp
	ON mgt.emp_no=emp.emp_no;

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp AS deptem
ON emp.emp_no=deptem.emp_no
JOIN departments AS dept
ON deptem.dept_no=dept.dept_no;

CREATE VIEW emp_dept AS
	SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
	FROM employees AS emp
	JOIN dept_emp AS deptem
	ON emp.emp_no=deptem.emp_no
	JOIN departments AS dept
	ON deptem.dept_no=dept.dept_no;

-- List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

CREATE VIEW Hercules AS
	SELECT first_name, last_name, sex
	FROM employees
	WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- List all employees in the Sales department, including their 
-- employee number, last name, first name, and department name.

SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp AS deptem
ON emp.emp_no=deptem.emp_no
JOIN departments AS dept
ON deptem.dept_no=dept.dept_no
WHERE dept.dept_name='Sales';

CREATE VIEW salesdept AS
	SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
	FROM employees AS emp
	JOIN dept_emp AS deptem
	ON emp.emp_no=deptem.emp_no
	JOIN departments AS dept
	ON deptem.dept_no=dept.dept_no
	WHERE dept.dept_name='Sales';

-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
FROM employees AS emp
JOIN dept_emp AS deptem
ON emp.emp_no=deptem.emp_no
JOIN departments AS dept
ON deptem.dept_no=dept.dept_no
WHERE dept.dept_name='Sales' OR dept.dept_name='Development';

CREATE VIEW salesAndDevelopmentDept
	SELECT emp.emp_no, emp.last_name, emp.first_name, dept.dept_name
	FROM employees AS emp
	JOIN dept_emp AS deptem
	ON emp.emp_no=deptem.emp_no
	JOIN departments AS dept
	ON deptem.dept_no=dept.dept_no
	WHERE dept.dept_name='Sales' OR dept.dept_name='Development';

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.

SELECT last_name, COUNT(*) AS num
FROM employees
GROUP BY last_name
ORDER BY num DESC;

CREATE VIEW descendingLast AS
	SELECT last_name, COUNT(*) AS num
	FROM employees
	GROUP BY last_name
	ORDER BY num DESC;
CREATE TABLE "employees" (
    "emp_no" varchar   NOT NULL Primary Key,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL);

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL Primary Key,
    "dept_name" VARCHAR   NOT NULL);

CREATE TABLE "dept_manager" (
    "dept_no" Varchar   NOT NULL, FOREIGN KEY("dept_no") REFERENCES "departments" ("dept_no"),
    "emp_no" varchar   NOT NULL, FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL);

CREATE TABLE "dept_emp" (
    "emp_no" varchar   NOT NULL, FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
    "dept_no" VARCHAR   NOT NULL, FOREIGN KEY("dept_no") REFERENCES "departments" ("dept_no"),
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL);


CREATE TABLE "salaries" (
    "emp_no" varchar   NOT NULL, FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
    "salary" varchar   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL);

CREATE TABLE "titles" (
    "emp_no" varchar   NOT NULL, FOREIGN KEY("emp_no") REFERENCES "employees" ("emp_no"),
    "title" VARCHAR   NOT NULL,
    "from_date" VARCHAR   NOT NULL,
    "to_date" VARCHAR   NOT NULL);

CREATE TABLE employee_data AS
	(SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
	 FROM employees as e
	 INNER JOIN salaries as s
	 ON e.emp_no = s.emp_no);

CREATE TABLE employees_1986 AS
(select e.first_name, e.last_name, e.hire_date
FROM employees as e
WHERE e.hire_date LIKE '1986%');

Create table manager_info as(
SELECT m.dept_no, m.emp_no, m.from_date, m.to_date, d.dept_name, e.first_name, e.last_name
FROM dept_manager AS m
INNER JOIN departments AS d ON
m.dept_no=d.dept_no
inner join employees as e
on m.emp_no= e.emp_no);

select * from manager_info

--misspelled employee sue me
Create table empoloyee_dept as(
SELECT t.dept_no, d.dept_name, e.first_name, e.last_name
FROM dept_emp AS t
INNER JOIN departments AS d ON
t.dept_no=d.dept_no
inner join employees as e
on t.emp_no= e.emp_no);

create table hercules as(
select e.first_name, e.last_name 
from employees as e
where e.first_name = 'Hercules' and e.last_name like 'B%');

create table sales as(
select e.emp_no, e.first_name, e.last_name, t.dept_no, d.dept_name
from employees as e
inner join dept_emp as t 
on e.emp_no = t.emp_no
inner join departments as d
on d.dept_no = t.dept_no);

create table sales_dept as(
select first_name, last_name, emp_no, dept_no, dept_name
from sales where dept_name = 'Sales')
select * from sales_dept

create table sales_and_dev as(
select first_name, last_name, emp_no, dept_no, dept_name
from sales where dept_name = 'Sales' or dept_name = 'Development');
select * from sales_and_dev

CREATE TABLE namecount as (
select e.last_name, count(e.last_name) as Count
from employees as e
group by e.last_name
order by Count DESC);
select * from namecount

select first_name, last_name from employees 
where emp_no = '499942'
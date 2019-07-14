-- Data Analysis
-- List the following details of each employee: employee number, last name, first name, gender, and salary.
	-- Create an intermediate view to find the latest salary for every employee, since an employee can have multiple
	-- salaries
	create view latest_salary as (
	select s.emp_no, s.salary, max(s.to_date) as latest_to_date
	from salaries s
	group by s.emp_no, s.salary)

	select e.emp_no, e.last_name, e.first_name, e.gender, ls.salary
	from employees e
	left join latest_salary ls
	on e.emp_no = ls.emp_no
	
-- List employees who were hired in 1986.
	select e.emp_no, e.last_name, e.first_name
	from employees e
	where extract(year from e.hire_date) = '1986';
	

-- List the manager of each department with the following information: department number, department name, 
-- the manager's employee number, last name, first name, and start and end employment dates.

 select d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, max(dm.from_date) as from_date, 
 	max(dm.to_date) as to_date
 from departments d
	 left join dept_manager dm
	 on d.dept_no = dm.dept_no
	 left join employees e
	 on dm.emp_no = e.emp_no
 
 where extract(year from dm.to_date)= '9999'
  group by d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name;

-- List the department of each employee with the following information: employee number, last name, 
-- first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from employees e
left join dept_emp de 
	on e.emp_no = de.emp_no
left join departments d
	on d.dept_no = de.dept_no
where extract(year from de.to_date)= '9999';


-- List all employees whose first name is "Hercules" and last names begin with "B."
select * from employees e
where e.first_name = 'Hercules'
and upper(substring(e.last_name from 1 for 1)) = 'B'

-- List all employees in the Sales department, including their employee number, last name, first name, 
-- and department name.

select e.emp_no, e.first_name, e.last_name, d.dept_name 
from employees e
left join dept_emp de 
	on e.emp_no = de.emp_no
left join departments d
	on d.dept_no = de.dept_no
where d.dept_name = 'Sales'
and extract(year from de.to_date)= '9999';

-- List all employees in the Sales and Development departments, including their employee number, last name, 
-- first name, and department name.
select e.emp_no, e.first_name, e.last_name, d.dept_name 
from employees e
left join dept_emp de 
	on e.emp_no = de.emp_no
left join departments d
	on d.dept_no = de.dept_no
where (d.dept_name = 'Sales' or d.dept_name = 'Development') 
and extract(year from de.to_date)= '9999';

-- In descending order, list the frequency count of employee last names, i.e., how many employees share each 
-- last name.

select e.last_name, count(e.emp_no) as frequency
from employees e
group by e.last_name
order by frequency desc;



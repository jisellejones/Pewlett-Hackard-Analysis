-- ---- Code for Deliverable 1 ----

-- Create a table to show all employees within retirement age and their titles
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;


-- Create a table from retirement_titles table that filters for most recent title
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

-- Create a table containing counts of all the retirees by title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- ---- Code for deliverable 2 ----

-- Create a Mentorship Eligibility table that holds the employees are eligible for a mentorship program (born in 1965).
SELECT DISTINCT ON (e.emp_no)
		e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		ti.title
INTO mentorship_eligibilty
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS ti
		ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC, ti.from_date DESC;


-- ---- Code for Last bullet results section ----

-- Create a table to find the count of employees by title who were born in 1965.
SELECT COUNT (title), title
INTO count_ment_elg
FROM mentorship_eligibilty
GROUP BY title
ORDER BY count DESC;

-- ---- Code for Summary Section ----

-- Create table to find all employees not nearing retirement age named "emp_not_retiring"
SELECT DISTINCT ON (e.emp_no)
		e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		ti.title
INTO emp_not_retiring
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
	INNER JOIN titles AS ti
		ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
	AND NOT(e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC, ti.from_date DESC;

-- Create a table from emplyees_not_retirement table that filters for most recent title
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles_not_retiring
FROM emp_not_retiring
ORDER BY emp_no ASC, to_date DESC;

-- Create a table that counts the number of non-retiring employees in current positions
SELECT COUNT(title), title
Into titles_count_emp_not_retiring
FROM unique_titles_not_retiring
GROUP BY title
ORDER BY count DESC;
# S06-L02 Row number

See salary of an employee with employee ID = 10004.

```sql
SELECT
	id,
	employee_id,
	salary_amount,
	from_date,
	to_date
FROM salary
WHERE employee_id = 10004
;
```

```sql
SET @row_number = 0;
SET @dummy_salary_amount = 0;
SET @dummy_employee_id = 0;

SELECT
	id,
	employee_id,
	salary_amount,
	from_date,
	to_date,
	IF(salary_amount < @dummy_salary_amount AND @dummy_salary_amount != 0, 'lower than last', 'higher') AS comparison,
	@row_number := IF(employee_id != @dummy_employee_id, 1, @row_number + 1) AS '@row_number',
	@dummy_salary_amount := salary_amount AS '@dummy_salary_amount',
	@dummy_employee_id := employee_id AS '@dummy_employee_id'
FROM (
	SELECT
		id,
		employee_id,
		salary_amount,
		from_date,
		to_date
	FROM salary
	WHERE salary.employee_id = 10004
	ORDER BY salary.from_date ASC
) xTMP
```

Now identify average months when the salary decreases (for this particular employee).

```sql
SET @row_number = 0;
SET @dummy_salary_amount = 0;
SET @dummy_employee_id = 0;

SELECT
	employee_id,
	ROUND(AVG(`@row_number`), 1) AS average_month_when_salary_decreases
FROM (
	SELECT
		id,
		employee_id,
		salary_amount,
		from_date,
		to_date,
		IF(salary_amount < @dummy_salary_amount AND @dummy_salary_amount != 0, 'lower than last', 'higher') AS comparison,
		@row_number := IF(employee_id != @dummy_employee_id, 1, @row_number + 1) AS '@row_number',
		@dummy_salary_amount := salary_amount AS '@dummy_salary_amount',
		@dummy_employee_id := employee_id AS '@dummy_employee_id'
	FROM (
		SELECT
			id,
			employee_id,
			salary_amount,
			from_date,
			to_date
		FROM salary
		WHERE salary.employee_id = 10004
		ORDER BY salary.from_date ASC
	) xTMP
) xTMP2
WHERE 1=1
	AND comparison = 'lower than last'
GROUP BY
	employee_id
```


// TODO
Use tinyint_asc to do a query like https://www.dropbox.com/s/z7cx1q40y8l1vjt/Screenshot%202016-05-16%2006.36.11.png?dl=0

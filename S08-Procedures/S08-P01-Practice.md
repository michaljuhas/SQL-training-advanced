# S08-P01 Practice

## Assignment

First, create a new view `v_average_salary` which will return average salary per month/year per department. The view should have the following columns:

* `department_id`
* `department_name`
* `average_salary_amount`
* `month_year` (i.e. '02/1985')

Then create a procedure `GET_DEPARTMENT_AVERAGE_SALARY` with a similar query inside as the view, but in addition also having an input attribute `in_department_id` to restrict the query for a selected department.

You will be able to fetch average salary for a specific department in 2 ways:

1. View: `SELECT * FROM v_average_salary WHERE department_id = 2;`
2. Procedure: `SELECT * FROM GET_DEPARTMENT_AVERAGE_SALARY(2);`

Your assignment:

* Try both approaches (create a view & procedure)
* Compare execution plan
* Compare time needed to perform both queries
* Identify which one is faster (and why?)

## Guidelines

```sql
SELECT /* Select average salary per department */
	`department`.`id` AS department_id,
  `department`.`name` AS department_name,
  ROUND(AVG(`salary_amount`), 2) AS average_salary_amount,
	CONCAT(LPAD(MONTH(invoice.invoiced_date), 2, '0'), '/', YEAR(invoice.invoiced_date)) AS month_year
FROM `sample_staff`.`invoice`
INNER JOIN `department_employee_rel` ON 1=1

  /* Uncomment in a procedure, keep commented in a view */
--  AND `department_employee_rel`.`department_id` = in_department_id

  AND `department_employee_rel`.`employee_id` = invoice.employee_id
	AND `invoice`.`invoiced_date` BETWEEN `department_employee_rel`.`from_date` AND IFNULL(`department_employee_rel`.`to_date`, '2002-08-01')
INNER JOIN `department` ON 1=1
  AND `department`.`id` = `department_employee_rel`.`department_id`
INNER JOIN `salary` ON 1=1
  AND `salary`.`employee_id` = `invoice`.`employee_id`
  AND `invoice`.`invoiced_date` BETWEEN `salary`.`from_date` AND IFNULL(`salary`.`to_date`, '2002-08-01')
WHERE 1=1
GROUP BY
	`department`.`id`,
  `department`.`name`,
	CONCAT(LPAD(MONTH(invoice.invoiced_date), 2, '0'), '/', YEAR(invoice.invoiced_date))
```

```sql
EXPLAIN SELECT * FROM v_average_salary WHERE department_id = 2;
```

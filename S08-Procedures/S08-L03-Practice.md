# S05-L03 Practice

## Assignment

Create a new view `v_average_salary` which will return average salary per month/year per department. The view should have the following columns:

* `department_id`
* `department_name`
* `average_salary_amount`
* `month_year` (i.e. '02/1985')

There are (at least) 2 ways to create & query the view:

1. `SELECT * FROM v_average_salary WHERE department_id = 2;`
2. `SET @department_id = 2; SELECT * FROM v_average_salary;`

Your assignment:

* try both approaches
* compare execution plan
* compare time needed to perform both queries
* identify which one is faster (and why?)

## Guidelines

```sql
SELECT /* Select average salary per department */
	`department`.`id` AS department_id,
  `department`.`name` AS department_name,
  ROUND(AVG(`salary_amount`), 2) AS average_salary_amount,
	CONCAT(LPAD(MONTH(invoice.invoiced_date), 2, '0'), '/', YEAR(invoice.invoiced_date)) AS month_year
FROM `sample_staff`.`invoice`
INNER JOIN `department_employee_rel` ON 1=1

  /* Either comment or uncomment the following line - based on the option listed above */
--  AND `department_employee_rel`.`department_id` = @department_id

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

`EXPLAIN SELECT * FROM v_average_salary WHERE department_id = 2;`
http://snpy.in/eOpW5r


http://snpy.in/UPhmX3

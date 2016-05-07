# S05-L03 Practice

## Assignment

Create a query to return average salary on `2000-01-01` per department and indication if it's above or below company average at the same date. The result structure should be:

* `year_month` (focus only on `2000-01-01`)
* `department_id`
* `department_name`
* `department_average_salary`
* `company_average_salary`
* `department_vs_company` (values: "lower" or "higher" or "same")

Store the company average in a session variable for easier & faster comparison.

## Guidelines

```sql
SET @focus_date = '2000-01-01';

SET @company_average_salary := (
  SELECT
    ROUND(AVG(`salary`.`salary_amount`), 2) AS company_average_salary
  FROM `sample_staff`.`salary`
  WHERE 1=1
    AND @focus_date BETWEEN `salary`.`from_date` AND IFNULL(`salary`.`to_date`, '2002-08-01')
);

SELECT
	`department_id` AS department_id,
	`department_name` AS department_name,
	`department_average_salary` AS department_average_salary,
	@company_average_salary AS company_average_salary,
	CASE
		WHEN `department_average_salary` > @company_average_salary THEN "higher"
		WHEN `department_average_salary` = @company_average_salary THEN "same"
		ELSE "lower"
	END AS department_vs_company
FROM (
SELECT
	`department`.`id` AS department_id,
	`department`.`name` AS department_name,
	AVG(`salary`.`salary_amount`) AS department_average_salary
FROM `sample_staff`.`salary`
INNER JOIN `sample_staff`.`department_employee_rel` ON 1=1
	AND `department_employee_rel`.`employee_id` = `salary`.`employee_id`
	AND @focus_date BETWEEN `department_employee_rel`.`from_date` AND IFNULL(`department_employee_rel`.`to_date`, '2002-08-01')
INNER JOIN `sample_staff`.`department` ON 1=1
	AND `department`.`id` = `department_employee_rel`.`department_id`
WHERE 1=1
	AND @focus_date BETWEEN `salary`.`from_date` AND IFNULL(`salary`.`to_date`, '2002-08-01')
GROUP BY
	`department`.`id`,
	`department`.`name`
) xTMP
```

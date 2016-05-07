# S05-L02 Session variable

```sql
SET @var2 = 10;
SELECT @var2 := @var2 + 2;
```

```sql
SELECT @var3 := @var3 + 2;
```

```sql
SELECT
	`date`.`date`,
	@day_of_week := DAYOFWEEK(date.date) AS day_of_week,
	CASE
		WHEN @day_of_week = 2 THEN "Thanks God It's Monday!"
		ELSE "Good morning"
	END AS welcome_message,
	CASE
		WHEN @day_of_week = 6 THEN "Have a great weekend!"
		ELSE "Good bye"
	END AS good_bye_message
FROM `sample_staff`.`date`
WHERE 1=1
	AND `date`.`date` BETWEEN '2016-01-01' AND '2016-01-07'
```

Variable used in `WHERE` condition:

```sql
SET @employee_id = 10001;

SELECT
  `salary`.`id`,
  `salary`.`employee_id`,
  `salary`.`salary_amount`
FROM `sample_staff`.`salary`
WHERE 1=1
  AND `salary`.`employee_id` = @employee_id
;
```

Create a dynamic `SELECT` query using multiple session variables.

```sql
-- Define the variables
SET @employee_id = 10001;
SET @columns = "employee_id, salary_amount";
SET @table_name = "salary";

-- Compose the query
SET @select_query = CONCAT("SELECT id, ", @columns, " FROM ", @table_name, " WHERE employee_id = ", @employee_id);

-- Prepare & execute
PREPARE stmt FROM @select_query;
EXECUTE stmt;
```

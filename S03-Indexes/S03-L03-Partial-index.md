# S03-L03 Partial indexes

Check `salary` table - it doesn't have a single index on `employee_id`.

But there's a composite index on multiple attributes:

* `employee_id`
* `from_date`
* `to_date`

```sql
SELECT * /* Ignore index - 2-3 seconds */
FROM `salary` IGNORE INDEX (`ak_salary`)
WHERE 1=1
	AND `salary`.`employee_id` = 499998
;

SELECT * /* Use index - very fast */
FROM `salary` USE INDEX (`ak_salary`)
WHERE 1=1
	AND `salary`.`employee_id` = 499998
;
```
You can also create a new index `idx_employee_id`, but not needed thanks to the composite `ak_salary`.

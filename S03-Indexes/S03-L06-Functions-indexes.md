# S03-L06 Functions on indexed columns

```sql
SELECT *
FROM `employee` /* USE INDEX (`ak_employee`) */
WHERE 1=1
	AND 'ff-975616' = lower(`employee`.`personal_code`)
;

EXPLAIN SELECT *
FROM `employee`
WHERE 1=1
	AND 'ff-975616' = lower(`employee`.`personal_code`)
;
```

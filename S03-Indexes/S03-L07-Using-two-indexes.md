# S03-L07 Using two indexes

```sql
SELECT
	employee.id,
	employee.personal_code
FROM employee
WHERE (
		employee.personal_code = '7C-91159'
		OR
    id BETWEEN 12340 AND 12400
	)
;
```

`EXPLAIN SELECT` shows that the engine chose `UNION`.

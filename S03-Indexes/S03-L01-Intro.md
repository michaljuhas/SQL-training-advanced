# S03-L01 Indexes and why to use them?

```sql
-- Drop the index, if exists in the table
ALTER TABLE `salary` DROP INDEX `idx_salary_amount`;

-- Select without an index takes 2-3 seconds
SELECT
	*
FROM salary
WHERE 1=1
	AND salary_amount > 190000
	AND from_date >= '1998-01-01'
LIMIT 100
;

-- Explain select (Add "EXPLAIN" before the query)
EXPLAIN SELECT
	*
FROM salary
WHERE 1=1
	AND salary_amount > 190000
	AND from_date >= '1998-01-01'
LIMIT 100
;

-- Add a new index
ALTER TABLE `salary` ADD INDEX `idx_salary_amount` (`salary_amount`);
```

Try to run the select query again - should be executed without a few miliseconds.

# S03-L08 Practice

## Assignment

These queries run slower than 100ms. How would you make them run in less than 10ms?

Verify the execution plan.

```sql
SELECT `contract`.`archive_code`
FROM `contract`
WHERE 1=1
	AND `contract`.`archive_code` = 'DA970'
	AND `contract`.`deleted_flag` = 0
	AND `contract`.`sign_date` >= '1990-01-01'
;

SELECT `contract`.`archive_code`
FROM `contract`
WHERE 1=1
	AND `contract`.`archive_code` = 'DA970'
	AND `contract`.`deleted_flag` = 0
;
```

## Guide

Add one index only. It should be used in both queries.

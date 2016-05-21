# S03-L02 Practice

## Assignment

These queries run longer than 100ms. How would you make them run in less than 10ms?

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

...

...

...

SPOILER: Below are the results

...

...

## Result

Add one index only. It should be used in both queries.

ALTER TABLE `contract` ADD INDEX `idx_archive_code_sign_date` (`archive_code`, `sign_date`);

When running the following `EXPLAIN SELECT` you should see that the key used is `idx_archive_code_sign_date`.

```sql
EXPLAIN SELECT `contract`.`archive_code`
FROM `contract`
WHERE 1=1
	AND `contract`.`archive_code` = 'DA970'
	AND `contract`.`deleted_flag` = 0
;
```

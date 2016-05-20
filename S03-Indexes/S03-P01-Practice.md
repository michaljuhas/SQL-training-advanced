# S03-P01 Practice

## Assignment

Create a new partial index on `sample_staff`.`employee`.`personal_code` with the first 2 characters only.

Select an employee with `personal_code` = `AA-751492` and check in execution plan which index was used. Try to use another index to verify the select would be slower or faster.

Finally, compare the size of the 2 indexes:

* The original `ak_employee` index
* Your newly created index

## Guide

```sql
-- It's good to run ANALYZE TABLE before checking index or table size
ANALYZE TABLE `sample_staff`.`employee`;

SELECT /* Select all indexes from table 'employee' and their size */
  sum(`stat_value`) AS pages,
  `index_name` AS index_name,
  sum(`stat_value`) * @@innodb_page_size / 1024 / 1024 AS size_mb
FROM `mysql`.`innodb_index_stats`
WHERE 1=1
  AND `table_name` = 'employee'
  AND `database_name` = 'sample_staff'
  AND `stat_description` = 'Number of pages in the index'
GROUP BY
 `index_name`
;
```

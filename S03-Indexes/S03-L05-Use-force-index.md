# S03-L04 Use & force index

* `USE INDEX`
* `FORCE INDEX`
* `IGNORE INDEX`

See table `salary`

```sql
EXPLAIN SELECT * /* Check the salary of employee with ID = 499998 */
FROM `sample_staff`.`salary` IGNORE INDEX (`ak_salary`) IGNORE INDEX (`idx_employee_id`)
WHERE 1=1
	AND `salary`.`employee_id` = 499997
	AND `salary`.`from_date` = '1993-12-27'
	AND `salary`.`to_date` = '1994-12-27'
;

-- Add a new index
ALTER TABLE `salary` ADD INDEX `idx_employee_id` (`employee_id`);

EXPLAIN SELECT * /* Check the salary of employee with ID = 499998 */
FROM `sample_staff`.`salary` USE INDEX (`ak_salary`)
WHERE 1=1
	AND `salary`.`employee_id` = 499998
	AND `salary`.`from_date` = '1993-12-27'
	AND `salary`.`to_date` = '1994-12-27'
;

EXPLAIN SELECT * /* Check the salary of employee with ID = 499998 */
FROM `sample_staff`.`salary` USE INDEX (`idx_employee_id`)
WHERE 1=1
	AND `salary`.`employee_id` = 499997
	AND `salary`.`from_date` = '1993-12-27'
	AND `salary`.`to_date` = '1994-12-27'
;
```

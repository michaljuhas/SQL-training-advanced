# S04-P03 Practice

## Assignment

Create a new table `sample_staff`.`invoice_partitioned` based on `sample_staff`.`invoice`, but change the following:

* and add one more column: `department_code`
* remove the current partitions & sub-partitions

Then, copy data from `invoice` to the new table and also fill in the new column based on the department which the user was a part at the time of `invoiced_date`.

Add new `LIST` partitioning to `invoice` based on the `department_code` (see `sample_staff`.`department`.`code`).

...

...

...

SPOILER: Below are the results

...

...

## Result


Hint: To get the department join `invoice` with `device_employee_rel`, see below:

```sql
INNER JOIN `sample_staff`.`department_employee_rel` ON 1=1
  AND `invoice`.`employee_id` = `department_employee_rel`.`employee_id`
  AND `invoice`.`invoiced_date` BETWEEN `device_employee_rel`.`from_date` AND IFNULL(`department_employee_rel`.`to_date`, '2002-08-01')
  AND `department_employee_rel`.`deleted_flag` = 0
INNER JOIN `sample_staff`.`department` ON 1=1
  `department`.`id` = `department_employee_rel`.`department_id`
```

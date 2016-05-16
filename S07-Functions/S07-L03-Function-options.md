# S07-L03 Function options

## `DETERMINISTIC` or not?

A routine is considered “deterministic” if it always produces the same result for the same input parameters, and “not deterministic” otherwise. If neither `DETERMINISTIC` nor `NOT DETERMINISTIC` is given in the routine definition, the default is `NOT DETERMINISTIC`. To declare that a function is deterministic, you must specify `DETERMINISTIC` explicitly.

A routine that contains the `NOW()` function (or its synonyms) or `RAND()` is nondeterministic.

## SQL usage indication

* `CONTAINS SQL` indicates that the routine does not contain statements that read or write data. This is the default if none of these characteristics is given explicitly. Examples of such statements are SET @x = 1 or DO RELEASE_LOCK('abc'), which execute but neither read nor write data.
* `NO SQL` indicates that the routine contains no SQL statements.
* `READS SQL DATA` indicates that the routine contains statements that read data (for example, `SELECT`), but not statements that write data.
* `MODIFIES SQL DATA` indicates that the routine contains statements that may write data (for example, `INSERT` or `DELETE`).

## `SQL SECURITY`

The `SQL SECURITY` characteristic can be `DEFINER` or `INVOKER` to specify the security context; that is, whether the routine executes using the privileges of the account named in the routine `DEFINER` clause or the user who invokes it. This account must have permission to access the database with which the routine is associated. The default value is `DEFINER`. The user who invokes the routine must have the `EXECUTE` privilege for it, as must the `DEFINER` account if the routine executes in definer security context.

`DEFINER = 'user_name'@'host_name'`


```sql
DROP PROCEDURE IF EXISTS `SEL_EMPLOYEE_COUNT`;

DELIMITER //

CREATE DEFINER=`staff`@`%` PROCEDURE `SEL_EMPLOYEE_COUNT`()
SQL SECURITY INVOKER
BEGIN
  SELECT COUNT(*) FROM `sample_staff`.`employee`;
END;
//

DELIMITER ;

-- Call the new procedure
CALL SEL_EMPLOYEE_COUNT();
```

Error: `The user specified as a definer ('staff'@'%') does not exist`

Create the missing user: `CREATE USER 'staff' IDENTIFIED BY 'ASD1n232';`

Error: `execute command denied to user 'staff'@'%' for routine 'sample_staff.SEL_EMPLOYEE_COUNT'`

Grant access: `GRANT EXECUTE ON sample_staff.* to 'staff'@'%';`

Error: `SELECT command denied to user 'staff'@'%' for table 'employee'`

Grant access: `GRANT SELECT ON sample_staff.employee to 'staff'@'%';`

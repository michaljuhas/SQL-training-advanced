# S05-L01 Variables

Types of variables:

* **Global** - server system variables `@@version`
* **Session** - user-defined variables `@var`
* **Local** - declared in a function or procedure `DECLARE var2 INT`;

## Global
```sql
-- Select a version on MySQL
SELECT @@version;
```

## Session

```sql
-- Select a user-defined variable
SET @var = 1;
SELECT @var;
```

## Local in a procedure

```sql
-- Define a variable inside a stored procedure
DROP PROCEDURE IF EXISTS `sample_staff`.`prc_test`;

DELIMITER //

CREATE PROCEDURE `sample_staff`.`prc_test` (
  in_var INT
)
BEGIN
    DECLARE p_var INT;
    SET p_var = 1;
    SELECT in_var + p_var;
END;
//

DELIMITER ;

-- Call the stored procedure
CALL prc_test(4);
```

# How to write procedures?

## Save user's login with `INS_USER_LOGIN`

```sql
DROP PROCEDURE IF EXISTS `INS_USER_LOGIN`;

DELIMITER //

CREATE PROCEDURE `INS_USER_LOGIN`(
	in_user_id INT(11),
	in_ip_address VARCHAR(20)
)
BEGIN
  INSERT INTO `sample_staff`.`user_login`
    (`user_id`, `login_dt`, `ip_address`, `insert_dt`, `insert_process_code`)
  VALUES
    (in_user_id, NOW(), INET_ATON(in_ip_address), NOW(), 'INS_USER_LOGIN');
END;
//

DELIMITER ;

-- Call the new procedure
CALL INS_USER_LOGIN(1, '32.12.45.193');
```

## Select user's last login with `SEL_USER_LOGIN`

```sql
DROP PROCEDURE IF EXISTS `SEL_USER_LOGIN`;

DELIMITER //

CREATE PROCEDURE `SEL_USER_LOGIN`(
	in_user_id INT(11)
)
BEGIN
  SELECT
    `user_login`.`id` AS `user_login_id`,
    `user_login`.`user_id`,
    `user`.`name` AS `user_name`,
    INET_NTOA(`user_login`.`ip_address`) AS `ip_address`,
    `user_login`.`login_dt`
  FROM `sample_staff`.`user_login`
  INNER JOIN `sample_staff`.`user` ON 1=1
    AND `user`.`id` = `user_login`.`user_id`
  WHERE 1=1
    AND `user_login`.`deleted_flag` = 0
    AND `user_login`.`user_id` = `in_user_id`
  ORDER BY
    `user_login`.`id` DESC
  LIMIT 1;

END;
//

DELIMITER ;

-- Call the new procedure
CALL SEL_USER_LOGIN(1);
```

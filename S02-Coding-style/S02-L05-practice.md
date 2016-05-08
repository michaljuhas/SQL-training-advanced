# Practice

## Assignment

Create a view `v_user_login` which will select user's recent logins.

## Guide

```sql
CREATE OR REPLACE VIEW `sample_staff`.`v_user_login` AS
  SELECT
    `user_login`.`id` AS `user_login_id`,
    `user_login`.`user_id`,
    `user`.`name` AS `user_name`,
    `user_login`.`ip_address` AS `ip_address_integer`,
    INET_NTOA(`user_login`.`ip_address`) AS `ip_address`,
    `user_login`.`login_dt`
  FROM `sample_staff`.`user_login`
  INNER JOIN `sample_staff`.`user` ON 1=1
    AND `user`.`id` = `user_login`.`user_id`
  WHERE 1=1
    AND `user_login`.`deleted_flag` = 0
  ORDER BY
    `user_login`.`id` DESC
  -- LIMIT shouldn't be here, because the user_id restriction will be
  -- outside of this view
  ;
```

```sql
SELECT * FROM `v_user_login`
WHERE `v_user_login`.`user_id` = 1
LIMIT 1;
```

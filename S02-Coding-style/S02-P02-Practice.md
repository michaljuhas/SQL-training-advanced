# S02-P02 Practice

## Assignment

Create a new view `v_user_login` which will select user's recent logins. Attributes to select:

* `user_login`.`id`
* `user_login`.`user_id`
* `user`.`name`
* `user_login`.`ip_address`
* `user_login`.`ip_address` `/* show in a standard notation xxx.xxx.xxx.xxx */ `
* `user_login`.`login_dt`

...

...

...

SPOILER: Below are the results

...

...

## Result

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

You can query data this way:

```sql
SELECT * FROM `v_user_login`
WHERE `v_user_login`.`user_id` = 1
LIMIT 1;
```

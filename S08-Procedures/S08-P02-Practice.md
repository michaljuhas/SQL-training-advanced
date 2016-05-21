# S08-P02 Practice

## Assignment

There is a stored function `INS_USER_LOGIN_DATA_GENERATOR` which simulates users logging to your website or mobile app and writing data to `sample_staff`.`user_login`. Your assignment will be to:

1. Create a new event in MySQL Event Scheduler which will run the procedure `INS_USER_LOGIN_DATA_GENERATOR` every 30 seconds
2. Create a new procedure which will delete from `sample_staff`.`user_login` data older than 10 minutes, but will keep the new data (newer than 10 minutes)

### Hints

```sql
-- Check if the Event Scheduler is turned ON
SHOW VARIABLES LIKE 'event_scheduler';

-- If the variable event_scheduler=OFF, you need to activate it
SET GLOBAL event_scheduler = 1;
```

### Procedure to randomly generate user login data

There should be a stored function `INS_USER_LOGIN_DATA_GENERATOR` saved in `sample_staff` database. If it's not, please run the script below to re-create it.

```sql
DROP PROCEDURE IF EXISTS `INS_USER_LOGIN_DATA_GENERATOR`;

DELIMITER //

CREATE PROCEDURE `INS_USER_LOGIN_DATA_GENERATOR`()
BEGIN
	DECLARE p_ip_address VARCHAR(20);
	DECLARE p_user_id INT;
	DECLARE p_loop_counter INT DEFAULT 10;

	WHILE p_loop_counter > 0 DO

	  INSERT INTO `sample_staff`.`user_login`
	    (`user_id`, `login_dt`, `ip_address`, `insert_dt`, `insert_process_code`)
	  SELECT
	  	`user`.`id` AS user_id,
	  	NOW() AS login_dt,
	  	INET_ATON(`ip_address_varchar20`.`ip_address`) AS ip_address,
	  	NOW(),
	  	'INS_USER_LOGIN_DATA_GENERATOR' AS insert_process_code
	  FROM `sample_staff`.`user`
	  INNER JOIN `sample_ip`.`ip_address_varchar20` ON 1=1
	  	AND `sample_ip`.`ip_address_varchar20`.`id` < 100
	  ORDER BY RAND()
	  LIMIT 1000
	  ;

		SET p_loop_counter = p_loop_counter - 1;
	END WHILE;

END;
//

DELIMITER ;

CALL `INS_USER_LOGIN_DATA_GENERATOR`();
```

...

...

...

SPOILER: Below are the results

...

...

## Result


```sql
DROP EVENT IF EXISTS `sample_staff`.`ev_generate_login_data`;

CREATE EVENT `sample_staff`.`ev_generate_login_data`
	ON SCHEDULE EVERY 30 SECOND
 	STARTS NOW()
  ENDS NOW() + INTERVAL 1 HOUR
  COMMENT 'Randomly generate data to sample_staff.user_login table.'
	DO CALL `INS_USER_LOGIN_DATA_GENERATOR`()
;
```

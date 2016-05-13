# S09-L02 Cursors

```sql
DROP PROCEDURE IF EXISTS `SAVE_ALL_USER_LOGIN_STAT`;

DELIMITER //

CREATE PROCEDURE `SAVE_ALL_USER_LOGIN_STAT`()
BEGIN
	DECLARE no_more_rows BOOLEAN;
	DECLARE user_id INT DEFAULT 0;

	DECLARE cursor_users CURSOR FOR
		SELECT `user`.`id` AS user_id
		FROM `sample_staff`.`user`
		WHERE 1=1
			AND user.deleted_flag = 0
		;

	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET no_more_rows = TRUE;

	OPEN cursor_users;

	loop_users: LOOP
		FETCH cursor_users INTO user_id;

		IF no_more_rows THEN
			LEAVE loop_users;
		END IF;

		CALL INS_USER_STAT(user_id);

	END LOOP loop_users;

	CLOSE cursor_users;
	
END//

DELIMITER ;
```

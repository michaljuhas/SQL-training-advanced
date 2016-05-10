# S09-L01 Cursors


```sql
DROP PROCEDURE IF EXISTS `GET_DATE_LIST`;

DELIMITER //

CREATE PROCEDURE `GET_DATE_LIST`(
  INOUT dates_list VARCHAR(10000)
)
BEGIN
	DECLARE no_more_rows BOOLEAN;
	DECLARE v_date DATE;

  -- Declare a new cursor for the dates
	DECLARE cursor_dates CURSOR FOR
		SELECT `date`
    FROM `sample_staff`.`date`
    LIMIT 100;

  -- Declare NOT FOUND handler
	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET no_more_rows = TRUE;

  -- Now open the cursor
	OPEN cursor_dates;

  -- Start the loop cycle
	loop_users: LOOP

    -- Fetch the next row from the cursor
		FETCH cursor_dates INTO v_date;

    -- If there are no more rows, then leave the loop cycle
		IF no_more_rows THEN
			LEAVE loop_users;
		END IF;

    -- Create the list
		SET dates_list = CONCAT(v_date, ' - ', dates_list);

	END LOOP loop_users;

  -- Close cursor when done
  CLOSE cursor_dates;
END//

DELIMITER ;
```

```sql
SET @dates_list = "";
CALL GET_DATE_LIST(@dates_list);
SELECT @dates_list;
```

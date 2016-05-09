# S09-L02 Cursors

TODO
TODO
TODO





```sql
DELIMITER ;;
CREATE DEFINER=`hqlive`@`%` PROCEDURE `reload_country_offers`(
	in_country_id INT(11),
	in_checkin_date DATE,
	in_checkout_date DATE,
	in_process_id CHAR(50)
)
begin
	DECLARE no_more_rows BOOLEAN;
	DECLARE city_id INT DEFAULT 0;

	DECLARE cursor_cities CURSOR FOR
		SELECT lst_city.id
		FROM lst_city
		WHERE 1=1
			AND lst_city.country_id = in_country_id
			AND lst_city.del_flag = 0
			AND lst_city.active_flag = 1
		;

	DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET no_more_rows = TRUE;

	OPEN cursor_cities;

	the_loop: LOOP
		FETCH cursor_cities INTO city_id;

		IF no_more_rows THEN
			CLOSE cursor_cities;
			LEAVE the_loop;
		END IF;

		CALL reload_city_offers(city_id, in_checkin_date, in_checkout_date, in_process_id);

	END LOOP the_loop;
end;;
DELIMITER ;
```

# S07-L01 Functions

```sql
SELECT /* Is multinight? */
	@checkin_date := '2016-05-09' AS checkin_date,
	@checkout_date := '2016-05-10' AS checkout_date,
	CASE
		WHEN DATEDIFF(@checkout_date, @checkin_date) = 1 THEN 0
		ELSE 1
	END AS is_multinight
;
```

```sql
DELIMITER //

CREATE FUNCTION `fc_is_multinight`(
	checkin_date DATE,
	checkout_date DATE
) RETURNS TINYINT(1)
BEGIN
	RETURN CASE
	  WHEN DATEDIFF(checkout_date, checkin_date) = 1 THEN FALSE
	  ELSE TRUE
	END;
END;
//

DELIMITER ;

SELECT
	@checkin_date := '2016-05-09' AS checkin_date,
	@checkout_date := '2016-05-10' AS checkout_date,
  fc_is_multinight(@checkin_date, @checkout_date)
;
```

# S08-L01 Procedures

## Differences between functions, procedures and views

### Function

```sql
SELECT INET_ATON('32.12.45.193');
SELECT INET_NTOA(537669057);

SELECT /* From S07-L03 */
	@checkin_date := '2016-05-09' AS checkin_date,
	@checkout_date := '2016-05-10' AS checkout_date,
  FC_IS_MULTINIGHT(@checkin_date, @checkout_date) AS is_multinight
;
```

### Procedure

```sql
-- Insert user login (user_id=1, ip_address=32.12.45.193)
CALL INS_USER_LOGIN(1, '32.12.45.193');

-- Select user login (user_id=1)
CALL SEL_USER_LOGIN(1);
```

### View

```sql
SELECT * FROM `v_user_login`
WHERE `v_user_login`.`user_id` = 1
LIMIT 1; /* From S02-L05 */
```

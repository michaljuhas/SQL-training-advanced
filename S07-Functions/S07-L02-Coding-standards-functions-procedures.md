# S07-L02 Coding standards for functions and procedures

* Always use `DELIMITER`, even if it's not necessary
* Split parameters on a new line
* Uppercase keywords, lowercase parameters, variables and table/column names
* Uppercase function and procedure names
* Comment a lot
* Add prefixes
  * Functions: `FC_`
  * Procedures: `INS_` / `DEL_` / `UPD_` / `SEL_`
* When saving code to repository, add delimiter & `DELETE ... IF EXISTS`

```sql
CREATE FUNCTION `FC_IS_MULTINIGHT`(
	checkin_date DATE,
	checkout_date DATE
) RETURNS TINYINT(1)
BEGIN
  ...
END;
```

# S06-L01 Analytic functions

* MySQL
  * hmmm... not many, but we can learn to simulate them *(yay!)*
  * See [User-defined functions in C/C++ to enhance MySQL](http://mysql-udf.sourceforge.net/)
* PostgreSQL
  * `ROW_NUMBER()`
  * `RANK()`, `DENSE_RANK()`
  * `LAG()`, `LEAD()``
  * `FIRST_VALUE()`, `LAST_VALUE()`

```sql
SELECT /* in PostgreSQL */
  letter,
  ROW_NUMBER() OVER(ORDER BY letter),
  RANK()       OVER(ORDER BY letter),
  DENSE_RANK() OVER(ORDER BY letter),
  PERCENT_RANK() OVER(ORDER BY letter),
  NTILE(10) OVER(ORDER BY letter),
  FIRST_VALUE(letter) OVER(),
  LAST_VALUE(letter) OVER(),
  NTH_VALUE(letter, 3) OVER(ORDER BY letter),
  LAG(letter) OVER(),
  LEAD(letter) OVER()
FROM sample.test
ORDER BY letter
;
```

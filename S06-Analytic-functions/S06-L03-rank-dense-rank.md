# S06-L03 `RANK()` & `DENSE_RANK()`

```sql
CREATE TABLE sample.test(letter) AS
SELECT * FROM (
  VALUES('a'),('a'),('a'),('b'),
        ('c'),('c'),('d'),('e')
) test(letter)
;

SELECT
  letter,
  ROW_NUMBER() OVER(ORDER BY letter),
  RANK()       OVER(ORDER BY letter),
  DENSE_RANK() OVER(ORDER BY letter)
FROM sample.test
ORDER BY 1, 2
;

SELECT
  letter,
  ROW_NUMBER() OVER(w),
  RANK()       OVER(w),
  DENSE_RANK() OVER(w)
FROM sample.test
WINDOW w AS (ORDER BY letter)
;
```

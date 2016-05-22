# S06-L03 `RANK()` & `DENSE_RANK()`

http://www.postgresql.org/docs/9.4/static/functions-window.html

```sql
CREATE DATABASE sample_window;

GRANT ALL ON sample_window.* TO 'juhasm'@'%';

CREATE TABLE sample_window.test (
	id INT(11) NOT NULL AUTO_INCREMENT,
	letter CHAR(4),
	PRIMARY KEY (id)
);

INSERT INTO sample_window.test (letter)
	SELECT 'a' UNION ALL SELECT 'a' UNION ALL SELECT 'a' UNION ALL SELECT 'b' UNION ALL SELECT 'c' UNION ALL SELECT 'c' UNION ALL SELECT 'd' UNION ALL SELECT 'e'
```


```sql
/* In Postgres */
CREATE TABLE sample.test(letter) AS
SELECT * FROM (
  VALUES('a'),('a'),('a'),('b'),
        ('c'),('c'),('d'),('e')
) test(letter)
;


SELECT /* In Postgres */
  letter,
  ROW_NUMBER() OVER(ORDER BY letter, id) AS row_number,
  DENSE_RANK() OVER(ORDER BY letter) AS dense_rank,
  RANK()       OVER(ORDER BY letter) AS rank
FROM sample.test
ORDER BY
	letter,
	id
;

SELECT /* In Postgres */
  letter,
  ROW_NUMBER() OVER(w),
  RANK()       OVER(w),
  DENSE_RANK() OVER(w)
FROM sample.test
WINDOW w AS (ORDER BY letter, id)
;
```

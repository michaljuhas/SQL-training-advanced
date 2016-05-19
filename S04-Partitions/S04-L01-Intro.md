# S04-L01 Partitions

Types of partitions:

* Range - `PARTITION BY RANGE(xxx) ... PARTITION pXXX VALUES LESS THAN (xxxx)`
* List - `PARTITION BY LIST(xxx) ... PARTITION pXXX VALUES IN ('X', 'Y', 'Z')`
* Hash - `PARTITION BY HASH( MONTH(invoiced_date)`

## Sub-partitioning

```sql
CREATE TABLE `test` (`id` INT, `purchased` DATE)
  PARTITION BY RANGE( YEAR(`purchased`) )
  SUBPARTITION BY HASH( TO_DAYS(`purchased`) )
  SUBPARTITIONS 10 (
    PARTITION p0 VALUES LESS THAN (1990),
    PARTITION p1 VALUES LESS THAN (2000),
    PARTITION p2 VALUES LESS THAN MAXVALUE
  )
;
```

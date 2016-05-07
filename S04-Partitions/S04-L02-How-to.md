# S04-L02 How to work with partitions?

```sql
-- 150ms
SELECT * /* Select without specifying a partition */
FROM `sample_staff`.`invoice`
WHERE 1=1
	AND YEAR(`invoice`.`invoiced_date`) = '1986'
	AND MONTH(`invoice`.`invoiced_date`) = 3
LIMIT 10
;

-- 1ms
SELECT * /* Select within a particular partition */
FROM `sample_staff`.`invoice` PARTITION (`p1986sp3`)
WHERE 1=1
	AND YEAR(`invoice`.`invoiced_date`) = '1986'
	AND MONTH(`invoice`.`invoiced_date`) = 3
LIMIT 10
;
```

```sql
SELECT /* Select a list of all partitions from a table */
	`table_name`,
	`partition_ordinal_position`,
	`table_rows`,
	`partition_method`,
	`partitions`.*
FROM information_schema.partitions
WHERE 1=1
	AND `table_schema` = 'sample_staff'
	AND `table_name` = 'invoice'
;
```

Query to create the invoice table with partitions:

```sql
CREATE TABLE `invoice` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) unsigned NOT NULL DEFAULT '0',
  `invoiced_date` date NOT NULL,
  `paid_flag` tinyint(4) NOT NULL DEFAULT '0',
  `insert_dt` datetime NOT NULL,
  `insert_user_id` int(11) NOT NULL DEFAULT '-1',
  `insert_process_code` varchar(255) DEFAULT NULL,
  `update_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_user_id` int(11) NOT NULL DEFAULT '-1',
  `update_process_code` varchar(255) DEFAULT NULL,
  `deleted_flag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`, `invoiced_date`)
) ENGINE=InnoDB
	DEFAULT CHARSET=utf8
    PARTITION BY RANGE( YEAR(invoiced_date) )
    SUBPARTITION BY HASH( MONTH(invoiced_date) )
    SUBPARTITIONS 12 (
        PARTITION p1984 VALUES LESS THAN (1985),
        PARTITION p1985 VALUES LESS THAN (1986),
        PARTITION p1986 VALUES LESS THAN (1987),
        PARTITION p1987 VALUES LESS THAN (1988),
        PARTITION p1988 VALUES LESS THAN (1989),
        PARTITION p1989 VALUES LESS THAN (1990),
        PARTITION p1990 VALUES LESS THAN (1991),
        PARTITION p1991 VALUES LESS THAN (1992),
        PARTITION p1992 VALUES LESS THAN (1993),
        PARTITION p1993 VALUES LESS THAN (1994),
        PARTITION pOTHER VALUES LESS THAN MAXVALUE
    )
;
```

# S08-L03 Events

## Administration

Check if the Event Scheduler is turned ON:

```sql
SHOW VARIABLES LIKE 'event_scheduler';
```

If the variable event_scheduler=OFF, you need to activate it

```sql
SET GLOBAL event_scheduler = 1;
```

## Event logger

```sql
DROP TABLE IF EXISTS `event_logger`;

CREATE TABLE `event_logger` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` VARCHAR(35) NOT NULL,
  `counter` INT(11) NOT NULL DEFAULT 0,
  `insert_dt` datetime NOT NULL,
  `insert_user_id` int(11) NOT NULL DEFAULT '-1',
  `insert_process_code` varchar(255) DEFAULT NULL,
  `update_dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_user_id` int(11) NOT NULL DEFAULT '-1',
  `update_process_code` varchar(255) DEFAULT NULL,
  `deleted_flag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `event_logger` (`id`, `event_name`, `counter`, `insert_dt`)
  VALUES (NULL, 'Test event', '0', NOW());
```

```sql
DROP EVENT IF EXISTS `sample_staff`.`ev_test_event_counter`;

DELIMITER //

CREATE EVENT `sample_staff`.`ev_test_event_counter`
	ON SCHEDULE EVERY 1 SECOND
 	STARTS NOW()
  ENDS NOW() + INTERVAL 1 MINUTE
  COMMENT 'Test event'
	DO
    BEGIN
      UPDATE `event_logger`
      SET counter = counter + 1
      WHERE event_name = 'Test event'
      ;
    END
//

DELIMITER ;
```

Select all events saved in Scheduler:

```sql
SHOW EVENTS;
```

# S07-L03 Practice

## Assignment

Create a function that will return distance between 2 coordinates. Each coordinate is defined by `latitude` and `longitude`.

Pick 2 places on [www.latlong.net](http://www.latlong.net/), get their latitude & longitude, and use your newly created function to calculate distance between the 2 places.

## Guide

```sql
DROP FUNCTION IF EXISTS `fc_get_distance`;

DELIMITER //

CREATE FUNCTION `fc_get_distance`(
	in_latitude_from FLOAT,
	in_longitude_from FLOAT,
	in_latitude_to FLOAT,
	in_longitude_to FLOAT
) RETURNS float
BEGIN
	RETURN
      ROUND(
	      6371
	      * ACOS( COS ( RADIANS(in_latitude_from) )
	      * COS( RADIANS(in_latitude_to ) )
	      * COS( RADIANS(in_longitude_to ) - RADIANS(in_longitude_from) )
	      + SIN( RADIANS(in_latitude_from) )
	      * SIN( RADIANS(in_latitude_to ) )
	      )
	      * 1000
      );
end;
//

DELIMITER ;

SELECT fc_get_distance(13.756331, 100.501765, 13.756262, 100.505891) AS distance_in_meters;
```

# S07-P01 Practice

## Assignment

Create a function that will return distance between 2 coordinates in meters. Each coordinate is defined by `latitude` and `longitude`.

Pick 2 places on [latlong.net](http://www.latlong.net/), get their latitude & longitude, and use your newly created function to calculate distance between the 2 places.

```
Law of cosines
d = R ⋅ acos( sin φ1 ⋅ sin φ2 + cos φ1 ⋅ cos φ2 ⋅ cos Δλ )
```

...

...

...

SPOILER: Below are the results

...

...

## Result

Calculations: http://www.movable-type.co.uk/scripts/latlong.html

```sql
DROP FUNCTION IF EXISTS `FC_GET_DISTANCE`;

DELIMITER //

CREATE FUNCTION `FC_GET_DISTANCE`(
	in_latitude_from FLOAT,
	in_longitude_from FLOAT,
	in_latitude_to FLOAT,
	in_longitude_to FLOAT
) RETURNS float
BEGIN
	RETURN
      ROUND(
	      6371 * 1000 /* R is earth’s radius in meters (6371km) */
	      * ACOS(
						COS( RADIANS(in_latitude_from) )
		      	* COS( RADIANS(in_latitude_to ) )
		      	* COS( RADIANS(in_longitude_to ) - RADIANS(in_longitude_from) )
		      + SIN( RADIANS(in_latitude_from) )
		      	* SIN( RADIANS(in_latitude_to ) )
	      )
      );
end;
//

DELIMITER ;

SELECT FC_GET_DISTANCE(13.756331, 100.501765, 13.756262, 100.505891) AS distance_in_meters;
```

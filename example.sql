/* Example doc */


SELECT /* ex 01 */
	id AS employee_id,
	first_name,
	last_name
FROM employee
WHERE 1=1
	AND deleted_flag = 0
LIMIT 100
;

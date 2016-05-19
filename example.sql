/* Example doc */


SELECT /* ex 01 */
	employee_id AS employee_id,
	first_name,
	last_name,
 	contract.sign_date
FROM employee
INNER JOIN contract ON 1=1
	and contract.employee_id = employee.id
	and contract.deleted_flag = 0
WHERE 1=1
	AND employee.deleted_flag = 0
LIMIT 100
;

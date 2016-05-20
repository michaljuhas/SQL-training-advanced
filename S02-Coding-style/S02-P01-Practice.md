# S02-P01 Practice

## Assignment

Re-write and beautify this query from S01-L02.

```sql
select
	e.id AS employee_id, concat(e.first_name, ' ', e.last_name) AS employee_full_name, d.id AS department_id, d.name AS last_department_name
from employee e
inner join ( select der.employee_id, max(der.id) AS max_id
	from department_employee_rel der
	where der.deleted_flag = 0
	group by der.employee_id
) derm ON derm.employee_id = e.id
inner join department_employee_rel der ON der.id = derm.max_id
	and der.deleted_flag = 0
inner join department d ON d.id = der.department_id
	and d.deleted_flag = 0
where e.id IN (10010, 10040, 10050, 91050, 205357)
	and e.deleted_flag = 0
limit 100;
```

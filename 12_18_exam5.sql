# Oracle HR Scheme에서 'Marketing' 부서에 속한 직원의 이름(last_name), 급여(salary), 부서이름(department_name)을 조회하시오. (단, 급여는 80번 부서의 평균보다 적게 받는 직원만 출력되어야 함)

select e.last_name, e.salary, d.department_name
  from Employees e inner join Departments d on e.department_id = d.department_id
 where d.department_name = 'Marketing'
   and e.salary < (select avg(salary) from Employees where department_id = 80

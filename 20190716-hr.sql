-- any/all sub query
select salary from employees where department_id=30;-- 11000 ~ 2500
select salary from employees
where salary >=
any(select salary from employees where department_id=30);

select salary from employees
where salary >=
all(select salary from employees where department_id=30);

-- table 복제
create table emp as (select * from employees);-- data도 복제
create table emp2 as (select * from employees where 1=2);-- data 제외
create table emp3(eid, fname, sal)-- 특정 column 및 data 복제 
as (select employee_id, first_name, salary from employees);
select * from emp;
select * from emp2;
select * from emp3;

-- update sub query
update emp3 set fname='mikol', sal=(select min(sal) from emp3)
where eid=100;

-- cross join
-- oracle
select e.employee_id, e.department_id, d.department_name
from employees e, departments d;
-- ansi
select e.employee_id, e.department_id, d.department_name
from employees e cross join departments d;

select (select count(*) from employees)*(select count(*) from departments) from dual;

-- inner join, eq-join : null값 제외
-- ansi
select employee_id, d.department_id, department_name
from employees e inner join departments d
on e.department_id = d.department_id;

select e.employee_id, department_id, d.department_name 
from employees e join departments d 
using (department_id);

select employee_id, d.department_id, department_name
from employees e join departments d
on e.department_id = d.department_id;
-- oracle
select employee_id, dept.department_id, department_name
from employees emp, departments dept
where emp.department_id = dept.department_id;

-- natural join
select employee_id, department_id, department_name
from employees natural join departments;

-- outer join : null값 표시
-- full outer join (oracle / ansi X)
select employee_id, dept.department_id, department_name
from employees emp full outer join departments dept
on emp.department_id = dept.department_id;
-- right outer join (oracle)
select employee_id, dept.department_id, department_name
from employees emp right outer join departments dept
on emp.department_id = dept.department_id;
-- left outer join (ansi)
select employee_id, dept.department_id, department_name
from employees emp, departments dept
where emp.department_id = dept.department_id(+);

select * from emp3;

-- join, inner join - on
select employee_id, d.department_id, department_name
from employees e inner join departments d
on e.department_id = d.department_id and employee_id = 200;
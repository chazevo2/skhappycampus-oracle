-- any/all sub query
select salary from employees where department_id=30;-- 11000 ~ 2500
select salary from employees
where salary >=
any(select salary from employees where department_id=30);

select salary from employees
where salary >=
all(select salary from employees where department_id=30);

-- table ����
create table emp as (select * from employees);-- data�� ����
create table emp2 as (select * from employees where 1=2);-- data ����
create table emp3(eid, fname, sal)-- Ư�� column �� data ���� 
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

-- inner join, eq-join : null�� ����
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

-- outer join : null�� ǥ��
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

-- join, inner join - on
select employee_id, d.department_id, department_name
from employees e inner join departments d
on e.department_id = d.department_id and employee_id = 200;

-- self join
-- oracle
select e1.employee_id, e1.first_name, e1.manager_id, e2.first_name 
from employees e1, employees e2
where e1.manager_id = e2.employee_id(+)
order by 1;
-- ansi
select e1.employee_id, e1.first_name, e1.manager_id, e2.first_name 
from employees e1 left outer join employees e2
on e1.manager_id = e2.employee_id
order by 1;

select e1.employee_id, e1.first_name, nvl(e1.manager_id, 1004), nvl(e2.first_name, 'õ��') 
from employees e1 left outer join employees e2
on e1.manager_id = e2.employee_id
order by 1;

select e1.employee_id || '�� ����� ' || e1.first_name || '�� �Ŵ����� ' || nvl(e2.first_name, 'õ��') || '�̴�.' �������
from employees e1 left outer join employees e2
on e1.manager_id = e2.employee_id
order by 1;

-- group by
select department_id, count(employee_id), sum(salary), round(avg(salary)) from employees
group by department_id
order by 1;

-- having
select department_id, sum(salary) from employees
group by department_id
having department_id is not null
order by 1;

-- rollup
select department_id, job_id, count(*), max(salary), sum(salary), round(avg(salary)) 
from employees
group by rollup (department_id, job_id)
order by 1, 2;

-- cube
select department_id, job_id, count(*), max(salary), sum(salary), round(avg(salary)) 
from employees
group by cube (department_id, job_id)
order by 1, 2;

-- 1.�� �μ��� �ּұ޿��� ������ �޿��� �޴� ��� ���� ã��
select * from employees
where salary in
(select min(salary) from employees group by department_id);
-- 2.30�� �μ��� �ּұ޿����� ���� �޴� ��� ���� ã��
select * from employees
where salary <
(select min(salary) from employees where department_id = 30);

select * from employees
where salary <
all(select salary from employees where department_id = 30);
-- 3. 105�� ����� �ٹ��ϴ� �μ��� �ִ�޿����� ���� �޴� ��� ���� ã��
select * from employees
where salary <
(select max(salary) from employees 
where department_id = 
(select department_id from employees where employee_id = 105));

select * from employees
where salary <
any(select salary from employees 
where department_id = 
(select department_id from employees where employee_id = 105));
-- 4. Neena�� �ٹ��ϴ� �μ� ������� ���, �̸�, ��, �μ���ȣ, �μ��� ����ϱ�
select employee_id, first_name, last_name, d.department_id, department_name
from employees e, departments d
where e.department_id = d.department_id
and d.department_id = 
(select department_id from employees where first_name='Neena');


-- q1. �����ȣ�� 103�� ����� job_id�� ���� ��� ���� ���
select * from employees
where job_id =
(select job_id from employees where employee_id = 103);
-- q2. Diana Lorentz�� ���� �μ��� ������� ������ ���
select * from employees
where department_id =
(select department_id from employees
where first_name || ' ' || last_name = 'Diana Lorentz');
-- q3. 110�� �μ��� �ְ� �޿��� ���� ������� ���� �޿��� �޴� ����� ����(��ȣ, �̸�, ����, �Ի�����, �޿�, �μ���ȣ) ���
select employee_id, first_name||' '||last_name, job_id, hire_date, salary, department_id
from employees
where salary >
(select max(salary) from employees where department_id = 110);
-- all(select salary from employees where department_id = 110);

-- view
create table dept as (select * from departments);
drop table dept;
select * from dept;

create or replace view view_dept as 
(select * from departments where manager_id is not null);
drop view view_dept;
select * from view_dept;

create or replace view view_emp(eid, dname, jtitle) as 
(select employee_id,department_name, job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id);
drop view view_emp;
select * from view_emp;
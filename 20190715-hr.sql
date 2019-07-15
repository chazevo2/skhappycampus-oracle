select * from tab;

-- 부서 검색
desc departments;
-- primary key(not null) / unique key(null)
select department_id, department_name, manager_id, location_id
from departments;

-- where 조건절
select department_id, department_name, manager_id, location_id
from departments
where department_name = 'Administration';

-- *(애스터리스크) : 모든 컬럼
select * from departments
where department_id = 30;

-- count
select count(*) from departments;

-- sub query
select employee_id, first_name, last_name, salary
from employees
where employee_id = 
(select manager_id from departments where department_id = 30);

-- 모든 사원 검색
select * from employees;

-- alias ""(숫자, 특수문자, 띄어쓰기 포함시 필요), AS
select employee_id as "사번", first_name "이름", last_name as 성, salary "(단위\)"
from employees
where employee_id = 100;

select employee_id as "사번", department_id deptno
from employees;

-- where and, or 연산자
select * from employees
where salary >= 17000 and salary <= 24000;

select * from employees
where salary = 17000 or salary = 24000;

select * from employees
where salary between 11000 and 17000;

-- in list (or 여러조건)
select * from employees
where salary in (17000, 24000, 9000, 6000);

select * from employees
where salary in 
(select salary from employees where department_id = 30);

-- order by절 asc(오름차순), desc(내림차순)
select employee_id, salary
from employees
where department_id = 30
order by employee_id desc;
--order by 1 desc;

select department_id, employee_id, salary
from employees
order by department_id asc, employee_id desc;
--order by 1 asc, 2 desc;

-- distinct 중복 제거
select distinct department_id from employees order by department_id;

-- null
select distinct department_id 
from employees 
where department_id is not null
order by department_id;

-- nvl
select distinct department_id, nvl(department_id, 999) deptno
from employees
order by department_id;


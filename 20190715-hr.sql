select * from tab;

-- �μ� �˻�
desc departments;
-- primary key(not null) / unique key(null)
select department_id, department_name, manager_id, location_id
from departments;

-- where ������
select department_id, department_name, manager_id, location_id
from departments
where department_name = 'Administration';

-- *(�ֽ��͸���ũ) : ��� �÷�
select * from departments
where department_id = 30;

-- count
select count(*) from departments;

-- sub query
select employee_id, first_name, last_name, salary
from employees
where employee_id = 
(select manager_id from departments where department_id = 30);

-- ��� ��� �˻�
select * from employees;

-- alias ""(����, Ư������, ���� ���Խ� �ʿ�), AS
select employee_id as "���", first_name "�̸�", last_name as ��, salary "(����\)"
from employees
where employee_id = 100;

select employee_id as "���", department_id deptno
from employees;

-- where and, or ������
select * from employees
where salary >= 17000 and salary <= 24000;

select * from employees
where salary = 17000 or salary = 24000;

select * from employees
where salary between 11000 and 17000;

-- in list (or ��������)
select * from employees
where salary in (17000, 24000, 9000, 6000);

select * from employees
where salary in 
(select salary from employees where department_id = 30);

-- order by�� asc(��������), desc(��������)
select employee_id, salary
from employees
where department_id = 30
order by employee_id desc;
--order by 1 desc;

select department_id, employee_id, salary
from employees
order by department_id asc, employee_id desc;
--order by 1 asc, 2 desc;

-- distinct �ߺ� ����
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

-- like, ���ϵ�ī��(_ / %)
select first_name, last_name, salary from employees
where first_name like 'St%';

select first_name, last_name, salary from employees
where first_name like '%ev%';

select first_name, last_name, salary from employees
where first_name like '__ev%';

-- escape '\' ���ϵ�ī��(_ / %) ���ڰ� �������� �Ϻκ��� ���
-- �ش� ���ϵ�ī��(_ / %) ���� �տ� \ �ۼ�
select first_name, last_name, job_id from employees
where job_id like 'AC\_A%' escape '\';

-- union �ߺ� ����
select employee_id, salary, department_id from employees
where department_id = 20
union --all �ߺ� ���
select employee_id, salary, department_id from employees
where department_id = 30;
-- minus ������
-- intersect ������
select employee_id, salary, department_id from employees
minus
select employee_id, salary, department_id from employees
where department_id = 50 order by 3;

-- �ý��� ���� sysdate, dual
select distinct sysdate from employees;
select sysdate from dual;

-- ���ڿ� ��ġ�� ||
select employee_id, first_name || ' ' || last_name ename
from employees;

-- count(*) null ���� / count(column) null ����
select count(commission_pct) from employees;
select count(*) from employees
where commission_pct is not null;

select * from employees;

-- sum
select sum(salary) from employees;

-- max
select * from employees
where salary = 
(select max(salary) from employees);

-- upper, lower, initcap(ù���ڸ� �빮��)
select 'AAaa', upper('AAaa'), lower('AAaa'), initcap('AAaa') from dual;
-- length, lengthb(byte ����)
select length('AAaa'), length('ȫ�浿'), lengthb('ȫ�浿') from dual;

-- substr ���ڿ� �ڸ���
select substr('abcdefg', 1, 2) from dual;

-- instr ���ڿ� ã��
-- instr('���ڿ�', 'ã������ ����', '������ġ', '������ġ���� ������ ����')

-- replace
select employee_id, job_id, replace(job_id, '_', '*') from employees;
-- lpad, rpad
select phone_number, lpad(phone_number, 20, '*'), rpad(phone_number, 20, '*') from employees;
select phone_number, rpad(substr(phone_number, 1, 3), length(phone_number), '*') from employees;

-- Ư�� ���� ����� trim(leading/trailing/both '�����ҹ���'/(������ ���鹮��) from ���ڿ�)

-- avg, round(����, �ݿø���ġ)
select round(avg(salary), 2) ��ձ޿� from employees;

-- trunc 
select avg(salary), trunc(avg(salary), 2) ��ձ޿� from employees;

-- ceil ���� ����� ū ���� ��ȯ, floor ���� ����� ���� ���� ��ȯ
-- mod �������� ���ϱ�

-- ��¥ ������ �Լ�
-- add_months, months_between, next_dat, last_day : ���� ������ ��¥
select months_between(sysdate, hire_date) from employees;

-- �ڷ� ��ȯ �Լ�
-- to_date, to_char, to_char
-- to_char
-- dd(��), day(����), mi(��)
select sysdate, to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') sday from dual;
-- ����
select salary, to_char(salary, '$999,999.99') as "����($)" from employees;

-- to_number
select 25*25, 25*'25', '25'*'25' from dual;
select '1,500'*'25' from dual; -- ���� ���� ��ǥ�� ��ȯ�� ���� ����
select to_number('1,500', '9999') from dual;
select to_number('1,500', '9999') * '25' from dual;

-- to_date
select '19/7/15', '2019-12-25' from dual;
select to_date('190715', 'YYMMDD'), to_date('2019-12-25', 'YYYY-MM-DD') from dual;

select * from employees
where hire_date > to_date('2006-12-25');
select * from employees
where hire_date > '2006-12-25';

-- null ó�� �Լ�
-- nvl, nvl2
select employee_id, salary, salary*nvl(commission_pct, 0) comm, salary + salary*nvl(commission_pct, 0) "sal+comm"
from employees;

select employee_id, salary, salary*nvl(commission_pct, 0.5) comm, salary + salary*nvl(commission_pct, 0.5) "sal+comm"
from employees;

select employee_id, salary, salary*nvl(commission_pct, 0.5) comm, 
salary + salary*nvl2(commission_pct, commission_pct, 0.5) "sal+comm"
from employees;

select employee_id, nvl2(commission_pct, 'O', 'X') from employees;

-- decode �Լ�, case ��
-- decode(���, ����1, ���1, ����2, ���2, ... ����n, ���n, default)
select first_name, job_id, salary, 
decode(job_id, -- ��� 
'SA_REP', salary*1.5, -- ����/���
'IT_PROG', salary*2, -- ����/���
'SA_MAN', salary*1.2, -- ����/���
'AC_MGR', salary*3, -- ����/���
salary*10) as sal -- default
from employees;

-- case ��� when ����1 then ���1  when ����2 then ���2 ...  when ����n then ���n else default end
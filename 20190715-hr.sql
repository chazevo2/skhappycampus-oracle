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

-- like, 와일드카드(_ / %)
select first_name, last_name, salary from employees
where first_name like 'St%';

select first_name, last_name, salary from employees
where first_name like '%ev%';

select first_name, last_name, salary from employees
where first_name like '__ev%';

-- escape '\' 와일드카드(_ / %) 문자가 데이터의 일부분의 경우
-- 해당 와일드카드(_ / %) 문자 앞에 \ 작성
select first_name, last_name, job_id from employees
where job_id like 'AC\_A%' escape '\';

-- union 중복 제거
select employee_id, salary, department_id from employees
where department_id = 20
union --all 중복 허용
select employee_id, salary, department_id from employees
where department_id = 30;
-- minus 차집합
-- intersect 교집합
select employee_id, salary, department_id from employees
minus
select employee_id, salary, department_id from employees
where department_id = 50 order by 3;

-- 시스템 일자 sysdate, dual
select distinct sysdate from employees;
select sysdate from dual;

-- 문자열 합치기 ||
select employee_id, first_name || ' ' || last_name ename
from employees;

-- count(*) null 포함 / count(column) null 제외
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

-- upper, lower, initcap(첫글자만 대문자)
select 'AAaa', upper('AAaa'), lower('AAaa'), initcap('AAaa') from dual;
-- length, lengthb(byte 길이)
select length('AAaa'), length('홍길동'), lengthb('홍길동') from dual;

-- substr 문자열 자르기
select substr('abcdefg', 1, 2) from dual;

-- instr 문자열 찾기
-- instr('문자열', '찾으려는 문자', '시작위치', '시작위치부터 끝나는 범위')

-- replace
select employee_id, job_id, replace(job_id, '_', '*') from employees;
-- lpad, rpad
select phone_number, lpad(phone_number, 20, '*'), rpad(phone_number, 20, '*') from employees;
select phone_number, rpad(substr(phone_number, 1, 3), length(phone_number), '*') from employees;

-- 특정 문자 지우기 trim(leading/trailing/both '삭제할문자'/(생략시 공백문자) from 문자열)

-- avg, round(숫자, 반올림위치)
select round(avg(salary), 2) 평균급여 from employees;

-- trunc 
select avg(salary), trunc(avg(salary), 2) 평균급여 from employees;

-- ceil 가장 가까운 큰 정수 반환, floor 가장 가까운 작은 정수 반환
-- mod 나머지값 구하기

-- 날짜 데이터 함수
-- add_months, months_between, next_dat, last_day : 달의 마지막 날짜
select months_between(sysdate, hire_date) from employees;

-- 자료 변환 함수
-- to_date, to_char, to_char
-- to_char
-- dd(일), day(요일), mi(분)
select sysdate, to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') sday from dual;
-- 단위
select salary, to_char(salary, '$999,999.99') as "단위($)" from employees;

-- to_number
select 25*25, 25*'25', '25'*'25' from dual;
select '1,500'*'25' from dual; -- 숫자 사이 쉼표로 변환이 되지 않음
select to_number('1,500', '9999') from dual;
select to_number('1,500', '9999') * '25' from dual;

-- to_date
select '19/7/15', '2019-12-25' from dual;
select to_date('190715', 'YYMMDD'), to_date('2019-12-25', 'YYYY-MM-DD') from dual;

select * from employees
where hire_date > to_date('2006-12-25');
select * from employees
where hire_date > '2006-12-25';

-- null 처리 함수
-- nvl, nvl2
select employee_id, salary, salary*nvl(commission_pct, 0) comm, salary + salary*nvl(commission_pct, 0) "sal+comm"
from employees;

select employee_id, salary, salary*nvl(commission_pct, 0.5) comm, salary + salary*nvl(commission_pct, 0.5) "sal+comm"
from employees;

select employee_id, salary, salary*nvl(commission_pct, 0.5) comm, 
salary + salary*nvl2(commission_pct, commission_pct, 0.5) "sal+comm"
from employees;

select employee_id, nvl2(commission_pct, 'O', 'X') from employees;

-- decode 함수, case 문
-- decode(대상, 조건1, 결과1, 조건2, 결과2, ... 조건n, 결과n, default)
select first_name, job_id, salary, 
decode(job_id, -- 대상 
'SA_REP', salary*1.5, -- 조건/결과
'IT_PROG', salary*2, -- 조건/결과
'SA_MAN', salary*1.2, -- 조건/결과
'AC_MGR', salary*3, -- 조건/결과
salary*10) as sal -- default
from employees;

-- case 대상 when 조건1 then 결과1  when 조건2 then 결과2 ...  when 조건n then 결과n else default end
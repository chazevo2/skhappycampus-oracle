-- DDL : create alter drop truncate (undo불가능, 자동저장)
-- DML : insert update delete (undo >> rollback, 자동저장안됨, commit)
-- TCL : commit rollback savepoint
-- DQL : select
-- DCL : grant revoke

select * from students;
-- insert into table(column) values(data);
INSERT INTO "TEST"."STUDENTS" (STD_NUM, STD_NAME, STD_PHONE) VALUES ('2', 'lee', '011');
INSERT INTO "TEST"."STUDENTS" (STD_NUM, STD_NAME, STD_PHONE) VALUES ('3', 'choi', '012');
-- data insert 후 commit;
commit;

-- sequence.nextval
-- auto increment
--------------------------------------------------------
--  DDL for Sequence STUDENTS_SEQ
--------------------------------------------------------
CREATE SEQUENCE  "TEST"."STUDENTS_SEQ";

select STUDENTS_SEQ.nextval from dual;
INSERT INTO "TEST"."STUDENTS" (STD_NUM, STD_NAME, STD_PHONE) VALUES (STUDENTS_SEQ.nextval, 'park', '013');

-- table 생성
create table member(
num number --constraint member_pk primary key
,user_name varchar2(30) not null
,tel varchar2(20) not null
,reg_date date default sysdate
,constraint member_pk primary key(num)
);
-- table 삭제
drop table member;
-- sequence 생성
create sequence member_seq;
-- sequence 삭제
drop sequence member_seq;

--------------------------------------------------------
insert into test.member(num, user_name, tel) values(MEMBER_SEQ.nextval, 'kim', '01');
insert into test.member(num, user_name, tel) values(MEMBER_SEQ.nextval, 'kim', '02');
insert into test.member(num, user_name, tel) values(MEMBER_SEQ.nextval, 'kim', '03');
insert into test.member(num, user_name, tel) values(MEMBER_SEQ.nextval, 'lee', '031');
commit;

select * from member where 1=2;-- 모든 데이터를 보기 싫을때

select * from member where num in (1, 3);

-- any / all
-- any 가장 작거나 큰 값을 기준,  list()를 포함하여 출력
select * from member where num > any (3, 5, 7);-- 가장 작은 값 초과
select * from member where num >= any (3, 5, 7);-- 가장 작은 값 이상
select * from member where num <= any (3, 5, 7);-- 가장 큰 값 이하
select * from member where num < any (3, 5, 7);-- 가장 큰 값 미만
-- all 전체를 기준으로, list() 기준값(=:포함/=X 미포함)을 제외하고 출력
select * from member where num < all (3, 5, 7);

-- update
UPDATE "TEST"."MEMBER" 
SET USER_NAME = 'lee5' 
WHERE ROWID = 'AAAE5pAABAAALDxAAE'
AND ORA_ROWSCN = '393178';

select rowid, rownum, num, user_name from member;

update member
set user_name = 'lee6', tel = '051', reg_date = sysdate + 1
where num = 6;

select * from member;

-- delete
delete from member where num = 7;
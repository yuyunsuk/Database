/* 240415 */

-- DML(데이터조작어)[Data Manipulation Language]
-- select, insert, update, delete

-- insert into 테이블명 values (값1, 값2, ... );
insert into 부서
values ('AS', '마케팅부'); -- 컬럼 순서대로 작성해야 함

insert into 제품
values (91, '연어피클소스', null, 5000, 40); -- 컬럼 순서대로 작성해야

/* insert into 테이블명(컬럼1, 컬럼2, ...)
 * values (값1, 값2, ...);
 * 이 경우, values 는 위의 컬럼 순서대로만 써주면 됨 */
insert into 제품(제품번호, 제품명, 단가, 재고)
values (90, '연어핫소스', 4000, 50);

-- 여러개의 데이터를 한번에 입력
insert into 사원(사원번호, 이름, 직위, 성별, 입사일)
values ('E20', '김사과', '수습사원', '남', curdate())
     , ('E21', '박바나나', '수습사원', '여', curdate())
     , ('E22', '정오렌지', '수습사원', '여', curdate());

-- update
/* update 테이블명 set 컬럼1 = 값1, 컬럼2 = 값2, ...
   where 조건; */
update 사원
set 이름 = '김레몬'
where 사원번호 = 'E20'; -- where 조건이 없으면 모든 열이 변경됨!!

update 제품
set 포장단위 = '200 ml bottles'
where 제품번호 = 91;

-- delete
-- delete from 테이블명 where 조건;
delete from 제품
where 제품번호 = 91;

-- 가장 최근 입사자 순서로 정렬하고 위에서 3개 row를 삭제
delete from 사원
order by 입사일 desc
limit 3;

-- insert on duplicate key update
-- 레코드(=열, row, 튜플)가 없으면 새롭게 추가하고, 있으면 변경
insert into 제품(제품번호, 제품명, 단가, 재고)
values (91, '연어피클핫소스', 6000, 50)
on duplicate key
update 제품명 = '연어피클핫소스', 단가 = 6000, 재고 = 50;

-- DDL(데이터 정의어)[Data Definition Language]
-- create, alter, drop, truncate

/* 문자형 데이터타입
char 고정길이      255
varchar 가변길이 65535 (소설책 20page 정도)
tinytext        255
text          65535
mediumtext    16,777,215
longtext   4,294,967,295
json 1기가(GB) */

/* 숫자형 데이터타입
tinyint   1byte
smallint  2byte
mediumint 3byte
int       4byte
bigint    8byte

float     4byte (소숫점 아래 7자리)
double    8byte (소숫점 아래 15자리)
decimal(전체자리수, 소수점자리수) */

/* 날짜시간형 데이터타입
date YYYY-MM-DD
time HH:MI:SS
datetime  YYYY-MM-DD HH:MI:SS
timestamp YYYY-MM-DD HH:MI:SS
*/

/* 이진형(binary) 데이터타입 : 이미지, 오디오, 비디오 등[원본은 클라우드, 데이터는 주소만 저장하는 방법 사용]
tinyblob   255 byte
blob     65535 byte (blob = binary large object)
mediumblob    16,777,215 byte
longblob   4,294,967,295 byte
*/

-- 1. create 데이터베이스 생성
create database project1;

create database project1
   CHAR SET utf8mb4 COLLATE utf8mb4_general_ci;

use project1;

-- 테이블 생성
ALTER DATABASE project1 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE 학과 CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
ALTER TABLE 학생 CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
show variables like 'c%';

create table 학과
( 학과번호 char(2)
, 학과명  varchar(20)
, 학과장명 varchar(20));

/*
insert into 학과
values ('AA', 'computer', 'steve')
     , ('BB', 'software', 'tom')
     , ('CC', 'design', 'michael');

delete from 학과 where 학과명 in ('computer','software','design');
*/

insert into 학과
values ('AA', '컴퓨터공학과', 'steve')
     , ('BB', '소프트웨어학과', 'tom')
     , ('CC', '디자인융합과', 'michael');
    
create table 학생
( 학번 char(5)
, 이름 varchar(20)
, 생일 date
, 연락처 varchar(20)
, 학과번호 char(2));

insert into 학생
values ('S0001', '이윤주', '2020-01-30', '01033334444', 'AA');

insert into 학생
values ('S0002', '이승은', '2021-02-23', null, 'AA')
     , ('S0003', '백재용', '2018-03-31', '01077778888', 'DD');

-- 2. alter 테이블명이나 컬럼명, 데이터타입을 변경하거나 컬럼 추가, 삭제
-- 컬럼추가
alter table 학생 add 성별 char(1);
alter table 학생 add column 성별 char(1);

-- 컬럼 데이터타입 변경
alter table 학생 modify column 성별 varchar(2);

-- 컬럼명 변경
alter table 학생 change column 연락처 핸드폰전화번호 varchar(20); 

-- 컬럼 삭제
alter table 학생 drop column 성별;

-- 테이블명 변경
alter table 학생 rename 재학생;

-- 3. drop 데이터베이스 또는 테이블 삭제

create database temp;

drop database temp;

--------------------------------

create table 휴학생 select * from 재학생;

drop table 휴학생;

-- DCL
-- grant : 특정 데이터베이스 사용자에게 특정 작업에 대한 수행 권한을 부여
-- revoke : 특정 데이터베이스 사용자에게 특정 작업에 대한 수행 권한을 박탈, 회수
-- commit : 트랜잭션의 작업을 저장
-- rollback : 트랜잭션의 작업을 취소, 원래대로 복구
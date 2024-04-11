/* 240411 */
-- [Maria SQL 함수]
-- [집계 함수]

-- count 데이터 열의 갯수를 세는 함수(null 은 제외)
select count(*)     -- 93 /* 모든 행의 갯수 */
     , count(고객번호) -- 93 
     , count(도시)    -- 93 
     , count(지역)    -- 92 /* [NULL] 이 포함되어 있는 경우 제외됨 */
  from 고객;

select 지역 from 고객;

-- sum 합계
-- avg 평균
-- min 최소값
-- max 최대값
select sum(마일리지)
     , avg(마일리지)
     , min(마일리지)
     , max(마일리지)
  from 고객;

-- group by 그룹별로 묶어주는 명령어(중요!!)
select 도시
     , count(*)   as 고객수
     , avg(마일리지) as 평균마일리지
  from 고객; -- 전체 고객수, 평균마일리지에 처음 도시가 붙어 나옴[결과 에러] => group by 필요

select count(*)   as 고객수
     , avg(마일리지) as 평균마일리지
  from 고객;
 
select 도시
     , count(*)   as 고객수
     , avg(마일리지) as 평균마일리지
  from 고객
 group by 도시;

select 담당자직위
     , 도시
     , count(*)   as 고객수
     , avg(마일리지) as 평균마일리지
  from 고객
 group by 담당자직위
     , 도시
 order by 담당자직위
     , 도시;

select 도시
     , 담당자직위
     , count(*)   as 고객수
     , avg(마일리지) as 평균마일리지
  from 고객
 group by 도시
     , 담당자직위
 order by 도시
     , 담당자직위;

-- having
select 도시
     , count(*)   as 고객수
     , avg(마일리지) as 평균마일리지
  from 고객
 group by 도시
having count(*) >= 4
 order by 2 desc;

select 도시
     , sum(마일리지) as '도시별 마일리지'
  from 고객
 where 고객번호 like 'T%' -- where 는 select 에 지정된 컬럼이외도 사용가능
 group by 도시
having sum(마일리지) >= 1000; -- having 은 select 에 지정된 컬럼만 사용

-- with rollup 그룹별 소계와 전체 총계를 표시
select 도시
     , count(*)   as 고객수
     , avg(마일리지) as 평균마일리지
  from 고객
 group by 도시
  with rollup; -- 고객수 총계

select 담당자직위
     , 도시
     , count(*)   as 고객수
  from 고객
 group by 담당자직위
     , 도시
 with rollup; -- 담당자직위별 소계 + 총계

-- group concat 컬럼내의 값을 결합해서 표시
select 도시
     , group_concat(고객회사명) as 고객회사명목록 
  from 고객
 group by 도시;
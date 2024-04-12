/* 240411 */

-- 서브쿼리[SubQuery]
-- sql문 내부에서 사용하는 select 문을 의미함
-- 장점: 복잡한 데이터추출 및 조작작업에 유용하며 유연성과 기능확장에 도움이 됨.
-- 단점: 지나치게 복잡한 서브쿼리를 사용하면 성능을 저하시킬 수 있음.

-- 최고의 마일리지를 보유한 고객은 누구?
select a.고객번호
     , a.고객회사명
     , a.담당자명
     , a.마일리지
  from 고객 a
 where a.마일리지 = ( select max(b.마일리지)
                     from 고객 b );

-- 주문번호 'H0250'을 주문한 고객의 고객회사명과 담당자명
-- 1. 단일 행 서브쿼리 사용 예
-- 서브쿼리 사용 예
select b.고객회사명
     , b.담당자명
  from 고객 b
 where b.고객번호 = ( select a.고객번호
                     from 주문 a
                    where a.주문번호 = 'H0250');

-- 서브쿼리 대신 inner join 사용 예
select b.고객회사명
     , b.담당자명
  from 고객 b
 inner join 주문 a
    on a.고객번호 = b.고객번호
 where a.주문번호 = 'H0250';

-- 2. 복수(멀티) 행 서브쿼리 사용 예
-- '부산광역시' 고객이 주문한 주문건수
select count(*) as 주문건수
  from 주문 b
 where b.고객번호 in ( select a.고객번호
                      from 고객 a
                     where a.도시 = '부산광역시' ) ;

-- '부산광역시' 전체고객의 마일리지 어느 하나보다도 마일리지가 큰 고객의 정보
-- 서브쿼리의 결과값중 어느 하나보다도 크면 선택됨
select a.담당자명
     , a.고객회사명
     , a.마일리지
  from 고객 a
 where a.마일리지 > any ( select b.마일리지
                         from 고객 b
                        where b.도시 = '부산광역시' );

select a.담당자명
     , a.고객회사명
     , a.마일리지
  from 고객 a
 where a.마일리지 > ( select min(b.마일리지)
                     from 고객 b
                    where b.도시 = '부산광역시' );

-- 각 지역의 어느 평균 마일리지 보다도 마일리지가 큰 고객의 정보
select a.담당자명
     , a.고객회사명
     , a.마일리지
  from 고객 a
 where a.마일리지 > all ( select avg(b.마일리지)
                         from 고객 b
                        group by b.지역 );

-- 서브쿼리의 결과값중 어떤것 모두 보다도 크면 선택됨
select a.담당자명
     , a.고객회사명
     , a.마일리지
  from 고객 a
 where a.마일리지 > all ( select b.마일리지
                         from 고객 b
                        where b.도시 = '부산광역시' );

select a.담당자명
     , a.고객회사명
     , a.마일리지
  from 고객 a
 where a.마일리지 > ( select max(b.마일리지)
                     from 고객 b
                    where b.도시 = '부산광역시' );

-- 한 번이라도 주문한적이 있는 고객의 정보
select a.고객번호
     , a.고객회사명
  from 고객 a
 where exists ( select b.고객번호
                  from 주문 b
                 where b.고객번호 = a.고객번호 )
 order by 1;

-- in 을 이용
select a.고객번호
     , a.고객회사명
  from 고객 a
 where a.고객번호 in ( select distinct b.고객번호
                      from 주문 b )
 order by 1;

select a.고객번호
     , a.고객회사명
  from 고객 a
 where a.고객번호 in ( select b.고객번호
                      from 주문 b
                     where b.고객번호 = a.고객번호 )
 order by 1;

-- join 을 이용
select distinct a.고객번호
     , a.고객회사명
  from 고객 a
 inner join 주문 b
    on b.고객번호 = a.고객번호
 order by 1;
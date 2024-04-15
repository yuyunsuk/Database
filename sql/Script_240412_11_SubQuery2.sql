/* 240412 */

-- 서브쿼리[SubQuery]
-- 단일행 =
-- 복수행 in, any, all, exists, not exists

-- 서버쿼리는 where 절 뿐만 아니라 select, from, having 에도 사용 가능

-- having 에 사용하는 예제
-- 고객 전체의 평균마일리지 보다 평균마일리지가 큰 도시
select 도시
     , avg(마일리지) as 평균마일리지
  from 고객
 group by 도시
having avg(마일리지) > ( select avg(마일리지)
                        from 고객 );

-- from 에 사용하는 예제 ('인라인뷰'라고 부름)
-- 담당자명, 고객회사명, 마일리지, 도시, 해당 도시의 평균마일리지
-- 도시의 평균마일리지와 각 고객의 마일리지의 차(-)도 함께 표현
select a.담당자명
     , a.고객회사명
     , a.마일리지
     , a.도시
     , b.도시평균마일리지
     , (b.도시평균마일리지 - a.마일리지) as 차이
  from 고객 a
     , ( select 도시
              , avg(마일리지) as 도시평균마일리지
           from 고객
          group by 도시 ) b 
 where a.도시 = b.도시;

select a.담당자명
     , a.고객회사명
     , a.마일리지
     , a.도시
     , b.도시평균마일리지
     , (b.도시평균마일리지 - a.마일리지) as 차이
  from 고객 a
 inner join ( select 도시
                   , avg(마일리지) as 도시평균마일리지
                from 고객
               group by 도시 ) b 
    on a.도시 = b.도시;

-- select 에 사용하는 예제
-- 하나의 컬럼 값만 반환하는 쿼리여야 함(Scalar SubQuery)
-- 고객번호, 담당자명, 고객의 최종주문일
select a.고객번호
     , a.담당자명
     , (select max(b.주문일)
          from 주문 b
         where b.고객번호 = a.고객번호) as 최종주문일
  from 고객 a;

-- 다중컬럼 서브쿼리 : 서브쿼리에서 여러개의 컬럼을 사용하는 경우
-- 각 도시마다 최고 마일리지를 보유한 고객의 정보

select 도시
     , max(마일리지)
  from 고객
 group by 도시;

select a.도시
     , a.담당자명
     , a.고객회사명
     , a.마일리지
  from 고객 a
     , (select 도시
             , max(마일리지) as 도시별최대마일리지
         from 고객
        group by 도시) b
 where a.도시   = b.도시
   and a.마일리지 = b.도시별최대마일리지;
 
select a.도시
     , a.담당자명
     , a.고객회사명
     , a.마일리지
  from 고객 a
 where (a.도시, a.마일리지) in (select 도시
                                , max(마일리지) as 도시별최대마일리지
                             from 고객
                            group by 도시);

-- 상관 서브쿼리(Corelated SubQuery)
/* main쿼리와 서브쿼리간의 상관관계를 포함하는 형태의 쿼리.
 * 상관서브쿼리는 메인쿼리와 한 행씩 실행하며 처리함.
 * 그렇기 때문에 실행속도가 늦어질 가능성이 있음 */
select a.사원번호
     , a.이름
     , a.상사번호
     , (select b.이름
          from 사원 b
         where b.사원번호 = a.상사번호 ) as 상사이름
 from 사원 a;

-- 특정 주문일 범위 안에서 각 주문번호당 총 판매금액
select a.주문번호
     , a.주문일
     , ( select sum(b.주문수량 * b.단가)
           from 주문세부 b
          where b.주문번호 = a.주문번호 ) as 총판매금액
  from 주문 a
 where a.주문일 between '2022-01-01'
                  and '2022-12-31';

-- 위의 쿼리를 join 으로 변경하면
select a.주문번호
     , a.주문일
     , sum(b.주문수량 * b.단가) as 총판매금액
  from 주문 a
  left outer join 주문세부 b
    on b.주문번호 = a.주문번호
 where a.주문일 between '2022-01-01'
                  and '2022-12-31'
 group by
       a.주문번호
     , a.주문일;

-- '배재용' 사원의 부서명
-- 비상관 쿼리
select 부서명
  from 부서
 where 부서번호 = ( select 부서번호 
                   from 사원
                  where 이름 = '배재용' );

select ( select b.부서명
           from 부서 b
          where b.부서번호 = a.부서번호 ) as 부서명
  from 사원 a
 where a.이름 = '배재용';

-- 담당자명, 고객회사명, 주문건수(count), 최초주문일(min), 최종주문일(max)
-- 서브쿼리 이용해서 표현하시오.
select a.담당자명
     , a.고객회사명
     , b.주문건수
     , b.최초주문일
     , b.최종주문일
  from 고객 a
 inner join ( select 고객번호
                   , count(*) as 주문건수
                   , min(주문일) as 최초주문일
                   , max(주문일) as 최종주문일
                from 주문
               group by 고객번호 ) b
    on b.고객번호 = a.고객번호;

select a.담당자명
     , a.고객회사명
  from 고객 a
 where not exists ( select *
                      from 주문 b
                     where b.고객번호 = a.고객번호 );

/* 1. 제품 테이블에 있는 제품 중 단가가 가장 높은 제품명 */
select a.제품명
     , a.단가
  from 제품 a
 where a.단가 = ( select max(단가) from 제품 );

/* 2. 제품 테이블에 있는 제품 중 단가가 가장 높은 제품의 주문수량합 */
select sum(a.주문수량) as 주문수량합
  from 주문세부 a
 where a.제품번호 = ( select 제품번호
                     from 제품
                    where 단가 = ( select max(단가) from 제품 ));

/* 3. '아이스크림' 제품의 주문수량합 */
select sum(a.주문수량) as 주문수량합
  from 주문세부 a
 where a.제품번호 in ( select b.제품번호
                     from 제품 b
                    where b.제품명 like '%아이스크림%' );

/* 4. '서울특별시' 고객들에 대한 주문년도별 주문건수 */
select year(a.주문일) as 주문년도
     , count(*)    as 주문건수
  from 주문 a
 where a.고객번호 in ( select b.고객번호
                      from 고객 b
                     where b.도시 = '서울특별시' )
 group by year(a.주문일);

-- //////////////////////////////////////////////////////////////
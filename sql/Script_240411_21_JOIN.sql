/* 240411 */

--[JOIN] 두개 이상의 테이블을 연결하여 데이터를 검색하는 방법
/*
<JOIN 의 종류>
cross join
inner join
outer join
self join
*/

-- 크로스 조인 : 한쪽 테이블의 각 행마다 다른 쪽 테이블의 모든 행이 한번씩
-- 매칭되는 조인을 의미
select 부서.부서번호
     , 부서명
     , 이름
     , 사원.부서번호
  from 부서
 cross join 사원
 where 이름 = '배재용';

select * from 부서; -- 4개

-- 내부조인(inner join) : 각 테이블에서 조인 조건에 일치하는 데이터만 조인
-- ANSI sql 조인 (American National Standards Institute[미국 표준 협회])
select 사원번호
     , 직위
     , 사원.부서번호
     , 부서명
  from 사원
 inner join 부서
    on 사원.부서번호 = 부서.부서번호
 where 이름 = '이소미';

-- Non-ANSI sql 조인 (위 방법과 결과는 같으나 문법이 다름)
select 사원번호
     , 직위
     , 사원.부서번호
     , 부서명
  from 사원, 부서
 where 사원.부서번호 = 부서.부서번호
   and 이름 = '이소미';

-- 고객회사들이 주문한 주문건수를 많은 순서대로 보이시오.
-- 컬럼은 고객번호, 담당자명, 고객회사명, 주문건수
select 고객.고객번호
     , 고객.담당자명
     , 고객.고객회사명
     , count(*) as 주문건수
  from 고객
 inner join 주문
    on 고객.고객번호 = 주문.고객번호
 group by 고객.고객번호
     , 고객.담당자명
     , 고객.고객회사명
 order by 4 desc;

-- 고객별로 주문금액 합을 보이되, 주문금액 합이 많은 순서대로
-- 컬럼은 고객번호, 담당자명, 고객회사명, 주문금액합
-- 고객, 주문, 주문세부
select c.고객번호
     , c.담당자명
     , c.고객회사명
     , sum(truncate((a.주문수량*a.단가)-(a.주문수량*a.단가*a.할인율), 1)) as 주문금액합
  from 고객 c
 inner join 주문 b 
    on c.고객번호 = b.고객번호
 inner join 주문세부 a
    on b.주문번호 = a.주문번호
 group by c.고객번호
     , c.담당자명
     , c.고객회사명
 order by 4 desc;

select c.고객번호
     , c.담당자명
     , c.고객회사명
     , sum(truncate((a.주문수량*a.단가)-(a.주문수량*a.단가*a.할인율), 1)) as 주문금액합
  from 고객 c
     , 주문 b
     , 주문세부 a
 where c.고객번호 = b.고객번호
   and b.주문번호 = a.주문번호
 group by c.고객번호
     , c.담당자명
     , c.고객회사명
 order by 4 desc;

-- 할인율을 반영하려면 아래 수식 사용!!
-- sum(truncate((주문수량*단가)-(주문수량*단가*할인율), 1)) as 주문금액

select * from 주문세부;

-- [연습1]
-- 모든 사원의 사원번호, 이름, 부서명 표시
select a.사원번호
     , a.이름
     , b.부서명
  from 부서 b
 inner join 사원 a
    on a.부서번호 = b.부서번호
 order by 1;

select * from 사원;

select a.사원번호
     , a.이름
     , b.부서명
  from 부서 b
 right outer join 사원 a
    on a.부서번호 = b.부서번호
 order by 1;

-- 주문번호 'H0255'의 제품명과 주문수량, 단가 표시
-- 테이블 이름이 길거나 많은 곳에 사용될 경우 별명을 사용하는 것이 좋다.
select a.주문번호
     , b.제품명
     , a.주문수량
     , a.단가
  from 제품 b
 inner join 주문세부 a
    on a.제품번호 = b.제품번호
 where a.주문번호 = 'H0255'
 order by 1;

select * from 주문세부 where 주문번호 = 'H0255';

-- Non-Equi Join
select a.고객번호
     , a.고객회사명
     , a.담당자명
     , a.마일리지
     , b.등급명
     , b.하한마일리지
     , b.상한마일리지
  from 마일리지등급 b
 inner join 고객 a
    on a.마일리지 >= b.하한마일리지
   and a.마일리지 <= b.상한마일리지
 where a.담당자명 = '이은광';

select a.고객번호
     , a.고객회사명
     , a.담당자명
     , a.마일리지
     , b.등급명
     , b.하한마일리지
     , b.상한마일리지
  from 마일리지등급 b
 inner join 고객 a
    on a.마일리지 between b.하한마일리지
                   and b.상한마일리지
 where a.담당자명 = '이은광';

select * from 고객;

-- 외부조인(Outer Join)
-- 사원중에 부서배치가 되지 않은 사원이 누구인지 확인 가능
-- outer 키워드는 생략 가능
select 사원번호
     , 이름
     , 부서명
  from 사원
  left outer join 부서 -- left join
    on 사원.부서번호 = 부서.부서번호;

-- 부서중에 사원이 소속되어 있지 않은 부서를 확인 가능
select 사원번호
     , 이름
     , 부서명
  from 사원
 right outer join 부서 -- right join
    on 사원.부서번호 = 부서.부서번호;

-- 셀프조인 : 동일한 테이블 안에서 한 컬럼이 다른 컬럼을 참조하는 경우에 사용
-- 마치 동일한 테이블을 다른 테이블인 것처럼 조인시키는 방법
-- 상사가 없는 사원까지 포함된 데이터를 요구할 경우 사용
select a.사원번호
     , a.이름
     , a.상사번호
     , b.이름   as 상사이름 
  from 사원 b
  right outer join 사원 a
    on a.상사번호 = b.사원번호
 order by 1;

-- [연습2]
/*
1. 제품테이블과 주문세부테이블을 조인하여 제품명별로 주문수량합과
주문금액합을 보이시오.
*/
select b.제품명
     , sum(a.주문수량) as 주문수량합
     , sum(a.주문수량*a.단가) as 주문금액합
  from 제품 b
 inner join 주문세부 a
    on a.제품번호 = b.제품번호
 group by b.제품명
 order by 1;

/*
2. 주문, 주문세부, 제품테이블을 조인하여 '아이스크림' 제품에 대하여
주문년도별 제품명별로 주문수량합을 보이시오.
*/
select year(b.주문일) as 주문년도
     , a.제품명
     , sum(c.주문수량) as 주문수량합
  from 주문세부 c
 inner join 주문 b
    on b.주문번호 = c.주문번호
 inner join 제품 a
    on a.제품번호 = c.제품번호
 where a.제품명 like '%아이스크림%'
 group by year(b.주문일)
     , a.제품명
 order by 1, 2;

select year(b.주문일) as 주문년도
     , a.제품명
     , sum(c.주문수량) as 주문수량합
  from 주문세부 c
     , 주문 b
     , 제품 a
 where a.제품번호 = c.제품번호 
   and b.주문번호 = c.주문번호 
   and a.제품명 like '%아이스크림%'
 group by year(b.주문일)
     , a.제품명
 order by 1, 2;

/* 3. 제품, 주문세부 테이블을 조인하여 제품명별로 주문수량합을 보이시오.
 * 이때 주문이 한 번도 안된 제품에 대한 정보도 나타내시오 */
select a.제품명
     , sum(ifnull(b.주문수량,0)) as 주문수량합
  from 제품 a
 left outer join 주문세부 b
    on b.제품번호 = a.제품번호
 group by a.제품명
 order by 1;

select a.제품번호
     , a.제품명
     , b.주문수량
  from 제품 a
  left outer join 주문세부 b
    on b.제품번호 = a.제품번호
 where b.제품번호 is null;

select a.제품명
  from 제품 a
 where a.제품번호 not in (select b.제품번호 from 주문세부 b);

select a.제품명
  from 제품 a
 where not exists (select b.제품번호
                     from 주문세부 b
                    where b.제품번호 = a.제품번호);

/* 4. 고객회사중 마일리지 등급이 'A'인 고객의 정보를 조회하시오.
 * 컬럼은 고객번호, 담당자명, 고객회사명, 등급명, 마일리지 */
select a.고객번호
     , a.담당자명
     , a.고객회사명
     , b.등급명
     , a.마일리지
     , b.하한마일리지
     , b.상한마일리지
  from 마일리지등급 b
 inner join 고객 a 
    on a.마일리지 between b.하한마일리지
                   and b.상한마일리지
 where b.등급명 = 'A';

select a.고객번호
     , a.담당자명
     , a.고객회사명
     , b.등급명
     , a.마일리지
     , b.하한마일리지
     , b.상한마일리지
  from 마일리지등급 b
 inner join 고객 a 
    on a.마일리지 >= b.하한마일리지
   and a.마일리지 <= b.상한마일리지
 where b.등급명 = 'A';
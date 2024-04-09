/* sql (Structured Query Language)
: 구조화된 요청 언어
: Database 에서 필요한 기능을 실행시키기 위한 명령어 모음
: 형태는 간단한 프로그래밍 명령어와 유사함
*/
use testdb;
-- use 명령어는 database를 선택한다는 뜻
select * from 고객;

select 고객번호, 담당자명, 고객회사명, 마일리지 from 고객; -- 특정 컬럼명을 명시하여 요청

select 고객번호
     , 담당자명
     , 고객회사명
     , 마일리지       as 포인트
     , 마일리지 * 1.1 as "10% 인상된 마일리지"
  from 고객;
-- as 는 별명이고, 인용부호는 별명에 특수문자가 있을 경우 사용
-- 테이블내의 컬럼이외에 새로운 컬럼을 보여줄 수 있다(실제 저장안됨)

select 고객번호
     , 담당자명
     , 마일리지
  from 고객
 where 마일리지 >= 100000;
-- 원하는 데이터를 필터링하여 가져오고 싶을때 where를 사용함
-- 순서가 중료. select from where 순서대로 사용함

select 고객번호
     , 담당자명
     , 도시
     , 마일리지
  from 고객
 where 도시 = '서울특별시'
 order by
       마일리지 desc;
-- 역시 키워드 사용 순서가 중요함. order by 가 제일 뒤
-- order by는 디폴트가 오름차순 이므로 내림차순은 desc를 사용해야 함.
/* '서울특별시'처럼 단따옴표가 기본, 쌍따옴표는 대소문자가 구별되어야하는
경우에만 사용하는 것이 권장됨 */

select 고객번호
     , 담당자명
     , 도시
     , 마일리지
  from 고객
 where 도시 = '서울특별시'
 order by
       마일리지 desc
 limit 10; -- limit 은 읽어오는 데이터의 갯수를 제한함. limit 2, 10; (2명 빼고 10명)

select 고객번호
     , 담당자명
     , 도시
     , 마일리지
  from 고객
 where 도시 = '서울특별시'
 order by
       마일리지 desc
 limit 10, 10;
/* 내림차순 이므로 상위 10명을 제외하고 그 이후 10명의 데이터를 읽은 방법임 */

-- 고객들이 위치한 도시정보만 보고 싶은 경우
select distinct 도시
  from 고객; -- distinct 는 중복제거

/* <sql 연습문제> */
/* 1. 모든 사원의 이름과 부서번호를 조회하세요. */
select 이름
     , 부서번호
  from 사원;

/* 2. 사원중에서 직위가 '과장'인 사원들의 이름과 직위를 사원번호의 내림차순으로 조회하세요. */

select distinct 직위 from 사원;
 
select 이름
     , 직위
     , 사원번호
  from 사원
 where 직위 = '과장'
 order by
       사원번호 desc;
 
/* 3. 고객번호가 'CCOPI'인 고객의 고객회사명과 담당자명을 조회하세요. */
select distinct 고객번호 from 고객;

select 고객회사명
     , 담당자명
  from 고객
 where 고객번호 = 'CCOPI';
      
/* 4. 주문일이 2021년5월1일 이후인 주문의 주문번호와 주문일을 최신 주문일 순으로 조회하세요. */

select 주문일 from 주문;

select 주문번호
     , 주문일
  from 주문
 where 주문일 > '2021-05-01'
 order by
       주문일 desc;

/* 5. 제품의 재고가 50개 미만인 제품들의 제품명과 재고를 조회하세요. */
select 제품명
     , 재고
  from 제품
 where 재고 < 50
 order by
       재고 desc, 제품명;
      
/* 6. 사원 중에서 남성 사원의 이름과 성별을 조회하세요. */
select distinct 성별 from 사원;
      
select 이름
     , 성별
  from 사원
 where 성별 = '남'
 order by
       이름;
      
/* 7. 고객의 마일리지가 1000이상인 고객들의 고객회사명과 마일리지를 조회하세요.
 *    결과는 마일리지가 높은 순으로 정렬하세요. */
select 고객회사명
     , 마일리지
  from 고객
 where 마일리지 >= 1000
 order by
       마일리지 desc;

/* 8. 주문세부에서 제품번호가 77인 제품의 주문번호와 주문수량을 조회하세요. */
select 주문번호
     , 주문수량
  from 주문세부
 where 제품번호 = 77;

/* 9. 주문일이 2021년 1월 1일이전인 주문의 주문번호와 주문일을 조회하세요. */
select 주문번호
     , 주문일
  from 주문
 where 주문일 < '2021-01-01';

/* 10. 사원의 성별이 여성이고, 직위가 '사원'인 사원들의 이름과 성별, 직위를 조회하세요. */
select 이름
     , 성별
     , 직위
  from 사원
 where 성별 = '여'
   and 직위 = '사원';

/* 11. 제품의 단가가 8000원 이상인 제품들 중에서 제품명 순으로 정렬하여 조회하세요. */
select 제품명
  from 제품
 where 단가 >= 8000
 order by 제품명 ASC;

/* 12. 주문세부에서 주문수량이 5개 이상인 주문의 주문번호와 주문수량을 조회하세요. 결과는 주문수량이 많은 순으로 정렬하세요. */
select 주문번호
     , 주문수량
  from 주문세부
 where 주문수량 >= 5
 order by
       주문수량 desc;

/* 13. 사원의 생일이 1990년 1월 1일 이후인 사원들의 이름과 생일을 조회하세요. */
select 이름
     , 생일
  from 사원
 where 생일 > '1990-01-01';

/* 14. 사원의 직위가 '사원'인 사람들 중에서 가장 최근에 입사한 사원의 이름과 입사일을 조회하세요. */
select 이름
     , 입사일
  from 사원
 where 직위 = '사원'
 order by
       입사일 desc
 limit 1;

/* 15. 고객들 중에서 도시가 '대전광역시'인 고객들의 고객번호와 고객회사명을 조회하세요. */
select 고객번호
     , 고객회사명
  from 고객
 where 도시 = '대전광역시';


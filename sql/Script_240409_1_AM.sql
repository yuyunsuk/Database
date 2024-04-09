/* 240409 */

use testdb;

-- 산술 연산자
select 23 + 5
     , 23 - 5
     , 23 * 5
     , 23 / 5
     , 23 div 5 -- div는 정수형 나누기(정수의 결과값이 출력됨)
     , 23 % 5
     , 23 mod 5;

-- 비교 연산자
select 23 >= 5
     , 23 <= 5
     , 23 > 23
     , 23 < 23
     , 23 = 23
     , 23 != 23
     , 23 <> 23; -- <> 같지 않다 표시, true(1), false(0)

-- 논리 연산자
select *
  from 고객
 where 도시 = '부산광역시'
   and 마일리지 < 1000;

-- 집합 연산자 (Union, Union All)
-- 1) 첫번째와 두번째 select 문의 컬럼 갯수 동일
-- 2) 컬럼이 다르다면 테이터타입은 같아야함(하나는 문자, 하나는 숫자면 오류)
-- union all 은 중복 허용
select 고객번호
     , 담당자명
     , 마일리지
     , 도시
  from 고객
 where 도시 = '부산광역시'
union
select 고객번호
     , 담당자명
     , 마일리지
     , 도시
  from 고객
 where 마일리지 < 1000
 order by
       마일리지 desc; -- 49개 (중복 제거 합치기)

select 고객번호
     , 담당자명
     , 마일리지
     , 도시
  from 고객
 where 도시 = '부산광역시'
   and 마일리지 < 1000; -- 1개
 
select 고객번호
     , 담당자명
     , 마일리지
     , 도시
  from 고객
 where 도시 = '부산광역시'
union all
select 고객번호
     , 담당자명
     , 마일리지
     , 도시
  from 고객
 where 마일리지 < 1000; -- 50개 (중복 상관없이 합치기)

select 도시
  from 고객
 where 도시 = '부산광역시'
union
select 도시
  from 고객
 where 마일리지 < 1000; -- 중복제거(합친 후 distinct 효과)

select 도시
  from 고객
 where 도시 = '부산광역시';

-- IS NULL
-- empty value(빈값)와 null은 다른 개념임
update 고객
   set 지역 = null
 where 고객회사명 = '굿모닝서울';

select *
  from 고객
 where 지역 is null;

select *
  from 고객
 where 지역 = '';

-- in 연산자 (or 연산자의 간편버전)

select distinct 담당자직위 from 고객;

select 고객번호
     , 담당자명
     , 담당자직위
  from 고객
 where 담당자직위 = '영업 과장'
    or 담당자직위 = '마케팅 과장';

select 고객번호
     , 담당자명
     , 담당자직위
  from 고객
 where 담당자직위 in ('영업 과장','마케팅 과장');

-- between and (범위를 표현, ~이상이고 ~이하) => 시작과 끝값을 포함
select 담당자명
     , 마일리지
  from 고객
 where 마일리지 >= 10000
   and 마일리지 <= 20000;

select 담당자명
     , 마일리지
  from 고객
 where 마일리지 between 10000
                 and 20000;

-- LIKE 연산자 (문자열의 특정 패턴을 필터링)
-- 특수문자 %, _ 사용
select *
  from 고객
 where 도시 like '%광역시'; -- %는 여러개의 문자가 존재할 수 있음을 의미

select *
  from 고객
 where 도시 like '%광역%'; -- 도시가 광역이 들어가는 모든 데이터

select *
  from 고객
 where 도시 like '부산%'; -- 도시가 부산으로 시작되는 모든 데이터

select *
  from 고객
 where 도시 like '%시'; -- 도시가 시로 끝나는 모든 데이터

--------------------------------------------------------

select *
  from 고객
 where 고객번호 like '_C%'; -- 정확히 한 개의 문자를 의미 (고객번호 2번째 자리가 C인 모든 데이터)

select *
  from 고객
 where 고객번호 like '__C%'; -- (고객번호 3번째 자리가 C인 모든 데이터)

--------------------------------------------------------
 
-- 전화번호 뒷자리가 45로 끝나는 고개
select *
  from 고객
 where 전화번호 like '%45';

-- 전화번호중 뒤에서 3번째 부터가 98인 고객
select *
  from 고객
 where 전화번호 like '%98_';

-- 전화번호에 45가 들어가는 고객
select *
  from 고객
 where 전화번호 like '%45%';
 
-- '서울'에 사는 고객중에 마일리지가 15000점 이상 20000점 이하인 고객
select *
  from 고객
 where 도시 like '%서울%'
   and 마일리지 between 15000
                 and 20000;

-- '춘천' 또는 '과천'에 사는 고객중 담당자직위에 '이사'가 들어가는 고객
select distinct 도시 from 고객;

select *
  from 고객
 where 도시 in ('춘천시','과천시')
   and 담당자직위 like '%이사%';

select *
  from 고객
 where (도시 like '%춘천%' or 도시 like '%과천%')
   and 담당자직위 like '%이사%';

-- '광역시' 또는 '특별시'에 살지않는 고객중 마일리지가 많은 상위 3명의 고객
-- '광역시'에 살지않고 [그리고] '특별시'에 살지않는 고객중 마일리지가 많은 상위 3명의 고객
select *
  from 고객
 where (도시 not like '%광역시%' and 도시 not like '%특별시%')
 order by 마일리지 desc
limit 3;

select *
  from 고객
 where not (도시 like '%광역시%' or 도시 like '%특별시%')
 order by 마일리지 desc
limit 3;

--------------------------------------------------------

-- 제품중에서 '주스' 제품에 대한 정보
select *
  from 제품
 where 제품명 like '%주스%'
 order by 제품명;

-- 단가가 5000원 이상 10000원 이하인 '주스' 제품
select *
  from 제품
 where 단가 between 5000
              and 10000
   and 제품명 like '%주스%'
 order by 단가 desc;

-- 제품번호가 1,2,4,7,11,20인 제품
select *
  from 제품
 where 제품번호 in (1,2,4,7,11,20)
 order by 제품번호;

/* 재고금액이 높은 상위 10개 제품에 대한 제품번호, 제품명, 단가, 재고,
   재고금액(단가*재고) */
select 제품번호
     , 제품명
     , 단가
     , 재고
     , (단가*재고) as 재고금액
  from 제품
 order by 5 desc -- 숫자는 select의 컬럼순서(5=재고금액)
 limit 10;
/* 240409 */

-- [Maria SQL 함수]
-- [문자 함수]

-- char_length, length
select char_length('hello')
     , length('hello')
     , char_length('안녕')   -- 문자의 갯수
     , length('안녕');       -- 바이트수

-- concat
-- concat_ws => with separator
select concat('dreams','come','true');
select concat_ws('-','2023','01','29');

-- left
-- right
-- substr
select left('SQL 공부', 3);  -- 왼쪽에서 3개 'SQL'

select right('SQL 공부', 3); -- 오른쪽에서 3개 ' 공부'

select substr('SQL 공부', 3, 4); -- 3자리에서 4개('L 공부')

select substr('SQL 공부', 5); -- 5자리에서 끝까지('공부')

-- substring_index 구분자를 만날때가지 문자열을 잘라냄
-- 인덱스는 몇번째 구분자를 만날때까지 자를지를 결정
-- 인덱스가 음수면 오른쪽부터 몇번째 구분자를 만날때까지 자를지를 결정
select substring_index('서울시 동작구 흑석동', ' ', 1); -- ' ' 구분자를 1개 만날때 잘라냄, [서울시]
select substring_index('서울시 동작구 흑석동', ' ', 2); -- ' ' 구분자를 2개 만날때 잘라냄, [서울시 동작구]
select substring_index('서울시 동작구 흑석동', ' ', 3); -- ' ' 구분자를 3개 만날때 잘라냄, [서울시 동작구 흑석동]
select substring_index('서울시 동작구 흑석동', ' ', -1); -- ' ' 구분자를 오른쪽 부터 1개 만날때 잘라냄, [흑석동]
select substring_index('서울시 동작구 흑석동', ' ', -2); -- ' ' 구분자를 오른쪽 부터 2개 만날때 잘라냄, [동작구 흑석동]
select substring_index(
       substring_index('서울시 동작구 흑석동', ' ', 2),' ', -1); -- ' ' 구분자를 왼쪽에서 2번째 까지 만날때 잘라낸후 오른쪽 부터 1개 만날때 잘라냄, [동작구]

-- lpad 지정한 길이에서 문자열을 제외한 나머지를 특수문자로 왼쪽부터 채움
-- rpad 오른쪽부터 채움
select lpad('sql', 10, '#')
     , rpad('sql', 5, '*');

-- ltrim 왼쪽 공백 제거
-- rtrim 오른쪽 공백 제거
-- trim 양쪽 공잭 제거
select ltrim('    sql')
     , rtrim('slq    ')
     , trim('   sql  ');

-- field 문자열의 위치를 찾음
-- field(찾는문자열, 문자열1, 문자열2, 문자열3, ...)
-- find_in_set 문자열 리스트에서 지정한 문자열을 찾음
-- find_in_set (찾는 문자열, 문자열 리스트)
select field('java', 'sql', 'java', 'javascript'); -- 2
select find_in_set('java', 'sql,java,javascript'); -- 2 (set 안에서 찾음)

-- locate 기준문자열에서 부분문자열의 위치을 찾음
-- locate(부분문자열, 기준문자열)
select locate('world', 'hello world.'); -- 7

-- elt 지정한 위치에 있는 문자열을 반환
select elt(2, 'sql', 'java', 'javascript'); -- 'java' 

-- repeat 문자열의 반복
select repeat('*', 5);

-- replace 문자열의 일부를 다른 문자열로 대체
-- replace(기준문자열, 바꿀문자열, 바뀔문자열)
select replace('010_1234_5678', '_', '-'); -- 010-1234-5678

-- reverse 문자열 거꾸로 바꿈
select reverse('hello');

-- [숫자 함수]
-- ceiling (올림)
-- floor (내림)
-- round (반올림, 두번째 매개변수 자리에 반올림 자릿수 표시가능)
-- truncate (버림, 지정한 위치에서 버림)
select ceiling(123.16)
     , floor(123.56)
     , round(123.56, 1)
     , truncate(123.56, 1);

-- abs (절대값)
-- sign (음수 -1, 양수 1)
select abs(-120)
     , sign(-120);

-- power (제곱)
-- sqrt (제곱근, 루트)
-- rand (랜덤넘버, 매개변수는 seed의 의미, seed가 같으면 랜덤값이 동일함)
select power(2, 3) -- 8 (2의 3승) 
     , sqrt(16) -- 4
     , rand()
     , rand(100)
     , rand(200);

-- [날짜, 시간 함수]
-- now
-- sysdate
-- curdate
-- curtime
select now()      -- 현재 날짜와 시간
     , sysdate()  -- 현재 시스템의 날짜와 시간(대부분 now와 동일)
     , curdate()  -- 현재 날짜
     , curtime(); -- 현재 시간

-- 연도,분기,월,일,시,분,초 반환 함수
select now()
     , year(now())
     , quarter(now())
     , month(now())
     , day(now())
     , hour(now())
     , minute(now())
     , second(now());

-- datediff 날짜간의 일수 차이
-- timestampdiff 두 날짜의 시간을 기준시간으로 변환하여 차를 계산하고
-- 다시 날짜로 변환하는 내부 프로세스를 따름
select now()
     , datediff('2025-12-20', now()) -- 620 (날짜 기준으로 계산), 큰일자가 앞으로 datediff(큰일자, 작은일자)
     , datediff(now(), '2025-12-20') -- -620
     , timestampdiff(year, now(), '2025-12-20')
     , timestampdiff(month, now(), '2025-12-20')
     , timestampdiff(day, now(), '2025-12-20'); -- 619 (시간 기준으로 계산), 큰 일자가 뒤로 timestampdiff(year, 작은일자, 큰일자)

-- adddate 특정날짜에 기간을더한 날짜 반환
-- subdate 특정날짜에 기간을 뺀 날짜 반환
select now()
     , adddate(now(), 50)
     , adddate(now(), -50)
     , subdate(now(), 50)
     , adddate(now(), interval 50 day)
     , adddate(now(), interval 50 month)
     , adddate(now(), interval 50 year)
     , subdate(now(), interval 50 hour);

-- last_day 그 달의 마지막 날
-- dayofyear 현재 연도에서 며칠이 지났는지
-- monthname 월을 영문으로 알려줌
-- weekday 요일을 정수로 알려줌 (MySql의 경우, 월[0] ~ 일[6])
select now()
     , last_day(now())
     , dayofyear(now())
     , monthname(now())
     , weekday(now()) -- 2024-04-09
     , weekday('2024-04-08')
     , weekday('2024-04-14');

-- [제어 함수, 현변환 함수]
-- cast 데이터타입을 변경시킴
-- MySql/Maria 의 데이터타입
-- char, signed, unsigned, date, datetime, time, binary
select cast('1' as unsigned)
     , cast(2 as char);

-- if(조건식, 참인 경우, 거짓인 경우)
select if(12500 * 450 > 500000, '초과달성', '미달성');

-- ifnull(A, B)
-- A가 null이면 B, A가 null이 아니면 A를 반환
select ifnull(5, 'null')
     , ifnull(null, '값이 없음')
     , ifnull(1/0, null);

-- nullif
-- NULLIF(수식1, 수식2) : 수식1 = 수식2 이면 null이 반환, 다르면 수식1 반환
select nullif(100, 100)
     , nullif(200, 100);

-- case
-- 'case when 조건 then 실행'의 형태로 조건에 따른 실행을 여러개 설정가능
-- 조건의 마지막에 나머지를 의미하는 else 사용(사용하지 않아도 됨)
-- case문의 마지막을 의미하는 end 반드시 사용!!
select case when 12500 * 450 > 500000 then '초과달성'
            when 2500 * 450 > 400000 then '달성'
            else '미달성'
       end;
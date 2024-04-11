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
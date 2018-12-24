
1. 수강하는 과목별 중간고사, 기말고사 성적을 저장하는 테이블(Grade) 생성.
#Grade 테이블 생성
create table Grade(  
    id int unsigned not null auto_increment primary key,
    midterm smallint unsigned not null default 0,
    finalterm smallint unsigned not null default 0,
    enroll smallint unsigned not null
);

START TRANSACTION;

다른 설정 값
Grade테이블 편집 -> Indexes 탭 -> 컬럼 enroll에 인덱스 생성
Grade테이블 편집 -> 컬럼 enroll에 UQ값을 줌


2. 수강테이블 기준으로 샘플 데이터를 중간(midterm), 기말(finalterm), 성적(100점 만점)으로 구성.
START TRANSACTION;
insert into Grade(enroll) (select id from Enroll order by id);
 
update Grade set midterm = (floor(rand() * 101));
update Grade set finalterm = (floor(rand() * 101));
COMMIT;

# 데이터 검증
select * from Grade;


3. 과목별 수강생을 과목/성적 순으로 아래와 같은 형식으로 출력하는 SQL을 작성하시오.

select sub.name as '과목명', stu.name as '학생명', g.midterm as '중간', g.finalterm as '기말',
          midterm + g.finalterm as '총점',  round((g.midterm + g.finalterm) / 2 , 1) as '평균',
          case when round((g.midterm + g.finalterm) / 2 , 1) >= 90 then 'A' 
               when round((g.midterm + g.finalterm) / 2 , 1) >= 80 then 'B' 
               when round((g.midterm + g.finalterm) / 2 , 1) >= 70 then 'C' 
               when round((g.midterm + g.finalterm) / 2 , 1) >= 60 then 'D' 
               when round((g.midterm + g.finalterm) / 2 , 1) >= 50 then 'E' 
           else 'F' end as '학점' 
from Grade g inner join (Enroll e inner join Student stu on e.student = stu.id
                        inner join Subject sub on e.subject = sub.id) on g.enroll = e.id
order by 1, 5 desc;


4.과목별 통계 리포트를 과목순으로 하여 아래와 같이 출력하는 SQL을 작성하시오.
# T1 테이블 생성.(문제3을 그대로 가져오는 테이블을 생성)
create table T1(
    id smallint unsigned not null auto_increment primary key,
    subject_t varchar(31) not null,
    student_t varchar(31) not null,
    midterm_t smallint unsigned not null,
    finalterm_t smallint unsigned not null,
    sum_t smallint unsigned not null,
    avg_t smallint unsigned not null,
    level_t varchar(10) not null
);

# 값을 넣어줌
START TRANSACTION;
insert into T1(subject_t , student_t, midterm_t, finalterm_t, sum_t , avg_t, level_t ) select sub.name as '과목', stu.name as '학생명', 
            g.midterm as '중간고사', g.finalterm as '기말고사',
            midterm + g.finalterm as '총점',  round((g.midterm + g.finalterm) / 2 , 1) as '평균',
            case when round((g.midterm + g.finalterm) / 2 , 1) >= 90 then 'A' 
                 when round((g.midterm + g.finalterm) / 2 , 1) >= 80 then 'B' 
                 when round((g.midterm + g.finalterm) / 2 , 1) >= 70 then 'C' 
                 when round((g.midterm + g.finalterm) / 2 , 1) >= 60 then 'D' 
                 when round((g.midterm + g.finalterm) / 2 , 1) >= 50 then 'E' 
         else 'F' end as '학점' 
from Grade g inner join (Enroll e inner join Student stu on e.student = stu.id
         inner join Subject sub on e.subject = sub.id) on g.enroll = e.id
order by 1, 6 desc;
COMMIT;

select t.subject_t as '과목', round(avg(t.avg_t), 1) as '평균', count(t.student_t) as '학생 수',  
      (select student_t from T1 where subject_t = t.subject_t and sum_t = max(t.sum_t) limit 1) as '최고득점자',
      max(t.sum_t) as '최고점수'
from T1 t
group by t.subject_t
order by 1;

5) 학생별 통계 리포트를 성적순으로 하여 아래와 같이 출력하는 SQL을 작성하시오.

select student_t as '학생명', count(subject_t) as '과목수', sum(sum_t) as '총점', round(sum(avg_t)/count(subject_t), 1) as '평균', 
       case when round(sum(avg_t)/count(subject_t), 1) >= 90 then 'A' 
            when round(sum(avg_t)/count(subject_t), 1) >= 80 then 'B' 
            when round(sum(avg_t)/count(subject_t), 1) >= 70 then 'C' 
            when round(sum(avg_t)/count(subject_t), 1) >= 60 then 'D' 
            when round(sum(avg_t)/count(subject_t), 1) >= 50 then 'E' 
            else 'F' end as '평점' 
from T1
group by 1
order by 3  desc;

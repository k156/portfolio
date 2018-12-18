# 학번, 학생명, 수강과목수, 전과목 평균점수 컬럼( 총 4개 컬럼)을 갖는 view를 작성하시오.

drop view if exists AvrGrade;
create view AvrGrade as
select s.id as id, s.name as `name`, count(e.subject) as subjects,  round(avg(midterm + finalterm)/2) as `avg`
from Student s inner join Enroll e on s.id = e.student
			    inner join Grade g on g.enroll = e.id
                group by s.id;
                
                
select * from AvrGrade;
                

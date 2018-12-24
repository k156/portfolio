
2.학생테이블과 과목테이블을 활용하여, 수강내역 테이블에 테스트용 데이터를 구성하는 DML을 절차적으로 작성하시오.
-------------------------------------------------------------------------------------------------------------
insert into Enroll(student, subject)
 select id, (select id from Subject order by rand() limit 1) sid from Student order by id;

insert into Enroll(student, subject)
 select id, (select id from Subject order by rand() limit 1) sid from Student order by rand() limit 500
 on duplicate key update student = student;
 
insert into Enroll(student, subject)
 select id, (select id from Subject order by rand() limit 1) sid from Student order by rand() limit 500
 on duplicate key update student = student;
 
 

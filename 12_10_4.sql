4. 학과 테이블(Dept)을 만들고 5개 학과 이상 샘플 데이터를 등록하고, 학생 테이블에 학과 칼럼(dept)을 추가한 후 모든 학생에 대해 랜덤하게 과 배정을 시키시오.
 
# 학과 테이블 생성
CREATE TABLE `dooodb`.`Dept` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(31) NOT NULL,
  `prof` SMALLINT(5) UNSIGNED NULL,
  `student` INT(11) UNSIGNED NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;

Alter table Dept ADD constraint foreign key (prof) references Prof(id);
Alter table Dept ADD constraint foreign key (student) references Student(id);

START TRANSACTION;

#학과 샘플데이터 등록
insert into Dept (name) values ('생명과학과');
insert into Dept (name) values ('생명공학과');
insert into Dept (name) values ('화공생명공학과');
insert into Dept (name) values ('농생물학과');
insert into Dept (name) values ('생명자원학과');

select * from Dept;



# 과대표 추가
update Dept d set student = (select id from Student where dept = d.id order by rand() limit 1);
select * from Dept;

#지도교수 추가
update Dept set prof = (select id from Prof order by rand() limit 1) where prof > 0;
select * from Dept;


#학생 테이블에 학과 컬럼 추가
Alter table Student Add column dept int after gender;
desc Student;


#랜덤하게 과 배정
Update Student set dept = (select id from Dept order by rand() limit 1) where id > 0;
#과별 학생수
select dept, count(*) from Student group by dept;
# 동일학과에 중복학생 존재 여부 체크
select dept, id from Student group by dept, id having count(*) >1;


Commit;

  
  

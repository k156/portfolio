1. 학생, 과목, 교수, 수강내역 테이블을 관계를 고려하여 생성하는 DDL을 작성하시오.
----------------------------------------------------------------------
CREATE TABLE `Student` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `addr` varchar(30) DEFAULT NULL,
  `birth` date DEFAULT NULL,
  `tel` varchar(15) DEFAULT NULL,
  `email` varchar(31) DEFAULT NULL,
  `regdt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gender` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8;


CREATE TABLE `Subject` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(31) DEFAULT NULL,
  `prof` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uq_subject_name` (`name`),
  KEY `Subject_ibfk_prof_idx` (`prof`),
  CONSTRAINT `Subject_ibfk_prof` FOREIGN KEY (`prof`) REFERENCES `Prof` (`id`) ON DELETE SET NULL ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;


CREATE TABLE `Prof` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(31) DEFAULT NULL,
  `likecnt` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;


CREATE TABLE `Enroll` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subject` smallint(5) unsigned NOT NULL,
  `student` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Enroll_ibfk_2` (`student`),
  KEY `Enroll_ibfk_1_idx` (`subject`),
  CONSTRAINT `Enroll_ibfk_1` FOREIGN KEY (`subject`) REFERENCES `Subject` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `Enroll_ibfk_2` FOREIGN KEY (`student`) REFERENCES `Student` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2046 DEFAULT CHARSET=utf8;




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
 
 
 
3.동아리(Club)별 회원 테이블(ClubMember)을 다음과 같이 만들고, 동아리별 50명 내외로 가입시키시오. (단, Club 테이블의 leader 컬럼은 삭제하고, 리더를 회원테이블의 레벨 2q2

 #ClubMember 테이블 생성
CREATE TABLE `dooodb`.`ClubMember` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `club` VARCHAR(31) NOT NULL,
  `student` INT NULL,
  `level` TINYINT(0) NULL DEFAULT 0 ,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


START TRANSACTION;
#ClubMember에 클럽이름, 클럽장 입력하기
insert into ClubMember(club) select name from Club order by id;
insert into ClubMember(student) select leader from Club order by id;
update ClubMember set level = 2 where id between 1 and 3;
select * from ClubMember;

#ClubMember에 클럽간부 입력하기 
insert into ClubMember(student, club)
select id, (select id from Club order by rand() limit 1) from Student order by id limit 10
on duplicate key update student = student;
update ClubMember set level = 1 where id > 3; 
select * from ClubMember;

#ClubMember에 클럽회원 입력하기 
insert into ClubMember(student, club)
select id, (select id from Club order by rand() limit 1) from Student order by id limit 40
on duplicate key update student = student;
update ClubMember set level = 0 where id > 21; 
select * from ClubMember;

# Club 테이블에서 leader 삭제
ALTER TABLE `dooodb`.`Club` 
DROP FOREIGN KEY `Club_ibfk_1`;
ALTER TABLE `dooodb`.`Club` 
DROP INDEX `fk_leader_student`;

Alter table Club drop leader;
select * from Club;

#ClubMember 테이블에 FK 추가
#Update ClubMember set club = 1 where id = 1;
#Update ClubMember set club = 2 where id = 2;
#Update ClubMember set club = 4 where id = 3;

ALTER TABLE `dooodb`.`ClubMember` 
CHANGE COLUMN `club` `club` SMALLINT UNSIGNED NULL DEFAULT NULL ,
CHANGE COLUMN `student` `student` INT(11) UNSIGNED NULL DEFAULT NULL ;

ALTER TABLE ClubMember ADD Constraint FOREIGN KEY (student) REFERENCES Student(id);
ALTER TABLE ClubMember ADD Constraint FOREIGN KEY (club) REFERENCES Club(id);

select * from ClubMember;

COMMIT;


select * from Dept;



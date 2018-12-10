5. 강의실 테이블(Classroom)을 만들고, 샘플 강의실 10개를 등록하고, 과목별 강의실 배치를 위해 과목(Subject) 테이블에 강의실 컬럼(Classroom) 추가한 후 배정하시오.
  
  CREATE TABLE `dooodb`.`Classroom` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `room_num` SMALLINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `room_num_UNIQUE` (`room_num` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


select * from Classroom;

# 샘플강의실 등록
insert into Classroom (room_num) values (101);
insert into Classroom (room_num) values (102);
insert into Classroom (room_num) values (103);
insert into Classroom (room_num) values (104);
insert into Classroom (room_num) values (105);
insert into Classroom (room_num) values (106);
insert into Classroom (room_num) values (107);
insert into Classroom (room_num) values (108);
insert into Classroom (room_num) values (109);
insert into Classroom (room_num) values (110);


# Subject 테이블에 Classroom 컬럼 추가
Alter table Subject add column classroom smallint;
desc Subject;

#강의실 배정
update Subject set classroom = (select room_num from Classroom order by rand() limit 1) where id > 0;
select * from Subject;

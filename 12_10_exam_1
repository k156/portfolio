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




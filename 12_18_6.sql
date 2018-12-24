# 과목별 Top3 학생의 이름과 성적을 한줄로 표현하는 리포트를 출력하는 프로시저를 작성하시오. (단, 성적은 중간, 기말 평균이며, 과목명 오름차순으로 정렬하시오)



-- v_grade_enroll 뷰 생성

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `dooo`@`%` 
    SQL SECURITY DEFINER
VIEW `v_grade_enroll` AS
    SELECT 
        `g`.`id` AS `id`,
        `stu`.`name` AS `student_name`,
        `sub`.`name` AS `subject_name`,
        `g`.`midterm` AS `midterm`,
        `g`.`finalterm` AS `finalterm`,
        `g`.`avr` AS `avr`,
        `g`.`enroll` AS `enroll`,
        `e`.`subject` AS `subject`,
        `e`.`student` AS `student`
    FROM
        (((`Grade` `g`
        JOIN `Enroll` `e` ON ((`g`.`enroll` = `e`.`id`)))
        JOIN `Student` `stu` ON ((`e`.`student` = `stu`.`id`)))
        JOIN `Subject` `sub` ON ((`e`.`subject` = `sub`.`id`)));
        
select * from v_grade_enroll;

delimiter $$
create procedure sp_subject_top_3( )


BEGIN

    declare _isdone boolean default False;
    declare _sub_name varchar(31);
    declare `_stu_name` varchar(31);
    declare _score smallint;
    declare i smallint default 0 ;

    declare top_3 CURSOR FOR
        select subject_name, student_name, max(avr)
        from v_grade_enroll 
        group by subject_name, student_name 
        order by 1, 3 desc;
    
    declare continue handler 
        for not found set _isdone = True;
        
    drop table if exists t_g_top_3;
    
    create temporary table t_g_top_3 (
        `sub_name` varchar(31) default ' ' primary key,
        `1st_stu` varchar(31) default ' ',
        `1st_score` smallint default 0 ,
        `2nd_stu` varchar(31) default ' ',
        `2nd_score` smallint default 0 ,
        `3rd_stu` varchar(31) default ' ',
        `3rd_score` smallint default 0,
        `cnt` smallint default 1 
         );


  OPEN top_3  ;
        

  loop1 : LOOP
    
    Fetch top_3  into _sub_name,  _stu_name , _score  ;
    
        IF not exists (select * from t_g_top_3 where sub_name = `_sub_name`) THEN
            insert into t_g_top_3(`sub_name`, `1st_stu`, `1st_score`) value(_sub_name, _stu_name, _score );

        ELSEIF  exists (select * from t_g_top_3 where sub_name = `_sub_name` and cnt = 1) THEN
             update t_g_top_3 set `2nd_stu`= _stu_name, `2nd_score` = _score, cnt = cnt + 1
              where `sub_name` = _sub_name and cnt = 1  ;

    ELSE 
             update t_g_top_3 set `3rd_stu`= _stu_name, `3rd_score` = _score, cnt = cnt + 1
              where `sub_name` = _sub_name and cnt = 2  ;
             
        END IF;
        
    
    IF _isdone THEN
            LEAVE loop1;
        END IF;
       
  END LOOP loop1;
    
  CLOSE  top_3 ;
    
    select sub_name as '과목', 1st_stu as '1등' , 1st_score as '점수', 2nd_stu as '2등', 2nd_score as '점수',
           3rd_stu as '3등', 3rd_score as '점수'
      from t_g_top_3
      order by 1;


END  $$

delimiter ;

call  sp_subject_top_3() ;

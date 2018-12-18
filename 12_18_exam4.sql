# 지난 학기 데이터 (수강학생수, 성적 등)을 기준으로 인기교수(강좌) Top 3를 추천하는 Stored Procedure를 작성하시오. 단, 데이터의 가중치는 자유롭게 부여하시오.



DROP Procedure IF EXISTS sp_top3;
DELIMITER $$
CREATE Procedure sp_top3(OUT po_lecture varchar(31), po_lecture2 varchar(31), po_lecture3 varchar(31))

BEGIN

create temporary table top_3 (
by_cnt int not null,
cnt int not null,
by_grade int not null,
avg_grd int not null,
by_likes int not null,
likecnt int not null);

insert into top3 (by_cnt, cnt) values (select subject, count(*)from Enroll group by subject order by count(*) desc limit 1);

insert into top3 (by_grade, avg_grd) values (select sbj.id, round(avg(g.avr)) s from Grade g inner join Enroll e on e.id = g.enroll 
											   inner join Subject sbj on e.subject = sbj.id
                                               group by e.subject order by s desc limit 1);

insert into top3 (by_likes, likecnt) values (select sbj.id, likecnt from Prof p inner join Subject sbj on sbj.prof = p.id order by likecnt desc limit 1);


select by_cnt, by_grade, by_likes from top3;




END $$
DELIMITER ;

call sp_top3();


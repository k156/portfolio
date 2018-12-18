# 클럽(Club)을 하나 추가하면 클럽회원(ClubMember)으로 임의의 한 학생(Student)을 회장으로 자동 등록하는 Trigger를 작성하시오.


DELIMITER //
Create Trigger auto_assign_leader
 AFTER INSERT on Club FOR EACH ROW
BEGIN
    insert into ClubMember (club, student, level) value (
    NEW.id,
    (select s.id from Student s inner join ClubMember c on s.id = c.student  
								where c.level = 0 order by rand() limit 1), 2 
                                );

END //
DELIMITER ;

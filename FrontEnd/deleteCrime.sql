USE nypd_police;
DROP PROCEDURE IF EXISTS deleteCrime; # delete a crime record
DELIMITER //
CREATE PROCEDURE deleteCrime(IN comp_number INT)
BEGIN
  DELETE FROM complaint_info # delete from parent tabe so child tables are also updated
  WHERE complaint_num = comp_number;
END//
DELIMITER ;


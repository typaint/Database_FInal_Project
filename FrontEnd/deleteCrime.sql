USE nypd_police;
DROP PROCEDURE IF EXISTS deleteCrime;
DELIMITER //
CREATE PROCEDURE deleteCrime(IN complaint_number INT)
BEGIN
  DELETE FROM police_mega
  WHERE complaint_num = complaint_number;
END//
DELIMITER ;
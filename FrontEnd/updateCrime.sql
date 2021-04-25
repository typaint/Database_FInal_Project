USE nypd_police;
DROP PROCEDURE IF EXISTS updateCrime;
DELIMITER //
CREATE PROCEDURE updateCrime(IN comp_number INT, IN end_time_new TIME, IN end_date_new CHAR(10)) 
BEGIN
    UPDATE complaint_info
    SET complaint_end_time = end_time_new,
        complaint_end_date = end_date_new # MM/DD/YYYY
	WHERE complaint_num = comp_number;
END //
DELIMITER ;


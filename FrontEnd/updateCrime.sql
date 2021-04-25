USE nypd_police;
DROP PROCEDURE IF EXISTS updateCrime;
DELIMITER //
CREATE PROCEDURE updateCrime(IN comp_number INT, IN begin_time_new INT, IN begin_date_new DATE,  IN end_time_new INT, IN end_date_new DATE) 
BEGIN
    UPDATE complaint_info
    SET complaint_begin_time = begin_time_new, 
		complaint_begin_date = begin_date_new,
        complaint_end_time = end_time_new,
        complaint_end_date = end_date_new
	WHERE complaint_num = comp_number;
END //
DELIMITER ;


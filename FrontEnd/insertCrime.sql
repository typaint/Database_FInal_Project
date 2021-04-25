USE nypd_police;
DROP PROCEDURE IF EXISTS insertCrime; # insert crime details
DELIMITER //
CREATE PROCEDURE insertCrime(IN ky_code_new INT,
		IN pd_code_new INT,
        IN jurisdiction_code_new INT,
        IN complaint_num_new INT,
        IN begin_time_new INT)
BEGIN
  INSERT INTO complaint_info(complaint_num, complaint_begin_time, ky_code, jurisdiction_code, pd_code) # enter primary key and foreign keys to satisfy functional dependencies
  VALUES(complaint_num_new, begin_time_new, ky_code_new, jurisdiction_code_new, pd_code_new);
END//
DELIMITER ;


call insertCrime(113,729,0,2,1);


select * from complaint_info;




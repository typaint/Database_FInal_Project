USE nypd_police;
DROP PROCEDURE IF EXISTS insertCrime; # insert crime details
DELIMITER //
CREATE PROCEDURE insertCrime(IN ky_code_new INT,
		IN pd_code_new INT,
        IN jurisdiction_code_new INT,
        IN complaint_num_new INT,
        IN begin_date_new INT,
        IN victim_sex_new char(1),
        IN suspect_sex_new char(1))
BEGIN
  INSERT INTO complaint_info(complaint_num, complaint_begin_time, ky_code, jurisdiction_code, pd_code) # enter primary key and foreign keys to satisfy functional dependencies
  VALUES(complaint_num_new, begin_date_new, ky_code_new, jurisdiction_code_new, pd_code_new);
  INSERT INTO suspect(complaint_num, suspect_sex)
  VALUES(complaint_num_new, suspect_sex_new); # enter complaint_num as FK
  INSERT INTO victim(complaint_num, victim_sex)
  VALUES(complaint_num_new, victim_sex_new); # enter complaint_num as FK
END//
DELIMITER ;

delete from complaint_info
where complaint_num = 1;

#call insertCrime(113,729,0,1,1,"M","M");





USE nypd_police;
DROP PROCEDURE IF EXISTS insertCrime; # insert crime details
DELIMITER //
CREATE PROCEDURE insertCrime(IN ky_code_new INT,
        IN jurisidiction_code_new INT,
<<<<<<< HEAD
        IN pd_code_new INT, 
=======
        IN pd_code_new INT,
>>>>>>> 989d166007fc84a5a9946068f62421b3fa9515a8
        IN complaint_num_new INT,
        IN begin_date_new DATE,
        IN vic_sex_new char(1),
        IN sus_sex_new char(1))
BEGIN
  INSERT INTO complaint_info(complaint_num, complaint_begin_date, ky_code, juristiction_code, pd_code) # enter primary key and foreign keys to satisfy functional dependencies
  VALUES(complaint_num_new, begin_date_new, ky_code_new, juristiction_code_new, pd_code_new);
  INSERT INTO suspect(complaint_num, suspect_sex)
  VALUES(complaint_num_new, suspect_sex_new); # enter complaint_num as FK
  INSERT INTO victim(complaint_num, victim_sex)
  VALUES(complaint_num_new, victim_sex_new); # enter complaint_num as FK
END//
DELIMITER ;
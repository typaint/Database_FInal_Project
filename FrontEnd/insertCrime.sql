USE nypd_police;
DROP PROCEDURE IF EXISTS insertCrime;
DELIMITER //
CREATE PROCEDURE insertCrime(IN ky_code_new INT,
        IN jurisidiction_code_new INT,
        IN pd_code_new INT,
        IN complaint_num_new INT,
        IN begin_date_new DATE,
        IN vic_sex_new char(1),
        IN sus_sex_new char(1))
BEGIN
  INSERT INTO offense(ky_code)
  VALUES (ky_code_new);
  INSERT INTO jurisdiction (juristiction_code)
  VALUES (jurisidiction_code_new);
  INSERT INTO pd (pd_code)
  VALUES (pd_code_new);
  INSERT INTO complaint_info(complaint_num, complaint_begin_date, victim_sex, suspect_sex, ky_code, juristiction_code, pd_code)
  VALUES(complaint_num_new, begin_date_new, vic_sex_new, sus_sex_new, ky_code_new, juristiction_code_new, pd_code_new);
END//
DELIMITER ;
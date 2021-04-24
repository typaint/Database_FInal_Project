USE nypd_police;
DROP TRIGGER IF EXISTS checkInsertCrime;

DELIMITER $$
CREATE TRIGGER checkInsertCrime # check the values inserted into the complaint_info table
BEFORE UPDATE 
ON complaint_info FOR EACH ROW 
BEGIN
	DECLARE kyError, jurisdictionError, pdError, compNumError, dateError, sexError VARCHAR(30); # declare error codes
    
    SET kyError = "Invalid ky code."; # set error code messages
    SET pdError = "Invalid pd code.";
    SET compNumError = "Invalid comlaint number.";
    SET dateError = "Invalid date format.";
    
    IF NEW.ky_code NOT IN (SELECT DISTINCT ky_code FROM offense) THEN # ensure ky_code is a current and valid ky_code
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = kyError;
	END IF;
    
    IF NEW.pd_code NOT IN (SELECT DISTINCT pd_code FROM pd) THEN # ensure pd_code is a current and valid ky_code
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = pdError;
	END IF;
    
    IF NEW.complaint_num IN (SELECT DISTINCT complaint_num FROM complaint_info) THEN # ensure complaint_num is not already used
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = compNumError;
	END IF;
    
    IF LENGTH(NEW.complaint_begin_date) != 8 THEN # check that date is 8 chars long
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = dateError;
	ELSE
		SET NEW.complaint_begin_date = str_to_date(NEW.complaint_begin_date, '%m/%d/%Y'); # convert to date format
	END IF;
    
	IF NEW.complaint_begin_date > CURDATE() THEN # test if date is in the future
		SET NEW.complaint_begin_date = CURDATE();
	END IF;
    
END $$
DELIMITER ;

USE nypd_police;
DROP TRIGGER IF EXISTS checkEndDate;

DELIMITER $$
CREATE TRIGGER checkEndDate # check a valid date is entered correctly; mm/dd/yyyy format
BEFORE UPDATE 
ON complaint_info FOR EACH ROW 
BEGIN
	DECLARE formatError VARCHAR(30);
    SET formatError = "Invalid date format."; 
            
	IF LENGTH(NEW.complaint_end_date) != 10 THEN # ensure date is 10 chars long (mm/dd/yyyy)
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = formatError;
	ELSE
		SET NEW.complaint_end_date = str_to_date(NEW.complaint_end_date, '%m/%d/%Y'); # convert string to date format
	END IF;
    
	IF NEW.complaint_end_date > CURDATE() THEN # test if date is in the future
		SET NEW.complaint_end_date = CURDATE(); # convert future date to current date
	END IF;
    
END $$
DELIMITER ;
	
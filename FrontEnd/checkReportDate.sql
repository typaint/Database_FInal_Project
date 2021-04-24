USE nypd_police;
DROP TRIGGER IF EXISTS checkReportDate;

DELIMITER $$
CREATE TRIGGER checkReportDate # check a valid date is entered correctly; mm/dd/yyyy format
BEFORE UPDATE 
ON crime_info FOR EACH ROW 
BEGIN
	DECLARE formatError VARCHAR(30);
    SET formatError = "Invalid date format."; 
            
	IF LENGTH(NEW.report_date) != 10 THEN # ensure date is 10 chars long (mm/dd/yyyy)
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = formatError;
	ELSE
		SET NEW.report_date = str_to_date(NEW.report_date, '%m/%d/%Y'); # convert string to date format
	END IF;
    
	IF NEW.report_date > CURDATE() THEN # test if date is in the future
		SET NEW.report_date = CURDATE(); # convert future date to current date
	END IF;
    
END $$
DELIMITER ;
	
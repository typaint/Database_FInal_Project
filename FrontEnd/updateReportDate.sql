USE nypd_police;
DROP TRIGGER IF EXISTS updateReportDate;

DELIMITER $$
CREATE TRIGGER updateReportDate
BEFORE UPDATE 
ON crime_info FOR EACH ROW 
BEGIN
	DECLARE formatError VARCHAR(30);
    SET formatError = "Invalid date format.";
            
	IF LENGTH(NEW.report_date) != 8 THEN
		SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = formatError;
	ELSE
		SET NEW.report_date = str_to_date(NEW.report_date, '%m/%d/%Y');
	END IF;
    
	IF NEW.report_date > CURDATE() THEN # test if date is in the future
		SET NEW.report_date = CURDATE();
	END IF;
    
END $$
DELIMITER ;
	
########## VIEWS ##########
# borough view for Crimes by Borough tab
DROP VIEW IF EXISTS borough_view;
CREATE VIEW  borough_view AS # view to see the number of crimes committed in each borough in descending order
SELECT borough_name, COUNT(*) as crime_count
FROM crime_info
GROUP BY borough_name
ORDER BY COUNT(*)  DESC;

# category view for Crimes by Type tab
DROP VIEW IF EXISTS category_view;
CREATE VIEW  category_view AS # view to see the type of crimes committed 
SELECT law_category_code AS crime_type, COUNT(*) as crime_count
FROM crime_info
GROUP BY law_category_code
ORDER BY COUNT(*) DESC;

########## TRIGGERS ##########
# trigger for checking crimes inserted
DROP TRIGGER IF EXISTS checkInsertCrime;

DELIMITER $$
CREATE TRIGGER checkInsertCrime # check the values inserted into the complaint_info table
BEFORE INSERT
ON complaint_info FOR EACH ROW 
BEGIN
	DECLARE kyError, jurisdictionError, pdError, compNumError, dateError, sexError VARCHAR(30); # declare error codes
    
    SET kyError = "Invalid ky code."; # set error code messages
    SET pdError = "Invalid pd code.";
    SET compNumError = "Invalid complaint number.";
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
    
    IF LENGTH(NEW.complaint_begin_date) != 10 THEN # check that date is 8 chars long
		SET NEW.complaint_begin_date = CURDATE();
	ELSE
		SET NEW.complaint_begin_date = str_to_date(NEW.complaint_begin_date, '%m/%d/%Y'); # convert to date format
	END IF;
    
	IF NEW.complaint_begin_date > CURDATE() THEN # test if date is in the future
		SET NEW.complaint_begin_date = CURDATE();
	END IF;
    
END $$
DELIMITER ;

# trigger to check end date
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

########## STORED PROCEDURES ##########
# stored procedure to delete a crime
DROP PROCEDURE IF EXISTS deleteCrime; # delete a crime record
DELIMITER //
CREATE PROCEDURE deleteCrime(IN comp_number INT)
BEGIN
  DELETE FROM complaint_info # delete from parent tabe so child tables are also updated
  WHERE complaint_num = comp_number;
END//
DELIMITER ;

# stored procedure to insert a crime
DROP PROCEDURE IF EXISTS insertCrime; 
DELIMITER //
CREATE PROCEDURE insertCrime(IN ky_code_new INT, # stored procedure to insert crime details
		IN pd_code_new INT,
        IN jurisdiction_code_new INT,
        IN complaint_num_new INT,
        IN begin_time_new INT)
BEGIN
  INSERT INTO complaint_info(complaint_num, complaint_begin_time, ky_code, jurisdiction_code, pd_code) # enter primary key and foreign keys to satisfy functional dependencies
  VALUES(complaint_num_new, begin_time_new, ky_code_new, jurisdiction_code_new, pd_code_new);
END//
DELIMITER ;

# stored procedure to search crime
DROP PROCEDURE IF EXISTS searchCrime;
DELIMITER //
CREATE PROCEDURE searchCrime(IN comp_number INT) # stored procedure to look at suspect details invloved in a crime
BEGIN
    SELECT complaint_info.complaint_num, suspect.suspect_sex, suspect.suspect_age_group, suspect.suspect_race,
			offense.offense_desc, complaint_info.complaint_end_date, complaint_info.complaint_end_time
	FROM complaint_info complaint_info
	LEFT JOIN suspect suspect on complaint_info.complaint_num = suspect.complaint_num
	LEFT JOIN offense offense on complaint_info.ky_code = offense.ky_code 
	WHERE complaint_info.complaint_num = comp_number;
END //
DELIMITER ;

# stored procedure to update crimes
DROP PROCEDURE IF EXISTS updateCrime;
DELIMITER //
CREATE PROCEDURE updateCrime(IN comp_number INT, IN end_time_new TIME, IN end_date_new CHAR(10)) # stored procedure to update end date & time
BEGIN
    UPDATE complaint_info
    SET complaint_end_time = end_time_new, # hh:mm:ss
        complaint_end_date = end_date_new # MM/DD/YYYY
	WHERE complaint_num = comp_number;
END //
DELIMITER ;


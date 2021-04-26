# Ty Painter & Tonnar Castellano
# Project 2

#############################
##### DATABASE CREATION #####
#############################

#DROP DATABASE IF EXISTS nypd_police;
CREATE DATABASE IF NOT EXISTS nypd_police;
USE nypd_police;

######### create megatable ##########
#DROP TABLE IF EXISTS police_mega;
CREATE TABLE IF NOT EXISTS police_mega
(
	complaint_num			VARCHAR(50),
	complaint_begin_date	VARCHAR(10), # convert to date
	complaint_begin_time	VARCHAR(50),
	complaint_end_date		VARCHAR(10), # convert to date
	complaint_end_time		VARCHAR(50),
	prescinct_addr_code		VARCHAR(50),
	report_date				VARCHAR(10), # convert to date
	ky_code					VARCHAR(50),
	offense_desc			VARCHAR(50),
	pd_code					VARCHAR(50),
	pd_desc					VARCHAR(100),
	crime_stage_code		VARCHAR(50),
	law_category_code		VARCHAR(50),
	borough_name			VARCHAR(50),
	location_occurance		VARCHAR(50),
	premises_desc			VARCHAR(50),
	jurisdiction_desc		VARCHAR(50),
	jurisdiction_code		VARCHAR(50),
	parks_name				VARCHAR(100),
    ha_develop				VARCHAR(50),
	housing_psa				VARCHAR(50),
	x_coord_code			VARCHAR(50),
	y_coord_code			VARCHAR(50),
	suspect_age_group		VARCHAR(50),
	suspect_race			VARCHAR(50),
	suspect_sex				VARCHAR(50),
	transit_dist			VARCHAR(50),
	lat						VARCHAR(50),
	lon						VARCHAR(50),
	lat_long				VARCHAR(50),
	patrol_borough			VARCHAR(50),
	station_name			VARCHAR(50),
	victim_age_group		VARCHAR(50),
	victim_race				VARCHAR(50),
	victim_sex				VARCHAR(50)
) ENGINE=INNODB;

########## load data into megatable ##########
LOAD DATA LOCAL INFILE '/Users/TyPainter1/Box/NYPD_Complaint_Data_Historic.csv' # URL link
INTO TABLE police_mega
FIELDS TERMINATED BY ','
		ESCAPED BY '\t'
IGNORE 1 LINES;

########## clean data ##########
SET SQL_SAFE_UPDATES = 0;

# replace blank and NA values with NULL
UPDATE police_mega
SET complaint_begin_date = NULL
WHERE complaint_begin_date = 'NA'
	OR complaint_begin_date = '';

UPDATE police_mega
SET complaint_end_date = NULL
WHERE complaint_end_date = 'NA'
	OR complaint_end_date = '';
    
UPDATE police_mega
SET complaint_end_time = NULL
WHERE complaint_end_time = 'NA'
	OR complaint_end_time = '';

UPDATE police_mega
SET prescinct_addr_code = NULL
WHERE prescinct_addr_code = 'NA'
	OR prescinct_addr_code = ''; 

UPDATE police_mega
SET offense_desc = NULL
WHERE offense_desc = 'NA'
	OR offense_desc = '';

UPDATE police_mega
SET pd_code = NULL
WHERE pd_code = 'NA'
	OR pd_code = '';
    
UPDATE police_mega
SET pd_desc = NULL
WHERE pd_desc = 'NA'
	OR pd_desc = '';
    
UPDATE police_mega
SET crime_stage_code = NULL
WHERE crime_stage_code = 'NA'
	OR crime_stage_code = '';
    
UPDATE police_mega
SET borough_name = NULL
WHERE borough_name = 'NA'
	OR borough_name = '';
    
UPDATE police_mega
SET location_occurance = NULL
WHERE location_occurance = 'NA'
	OR location_occurance = '';
    
UPDATE police_mega
SET premises_desc = NULL
WHERE premises_desc = 'NA'
	OR premises_desc = '';
    
UPDATE police_mega
SET jurisdiction_code = NULL
WHERE jurisdiction_code = 'NA'
	OR jurisdiction_code = '';

UPDATE police_mega
SET parks_name = NULL
WHERE parks_name = 'NA'
	OR parks_name = '';

UPDATE police_mega
SET ha_develop = NULL
WHERE ha_develop = 'NA'
	OR ha_develop = '';
    
UPDATE police_mega
SET housing_psa = NULL
WHERE housing_psa = 'NA'
	OR housing_psa = '';
    
UPDATE police_mega
SET x_coord_code = NULL
WHERE x_coord_code = 'NA'
	OR x_coord_code = '';

UPDATE police_mega
SET y_coord_code = NULL
WHERE y_coord_code = 'NA'
	OR y_coord_code = '';

UPDATE police_mega
SET suspect_age_group = NULL
WHERE suspect_age_group = 'NA'
	OR suspect_age_group = '';
    
UPDATE police_mega
SET suspect_race = NULL
WHERE suspect_race = 'NA'
	OR suspect_race = '';
    
UPDATE police_mega
SET suspect_sex = NULL
WHERE suspect_sex = 'NA'
	OR suspect_sex = '';
    
UPDATE police_mega
SET transit_dist = NULL
WHERE transit_dist = 'NA'
	OR transit_dist = '';
    
UPDATE police_mega
SET lat = NULL
WHERE lat = 'NA'
	OR lat = '';

UPDATE police_mega
SET lon = NULL
WHERE lon = 'NA'
	OR lon = '';

UPDATE police_mega
SET lat_long = NULL
WHERE lat_long = 'NA'
	OR lat_long = '';
    
UPDATE police_mega
SET patrol_borough = NULL
WHERE patrol_borough = 'NA'
	OR patrol_borough = '';

UPDATE police_mega
SET station_name = NULL
WHERE station_name = 'NA'
	OR station_name = '';
    
UPDATE police_mega
SET victim_age_group = NULL
WHERE victim_age_group = 'NA'
	OR victim_age_group = '';
    
UPDATE police_mega
SET victim_race = NULL
WHERE victim_race = 'NA'
	OR victim_race = '';
    
UPDATE police_mega
SET victim_sex = NULL
WHERE victim_sex = 'NA'
	OR victim_sex = '';

# modify data types in mega table
ALTER TABLE police_mega
MODIFY COLUMN complaint_num					INT,
	MODIFY COLUMN complaint_begin_date		VARCHAR(10), # convert to date
	MODIFY COLUMN complaint_begin_time		TIME,
	MODIFY COLUMN complaint_end_date		VARCHAR(10), # convert to date
	MODIFY COLUMN complaint_end_time		TIME,
	MODIFY COLUMN prescinct_addr_code		SMALLINT,
	MODIFY COLUMN report_date				VARCHAR(10), # convert to date
	MODIFY COLUMN ky_code					SMALLINT,
	MODIFY COLUMN offense_desc				VARCHAR(50),
	MODIFY COLUMN pd_code					SMALLINT,
	MODIFY COLUMN pd_desc					VARCHAR(100),
	MODIFY COLUMN crime_stage_code			VARCHAR(50), # code but more of description
	MODIFY COLUMN law_category_code			VARCHAR(50), # code but more of description
	MODIFY COLUMN borough_name				VARCHAR(50),
	MODIFY COLUMN location_occurance		VARCHAR(50),
	MODIFY COLUMN premises_desc				VARCHAR(50),
	MODIFY COLUMN jurisdiction_desc			VARCHAR(50),
	MODIFY COLUMN jurisdiction_code			SMALLINT,
	MODIFY COLUMN parks_name				VARCHAR(100),
    MODIFY COLUMN ha_develop				VARCHAR(50),
	MODIFY COLUMN housing_psa				VARCHAR(50),
	MODIFY COLUMN x_coord_code				INT,
	MODIFY COLUMN y_coord_code				INT,
	MODIFY COLUMN suspect_age_group			VARCHAR(50), # range of ages
	MODIFY COLUMN suspect_race				VARCHAR(50),
	MODIFY COLUMN suspect_sex				CHAR(1),
	MODIFY COLUMN transit_dist				VARCHAR(50),
	MODIFY COLUMN lat						DOUBLE, # different length decimals
	MODIFY COLUMN lon						DOUBLE, # different length decimals
	MODIFY COLUMN lat_long					VARCHAR(50),
	MODIFY COLUMN patrol_borough			VARCHAR(50),
	MODIFY COLUMN station_name				VARCHAR(50),
	MODIFY COLUMN victim_age_group			VARCHAR(50),
	MODIFY COLUMN victim_race				VARCHAR(50),
	MODIFY COLUMN victim_sex				CHAR(1);
    
# convert date columns from varchar to date
UPDATE police_mega
SET complaint_begin_date = str_to_date(complaint_begin_date, '%m/%d/%Y')
WHERE complaint_begin_date != '';

UPDATE police_mega
SET complaint_end_date = str_to_date(complaint_end_date, '%m/%d/%Y')
WHERE complaint_end_date != '';

UPDATE police_mega
SET report_date = str_to_date(report_date, '%m/%d/%Y')
WHERE report_date != '';

SET SQL_SAFE_UPDATES = 1;

########## normalized tables ##########

# create offense table 
DROP TABLE IF EXISTS offense; 
CREATE TABLE IF NOT EXISTS offense # describes specific crime committed
(
	ky_code					SMALLINT,
	offense_desc			VARCHAR(50),
	PRIMARY KEY (ky_code) # functional dependency where ky_code determines offense_desc
) ENGINE=INNODB;
    
# create pd table
DROP TABLE IF EXISTS pd; 
CREATE TABLE IF NOT EXISTS pd # describes general crime committed
(
	pd_code					SMALLINT,
	pd_desc					VARCHAR(100),
	PRIMARY KEY (pd_code) # functional dependency where pd_code determines pd_desc
) ENGINE=INNODB;
    
# create jurisdiction table
DROP TABLE IF EXISTS jurisdiction;
CREATE TABLE IF NOT EXISTS jurisdiction # describes general crime committed
(
	jurisdiction_desc		VARCHAR(50),
	jurisdiction_code		SMALLINT,
	PRIMARY KEY (jurisdiction_code) # functional dependency where pd_code determines pd_desc
) ENGINE=INNODB;

# create complaint_info table
DROP TABLE IF EXISTS complaint_info;
CREATE TABLE IF NOT EXISTS complaint_info # central table with basic complaint details
(
	complaint_num			INT,
	complaint_begin_date	VARCHAR(10),
	complaint_begin_time	TIME				NOT NULL,
	complaint_end_date		VARCHAR(10),
	complaint_end_time		TIME,
    lat						DOUBLE,
	lon						DOUBLE,
    pd_code					SMALLINT,
    jurisdiction_code		SMALLINT,
    ky_code					SMALLINT,
    PRIMARY KEY (complaint_num), # global primary key
    CONSTRAINT pd_fk_complaint 
		FOREIGN KEY (pd_code) REFERENCES pd (pd_code), # foreign key to pd_code functional dependency
	CONSTRAINT jurisdiction_fk_complaint 
		FOREIGN KEY (jurisdiction_code) REFERENCES jurisdiction (jurisdiction_code), # foreign key to jurisdiction_code functional dependency
	CONSTRAINT offense_fk_complaint 
		FOREIGN KEY (ky_code) REFERENCES offense (ky_code) # foreign key to ky_code functional dependency
) ENGINE=INNODB;

# create suspect table
DROP TABLE IF EXISTS suspect;
CREATE TABLE IF NOT EXISTS suspect # suspect details
(
	suspect_id				INT				AUTO_INCREMENT,
    complaint_num			INT,
	suspect_age_group		VARCHAR(50),
	suspect_race			VARCHAR(50),
	suspect_sex				CHAR(1),
    PRIMARY KEY (suspect_id), # suspect info is identified by suspect_id
    CONSTRAINT suspect_fk_complaint_num
		FOREIGN KEY (complaint_num) REFERENCES complaint_info (complaint_num) # foreign key back to central table
        ON UPDATE CASCADE # ensure universal update
        ON DELETE CASCADE # prevent delete from child table
) ENGINE=INNODB;

# create victim table
DROP TABLE IF EXISTS victim;
CREATE TABLE IF NOT EXISTS victim # victim details
(
	victim_id				INT				AUTO_INCREMENT,
    complaint_num			INT,
	victim_age_group		VARCHAR(50),
	victim_race				VARCHAR(50),
	victim_sex				CHAR(1),
    PRIMARY KEY (victim_id), # victim info is identified by victim_id
    CONSTRAINT victim_fk_complaint_num
		FOREIGN KEY (complaint_num) REFERENCES complaint_info (complaint_num) # foreign key back to central table
        ON UPDATE CASCADE # ensure universal update
        ON DELETE CASCADE # prevent delete from child table
) ENGINE=INNODB;

# create extra_info table
DROP TABLE IF EXISTS extra_info;
CREATE TABLE IF NOT EXISTS extra_info # data without much purpose without a data dictionary
(
    lat_long				VARCHAR(50),
	x_coord_code			INT,
	y_coord_code			INT,
    complaint_num			INT,
    parks_name				VARCHAR(100),
    ha_develop				VARCHAR(50),
    housing_psa				VARCHAR(50),
    transit_dist			VARCHAR(50),
    station_name			VARCHAR(50),
    PRIMARY KEY (complaint_num), # extra info is identified by complaint_num
    CONSTRAINT location_fk_complaint_num
		FOREIGN KEY (complaint_num) REFERENCES complaint_info (complaint_num) # foreign key back to central table
        ON UPDATE CASCADE # ensure universal update
        ON DELETE CASCADE # prevent delete from child table
) ENGINE=INNODB;

# create crime_info table
DROP TABLE IF EXISTS crime_info;
CREATE TABLE IF NOT EXISTS crime_info # info about the location and stage of the crime
(
    complaint_num			INT,
    report_date				VARCHAR(10),
	crime_stage_code		VARCHAR(50),
	law_category_code		VARCHAR(50),
    location_occurance		VARCHAR(50),
	premises_desc			VARCHAR(50),
    patrol_borough			VARCHAR(50),
	borough_name			VARCHAR(50),
    prescinct_addr_code		SMALLINT,
    PRIMARY KEY (complaint_num), # crime info is identified by complaint_num
    CONSTRAINT crime_fk_complaint_num
		FOREIGN KEY (complaint_num) REFERENCES complaint_info (complaint_num) # foreign key back to central table
        ON UPDATE CASCADE # ensure universal update
        ON DELETE CASCADE # prevent delete from child table
) ENGINE=INNODB;

######### create small mega table ########## 
# small mega table with subset of data to reduce runtime
DROP TABLE IF EXISTS police_small_mega;
CREATE TABLE police_small_mega
(
	 complaint_num				INT,
	 complaint_begin_date		DATE,
	 complaint_begin_time		TIME,
	 complaint_end_date			DATE,
	 complaint_end_time			TIME,
	 prescinct_addr_code		SMALLINT,
	 report_date				DATE,
	 ky_code					SMALLINT,
	 offense_desc				VARCHAR(50),
	 pd_code					SMALLINT,
	 pd_desc					VARCHAR(100),
	 crime_stage_code			VARCHAR(50),
	 law_category_code			VARCHAR(50),
	 borough_name				VARCHAR(50),
	 location_occurance			VARCHAR(50),
	 premises_desc				VARCHAR(50),
	 jurisdiction_desc			VARCHAR(50),
	 jurisdiction_code			SMALLINT,
	 parks_name					VARCHAR(100),
     ha_develop					VARCHAR(50),
	 housing_psa				VARCHAR(50),
	 x_coord_code				INT,
	 y_coord_code				INT,
	 suspect_age_group			VARCHAR(50),
	 suspect_race				VARCHAR(50),
	 suspect_sex				CHAR(1),
	 transit_dist				VARCHAR(50),
	 lat						DOUBLE,
	 lon						DOUBLE,
	 lat_long					VARCHAR(50),
	 patrol_borough				VARCHAR(50),
	 station_name				VARCHAR(50),
	 victim_age_group			VARCHAR(50),
	 victim_race				VARCHAR(50),
	 victim_sex					CHAR(1)
) ENGINE=INNODB;

########## create dirty_data table ##########
# table includes duplicate rows and records missing a PK
DROP TABLE IF EXISTS dirty_data;
CREATE TABLE dirty_data
(
	 complaint_num				INT,
	 complaint_begin_date		DATE,
	 complaint_begin_time		TIME,
	 complaint_end_date			DATE,
	 complaint_end_time			TIME,
	 prescinct_addr_code		SMALLINT,
	 report_date				DATE,
	 ky_code					SMALLINT,
	 offense_desc				VARCHAR(50),
	 pd_code					SMALLINT,
	 pd_desc					VARCHAR(100),
	 crime_stage_code			VARCHAR(50),
	 law_category_code			VARCHAR(50),
	 borough_name				VARCHAR(50),
	 location_occurance			VARCHAR(50),
	 premises_desc				VARCHAR(50),
	 jurisdiction_desc			VARCHAR(50),
	 jurisdiction_code			SMALLINT,
	 parks_name					VARCHAR(100),
     ha_develop					VARCHAR(50),
	 housing_psa				VARCHAR(50),
	 x_coord_code				INT,
	 y_coord_code				INT,
	 suspect_age_group			VARCHAR(50),
	 suspect_race				VARCHAR(50),
	 suspect_sex				CHAR(1),
	 transit_dist				VARCHAR(50),
	 lat						DOUBLE,
	 lon						DOUBLE,
	 lat_long					VARCHAR(50),
	 patrol_borough				VARCHAR(50),
	 station_name				VARCHAR(50),
	 victim_age_group			VARCHAR(50),
	 victim_race				VARCHAR(50),
	 victim_sex					CHAR(1)
) ENGINE=INNODB;

##########################
##### DATA INSERTION #####
##########################

######### insert subset of data from mega table into small mega table ##########
INSERT INTO police_small_mega
SELECT *
FROM police_mega
LIMIT 10000;

######### clean data values for functional dependencies ##########
# all standardizations are results from NormalizationTests script
# must run NormalizationTests script *BEFORE* the updates below to observe dirty functional dependencies
SET SQL_SAFE_UPDATES = 0;

# standardize ky_code 116, 120, 124, 125, 343, 345, 364, 677
UPDATE police_small_mega
SET offense_desc = 'SEX CRIMES'
WHERE ky_code = 116;

UPDATE police_small_mega
SET offense_desc = 'CHILD ABANDONMENT/NON SUPPORT'
WHERE ky_code = 120;

UPDATE police_small_mega
SET offense_desc = 'KIDNAPPING'
WHERE ky_code = 124;

UPDATE police_small_mega
SET offense_desc = 'NYS LAW-UNCLASSIFIED FELONY'
WHERE ky_code = 125;

UPDATE police_small_mega
SET offense_desc = 'THEFT OF SERVICES'
WHERE ky_code = 343;

UPDATE police_small_mega
SET offense_desc = 'OFFENSES RELATED TO CHILDREN'
WHERE ky_code = 345;

UPDATE police_small_mega
SET offense_desc = 'AGRICULTURE & MRKTS LAW-UNCLASSIFIED'
WHERE ky_code = 364;

UPDATE police_small_mega
SET offense_desc = 'NYS LAWS-UNCLASSIFIED VIOLATION'
WHERE ky_code = 677;

# standardize PD_code 234, 694
UPDATE police_small_mega
SET pd_desc = 'BURGLARY, UNKNOWN TIME'
WHERE pd_code = 234;

UPDATE police_small_mega
SET pd_desc = 'INCEST'
WHERE pd_code = 694;

# insert NULL PK data into dirty_data
INSERT INTO dirty_data
SELECT *
FROM police_small_mega
WHERE complaint_num IS NULL 
	OR pd_code IS NULL
	OR jurisdiction_code IS NULL
    OR ky_code IS NULL;
# delete NULL PK data from police_small_mega since it is inserted into dirty_data table
DELETE
FROM police_small_mega
WHERE complaint_num IS NULL 
	OR pd_code IS NULL
	OR jurisdiction_code IS NULL
    OR ky_code IS NULL;
    
SET SQL_SAFE_UPDATES = 1;
    
########## insert data into normalized tables ##########

# insert data into offense table
INSERT INTO offense
SELECT DISTINCT ky_code, # functional dependency; fk to complaint_info
	offense_desc
FROM police_small_mega
WHERE offense_desc IS NOT NULL; # put null in bad table

# insert data into pd table
INSERT INTO pd
SELECT DISTINCT pd_code, # functional dependency; fk to complaint_info
		pd_desc	
FROM police_small_mega
WHERE pd_code IS NOT NULL; # put null in bad table

# insert data into jurisdiction table
INSERT INTO jurisdiction
SELECT DISTINCT jurisdiction_desc, # functional dependency; fk to complaint_info
		jurisdiction_code
FROM police_small_mega
WHERE jurisdiction_code IS NOT NULL; # put null in bad table;

# insert data into complaint_info table
INSERT INTO complaint_info
SELECT p.complaint_num,
		p.complaint_begin_date,
		p.complaint_begin_time,
		p.complaint_end_date,
		p.complaint_end_time,
		p.lat,
		p.lon,
        pd.pd_code,
		j.jurisdiction_code,
		o.ky_code
FROM police_small_mega p
JOIN pd ON pd.pd_code = p.pd_code # join pd, jurisdiction, offense tables to enforce foreign key and functional dependency
	JOIN jurisdiction j ON j.jurisdiction_code = p.jurisdiction_code
    JOIN offense o ON o.ky_code = p.ky_code;
# insert data into suspect table
INSERT INTO suspect(complaint_num, suspect_age_group, suspect_race, suspect_sex)
SELECT c.complaint_num,
		p.suspect_age_group,
		p.suspect_race,
		p.suspect_sex	
FROM police_small_mega p
JOIN complaint_info c ON c.complaint_num = p.complaint_num; # join complaint_info to enforce foreign key
# insert data into victim table
INSERT INTO victim(complaint_num, victim_age_group, victim_race, victim_sex)
SELECT c.complaint_num,
		p.victim_age_group,
		p.victim_race,
		p.victim_sex
FROM police_small_mega p
JOIN complaint_info c ON c.complaint_num = p.complaint_num; # join complaint_info to enforce foreign key
# insert data into extra_info table
INSERT INTO extra_info
SELECT lat_long,
		x_coord_code,
		y_coord_code,
		c.complaint_num,
		parks_name,
		ha_develop,
		housing_psa,
		transit_dist,
		station_name	
FROM police_small_mega p
JOIN complaint_info c ON c.complaint_num = p.complaint_num; # join complaint_info to enforce foreign key
# insert data into crime_info table
INSERT INTO crime_info
SELECT c.complaint_num,
    report_date,
	crime_stage_code,
	law_category_code,
    location_occurance,
	premises_desc,
    patrol_borough,
	borough_name,
    prescinct_addr_code	
FROM police_small_mega p
JOIN complaint_info c ON c.complaint_num = p.complaint_num; # join complaint_info to enforce foreign key

#################################
### Application Functionality ###
#################################

# VIEWS
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

# TRIGGERS
# trigger for checking crimes inserted
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

# STORED PROCEDURES
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
    SET complaint_end_time = end_time_new,
        complaint_end_date = end_date_new # MM/DD/YYYY
	WHERE complaint_num = comp_number;
END //
DELIMITER ;

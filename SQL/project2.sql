# Ty Painter & Tonnar Castellano
# Project 2

########## create database ##########
#DROP DATABASE IF EXISTS nypd_police;
CREATE DATABASE IF NOT EXISTS nypd_police;
USE nypd_police;

######### create megatable ##########
DROP TABLE IF EXISTS police_mega;
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
LOAD DATA LOCAL INFILE '/Users/TyPainter1/Box/NYPD_Complaint_Data_Historic.csv'
INTO TABLE police_mega
FIELDS TERMINATED BY ','
		OPTIONALLY ENCLOSED BY '"'
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

# modify data types
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
	MODIFY COLUMN crime_stage_code			VARCHAR(50),
	MODIFY COLUMN law_category_code			VARCHAR(50),
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
	MODIFY COLUMN suspect_age_group			VARCHAR(50),
	MODIFY COLUMN suspect_race				VARCHAR(50),
	MODIFY COLUMN suspect_sex				CHAR(1),
	MODIFY COLUMN transit_dist				VARCHAR(50),
	MODIFY COLUMN lat						DOUBLE,
	MODIFY COLUMN lon						DOUBLE,
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
CREATE TABLE IF NOT EXISTS offense
(
	ky_code					SMALLINT,
	offense_desc			VARCHAR(50),
	PRIMARY KEY (ky_code)
) ENGINE=INNODB;
    
# create pd table
DROP TABLE IF EXISTS pd;
CREATE TABLE IF NOT EXISTS pd
(
	pd_code					SMALLINT,
	pd_desc					VARCHAR(100),
	PRIMARY KEY (pd_code)
) ENGINE=INNODB;
    
# create jurisdiction table
DROP TABLE IF EXISTS jurisdiction;
CREATE TABLE IF NOT EXISTS jurisdiction
(
	jurisdiction_desc		VARCHAR(50),
	jurisdiction_code		SMALLINT,
	PRIMARY KEY (jurisdiction_code)
) ENGINE=INNODB;
# create complaint_info table
DROP TABLE IF EXISTS complaint_info;
CREATE TABLE IF NOT EXISTS complaint_info
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
    PRIMARY KEY (complaint_num),
    CONSTRAINT pd_fk_complaint 
		FOREIGN KEY (pd_code) REFERENCES pd (pd_code),
	CONSTRAINT jurisdiction_fk_complaint 
		FOREIGN KEY (jurisdiction_code) REFERENCES jurisdiction (jurisdiction_code),
	CONSTRAINT offense_fk_complaint 
		FOREIGN KEY (ky_code) REFERENCES offense (ky_code)
) ENGINE=INNODB;

# create suspect table
DROP TABLE IF EXISTS suspect;
CREATE TABLE IF NOT EXISTS suspect
(
	complaint_num			INT,
	suspect_age_group		VARCHAR(50),
	suspect_race			VARCHAR(50),
	suspect_sex				CHAR(1),
    PRIMARY KEY (complaint_num),
    CONSTRAINT suspect_fk_complaint_num
		FOREIGN KEY (complaint_num) REFERENCES complaint_info (complaint_num)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=INNODB;

# create victim table
DROP TABLE IF EXISTS victim;
CREATE TABLE IF NOT EXISTS victim
(
	complaint_num			INT,
	victim_age_group		VARCHAR(50),
	victim_race				VARCHAR(50),
	victim_sex				CHAR(1),
    PRIMARY KEY (complaint_num),
    CONSTRAINT victim_fk_complaint_num
		FOREIGN KEY (complaint_num) REFERENCES complaint_info (complaint_num)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=INNODB;

# create extra_info table
DROP TABLE IF EXISTS extra_info;
CREATE TABLE IF NOT EXISTS extra_info
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
    PRIMARY KEY (complaint_num),
    CONSTRAINT location_fk_complaint_num
		FOREIGN KEY (complaint_num) REFERENCES complaint_info (complaint_num)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=INNODB;

# crime_info table
DROP TABLE IF EXISTS crime_info;
CREATE TABLE IF NOT EXISTS crime_info
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
    PRIMARY KEY (complaint_num),
    CONSTRAINT crime_fk_complaint_num
		FOREIGN KEY (complaint_num) REFERENCES complaint_info (complaint_num)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=INNODB;

######### create small mega table ##########
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

######### insert subset of data from mega table into small mega table ##########
INSERT INTO police_small_mega
SELECT *
FROM police_mega
LIMIT 100000;

######### clean data values for functional dependencies ##########
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
# delete NULL PK data from police_small_mega
DELETE
FROM police_small_mega
WHERE complaint_num IS NULL 
	OR pd_code IS NULL
	OR jurisdiction_code IS NULL
    OR ky_code IS NULL;
    
SET SQL_SAFE_UPDATES = 1;
    
########## insert data into tables ##########
# insert data into offense table
INSERT INTO offense
SELECT DISTINCT ky_code, # fk to complaint_info
	offense_desc
FROM police_small_mega
WHERE offense_desc IS NOT NULL; # put null in bad table
# insert data into pd table
INSERT INTO pd
SELECT DISTINCT pd_code,
		pd_desc	
FROM police_small_mega
WHERE pd_code IS NOT NULL; # put null in bad table
# insert data into jurisdiction table
INSERT INTO jurisdiction
SELECT DISTINCT jurisdiction_desc,
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
JOIN pd ON pd.pd_code = p.pd_code
	JOIN jurisdiction j ON j.jurisdiction_code = p.jurisdiction_code
    JOIN offense o ON o.ky_code = p.ky_code;
# insert data into suspect table
INSERT INTO suspect
SELECT c.complaint_num,
		p.suspect_age_group,
		p.suspect_race,
		p.suspect_sex	
FROM police_small_mega p
JOIN complaint_info c ON c.complaint_num = p.complaint_num;
# insert data into victim table
INSERT INTO victim
SELECT c.complaint_num,
		p.victim_age_group,
		p.victim_race,
		p.victim_sex
FROM police_small_mega p
JOIN complaint_info c ON c.complaint_num = p.complaint_num;
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
JOIN complaint_info c ON c.complaint_num = p.complaint_num;
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
JOIN complaint_info c ON c.complaint_num = p.complaint_num;

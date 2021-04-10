# Ty Painter & Tonnar Castellano
# Project 2

########## create database ##########
DROP DATABASE IF EXISTS nypd_police;
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

SELECT * FROM police_mega
where prescinct_addr_code = ''
limit 50;

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
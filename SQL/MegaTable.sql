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
	complaint_num			INT,
	complaint_begin_date	VARCHAR(10), # convert to date
	complaint_begin_time	TIME,
	complaint_end_date		VARCHAR(10), # convert to date
	complaint_end_time		TIME,
	prescinct_addr_code		SMALLINT,
	report_date				VARCHAR(10), # convert to date
	ky_code					SMALLINT,
	offense_desc			VARCHAR(50),
	pd_code					SMALLINT,
	pd_desc					VARCHAR(100),
	crime_stage_code		VARCHAR(50),
	law_category_code		VARCHAR(50),
	borough_name			VARCHAR(50),
	location_occurance		VARCHAR(50),
	premises_desc			VARCHAR(50),
	jurisdiction_desc		VARCHAR(50),
	jurisdiction_code		SMALLINT,
	parks_name				VARCHAR(100),
    ha_develop				VARCHAR(50),
	housing_psa				VARCHAR(50),
	x_coord_code			INT,
	y_coord_code			INT,
	suspect_age_group		VARCHAR(50),
	suspect_race			VARCHAR(50),
	suspect_sex				CHAR(1),
	transit_dist			VARCHAR(50),
	lat						DOUBLE,
	lon						DOUBLE,
	lat_long				VARCHAR(50),
	patrol_borough			VARCHAR(50),
	station_name			VARCHAR(50),
	victim_age_group		VARCHAR(50),
	victim_race				VARCHAR(50),
	victim_sex				CHAR(1)
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
# replace blank values with null
UPDATE police_mega
SET complaint_begin_date = NULL
WHERE complaint_begin_date = 'NA'
	OR complaint_begin_date = '';

UPDATE police_mega
SET complaint_end_date = NULL
WHERE complaint_end_date = 'NA'
	OR complaint_end_date = '';

UPDATE police_mega
SET prescinct_addr_code = NULL
WHERE prescinct_addr_code = 0; # NA and blank values converted to 0 for INT type

UPDATE police_mega
SET offense_desc = NULL
WHERE offense_desc = 'NA'
	OR offense_desc = '';
    
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
WHERE jurisdiction_code = 0; # check since 0 is a value

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
WHERE x_coord_code = 0; # NA and blank values converted to 0 for INT type

UPDATE police_mega
SET y_coord_code = NULL
WHERE y_coord_code = 0; # NA and blank values converted to 0 for INT type

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
WHERE lat = 0; # NA and blank values converted to 0 for INT type

UPDATE police_mega
SET lon = NULL
WHERE lon = 0; # NA and blank values converted to 0 for INT type

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
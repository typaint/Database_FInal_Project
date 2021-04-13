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
	row_num					INT, # delete row number label
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
LOAD DATA LOCAL INFILE '/Users/TyPainter1/Box/police.csv'
INTO TABLE police_mega
FIELDS TERMINATED BY ','
		OPTIONALLY ENCLOSED BY '"'
		ESCAPED BY '\n';
        
# convert date columns from varchar to date
SET SQL_SAFE_UPDATES = 0;

UPDATE police_mega
SET complaint_begin_date = str_to_date(complaint_begin_date, '%m/%d/%Y')
WHERE complaint_begin_date != '';

UPDATE police_mega
SET complaint_end_date = str_to_date(complaint_end_date, '%m/%d/%Y')
WHERE complaint_end_date != '';

UPDATE police_mega
SET report_date = str_to_date(report_date, '%m/%d/%Y')
WHERE report_date != '';

# delete row number column
ALTER TABLE police_mega
DROP row_num;

SET SQL_SAFE_UPDATES = 1;

########## decomposed tables ##########
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
    PRIMARY KEY (complaint_num)
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

# create borough table
DROP TABLE IF EXISTS borough;
CREATE TABLE IF NOT EXISTS borough
(
	patrol_borough			VARCHAR(50),
	borough_name			VARCHAR(50),
    prescinct_addr_code		SMALLINT,
	PRIMARY KEY (patrol_borough)
) ENGINE=INNODB;

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
	PRIMARY KEY (jurisidiction_desc)
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

# crime_info location table
DROP TABLE IF EXISTS crime_info;
CREATE TABLE IF NOT EXISTS crime_info
(
    complaint_num			INT,
    report_date				VARCHAR(10),
	crime_stage_code		VARCHAR(50),
	law_category_code		VARCHAR(50),
    location_occurance		VARCHAR(50),
	premises_desc			VARCHAR(50),
    PRIMARY KEY (complaint_num),
    CONSTRAINT crime_fk_complaint_num
		FOREIGN KEY (complaint_num) REFERENCES complaint_info (complaint_num)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=INNODB;

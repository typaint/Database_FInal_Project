# Ty Painter & Tonnar Castellano
# Project 2

# create database
DROP DATABASE IF EXISTS nypd_police;
CREATE DATABASE IF NOT EXISTS nypd_police;
USE nypd_police;

# create megatable
DROP TABLE IF EXISTS police_mega;
CREATE TABLE IF NOT EXISTS police_mega
(
	complaint_num			VARCHAR(10),
	complaint_begin_date	VARCHAR(10), # date
	complaint_begin_time	TIME,
	complaint_end_date		VARCHAR(10), # date
	complaint_end_time		TIME,
	prescinct_addr_code		SMALLINT,
	report_date				VARCHAR(10), # date
	ky_code					SMALLINT,
	offense_desc			VARCHAR(50),
	pd_code					SMALLINT,
	pd_desc					VARCHAR(50),
	crime_stage_code		VARCHAR(50),
	law_category_code		VARCHAR(50),
	borough_name			VARCHAR(50),
	location_occurance		VARCHAR(50),
	premises_desc			VARCHAR(50),
	jurisdiction_desc		VARCHAR(50),
	jurisdiction_code		TINYINT,
	parks_name				VARCHAR(50),
    ha_develop				VARCHAR(50),
	housing_psa				VARCHAR(50),
	x_coord_code			INT,
	y_coord_code			INT,
	suspect_age_group		VARCHAR(50),
	suspect_race			VARCHAR(50),
	suspect_sex				CHAR(1),
	transit_dist			VARCHAR(50),
	lat						DECIMAL(11,9),
	lon						DECIMAL(11,9),
	lat_long				VARCHAR(50),
	patrol_borough			VARCHAR(50),
	station_name			VARCHAR(50),
	victim_age_group		INT,
	victim_race				VARCHAR(50),
	victim_sex				CHAR(1)
) ENGINE=INNODB;

# load data into megatable
LOAD DATA LOCAL INFILE '/Users/TyPainter1/Desktop/Masters/spring-2021/DS-5420/project2/police.csv'
INTO TABLE police_mega
FIELDS TERMINATED BY ','
		OPTIONALLY ENCLOSED BY '"'
		ESCAPED BY '\n'
IGNORE 1 LINES;

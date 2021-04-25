# Ty Painter & Tonnar Castellano
# Project 2

########## create database ##########
DROP DATABASE IF EXISTS nypd_police;
CREATE DATABASE IF NOT EXISTS nypd_police;
USE nypd_police;

######### create megatable ##########
DROP TABLE IF EXISTS police_mini_mega;
CREATE TABLE IF NOT EXISTS police_mini_mega
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
LOAD DATA LOCAL INFILE '/Users/tonnarcastellano/desktop/mini.csv'
INTO TABLE police_mini_mega
FIELDS TERMINATED BY ','
		OPTIONALLY ENCLOSED BY '"'
		ESCAPED BY '\t'
IGNORE 1 LINES;



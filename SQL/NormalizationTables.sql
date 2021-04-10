# Ty Painter & Tonnar Castellano
# Project 2

########## normalization tables ##########
# create complaint_info table
DROP TABLE IF EXISTS complaint_info;
CREATE TABLE IF NOT EXISTS complaint_info
(
	complaint_info_id		INT					AUTO_INCREMENT,
	complaint_num			INT,
	complaint_begin_date	VARCHAR(10),
	complaint_begin_time	TIME				NOT NULL,
	complaint_end_date		VARCHAR(10),
	complaint_end_time		TIME,
    PRIMARY KEY (complaint_info_id)
) ENGINE=INNODB;

# create suspect table
DROP TABLE IF EXISTS suspect;
CREATE TABLE IF NOT EXISTS suspect
(
	suspect_age_group		VARCHAR(50),
	suspect_race			VARCHAR(50),
	suspect_sex				CHAR(1),
    complaint_info_id		INT				AUTO_INCREMENT,
    PRIMARY KEY (complaint_info_id),
    CONSTRAINT suspect_fk_complaint_num
		FOREIGN KEY (complaint_info_id) REFERENCES complaint_info (complaint_info_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=INNODB;

# create victim table
DROP TABLE IF EXISTS victim;
CREATE TABLE IF NOT EXISTS victim
(
	victim_age_group		VARCHAR(50),
	victim_race				VARCHAR(50),
	victim_sex				CHAR(1),
    complaint_info_id		INT				AUTO_INCREMENT,
    PRIMARY KEY (complaint_info_id),
    CONSTRAINT victim_fk_complaint_info_id
		FOREIGN KEY (complaint_info_id) REFERENCES complaint_info (complaint_info_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=INNODB;

# create patrol_borough table
DROP TABLE IF EXISTS patrol_borough;
CREATE TABLE IF NOT EXISTS patrol_borough
(
	patrol_borough			VARCHAR(50),
	borough_name			VARCHAR(50),
    ky_code					SMALLINT,
	offense_desc			VARCHAR(50),
	pd_code					SMALLINT,
	pd_desc					VARCHAR(100),
    jurisdiction_desc		VARCHAR(50),
	jurisdiction_code		SMALLINT,
    complaint_num			INT,
    complaint_info_id		INT				AUTO_INCREMENT,
    PRIMARY KEY (complaint_info_id),
    CONSTRAINT patrol_boro_fk_complaint_info_id
		FOREIGN KEY (complaint_info_id) REFERENCES complaint_info (complaint_info_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=INNODB;

# create location table
DROP TABLE IF EXISTS location;
CREATE TABLE IF NOT EXISTS location
(
	lat						DOUBLE,
	lon						DOUBLE,
	lat_long				VARCHAR(50),
	x_coord_code			INT,
	y_coord_code			INT,
	complaint_info_id		INT				AUTO_INCREMENT,
    PRIMARY KEY (complaint_info_id),
    CONSTRAINT location_fk_complaint_num
		FOREIGN KEY (complaint_info_id) REFERENCES complaint_info (complaint_info_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=INNODB;

# crime_info table
DROP TABLE IF EXISTS crime_info;
CREATE TABLE IF NOT EXISTS crime_info
(
	prescinct_addr_code		SMALLINT,
    report_date				VARCHAR(10),
	crime_stage_code		VARCHAR(50),
	law_category_code		VARCHAR(50),
    location_occurance		VARCHAR(50),
	premises_desc			VARCHAR(50),
	parks_name				VARCHAR(100),
    ha_develop				VARCHAR(50),
    housing_psa				VARCHAR(50),
    transit_dist			VARCHAR(50),
    station_name			VARCHAR(50),
	complaint_info_id		INT				AUTO_INCREMENT,
    PRIMARY KEY (complaint_info_id),
    CONSTRAINT crime_fk_complaint_num
		FOREIGN KEY (complaint_info_id) REFERENCES complaint_info (complaint_info_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=INNODB;

INSERT INTO complaint_info(complaint_num, complaint_begin_date, complaint_begin_time, complaint_end_date, complaint_end_time)
SELECT police_mega.complaint_num, police_mega.complaint_begin_date, police_mega.complaint_begin_time, 
police_mega.complaint_end_date, police_mega.complaint_end_time
FROM police_mega as police_mega
LIMIT 25000;

INSERT INTO suspect(suspect_age_group, suspect_race, suspect_sex)
SELECT police_mega.suspect_age_group, police_mega.suspect_race, police_mega.suspect_sex
FROM police_mega as police_mega
LIMIT 25000;

INSERT INTO victim(victim_age_group, victim_race, victim_sex)
SELECT  police_mega.victim_age_group, police_mega.victim_race, police_mega.victim_sex
FROM police_mega as police_mega
LIMIT 25000;

INSERT INTO location(lat, lon, lat_long, x_coord_code, y_coord_code)
SELECT police_mega.lat, police_mega.lon, police_mega.lat_long, police_mega.x_coord_code, police_mega.y_coord_code
FROM police_mega as police_mega
LIMIT 25000;

INSERT INTO crime_info(prescinct_addr_code, report_date, crime_stage_code, 
	law_category_code, location_occurance, premises_desc, parks_name, 
    ha_develop, housing_psa, transit_dist, station_name)
SELECT police_mega.prescinct_addr_code, police_mega.report_date, police_mega.crime_stage_code, 
	police_mega.law_category_code, police_mega.location_occurance, police_mega.premises_desc, police_mega.parks_name, 
    police_mega.ha_develop, housing_psa, police_mega.transit_dist, police_mega.station_name
FROM police_mega as police_mega
LIMIT 25000;

INSERT INTO patrol_borough
SELECT	patrol_borough,
	borough_name,
    ky_code,
	offense_desc,
	pd_code,
	pd_desc,
    jurisdiction_desc,
	jurisdiction_code,
    complaint_num,
    complaint_info_id
FROM police_mega
LIMIT 25000;

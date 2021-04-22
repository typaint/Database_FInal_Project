# Ty Painter & Tonnar Castellano
# Project 2

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

######### create small mega table with subset of data ##########
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

######### insert mega table into small mega table ##########
INSERT INTO police_small_mega
SELECT *
FROM police_mega
LIMIT 100000;

######### clean data ##########
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

use nypd_police;

######### clean data values for functional dependencies ##########
# all standardizations are results from NormalizationTests script
# must run NormalizationTests script *BEFORE* the updates below to observe dirty functional dependencies
SET SQL_SAFE_UPDATES = 0;

# standardize ky_code 116, 120, 124, 125, 343, 345, 364, 677
UPDATE police_mini_mega
SET offense_desc = 'SEX CRIMES'
WHERE ky_code = 116;

UPDATE police_mini_mega
SET offense_desc = 'CHILD ABANDONMENT/NON SUPPORT'
WHERE ky_code = 120;

UPDATE police_mini_mega
SET offense_desc = 'KIDNAPPING'
WHERE ky_code = 124;

UPDATE police_mini_mega
SET offense_desc = 'NYS LAW-UNCLASSIFIED FELONY'
WHERE ky_code = 125;

UPDATE police_mini_mega
SET offense_desc = 'THEFT OF SERVICES'
WHERE ky_code = 343;

UPDATE police_mini_mega
SET offense_desc = 'OFFENSES RELATED TO CHILDREN'
WHERE ky_code = 345;

UPDATE police_mini_mega
SET offense_desc = 'AGRICULTURE & MRKTS LAW-UNCLASSIFIED'
WHERE ky_code = 364;

UPDATE police_mini_mega
SET offense_desc = 'NYS LAWS-UNCLASSIFIED VIOLATION'
WHERE ky_code = 677;

# standardize PD_code 234, 694
UPDATE police_mini_mega
SET pd_desc = 'BURGLARY, UNKNOWN TIME'
WHERE pd_code = 234;

UPDATE police_mini_mega
SET pd_desc = 'INCEST'
WHERE pd_code = 694;

# insert NULL PK data into dirty_data
INSERT INTO dirty_data
SELECT *
FROM police_mini_mega
WHERE complaint_num IS NULL 
	OR pd_code IS NULL
	OR jurisdiction_code IS NULL
    OR ky_code IS NULL;
# delete NULL PK data from police_mini_mega since it is inserted into dirty_data table
DELETE
FROM police_mini_mega
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
FROM police_mini_mega
WHERE offense_desc IS NOT NULL; # put null in bad table

# insert data into pd table
INSERT INTO pd
SELECT DISTINCT pd_code, # functional dependency; fk to complaint_info
		pd_desc	
FROM police_mini_mega
WHERE pd_code IS NOT NULL; # put null in bad table

# insert data into jurisdiction table
INSERT INTO jurisdiction
SELECT DISTINCT jurisdiction_desc, # functional dependency; fk to complaint_info
		jurisdiction_code
FROM police_mini_mega
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
FROM police_mini_mega p
JOIN pd ON pd.pd_code = p.pd_code # join pd, jurisdiction, offense tables to enforce foreign key and functional dependency
	JOIN jurisdiction j ON j.jurisdiction_code = p.jurisdiction_code
    JOIN offense o ON o.ky_code = p.ky_code;
# insert data into suspect table
INSERT INTO suspect(complaint_num, suspect_age_group, suspect_race, suspect_sex)
SELECT c.complaint_num,
		p.suspect_age_group,
		p.suspect_race,
		p.suspect_sex	
FROM police_mini_mega p
JOIN complaint_info c ON c.complaint_num = p.complaint_num; # join complaint_info to enforce foreign key
# insert data into victim table
INSERT INTO victim(complaint_num, victim_age_group, victim_race, victim_sex)
SELECT c.complaint_num,
		p.victim_age_group,
		p.victim_race,
		p.victim_sex
FROM police_mini_mega p
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
FROM police_mini_mega p
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
FROM police_mini_mega p
JOIN complaint_info c ON c.complaint_num = p.complaint_num; # join complaint_info to enforce foreign key




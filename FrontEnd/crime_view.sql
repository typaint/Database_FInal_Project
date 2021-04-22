DROP VIEW IF EXISTS crime_view;
CREATE VIEW  crime_view AS 
SELECT complaint_info.complaint_num, suspect.suspect_sex, suspect.suspect_age_group, suspect.suspect_race, 
		offense.offense_desc
FROM complaint_info complaint_info
INNER JOIN suspect suspect on suspect.complaint_num = complaint_info.complaint_num
INNER JOIN offense offense on offense.ky_code = complaint_info.ky_code;


SELECT *
FROM crime_view
WHERE complaint_num = 101448063;
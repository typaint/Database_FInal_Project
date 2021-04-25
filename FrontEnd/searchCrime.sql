USE nypd_police;
DROP PROCEDURE IF EXISTS searchCrime;
DELIMITER //
CREATE PROCEDURE searchCrime(IN comp_number INT) # stored procedure to look at suspect details invloved in a crime
BEGIN
    SELECT complaint_info.complaint_num, suspect.suspect_sex, suspect.suspect_age_group, suspect.suspect_race,
			offense.offense_desc
	FROM complaint_info complaint_info
	LEFT JOIN suspect suspect on complaint_info.complaint_num = suspect.complaint_num
	LEFT JOIN offense offense on complaint_info.ky_code = offense.ky_code 
	WHERE complaint_info.complaint_num = comp_number;
END //
DELIMITER ;

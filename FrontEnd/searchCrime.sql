USE nypd_police;
DROP PROCEDURE IF EXISTS searchCrime;
DELIMITER //
CREATE PROCEDURE searchCrime(IN comp_number INT) # stored procedure to look at suspect details invloved in a crime
BEGIN
    SELECT complaint_info.complaint_num, suspect.suspect_sex, suspect.suspect_age_group, suspect.suspect_race, 
			offense.offense_desc
	FROM complaint_info complaint_info
	JOIN suspect suspect on suspect.complaint_num = complaint_info.complaint_num
	JOIN offense offense on offense.ky_code = complaint_info.ky_code
	WHERE complaint_info.complaint_num = comp_number;
END //
DELIMITER ;
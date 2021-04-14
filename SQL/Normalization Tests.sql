###### break up patrol_borough table
# test borough
SELECT *, count(*) AS count
FROM	
    (SELECT count(*) as count, patrol_borough, borough_name
	FROM police_mega
	GROUP BY patrol_borough, borough_name
	ORDER BY patrol_borough) as new_table
GROUP BY patrol_borough
HAVING count > 2;

# tets ky_code
SELECT *, count(*) AS count
FROM	
    (SELECT count(*) as count, ky_code, offense_desc
	FROM police_mega
	GROUP BY ky_code, offense_desc
	ORDER BY ky_code) as new_table
GROUP BY ky_code
HAVING count > 2;

# tets pd_code
SELECT count(*) AS count, pd_code
FROM	
    (SELECT count(*) as count, pd_code, pd_desc
	FROM police_mega
	GROUP BY pd_code, pd_desc
	ORDER BY pd_code) as new_table
GROUP BY pd_code, pd_desc
HAVING count > 1;
#############
select DISTINCT pd_code, pd_desc
from police_mega
WHere pd_code = 234 OR pd_code = 694;

# tets jurisdiction_code
SELECT count(*) AS count, jurisdiction_code
FROM	
    (SELECT count(*) as count, jurisdiction_code, jurisdiction_desc
	FROM police_mega
	GROUP BY jurisdiction_code, jurisdiction_desc
	ORDER BY jurisdiction_code) as new_table
GROUP BY jurisdiction_code
HAVING count > 1; # null

# tets lat lon
SELECT count(*) AS count, lat_long
FROM	
    (SELECT count(*) as count, lat_long, lat, lon
	FROM police_mega
	GROUP BY lat_long, lat, lon
	ORDER BY lat_long) as new_table
GROUP BY lat_long
HAVING count > 1;

select complaint_num,
	prescinct_addr_code,
    report_date,
	crime_stage_code,
	law_category_code,
    location_occurance,
	premises_desc
from police_mega;
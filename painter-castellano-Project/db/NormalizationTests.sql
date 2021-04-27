# test borough
SELECT prescinct_addr_code, count(*) AS count, patrol_borough
FROM	
    (SELECT count(*) as count, patrol_borough, borough_name, prescinct_addr_code
	FROM police_mega
	GROUP BY patrol_borough, borough_name, prescinct_addr_code) as new_table
GROUP BY patrol_borough, prescinct_addr_code
HAVING count > 2;

# tests ky_code
SELECT ky_code, count(*) AS count
FROM	
    (SELECT count(*) as count, ky_code, offense_desc
	FROM police_mega
	GROUP BY ky_code, offense_desc
    HAVING offense_desc IS NOT NULL
	ORDER BY ky_code) as new_table
GROUP BY ky_code
HAVING count > 1;

SELECT DISTINCT ky_code, offense_desc
FROM police_mega
WHERE ky_code = 124;

# tests pd_code
SELECT pd_code, count(*) AS count
FROM	
    (SELECT count(*) as count, pd_code, pd_desc
	FROM police_mega
	GROUP BY pd_code, pd_desc
	ORDER BY pd_code) as new_table
GROUP BY pd_code
HAVING count > 1;

SELECT DISTINCT pd_code, pd_desc
FROM police_mega
WHERE pd_code = 234;

# tests jurisdiction_code
SELECT count(*) AS count, jurisdiction_code
FROM	
    (SELECT count(*) as count, jurisdiction_code, jurisdiction_desc
	FROM police_mega
	GROUP BY jurisdiction_code, jurisdiction_desc
	ORDER BY jurisdiction_code) as new_table
GROUP BY jurisdiction_code
HAVING count > 1; # null

SELECT DISTINCT jurisdiction_code, jurisdiction_desc
FROM police_mega
WHERE jurisdiction_code IS NULL;

# test lat lon
SELECT count(*) AS count, lat_long
FROM	
    (SELECT count(*) as count, lat_long, lat, lon
	FROM police_mega
	GROUP BY lat_long, lat, lon
	ORDER BY lat_long) as new_table
GROUP BY lat_long
HAVING count > 1;

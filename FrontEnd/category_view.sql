USE nypd_police;
DROP VIEW IF EXISTS category_view;
CREATE VIEW  category_view AS # view to see the type of crimes committed 
SELECT borough_name, COUNT(*) as crime_count
FROM crime_info
GROUP BY borough_name
ORDER BY COUNT(*)  DESC;


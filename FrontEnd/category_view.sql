USE nypd_police;
DROP VIEW IF EXISTS category_view;
CREATE VIEW  category_view AS # view to see the type of crimes committed 
SELECT law_category_code AS crime_type, COUNT(*) as crime_count
FROM crime_info
GROUP BY law_category_code
ORDER BY COUNT(*) DESC;


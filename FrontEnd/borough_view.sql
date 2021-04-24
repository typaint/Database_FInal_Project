DROP VIEW IF EXISTS borough_view;
CREATE VIEW  borough_view AS # view to see the number of crimes committed in each borough in descending order
SELECT borough_name, COUNT(*) as 'Crime Count'
FROM crime_info
GROUP BY borough_name
ORDER BY COUNT(*)  DESC;


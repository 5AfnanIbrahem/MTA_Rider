SELECT * FROM mta.`mta.d`;

SELECT 
    `Year`,
    COUNT(DISTINCT `Date`) AS days_recorded,
    SUM(`Riders`) AS total_riders,
    ROUND(AVG(`Riders`), 0) AS avg_daily_riders,
    ROUND(AVG(`Recovery_Percentage`), 2) AS avg_recovery,
    (SELECT `Mode_Name` FROM `mta.d` WHERE `Year` = t.`Year` GROUP BY `Mode_Name` ORDER BY SUM(`Riders`) DESC LIMIT 1) AS top_mode,
    (SELECT MAX(`Riders`) FROM `mta.d` WHERE `Year` = t.`Year`) AS peak_day_riders
FROM `mta.d` t
GROUP BY `Year`
ORDER BY `Year` DESC;



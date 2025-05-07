SELECT * FROM mta.`mta.d`;

USE mta;

DESCRIBE `mta.d`;



SELECT 
    `Year`,
    `Date`,
    `Day Name`,
    `Riders` AS total_riders
FROM (
    SELECT 
        `Year`,
        `Date`,
        `Day Name`,
        `Riders`,
        RANK() OVER (PARTITION BY `Year` ORDER BY `Riders` DESC) AS rank_desc
    FROM `mta.d`
) ranked
WHERE rank_desc <= 5  -- أعلى 5 أيام لكل سنة
ORDER BY `Year` DESC, `Riders` DESC;




SELECT 
    `Year`,
    `Date`,
    `Day Name`,
    `Riders` AS total_riders
FROM (
    SELECT 
        `Year`,
        `Date`,
        `Day Name`,
        `Riders`,
        RANK() OVER (PARTITION BY `Year` ORDER BY `Riders` ASC) AS rank_asc
    FROM `mta.d`
    WHERE `Riders` > 0  -- استبعاد الأيام التي قد تكون فيها القيمة صفر
) ranked
WHERE rank_asc <= 5  -- أقل 5 أيام لكل سنة
ORDER BY `Year` DESC, `Riders` ASC;



SELECT 
    `Year`,
    `Mode_Name`,
    SUM(`Riders`) AS total_riders,
    ROUND(AVG(`Recovery_Percentage`), 2) AS avg_recovery,
    ROUND(SUM(`Riders`) * 100.0 / SUM(SUM(`Riders`)) OVER (PARTITION BY `Year`), 2) AS percentage_of_year
FROM `mta.d`
GROUP BY `Year`, `Mode_Name`
ORDER BY `Year` DESC, total_riders DESC;



SELECT 
    `Year`,
    `Month Name`,
    SUM(`Riders`) AS total_riders
FROM `mta.d`
GROUP BY `Year`, `Month Name`
ORDER BY `Year` DESC, total_riders DESC;



SELECT 
    `Year`,
    `Type of day`,
    ROUND(AVG(`Recovery_Percentage`), 2) AS avg_recovery_percentage,
    COUNT(*) AS record_count
FROM `mta.d`
GROUP BY `Year`, `Type of day`
ORDER BY `Year` DESC, `Type of day`;



SELECT 
    `Year`,
    `Type of day`,
    SUM(`Riders`) AS total_riders,
    ROUND(AVG(`Riders`), 0) AS avg_daily_riders,
    ROUND(SUM(`Riders`) * 100.0 / SUM(SUM(`Riders`)) OVER (PARTITION BY `Year`), 2) AS percentage_of_year
FROM `mta.d`
GROUP BY `Year`, `Type of day`
ORDER BY `Year` DESC, `Type of day`;


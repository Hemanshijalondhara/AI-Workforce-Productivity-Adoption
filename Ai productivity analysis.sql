-- Create database
CREATE DATABASE ai_productivity_analysis;
USE ai_productivity_analysis;
-- Create table
CREATE TABLE ai_adoption(
    Employee_ID INT,
    Age INT,
    Industry VARCHAR(100),
    Job_Role VARCHAR(100),
    Experience_Years INT,
    Company_Size VARCHAR(50),
    Remote_Work_Type VARCHAR(50),
    AI_Tools_Used INT,
    Daily_AI_Usage_Hours DECIMAL(4,2),
    Primary_AI_Tool VARCHAR(100),
    Tasks_Automated_Percent DECIMAL(5,2),
    Time_Saved_Per_Day_Minutes INT,
    Learning_Time_Per_Week_Hours DECIMAL(4,2),
    Meetings_Per_Day INT,
    Work_Hours_Per_Day DECIMAL(4,2),
    Job_Satisfaction VARCHAR(20),
    Productivity_Change VARCHAR(20),
    Salary_USD INT,
    Promotion_Last_Year VARCHAR(10),
    Fear_of_AI_Replacing_Job VARCHAR(20),
    Target VARCHAR(50)
);
-- Import file
SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'D:/internship project/AI Tools Productivity.csv'
INTO TABLE ai_adoption
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM ai_adoption;
-- check data quality
SELECT Employee_ID, COUNT(*) AS cnt
FROM ai_adoption
GROUP BY Employee_ID
HAVING COUNT(*) > 1;

TRUNCATE TABLE ai_adoption;

DESCRIBE ai_adoption;
-- Check Duplicate Records
SELECT Employee_ID,
COUNT(*) AS duplicate_count
FROM ai_adoption
GROUP BY Employee_ID
HAVING COUNT(*) > 1;
-- Check Missing Value
SELECT
SUM(Employee_ID IS NULL) AS Employee_ID,
SUM(Age IS NULL) AS Age,
SUM(Industry IS NULL) AS Industry,
SUM(Job_Role IS NULL) AS Job_Role,
SUM(Experience_Years IS NULL) AS Experience,
SUM(Salary_USD IS NULL) AS Salary
FROM ai_adoption;
-- Check blank value
SELECT *
FROM ai_adoption
WHERE Industry=''
OR Job_Role=''
OR Company_Size='';
-- Remove extra space
UPDATE ai_adoption
SET Industry = TRIM(Industry);
-- check invalid age
SELECT *
FROM ai_adoption
WHERE Age<18
OR Age>70;
-- check invalid salary
SELECT *
FROM ai_adoption
WHERE Salary_USD<=0;
-- check invalid experience
SELECT *
FROM ai_adoption
WHERE Experience_Years<0;
-- check  ai usage hours
SELECT *
FROM ai_adoption
WHERE Daily_AI_Usage_Hours<0
OR Daily_AI_Usage_Hours>24;
-- check work hour
SELECT *
FROM ai_adoption
WHERE Work_Hours_Per_Day>24;
-- check automation percentage
SELECT *
FROM ai_adoption
WHERE Tasks_Automated_Percent<0
OR Tasks_Automated_Percent>100;
--  check job satisfaction
SELECT distinct Job_Satisfaction
FROM ai_adoption;

-- check ai tools name 
SELECT DISTINCT Primary_AI_Tool
FROM ai_adoption;
-- check remote work value 
SELECT DISTINCT Remote_Work_Type
FROM ai_adoption;
-- check fear levels
SELECT DISTINCT Fear_of_AI_Replacing_Job
FROM ai_adoption;
-- remove impossible records
DELETE
FROM ai_adoption
WHERE Salary_USD<0;
-- final validation
SELECT COUNT(*) FROM ai_adoption;
SELECT DISTINCT Industry FROM ai_adoption;
SELECT DISTINCT Company_Size FROM ai_adoption;
-- 
SELECT *
FROM ai_adoption;
-- drop table 
DROP TABLE ai_adoption; 
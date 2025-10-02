CREATE TABLE movies (
ID INTEGER,
Title TEXT, 
Genre TEXT,
Release_Year INTEGER,
Release_Date INTEGER,
Country TEXT,
Budget DECIMAL(10, 2),
US_Box_Office DECIMAL(10, 2),
Global_Box_Office DECIMAL(10, 2),
Opening_Day_Sales DECIMAL(10, 2),
One_Week_Sales DECIMAL(10, 2),
IMBDb_Rating DOUBLE, 
Rotten_Tomato_Score INTEGER,
NumVotesIMDb INTEGER,
NumVotesRT INTEGER,
Director TEXT,
LeadActor TEXT
);
ALTER TABLE movies 
MODIFY COLUMN Release_Date DATE;
ALTER TABLE movies
DROP COLUMN Release_Date;




USE movie_database;

ALTER TABLE movies
RENAME COLUMN IMBDB_Rating TO IMDb_Rating;

-- Box Office Performance Analysis --

-- Which 5 movies had the highest global box office?
SELECT title, Global_Box_Office FROM movies ORDER BY Global_Box_Office DESC LIMIT 5;

-- What is the average budget for movies per genre?
SELECT Genre, ROUND(AVG(Budget), 2) FROM movies GROUP BY Genre;

-- Compare the US box office vs Global box office for top 10 movies.
SELECT title, US_Box_Office , Global_Box_Office FROM movies ORDER BY Global_Box_Office DESC LIMIT 10;

-- Which genres tend to have the highest global box office returns?
SELECT Genre, AVG(Global_Box_Office) AS Global_BoxOffice
FROM movies
GROUP BY Genre
ORDER BY AVG(Global_Box_Office) DESC;

-- 2. Rating and Reviews Analysis--
-- Which 10 movies have the highest Rotten Tomato scores?
SELECT Title, Rotten_Tomato_Score FROM movies ORDER BY Rotten_Tomato_Score DESC LIMIT 10;

-- Correlate budget with IMDB rating — do bigger budgets mean better ratings?
SELECT ID, Budget, IMDb_Rating FROM movies ORDER BY Budget DESC, IMDb_Rating DESC;

-- What is the average rating per genre?
SELECT 
Genre, 
ROUND(AVG(IMDB_Rating), 2) AS IMDb_Rating, 
ROUND(AVG(Rotten_Tomato_Score), 2) AS Rotten_Tomato_Score
 FROM movies GROUP BY Genre;

-- Which 10 directors have the highest average movie ratings?
SELECT 
Director,
ROUND(AVG(IMDB_Rating), 2) AS IMDb_Rating, 
ROUND(AVG(Rotten_Tomato_Score), 2) AS Rotten_Tomato_Score
FROM movies
GROUP BY Director
Limit 10;

-- 3. Time-Based Trends --
-- How did the average budget for movies change over the years (Release_Year)?
SELECT 
Release_Year,
ROUND(AVG(Budget), 2) AS Avg_Budget
FROM movies
GROUP BY Release_Year
ORDER BY Release_Year ASC; 

-- Which years saw the highest number of releases?
SELECT Release_Year, COUNT(Release_Year) AS no_releases FROM movies GROUP BY Release_Year
ORDER BY no_releases DESC;

-- Trends in box office over decades — did global box office increase for specific genres?
SELECT 
  Genre,
  CONCAT(FLOOR(Release_Year / 10) * 10, 's') AS Decade,
  SUM(Global_Box_Office) AS total_box_office
  FROM movies
  GROUP BY Genre, Decade
  ORDER BY Genre, Decade ASC;


-- 4. Sales and Revenue Analysis --
-- Which 10 movies had the biggest opening day sales and one-week sales?
SELECT Title, Opening_Day_Sales, One_Week_Sales FROM movies ORDER BY Opening_Day_Sales DESC, One_Week_Sales DESC LIMIT 10;

-- 5. Country and Market Analysis --
-- Which countries produce the most movies in your dataset?
SELECT Country, COUNT(Country) AS No_Releases FROM movies GROUP BY Country Order By No_Releases DESC;

-- Do movies from certain countries have higher IMDb ratings?
SELECT Country, ROUND(AVG(IMDb_Rating), 2) AS IMDb_Rating FROM movies GROUP BY Country ORDER BY IMDb_Rating DESC;

-- 6. Director and Actor Analysis --
-- Which lead actors appear most frequently in high-grossing movies?
SELECT LeadActor, COUNT(*) AS Frequency, 
SUM(COALESCE(Global_Box_Office, 0) + COALESCE(Opening_Day_Sales, 0) + COALESCE(One_Week_Sales, 0) + COALESCE(US_Box_Office, 0)) AS Gross
FROM movies
GROUP BY LeadActor
ORDER BY Gross DESC
LIMIT 10;

-- 7. Data Quality & Cleaning Checks --
-- Check for movies with missing or zero budget or global box office numbers.
SELECT * FROM movies WHERE BUDGET IS NULL OR Global_Box_Office IS NULL;

-- Identify duplicate movie titles or records.
SELECT 
  Title, 
  COUNT(*) AS duplicate_count
FROM movies
GROUP BY Title
HAVING COUNT(*) > 1;





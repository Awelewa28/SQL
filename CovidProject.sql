SELECT* 
FROM CovidData

SELECT DISTINCT* 
FROM CovidData

---The data consist of duplicates

---Filtering out Duplicates using CTE
Select*
FROM CovidData
WHERE Countries = 'Afghanistan'

WITH CovidCTE AS(
SELECT *, 
	ROW_NUMBER()
	OVER(PARTITION BY Countries,
					  Total_Cases,
					  New_Deaths,
					  Active_Cases,
					  Critical_Cases,
					  Total_Tests,
					  Population
					  ORDER BY Countries) AS row_Num
FROM CovidData)
SELECT *
FROM CovidCTE
WHERE row_Num > 1

---Deleting Duplicates Using CTE
WITH CovidCTE AS(
SELECT *, 
	ROW_NUMBER()
	OVER(PARTITION BY Countries,
					  Total_Cases,
					  New_Deaths,
					  Active_Cases,
					  Critical_Cases,
					  Total_Tests,
					  Population
					  ORDER BY Countries) AS row_Num
FROM CovidData)
DELETE 
FROM CovidCTE
WHERE row_Num > 1

SELECT*
FROM CovidData    ---Duplicates have been removed and table reduced from 920 rows to 230 rows
ORDER BY Countries

---Total Number of Death, Cases and Recovery WorldWide
Select SUM(Total_Cases) AS WorldCovidCases, SUM(Total_Deaths) WorldCovidDeaths , SUM(Total_Recovered) WorldCovidRecovery
FROM CovidData


--Joining Continent table to CovidData Table

SELECT*
FROM ContinentTable
Where Countries like '%Angola'

UPDATE ContinentTable    ---The Countries weren't correlating due to excess spaces in the countries column of ContinentTable
SET Countries = LTRIM(Countries)								   ---- So it had to be trimmed

Select CovidData.Countries,ContinentTable.Countries,Continent
FROM CovidData
FULL OUTER JOIN ContinentTable
ON CovidData.Countries = ContinentTable.Countries
GROUP BY CovidData.Countries,ContinentTable.Countries,Continent
Order by CovidData.Countries,ContinentTable.Countries 

---After the above join it was noticed that some countries didn't match up due to incorrect spellings in the dataset

---Correcting spellings in corellation to the CovidData Table

UPDATE ContinentTable
SET Countries = LTRIM(Countries)

UPDATE ContinentTable
SET Countries = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
				(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
															(Countries,'Baharin','Bahrain'),
															'Cape Verde','Cabo Verde'),
															'Central African Republic', 'CAR'),
															'Republic of Congo', 'Congo'),
															'Czech Republic', 'Czechia'),
															'Dijibouti', 'Djibouti'),
															'North Korea', 'DPRK'),
															'Equatorial Guinea', 'Equatorial Guinea'),
															'Guinea Bissau', 'Guinea-Bissau'),
															'Lieischenstein', 'Liechtenstein'),
															'Macedonia', 'North Macedonia'),
															'South Korea', 'S. Korea'),
															'St Kitts and Nevis', 'Saint Kitts and Nevis'),
															'St Lucia', 'Saint Lucia'),
															'St Vincent Grenadines', 'St. Vincent Grenadines'),
															'Sai Tome and Principe', 'Sao Tome and Principe'),
															'Sudan', ' South Sudan'),
															'US', 'USA'),
															'AUSAAtralia','Australia'),
															'AUSAAtria', 'Austria'), 'BelarUSA','Belarus'), 'Columbia','Colombia'),'CyprUSA', 'Cyprus'),
															'MauritiUSA', 'Mauritius'), 'North North Macedonia', 'North Macedonia'),
															'RUSAsia','Russia'), 'Srilanka', 'Sri Lanka'), 'Papua New guinea', 'Papua New Guinea')
															WHERE Countries IN('Sudan', 'St Vincent Grenadines','AUSAAtralia','AUSAAtria','Columbia',
																			  'CyprUSA','MauritiUSA','North North Macedonia','Srilanka' )

INSERT INTO ContinentTable VALUES  ---Missing Africa country in Continent table
('Eswatini', 'Africa')



Select COV.Countries,CON.Countries,Continent
FROM CovidData AS COV
LEFT OUTER JOIN ContinentTable AS CON
ON COV.Countries = CON.Countries              --Countries and Continent are now in correlation for both table
GROUP BY COV.Countries,CON.Countries,Continent
Order by COV.Countries 

----Percentage of Death per population
  SELECT (SUM(Total_Deaths)/SUM(Population))*100  TotalDeathPercentage
  FROM CovidData

----Percentage of Covid Cases per Population
SELECT (SUM(Total_Cases)/SUM(Population))*100  TotalCovidCasesPercentage
FROM CovidData

--Recovery Percentage per population
SELECT (SUM([Total_Recovered])/SUM(Population))*100  RecoveryPercentage
FROM CovidData

----Percentage of Active Cases
SELECT (SUM([Active_Cases])/SUM(Population))*100 ActiveCasesPercentage 
FROM CovidData

SELECT (SUM(Total_Cases - Total_Recovered - Active_Cases)/SUM(Population)) * 100 ---Proof of correct Calculation, this give Death Percentage by Population
FROM CovidData

----Merging Some columns in CovidData Table and Continent Table to Get a desired outcome for further Analysis

CREATE TABLE JointTable
(Countries NVARCHAR(255),
Continent NVARCHAR(255),
Population FLOAT,
Total_Cases FLOAT,
Active_Cases FLOAT,
Total_Deaths FLOAT,
Total_Recovered FLOAT)

INSERT INTO JointTable
Select COV.Countries,Continent, Population, Total_Cases, Active_Cases, Total_Deaths,Total_Recovered
FROM CovidData AS COV
LEFT OUTER JOIN ContinentTable AS CON
ON COV.Countries = CON.Countries              
GROUP BY COV.Countries,Continent, Population, Total_Cases, Active_Cases, Total_Deaths,Total_Recovered
Order by COV.Countries 

select* from JointTable

---Changing NULL in cotinent column to International, Because they are not countries
UPDATE JointTable
SET Continent = ISNULL(Continent, 'International')

SELECT DISTINCT(Continent)
FROM JointTable

---Changing NULL in [Active_Cases], [Total_Cases],[Total_Deaths], [Total_Recovered]

UPDATE JointTable
SET Active_Cases = ISNULL( [Active_Cases], 0)

UPDATE JointTable
SET Total_Cases = ISNULL( [Total_Cases], 0)

UPDATE JointTable
SET Total_Deaths = ISNULL( [Total_Deaths], 0)

UPDATE JointTable
SET Total_Recovered = ISNULL( [Total_Recovered], 0)



					-----Analysing Each Continent
--For Asia

SELECT (SUM(Total_Cases)/SUM(Population))*100 as TotalCasesInASIA_Percent ---3.87% cases in Asia per her Population
FROM JointTable
WHERE Continent = 'Asia'

SELECT (SUM(Active_Cases)/SUM(Population))*100 as ActiveCasesInASIA_Percent ---- 0.066% Active cases in Asia per population
FROM JointTable
WHERE Continent = 'Asia'

SELECT (SUM(Total_Recovered)/SUM(Population))*100 as RecoveryInASIA_Percent ---3.76% has Recovered per Asia Population
FROM JointTable
WHERE Continent = 'Asia'

SELECT (SUM(Total_Deaths)/SUM(Population))*100 as DeathsInASIA_Percent ---0.03% Died of covid in Asia per Asia Population
FROM JointTable
WHERE Continent = 'Asia'

---For Africa
SELECT (SUM(Total_Cases)/SUM(Population))*100 as TotalCasesInAfrica_Percent ---- 0.86% Totalcases in Africa per population
FROM JointTable
WHERE Continent = 'Africa'

SELECT (SUM(Active_Cases)/SUM(Population))*100 as ActiveCasesInAfrica_Percent ---- 0.019% Active cases in Africa per population
FROM JointTable
WHERE Continent = 'Africa'

SELECT (SUM(Total_Recovered)/SUM(Population))*100 as RecoveryInAfrica_Percent ---- 0.74% Recovery in Africa per population
FROM JointTable
WHERE Continent = 'Africa'

SELECT (SUM(Total_Deaths)/SUM(Population))*100 as DeathsInAfrica_Percent ---- 0.018% Died of Covid19 in Africa per population
FROM JointTable
WHERE Continent = 'Africa'

---For Europe

SELECT (SUM(Total_Cases)/SUM(Population))*100 as TotalCasesInEurope_Percent ---- 30.37% Totalcases in Europe per population
FROM JointTable
WHERE Continent = 'Europe'

SELECT (SUM(Active_Cases)/SUM(Population))*100 as ActiveCasesInEurope_Percent ---- 0.597% Active cases in Europe per population
FROM JointTable
WHERE Continent = 'Europe'

SELECT (SUM(Total_Recovered)/SUM(Population))*100 as RecoveryInEurope_Percent ---- 29.497% Recovery in Europe per population
FROM JointTable
WHERE Continent = 'Europe'

SELECT (SUM(Total_Deaths)/SUM(Population))*100 as DeathsInEurope_Percent ---- 0.25% Died of Covid19 in Europe per population
FROM JointTable
WHERE Continent = 'Europe'

---For Oceania

SELECT (SUM(Total_Cases)/SUM(Population))*100 as TotalCasesInOceania_Percent ---- 28.48% Totalcases in Oceania per population
FROM JointTable
WHERE Continent = 'Oceania'

SELECT (SUM(Active_Cases)/SUM(Population))*100 as ActiveCasesInOceania_Percent ---- 0.23% Active cases in Oceania per population
FROM JointTable
WHERE Continent = 'Oceania'

SELECT (SUM(Total_Recovered)/SUM(Population))*100 as RecoveryInOceania_Percent ---- 28.19% Recovery in Oceania per population
FROM JointTable
WHERE Continent = 'Oceania'

SELECT (SUM(Total_Deaths)/SUM(Population))*100 as DeathsOceania_Percent ---- 0.046% Died of Covid19 in Oceania per population
FROM JointTable
WHERE Continent = 'Oceania'

---For South America

SELECT (SUM(Total_Cases)/SUM(Population))*100 as TotalCasesInSouthAmerica_Percent ---- 14.63% Totalcases in South America per population
FROM JointTable
WHERE Continent = 'South America'

SELECT (SUM(Active_Cases)/SUM(Population))*100 as ActiveCasesInSouthAmerica_Percent ---- 0.068% Active cases in South America per population
FROM JointTable
WHERE Continent = 'South America'

SELECT (SUM(Total_Recovered)/SUM(Population))*100 as RecoveryInSouthAmerica_Percent ---- 14.24% Recovery in South America per population
FROM JointTable
WHERE Continent = 'South America'

SELECT (SUM(Total_Deaths)/SUM(Population))*100 as DeathsinSouthAmerica_Percent ---- 0.30% Died of Covid19 in South America per population
FROM JointTable
WHERE Continent = 'South America'

---For North America

SELECT (SUM(Total_Cases)/SUM(Population))*100 as TotalCasesInNorthAmerica_Percent ---- 19.40% Totalcases in North America per population
FROM JointTable
WHERE Continent = 'North America'

SELECT (SUM(Active_Cases)/SUM(Population))*100 as ActiveCasesInSouthAmerica_Percent ---- 0.48% Active cases in North America per population
FROM JointTable
WHERE Continent = 'North America'

SELECT (SUM(Total_Recovered)/SUM(Population))*100 as RecoveryInSouthAmerica_Percent ---- 18.59% Recovery in North America per population
FROM JointTable
WHERE Continent = 'North America'

SELECT (SUM(Total_Deaths)/SUM(Population))*100 as DeathsinSouthAmerica_Percent ---- 0.25% Died of Covid19 in North America per population
FROM JointTable
WHERE Continent = 'North America'

---For International

SELECT (SUM(Total_Cases)/SUM(Population))*100 as TotalCasesInInternational_Percent ---- 23.91% Totalcases in International per population
FROM JointTable
WHERE Continent = 'International'

SELECT (SUM(Active_Cases)/SUM(Population))*100 as ActiveCasesInInternational_Percent ---- 2.94% Active cases in International per population
FROM JointTable
WHERE Continent = 'International'

SELECT (SUM(Total_Recovered)/SUM(Population))*100 as RecoveryInInternational_Percent ---- 19.49% Recovery in International per population
FROM JointTable
WHERE Continent = 'International'

SELECT (SUM(Total_Deaths)/SUM(Population))*100 as DeathsinInternational_Percent ---- 0.08% Died of Covid19 in International per population
FROM JointTable
WHERE Continent = 'International'

----Showing Top 10 in Couuntries with Cases, Deaths and Recovery in each Continent
SELECT Top 10 Countries, Total_Cases, Total_Deaths, Total_Recovered, Active_Cases
from JointTable
WHERE Continent = 'Africa' 
ORDER BY Total_Cases DESC

SELECT Top 10 Countries, Total_Cases, Total_Deaths, Total_Recovered, Active_Cases
from JointTable
WHERE Continent = 'Asia' 
ORDER BY Total_Cases DESC

SELECT Top 10 Countries, Total_Cases, Total_Deaths, Total_Recovered, Active_Cases
from JointTable
WHERE Continent = 'Europe' 
ORDER BY Total_Cases DESC

SELECT Top 10 Countries, Total_Cases, Total_Deaths, Total_Recovered, Active_Cases
from JointTable
WHERE Continent = 'South America' 
ORDER BY Total_Cases DESC

SELECT Top 10 Countries, Total_Cases, Total_Deaths, Total_Recovered, Active_Cases
from JointTable
WHERE Continent = 'North America' 
ORDER BY Total_Cases DESC

SELECT Top 10 Countries, Total_Cases, Total_Deaths, Total_Recovered, Active_Cases
from JointTable
WHERE Continent = 'International' 
ORDER BY Total_Cases DESC










INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male')

INSERT INTO EmployeeDemographics VALUES
(1002, 'Awe', 'Damola', 25, 'Male'),
(1003, 'Paul', 'Josephine', 30, 'Female'),
(1004, 'Adetunji', 'Zainab', 25, 'Female'),
(1005, 'Adetunji', 'Habeeb', 26, 'Male'),
(1006, 'Olabiyi', 'Olamide', 25, 'Male'),
(1007, 'Fasina', 'Janet', 28, 'Female'),
(1008, 'Babalola', 'Bolaji', 27, 'Male'),
(1009, 'Peace', 'Oluwadara', 25, 'Female'),
(1010, 'Adeola', 'Rahmat', 25, 'Female')


INSERT INTO EmployeeSalary VALUES
(1001, 'Salaesman', 45000),
(1002, 'Data Analyst', 50000),
(1003, 'Marketer', 20000),
(1004, 'Writer', 30000),
(1005, 'FX', 35000),
(1006, 'Admin', 40000),
(1007, 'Designer', 30000),
(1008, 'HR', 30000),
(1009, 'HR', 30000),
(1010, 'Accountant', 35000)

SELECT* 
FROM EmployeeDemographics

SELECT LastName FROM EmployeeDemographics

SELECT JobTitle, Salary FROM EmployeeSalary

SELECT TOP 5*
FROM EmployeeDemographics

SELECT TOP 5 JobTitle, Salary
FROM EmployeeSalary

SELECT DISTINCT(FirstName)
FROM EmployeeDemographics

SELECT COUNT(Salary)
FROM EmployeeSalary

SELECT DISTINCT(FirstName) AS DistinctName
FROM EmployeeDemographics

SELECT MAX(Salary) FROM EmployeeSalary
SELECT MIN(Salary) FROM EmployeeSalary
SELECT AVG(Salary) FROM EmployeeSalary

--Changed database from stud_details to Master below

SELECT* 
FROM stud_details.dbo.EmployeeDemographics

--Where Statement

SELECT *
FROM EmployeeDemographics
WHERE FirstName= 'Adetunji'

SELECT*
FROM EmployeeSalary
WHERE Salary >= 25000

SELECT*
FROM EmployeeDemographics
WHERE Age >= 25 AND Gender = 'Male'

SELECT*
FROM EmployeeDemographics
WHERE Age >= 25 or Gender = 'Male'

SELECT*
FROM EmployeeDemographics
WHERE FirstName LIKE 'A%' AND Age = 25

SELECT*
FROM EmployeeSalary
WHERE JobTitle IS NULL

SELECT*
FROM EmployeeSalary
WHERE JobTitle IS NOT NULL

SELECT*
FROM EmployeeDemographics
WHERE FirstName IN ('Awe', 'Adetunji', 'Fasina')

---GRoup By and Order BY---

SELECT Gender
FROM EmployeeDemographics
GROUP BY Gender

SELECT Gender, Age, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
GROUP BY Gender, Age

SELECT Gender, Age, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
WHERE AGE >= 27
GROUP BY Gender, Age

SELECT Gender, Age, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
WHERE AGE >= 25
GROUP BY Gender, Age
ORDER BY Age

SELECT Gender, Age, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
WHERE AGE >= 25
GROUP BY Gender, Age
ORDER BY Age DESC

SELECT Gender, Age, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
WHERE AGE >= 25
GROUP BY Gender, Age
ORDER BY Age DESC, Gender

SELECT Gender, Age, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
WHERE AGE >= 25
GROUP BY Gender, Age
ORDER BY Age DESC, Gender DESC

SELECT Gender, Age, COUNT(Gender) AS GenderCount
FROM EmployeeDemographics
WHERE AGE >= 25
GROUP BY Gender, Age
ORDER BY 1 DESC, 3 DESC
          --Intermediate SQL

--Joins

SELECT*
FROM EmployeeDemographics

INSERT INTO EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

SELECT*
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID =EmployeeSalary.EmployeeID

SELECT*
FROM EmployeeDemographics
FULL OUTER JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID =EmployeeSalary.EmployeeID

SELECT*
FROM EmployeeDemographics
LEFT OUTER JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID =EmployeeSalary.EmployeeID

SELECT*
FROM EmployeeDemographics
RIGHT OUTER JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID =EmployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics
LEFT OUTER JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID =EmployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID =EmployeeSalary.EmployeeID
	WHERE FirstName <> 'Jim'
	ORDER BY Salary DESC

---UNIONS

CREATE TABLE WarehouseEmployeeDemographics
(EmployeeID INT,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Age INT,
Gender VARCHAR(50))

INSERT INTO WarehouseEmployeeDemographics VALUES
(1050, 'Omogie', 'Favour', 30, 'Male'),
(1013, NULL, 'Shalom', 22, 'Female'),
(1051, 'Afolabi', 'Mubarak', 24, 'Male'),
(1042, 'Dare', NULL, 28, 'Female')

INSERT INTO WarehouseEmployeeDemographics VALUES
(1051, 'Afolabi', 'Mubarak', 24, 'Male')


SELECT* FROM EmployeeDemographics
UNION
SELECT* FROM WarehouseEmployeeDemographics

SELECT* FROM EmployeeDemographics
UNION ALL
SELECT* FROM WarehouseEmployeeDemographics
ORDER BY EmployeeID

---Case Statement

SELECT FirstName, LastName, Age, 
CASE
	WHEN Age > 23 THEN 'Old'
	ELSE 'Young'
END AS Category
FROM EmployeeDemographics
ORDER BY Age

SELECT FirstName, LastName, Age, 
CASE
	WHEN Age BETWEEN 25 AND 26 THEN 'YOUNG'
	WHEN Age = 27 THEN 'Mature'
	WHEN Age BETWEEN 28 AND 29 THEN 'Grown'
	ELSE 'Old'
END AS Category
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age

---Having Clause

SELECT  JobTitle, COUNT(JobTitle) AS JOBCOUNT
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle 
HAVING COUNT(JobTitle) > 0 

SELECT  JobTitle, AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle 
HAVING AVG(Salary) > 25000
ORDER BY AVG(Salary)

---Updating Data
SELECT*
FROM EmployeeDemographics

UPDATE EmployeeDemographics
SET EmployeeID =1012, Gender = 'Female'
WHERE FirstName = 'Holly' AND AGE IS NULL

---Deleting Data

SELECT*
FROM EmployeeDemographics


DELETE EmployeeDemographics
WHERE EmployeeID = 1013

---Aliasing

SELECT EmployeeID, FirstName,LastName, FirstName + '.' + LastName+'@gmail.com' AS Email
FROM EmployeeDemographics

SELECT DEMO.EmployeeID
FROM EmployeeDemographics AS DEMO

SELECT DEMO.EmployeeID, SAL.EmployeeID
FROM EmployeeDemographics AS DEMO
JOIN EmployeeSalary AS SAL
	ON DEMO.EmployeeID = SAL.EmployeeID

---ADVANCED SQL

---WITH CTE

WITH CTE_Employee AS (SELECT FirstName, LastName, Gender, Salary,
	COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender, AVG(Salary) OVER (PARTITION BY Gender) AS AvgSalary
FROM  EmployeeDemographics EMP
JOIN EmployeeSalary SAL
ON EMP.EmployeeID = SAL.EmployeeID
WHERE Salary > 30000)
SELECT*
FROM CTE_Employee

---TEMP_TABLE

CREATE TABLE #temp_Employee(
EmployeeID INT,
JobTitle VARCHAR(50),
Salary INT)

SELECT*
FROM #temp_Employee

INSERT INTO #temp_Employee
VALUES (0001, 'Analyst', 100000)

CREATE TABLE EmployeeError(
EmployeeID VARCHAR (50),
FirstName VARCHAR (50),
LastName VARCHAR (50) )

INSERT INTO EmployeeError
VALUES 
('1001', 'Jimbo', 'Halbert'),
(' 1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson-Fixed')
	
SELECT*
FROM EmployeeError

--TRIM, LTRIM, RTIM
SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeError

SELECT EmployeeID, LTRIM(EmployeeID) as IDTRIM
FROM EmployeeError

SELECT EmployeeID, RTRIM(EmployeeID) as IDTRIM
FROM EmployeeError

---REPLACE
SELECT LastName, REPLACE(LastName,'-Fixed','') AS LastNameFixed
FROM EmployeeError

SELECT EmployeeID,FirstName,LastName, REPLACE(LastName, 'Halbert', 'Awelewa') AS Corrected, FirstName+' '+LastName
FROM EmployeeError

---SUBSTRING
CREATE TABLE EMPNAME(
EmployeeID INT, FirstName VARCHAR(50), LastName VARCHAR(50))

INSERT INTO EMPNAME
VALUES(1002, 'Awe', 'Damola'),
(1003, 'Paul', 'Josephine'),
(1004, 'Adetunji', 'Zainab'),
(1005, 'Adetunji', 'Habeeb'),
(1006, 'Olabiyi', 'Olamide'),
(1007, 'Fasina', 'Janet'),
(1008, 'Babalola', 'Bolaji'),
(1009, 'Peace', 'Oluwadara'),
(1010, 'Adeola', 'Rahmat')

SELECT SUBSTRING(FirstName,1,3)
FROM EmployeeError


SELECT EMP.FirstName, SUBSTRING(EMP.FirstName,1,3),DEM.FirstName,SUBSTRING(DEM.FirstName,1,3)
FROM EMPNAME EMP
JOIN EmployeeDemographics DEM
ON EMP.FirstName = DEM. FirstName

---UPPER AND LOWER
SELECT*
FROM EmployeeError

SELECT FirstName, LOWER(FirstName)
FROM EmployeeError
WHERE FirstName  LIKE 'TO%'

SELECT FirstName, UPPER(FirstName) AS NEWNAME
FROM EmployeeError

---STORED PROCEDURE
CREATE PROCEDURE TEST
AS
SELECT*
FROM EmployeeDemographics
EXEC TEST

CREATE PROCEDURE Temp_Employee
AS
CREATE TABLE #Temp_Employee
(JobTitle VARCHAR (50),
EmployeeperJobs INT,
AvgAge INT,
AvgSalary INT)

INSERT INTO #Temp_Employee
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle

SELECT* FROM #Temp_Employee

EXEC Temp_Employee

---MODIFYING STORED PROCEDURES
ALTER PROCEDURE Temp_Employee
@JobTitle NVARCHAR(100)
AS
CREATE TABLE #Temp_Employee
(JobTitle VARCHAR (50),
EmployeeperJobs INT,
AvgAge INT,
AvgSalary INT)

INSERT INTO #Temp_Employee
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
ON emp.EmployeeID = sal.EmployeeID
WHERE JobTitle = @JobTitle
GROUP BY JobTitle

SELECT* FROM #Temp_Employee

EXEC Temp_Employee @Jobtitle = 'HR'

---SUBQUERY

---IN SELECT
SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AllAvgSalary
FROM
EmployeeSalary

---IN PARTITION BY
SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
FROM EmployeeSalary

---IN FROM
SELECT a.EmployeeID, AllAvgSalary
FROM
(SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
FROM EmployeeSalary) a

---IN WHERE
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID IN (
SELECT EMployeeID FROM EmployeeDemographics
WHERE Age > 25)




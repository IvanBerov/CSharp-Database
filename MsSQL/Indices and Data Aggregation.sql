USE Gringotts
--1.Records’ Count
SELECT COUNT(*) AS [Count]
FROM WizzardDeposits

--2.Longest Magic Wand

SELECT TOP(1) 
			MagicWandSize AS LongestMagicWand
		FROM WizzardDeposits
	ORDER BY MagicWandSize DESC

--3.Longest Magic Wand per Deposit Groups
SELECT 
		DepositGroup,MAX(MagicWandSize) AS LongestMagicWand 
	FROM WizzardDeposits
	GROUP BY DepositGroup

--4.Smallest Deposit Group per Magic Wand Size
SELECT TOP(2)
		DepositGroup
	FROM WizzardDeposits
	GROUP BY DepositGroup
	ORDER BY AVG(MagicWandSize)

--5.Deposits Sum
SELECT DepositGroup,
	   SUM(DepositAmount) AS TotalSum 
	FROM WizzardDeposits
	GROUP BY DepositGroup

--6.Deposits Sum for Ollivander Family
SELECT 
	DepositGroup,
	SUM(DepositAmount) AS TotalSum 
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

--7.Deposits Filter
SELECT 
		DepositGroup,
		SUM(DepositAmount) AS TotalSum
	FROM WizzardDeposits
	WHERE MagicWandCreator = 'Ollivander family'
	GROUP BY DepositGroup
	HAVING SUM(DepositAmount) < 150000
	ORDER BY TotalSum DESC

--8.Deposit Charge
SELECT 
		DepositGroup,
		MagicWandCreator,
		MIN(DepositCharge)
		FROM WizzardDeposits
	GROUP BY DepositGroup , MagicWandCreator
	ORDER BY MagicWandCreator,DepositGroup

--9.Age Groups
SELECT AgeGroup,
	   COUNT(Id) AS WizardCount
FROM   (
        SELECT 
	    	*,CASE 
	    		WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
	    		WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
	    		WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
	    		WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
	    		WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
	    		WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
	    		ELSE '[61+]'
	    		END AS AgeGroup
	    FROM WizzardDeposits
	   ) AS AgeGrouping
GROUP BY AgeGroup

--10.First Letter
SELECT 
	LEFT(WizzardDeposits.FirstName,1) AS FirstLetter
	FROM WizzardDeposits
	WHERE DepositGroup = 'Troll Chest'
	GROUP BY LEFT(WizzardDeposits.FirstName,1)
	ORDER BY FirstLetter

--11.Average Interest
SELECT 
	    wd.DepositGroup,
		wd.IsDepositExpired,
		AVG(wd.DepositInterest) AS AverageInterest
	FROM WizzardDeposits AS wd
	WHERE wd.DepositStartDate > '1985-01-01'
	GROUP BY wd.DepositGroup, wd.IsDepositExpired
	ORDER BY wd.DepositGroup DESC, wd.IsDepositExpired 

--12.Rich Wizard, Poor Wizard
SELECT SUM([Difference]) AS SumDifference 
FROM 
    (
    	SELECT 
    	      wd.FirstName AS [Host Wizard],
    	      wd.DepositAmount AS [Host Wizard Deposit],
    	      LEAD(wd.FirstName) OVER (ORDER BY wd.Id) AS [Guest Wizard],
    	      LEAD(wd.DepositAmount) OVER (ORDER BY wd.Id) AS [Guest Wizard Deposit],
    	      wd.DepositAmount - LEAD(wd.DepositAmount) OVER (ORDER BY wd.Id) AS [Difference]
    	FROM WizzardDeposits AS wd
    )
AS DifferenceSubQuery

USE SoftUni
--13.Departments Total Salaries
SELECT 
		DepartmentID,
		SUM(Salary) AS TotalSalary
	FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID 

--14.Employees Minimum Salaries
SELECT 
      DepartmentID,
      MIN(Salary) AS MinimumSalary 
FROM Employees
WHERE (DepartmentID = 2 OR 
	  DepartmentID = 5 OR
	  DepartmentID = 7) AND HireDate > '01/01/2000'
GROUP BY DepartmentID

--15.Employees Average Salaries
SELECT 
	* 
INTO EmployeeOver30000Salary
FROM Employees AS E
WHERE E.Salary > 30000

DELETE FROM EmployeeOver30000Salary 
WHERE  ManagerID = 42

UPDATE EmployeeOver30000Salary
SET Salary += 5000
WHERE DepartmentID = 1 

SELECT E.DepartmentID,
AVG(E.Salary)
FROM EmployeeOver30000Salary AS E 
GROUP BY DepartmentID

--16.Employees Maximum Salaries
SELECT 
	e.DepartmentID,
	MAX(e.Salary) AS MaxSalary
 FROM Employees AS e
 GROUP BY e.DepartmentID
 HAVING MAX(e.Salary) NOT BETWEEN 30000 AND 70000 

 SELECT 
	E.DepartmentID, 
	MAX(E.Salary) AS MaxSalary
FROM Employees AS E
GROUP BY E.DepartmentID
HAVING MAX(Salary) < 30000 OR MAX(Salary) >  70000

--17.Employees Count Salaries
SELECT 
		COUNT(*) AS [Count]
	FROM Employees
	WHERE ManagerID IS NULL

--18. 3rd Highest Salary
SELECT
	r.DepartmentID,
	r.Salary
	FROM (SELECT 
		*,ROW_NUMBER() OVER(PARTITION BY r.DepartmentID ORDER BY r.Salary DESC) as [Rank]
	FROM (SELECT 
		e.DepartmentID,
		e.Salary
	FROM Employees AS e
	GROUP BY e.DepartmentID,e.Salary
         ) AS r
		 ) AS r
 WHERE r.[Rank] = 3

 --19.Salary Challenge
 SELECT TOP(10) 
	FirstName,
	LastName,
	e.DepartmentID
FROM (SELECT 
	DepartmentID,
	AVG(Salary) AS AvgSalary
	FROM Employees
 GROUP BY DepartmentID
     ) AS r,
	 Employees AS e
 WHERE r.DepartmentID = e.DepartmentID AND e.Salary > r.AvgSalary
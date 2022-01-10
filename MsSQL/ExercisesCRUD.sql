--1
SELECT * FROM Departments
--2
SELECT [Name] 
FROM [Departments]
--3
SELECT [FirstName],[MiddleName],[LastName] 
FROM [Employees]
--4
SELECT (FirstName + '.' + LastName + '@softuni.bg') AS [Full Email Address] 
FROM [Employees]
--5
SELECT * FROM Employees
--6
SELECT DISTINCT [Salary] 
FROM [Employees]
--7
SELECT * 
FROM Employees
	WHERE JobTitle = 'Sales Representative'
--8
SELECT [FirstName],[LastName],[JobTitle] 
FROM [Employees]
	WHERE [Salary] BETWEEN 20000 AND 30000
--9
SELECT CONCAT ([FirstName],' ',[MiddleName],' ',[LastName]) AS [Full Name]
	FROM [Employees]
	WHERE [Salary] IN (25000,14000,12500,23600)
--10
SELECT [FirstName],[LastName] 
FROM [Employees]
	WHERE [ManagerID] IS NULL
--11
SELECT [FirstName],[LastName],[Salary] 
FROM [Employees]
	WHERE [Salary] > 50000
	ORDER BY [Salary] DESC
--12
SELECT TOP(5) [FirstName],[LastName] 
FROM [Employees]
	ORDER BY [Salary] DESC
--13
SELECT [FirstName],[LastName] 
FROM [Employees]
	WHERE [DepartmentID] != 4
--14
SELECT * 
FROM [Employees]
	ORDER BY [Salary] DESC,
	         [FirstName] ASC,
			 [LastName] DESC,
			 [MiddleName] ASC
--15
GO

CREATE VIEW [V_EmployeesSalaries] AS
	 SELECT [FirstName],[LastName],[Salary]
	   FROM [Employees]

GO
--16
CREATE VIEW [V_EmployeeNameJobTitle] AS (
	SELECT CONCAT([FirstName],' ',[MiddleName],' ',[LastName]) AS [Full Name],
	                                                [JobTitle] AS [Job Title]
		FROM [Employees])

GO
--17
SELECT DISTINCT [JobTitle] FROM [Employees]
--18
SELECT TOP(10) * 
FROM [Projects]
	WHERE [StartDate] IS NOT NULL
	ORDER BY [StartDate] ASC,[Name] ASC
--19
SELECT TOP(7) [FirstName],[LastName],[HireDate] 
FROM [Employees]
	ORDER BY [HireDate] DESC
--20
UPDATE [Employees]
   SET [Salary] = [Salary] * 1.12
 WHERE [DepartmentID] IN (1,2,4,11)
 SELECT[Salary] FROM [Employees]

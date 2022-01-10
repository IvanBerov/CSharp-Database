--Find Names of All Employees by First Name
SELECT [FirstName],[LastName] FROM Employees
  WHERE LEFT([FirstName], 2) = 'Sa'
--WHERE SUBSTRING([FirstName], 1, 2) = 'Sa'
--WHERE [FirstName] LIKE 'Sa%'


--Find Names of All employees by Last Name 
SELECT [FirstName],[LastName] FROM Employees
WHERE [LastName] LIKE '%ei%'
--WHERE CHARINDEX('ei', [LastName]) <> 0


--Find First Names of All Employees
SELECT [FirstName] FROM Employees
  WHERE ([DepartmentID] = 3 OR [DepartmentID] = 10) AND (YEAR([HireDate]) >= 1995 
                                                    AND YEAR([HireDate]) <= 2005)
--WHERE [DepartmentID] IN (3, 10) AND YEAR([HireDate]) BETWEEN 1995 AND 2005


--Find All Employees Except Engineers
SELECT [FirstName],[LastName] FROM [Employees]
WHERE [JobTitle] NOT LIKE '%engineer%'


--Find Towns with Name Length
SELECT [Name] FROM [Towns]
WHERE LEN([Name]) IN (5, 6)
	  ORDER BY [Name] ASC 


--Find Towns Starting With
SELECT * FROM  [Towns]
	WHERE LEFT([Name], 1) IN ('M','K','B','E') 
	ORDER BY [Name] ASC
--WHERE [Name] LIKE 'M%' OR 
	  --[Name] LIKE 'K%' OR
	  --[Name] LIKE 'B%' OR  
	  --[Name] LIKE 'E%'  

--WHERE [Name] LIKE '[MKBE]%'


--Find Towns Not Starting With
SELECT * FROM [Towns]
	WHERE LEFT([Name], 1) NOT IN ('R', 'B', 'D')
	ORDER BY [Name] 


--Create View Employees Hired After
CREATE VIEW V_EmployeesHiredAfter2000 AS 
	SELECT [FirstName], [LastName] FROM [Employees]
	WHERE YEAR(HireDate) > 2000


--Length of Last Name
SELECT [FirstName],[LastName] FROM Employees
	WHERE LEN([LastName]) = 5 


--Rank Employees by Salary
SELECT [EmployeeID], [FirstName], [LastName], [Salary], 
	DENSE_RANK() OVER(PARTITION BY [Salary] ORDER BY [EmployeeID]) 
	AS [Rank]
	FROM Employees
	WHERE [Salary] BETWEEN 10000 AND 50000
	ORDER BY [Salary] DESC


--Find All Employees with Rank 2 *
SELECT * FROM (SELECT [EmployeeID],[FirstName],[LastName],[Salary], 
		DENSE_RANK() OVER (PARTITION BY [Salary]ORDER BY [EmployeeID]) AS [Rank]
FROM  [Employees]
WHERE [Salary] >= 10000  AND [Salary] <= 50000) s
WHERE [Rank] = 2
ORDER BY [Salary] DESC;

SELECT * FROM ( 
				SELECT [EmployeeId],[FirstName],[LastName],[Salary],
						DENSE_RANK() OVER (PARTITION BY [Salary] ORDER BY [EmployeeID]) AS [Rank]
				FROM [Employees]
				WHERE [Salary] BETWEEN 10000 AND 50000
			  )
		AS [RankingTable]
		WHERE [Rank] = 2
		ORDER BY [Salary] DESC
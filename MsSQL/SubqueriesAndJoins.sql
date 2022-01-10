--Subqueries and Joins

--1.Employee Address
SELECT TOP(5) e.EmployeeID,
			  e.JobTitle,
			  e.AddressID,
			  a.AddressText
		 FROM [Employees] AS e
	LEFT JOIN [Addresses] AS a
	ON e.AddressID = a.AddressID
	ORDER BY e.AddressID

--2. Addresses with Towns
SELECT TOP(50)
		e.FirstName,
		e.LastName,
		t.Name AS Town,
		a.AddressText
	FROM Employees AS e
	JOIN Addresses AS a ON a.AddressID = e.AddressID
	JOIN Towns AS t ON a.TownID = t.TownID
	ORDER BY e.FirstName, e.LastName

--3. Sales Employees
SELECT
		e.EmployeeID,
		e.FirstName,
		e.LastName,
		d.Name AS DepartmentName
	FROM Employees AS e
	JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
	WHERE d.Name = 'Sales'
	ORDER BY e.EmployeeID

--4. Employee Departments
SELECT TOP(5)
		e.EmployeeID,
		e.FirstName,
		e.Salary,
		d.Name AS DepartmentName
	FROM Employees AS e
	JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
	WHERE e.Salary > 15000
	ORDER BY d.DepartmentID

--5.Employees Without Projects
SELECT TOP(3)
		e.EmployeeID,
		e.FirstName
	FROM Employees AS e
	LEFT JOIN EmployeesProjects AS ep 
	ON e.EmployeeID = ep.EmployeeID
	WHERE ep.EmployeeID IS NULL
	ORDER BY e.EmployeeID

--6.Employees Hired After
SELECT
		e.FirstName,
		e.LastName,
		e.HireDate,
		d.[Name] AS DeptName
	FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	WHERE e.HireDate > '1.1.1999' AND d.[Name] IN ('Sales', 'Finance')

--7.Employees With Project
SELECT TOP(5) 
		e.EmployeeID,
		e.FirstName,
		p.[Name] AS ProjectName
	FROM Employees AS e
	JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
	JOIN Projects AS p ON ep.ProjectID = p.ProjectID
    WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
    ORDER BY e.EmployeeID

--8.Employee 24
SELECT
		e.EmployeeID,
	    e.FirstName,
		 CASE 
		 	WHEN YEAR(p.StartDate) >= 2005 THEN NULL
		 	ELSE p.[Name]
		 END AS ProjectName
	FROM Employees AS e
	JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
	JOIN Projects AS p ON ep.ProjectID = p.ProjectID
    WHERE ep.EmployeeID = 24

--9.Employee Manager
SELECT 
		e.EmployeeID,
		e.FirstName,
		e.ManagerID,
		m.FirstName AS [ManagerName]
	FROM Employees AS e
	JOIN Employees AS m 
	ON e.ManagerID = m.EmployeeID
    WHERE e.ManagerID IN (3,7)
    ORDER BY e.EmployeeID

--10.Employees Summary
SELECT TOP(50)
		e.EmployeeID,
		CONCAT(e.FirstName, ' ', e.LastName) AS EmploeyeeName,
		CONCAT(m.FirstName, ' ', m.LastName) AS ManagerName,
		d.[Name] AS DepartmentName
	FROM Employees AS e
	JOIN Employees AS m 
	ON m.EmployeeID = e.ManagerID
	JOIN Departments AS d 
	ON d.DepartmentID = e.DepartmentID
	ORDER BY e.EmployeeID

--11.Min Average Salary
SELECT TOP(1)
		AVG(Salary) AS MinAverageSalary
	FROM Employees AS e
GROUP BY e.DepartmentID
ORDER BY MinAverageSalary



USE Geography
--12.Highest Peaks in Bulgaria
SELECT 
		c.CountryCode,
		m.MountainRange,
		p.PeakName,
		p.Elevation
	FROM Peaks AS p
	JOIN Mountains AS m 
	ON m.Id = p.MountainId  
	JOIN MountainsCountries AS mc 
	ON mc.MountainId = m.Id
	JOIN Countries AS c 
	ON c.CountryCode = mc.CountryCode
	WHERE p.Elevation > 2835 AND c.CountryCode = 'BG'
	ORDER BY p.Elevation DESC

--13. Count Mountain Ranges
SELECT 
		mc.CountryCode ,
		COUNT(mc.MountainId) AS MountainRanges
	FROM Mountains AS m
	JOIN MountainsCountries AS mc 
	ON mc.MountainId = m.Id
	WHERE mc.CountryCode IN ('BG', 'RU', 'US')
	GROUP BY mc.CountryCode

--14. Countries With or Without Rivers
SELECT TOP(5) 
		c.CountryName,
		r.RiverName
	FROM Rivers AS r
	RIGHT JOIN CountriesRivers AS cr 
	ON cr.RiverId = r.Id
	RIGHT JOIN Countries AS c 
	ON c.CountryCode = cr.CountryCode
	WHERE c.ContinentCode = 'AF'
	ORDER BY c.CountryName ASC

--15.Continents and Currencies
SELECT 
		ContinentCode,
		CurrencyCode,
		Total AS CurrencyUsage 
		FROM (SELECT ContinentCode,CurrencyCode,
			  COUNT(*) AS Total,
		      DENSE_RANK() OVER (PARTITION BY ContinentCode Order by COUNT(*) DESC ) AS Ranked
		FROM Countries
		GROUP BY ContinentCode, CurrencyCode) AS k
	WHERE Ranked = 1 AND Total > 1
	ORDER BY ContinentCode,CurrencyCode

--16.Countries Without any Mountains
SELECT 
		COUNT(*) AS Count 
	FROM Continents AS c
	LEFT JOIN Countries AS con 
	ON con.ContinentCode = c.ContinentCode
	LEFT JOIN MountainsCountries AS mc 
	ON mc.CountryCode = con.CountryCode
	LEFT JOIN Mountains AS m 
	ON m.Id = mc.MountainId
	WHERE m.Id IS NULL

--17. Highest Peak and Longest River by Country
SELECT TOP(5)
		c.[CountryName],
		MAX(p.[Elevation]) AS [HighestPeakElevation],
		MAX(r.[Length]) AS [LongestRiverLength]
	FROM [Countries] c
	LEFT JOIN [MountainsCountries] mc 
	ON c.[CountryCode] = mc.[CountryCode]
	LEFT JOIN [Peaks] p 
	ON mc.[MountainId] = p.[MountainId]
	LEFT JOIN [CountriesRivers] cr 
	ON c.[CountryCode] = cr.[CountryCode]
	LEFT JOIN [Rivers] r 
	ON cr.[RiverId] = r.[Id]
	GROUP BY [CountryName]
	ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, c.[CountryName]

--18. Highest Peak Name and Elevation by Country
SELECT TOP(5)
		c.[CountryName],
		ISNULL(p.[PeakName],'(no highest peak)') AS [Highest Peak Name],
		ISNULL(MAX(p.[Elevation]), 0) AS [Highest Peak Elevation],
		ISNULL(m.MountainRange, '(no mountain)') AS [Mountain]
	FROM [Countries] c
	LEFT JOIN [MountainsCountries] AS mc 
	ON c.[CountryCode] = mc.[CountryCode]
	LEFT JOIN [Peaks] p 
	ON mc.[MountainId] = p.[MountainId]
	LEFT JOIN [Mountains] m 
	ON p.[MountainId] = m.[Id]
	GROUP BY c.[CountryName], p.[PeakName], m.[MountainRange]	
	ORDER BY c.[CountryName], p.[PeakName]
SELECT * FROM Games
--Games from 2011 and 2012 year
SELECT TOP(50) [Name], FORMAT([Start], 'yyyy-MM-dd') AS [Start] FROM [Games]
	WHERE YEAR([Start]) BETWEEN 2011 AND 2012
	ORDER BY [Start],[Name]


--User Email Providers
SELECT * FROM Users

SELECT [Username],
				 SUBSTRING(Email, CHARINDEX('@', Email, 1) + 1, LEN(Email)) 
	AS [Email Provider]
	FROM Users
	ORDER BY [Email Provider] ASC, [Username] ASC


--User Email Providers
SELECT [Username], [IpAddress] AS [IP Address]
	FROM [Users]
	WHERE [IpAddress] LIKE '___.1_%._%.___'
					     --"***.1^.^.***"
	ORDER BY [Username]


--Show All Games with Duration and Part of the Day
SELECT [Name]
	,CASE
		WHEN DATEPART(hour, [Start]) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(hour, [Start]) BETWEEN 12 AND 17 THEN 'Afternoon'
		WHEN DATEPART(hour, [Start]) BETWEEN 18 AND 23 THEN 'Evening'
	    END 
		AS [Part of the day]
	,CASE
		WHEN Duration <= 3 THEN 'Extra Short'
		WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
		WHEN Duration > 6 THEN 'Long'
		ELSE 'Extra Long'
	    END
		AS [Duration]
	FROM Games
	ORDER BY [Name],
		     [Duration],
		     [Part of the day]
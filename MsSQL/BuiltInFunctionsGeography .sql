--Countries Holding ‘A’ 3 or More Times

SELECT [CountryName] AS [Country Name], [IsoCode] AS [ISO Code] 
	FROM [Countries]
	WHERE [CountryName] LIKE '%a%a%a%'
	ORDER BY [ISO Code]


--Mix of Peak and River Names

SELECT [PeakName],[RiverName],
							LOWER([PeakName] + SUBSTRING([RiverName], 2, LEN([RiverName]))) 
	AS    [Mix]
	FROM   [Peaks],[Rivers]
	WHERE  LEFT(RiverName,1) = RIGHT(PeakName,1)
	ORDER BY [Mix]
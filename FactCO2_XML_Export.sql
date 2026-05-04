USE BigDataProject;
GO

SELECT 
    c.CountryName,
    t.Year,
    SUM(f.TotalCO2) AS TotalCO2
FROM FactCO2Energy f
JOIN DimCountry c ON f.CountryKey = c.CountryKey
JOIN DimTime t ON f.TimeKey = t.TimeKey
GROUP BY c.CountryName, t.Year
FOR XML PATH('CO2Data'), ROOT('CO2Dataset');
GO
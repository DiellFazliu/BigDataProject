USE BigDataProject;
GO

-- =====================================================
-- EKSPORTI I TË DHËNAVE NË XML (VERSIONI I PASTRUAR)
-- =====================================================

SELECT 
    c.CountryName AS '@Country',
    REPLACE(REPLACE(c.CountryCode, '"', ''), '"', '') AS '@CountryCode',
    t.Year AS '@Year',
    CAST(ROUND(SUM(f.TotalCO2), 2) AS DECIMAL(18,2)) AS 'TotalCO2',
    CAST(ROUND(SUM(f.CoalCO2), 2) AS DECIMAL(18,2)) AS 'CoalCO2',
    CAST(ROUND(SUM(f.OilCO2), 2) AS DECIMAL(18,2)) AS 'OilCO2',
    CAST(ROUND(SUM(f.GasCO2), 2) AS DECIMAL(18,2)) AS 'GasCO2',
    CAST(SUM(f.Population) AS BIGINT) AS 'Population'
FROM FactCO2Energy f
JOIN DimCountry c ON f.CountryKey = c.CountryKey
JOIN DimTime t ON f.TimeKey = t.TimeKey
GROUP BY c.CountryName, c.CountryCode, t.Year
ORDER BY t.Year, c.CountryName
FOR XML PATH('CountryRecord'), ROOT('CO2Dataset');
GO
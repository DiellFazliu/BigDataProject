-- View 1
CREATE OR ALTER VIEW vw_CO2PerCapita AS  
SELECT 
    c.CountryName,   
    CASE 
        WHEN SUM(f.Population) = 0 OR SUM(f.Population) IS NULL THEN 0
        ELSE SUM(f.TotalCO2) / SUM(f.Population)
    END AS CO2_PerCapita  
FROM FactCO2Energy f  
JOIN DimCountry c ON f.CountryKey = c.CountryKey  
GROUP BY c.CountryName;
GO

-- View 2
CREATE OR ALTER VIEW vw_CompareGermanyFrance AS  
SELECT 
    t.Year, 
    c.CountryName, 
    SUM(f.TotalCO2) AS TotalCO2,
    CASE 
        WHEN SUM(f.Population) = 0 OR SUM(f.Population) IS NULL THEN 0
        ELSE SUM(f.TotalCO2) / SUM(f.Population)
    END AS CO2_PerCapita
FROM FactCO2Energy f  
JOIN DimCountry c ON f.CountryKey = c.CountryKey  
JOIN DimTime t ON f.TimeKey = t.TimeKey  
WHERE c.CountryName IN ('Germany', 'France')  
GROUP BY t.Year, c.CountryName;
GO

-- View 3
CREATE OR ALTER VIEW vw_Top10Countries AS 
SELECT TOP 10 
    c.CountryName, 
    SUM(f.TotalCO2) AS TotalCO2 
FROM FactCO2Energy f 
JOIN DimCountry c ON f.CountryKey = c.CountryKey 
GROUP BY c.CountryName 
ORDER BY TotalCO2 DESC;
GO

-- View 4
CREATE OR ALTER VIEW vw_YearlyGlobalStats AS
SELECT 
    t.Year,
    COUNT(DISTINCT c.CountryKey) AS NumberOfCountries,
    SUM(f.TotalCO2) AS GlobalTotalCO2,
    AVG(CASE 
        WHEN f.Population > 0 THEN f.TotalCO2 / f.Population 
        ELSE NULL 
    END) AS AvgCO2PerCapita,
    SUM(f.CoalCO2) AS GlobalCoalCO2,
    SUM(f.OilCO2) AS GlobalOilCO2,
    SUM(f.GasCO2) AS GlobalGasCO2,
    SUM(f.Population) AS GlobalPopulation
FROM FactCO2Energy f
JOIN DimCountry c ON f.CountryKey = c.CountryKey
JOIN DimTime t ON f.TimeKey = t.TimeKey
WHERE f.TotalCO2 IS NOT NULL
GROUP BY t.Year;
GO

--View 5
CREATE OR ALTER VIEW vw_CountryYearUnique AS
SELECT DISTINCT
    c.CountryName,
    c.CountryCode,
    t.Year,
    CONCAT(c.CountryName, '_', t.Year) AS UniqueID
FROM FactCO2Energy f
JOIN DimCountry c ON f.CountryKey = c.CountryKey
JOIN DimTime t ON f.TimeKey = t.TimeKey;
GO
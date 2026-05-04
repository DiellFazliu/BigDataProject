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
CREATE OR ALTER VIEW vw_CO2_vs_GDP AS
SELECT 
    c.CountryName,
    t.Year,
    SUM(f.TotalCO2) AS TotalCO2,
    AVG(w.Value) AS GDP,  -- AVG në vend të MAX (më i saktë)
    CASE 
        WHEN AVG(w.Value) = 0 OR AVG(w.Value) IS NULL THEN 0
        ELSE SUM(f.TotalCO2) / AVG(w.Value) * 1000000  -- CO2 për 1 milion GDP
    END AS CO2_Per_UnitGDP
FROM dbo.FactCO2Energy f
JOIN dbo.DimCountry c 
    ON f.CountryKey = c.CountryKey
JOIN dbo.DimTime t 
    ON f.TimeKey = t.TimeKey
LEFT JOIN dbo.FactWDI w   -- Përdor LEFT JOIN për të mos humbur të dhëna pa GDP
    ON w.CountryKey = c.CountryKey 
    AND w.TimeKey = t.TimeKey
LEFT JOIN dbo.DimSeries s 
    ON w.SeriesKey = s.SeriesKey
    AND s.SeriesCode = 'NY.GDP.MKTP.CD'
WHERE f.TotalCO2 IS NOT NULL  -- Filtro vetëm rreshtat me të dhëna CO2
GROUP BY c.CountryName, t.Year;
GO

-- View 5
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

--View 6
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
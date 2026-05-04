-- View 1
CREATE VIEW vw_CO2PerCapita AS  
SELECT c.CountryName,   
       SUM(f.TotalCO2)/SUM(f.Population) AS CO2_PerCapita  
FROM FactCO2Energy f  
JOIN DimCountry c ON f.CountryKey = c.CountryKey  
GROUP BY c.CountryName;
GO

-- View 2
CREATE VIEW vw_CompareGermanyFrance AS  
SELECT t.Year, c.CountryName, SUM(f.TotalCO2) AS TotalCO2  
FROM FactCO2Energy f  
JOIN DimCountry c ON f.CountryKey = c.CountryKey  
JOIN DimTime t ON f.TimeKey = t.TimeKey  
WHERE c.CountryName IN ('Germany', 'France')  
GROUP BY t.Year, c.CountryName;
GO

-- View 3
CREATE VIEW vw_Top10Countries AS 
SELECT TOP 10 c.CountryName, SUM(f.TotalCO2) AS TotalCO2 
FROM FactCO2Energy f 
JOIN DimCountry c ON f.CountryKey = c.CountryKey 
GROUP BY c.CountryName 
ORDER BY TotalCO2 DESC;
GO

-- View 4
CREATE VIEW vw_CO2_vs_GDP AS
SELECT 
    c.CountryName,
    t.Year,
    SUM(f.TotalCO2) AS TotalCO2,
    MAX(w.Value) AS GDP
FROM dbo.FactCO2Energy f
JOIN dbo.DimCountry c 
    ON f.CountryKey = c.CountryKey
JOIN dbo.DimTime t 
    ON f.TimeKey = t.TimeKey
JOIN dbo.FactWDI w 
    ON w.CountryKey = c.CountryKey 
   AND w.TimeKey = t.TimeKey
JOIN dbo.DimSeries s 
    ON w.SeriesKey = s.SeriesKey
WHERE s.SeriesCode = 'NY.GDP.MKTP.CD'
GROUP BY c.CountryName, t.Year;
GO

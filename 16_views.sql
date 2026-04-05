-- View 1
CREATE VIEW vw_CO2PerCapita AS  
SELECT c.CountryName,   
       SUM(f.TotalCO2)/SUM(f.Population) AS CO2_PerCapita  
FROM FactCO2Energy f  
JOIN DimCountry c ON f.CountryKey = c.CountryKey  
GROUP BY c.CountryName;

-- View 2
CREATE VIEW vw_CompareGermanyFrance AS  
SELECT t.Year, c.CountryName, SUM(f.TotalCO2) AS TotalCO2  
FROM FactCO2Energy f  
JOIN DimCountry c ON f.CountryKey = c.CountryKey  
JOIN DimTime t ON f.TimeKey = t.TimeKey  
WHERE c.CountryName IN ('Germany', 'France')  
GROUP BY t.Year, c.CountryName;


-- View 3
CREATE VIEW vw_Top10Countries AS 
SELECT TOP 10 c.CountryName, SUM(f.TotalCO2) AS TotalCO2 
FROM FactCO2Energy f 
JOIN DimCountry c ON f.CountryKey = c.CountryKey 
GROUP BY c.CountryName 
ORDER BY TotalCO2 DESC;

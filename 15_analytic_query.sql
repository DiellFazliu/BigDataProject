-- Analytic Query 3
SELECT c.CountryName,
       SUM(f.CoalCO2) AS TotalCoalCO2,
       SUM(f.OilCO2) AS TotalOilCO2,
       SUM(f.GasCO2) AS TotalGasCO2
FROM FactCO2Energy f
JOIN DimCountry c ON f.CountryKey = c.CountryKey
GROUP BY c.CountryName
ORDER BY TotalCoalCO2 DESC;


-- Analytic Query 4
SELECT Year,
       AVG(PerCapitaCO2) AS AvgCO2PerCapita
FROM MasterNormalized
GROUP BY Year
ORDER BY Year;

-- Analytic Query 5 
SELECT TOP 5 c.CountryName,
       SUM(f.TotalCO2) AS TotalCO2_2020
FROM FactCO2Energy_Partitioned f
JOIN DimCountry c ON f.CountryKey = c.CountryKey
WHERE f.Year = 2020
GROUP BY c.CountryName
ORDER BY TotalCO2_2020 DESC;

-- Analytic Query 6
SELECT c.CountryName,
       SUM(f.CoalCO2) AS CoalCO2,
       SUM(f.OilCO2) AS OilCO2,
       SUM(f.GasCO2) AS GasCO2,
       SUM(f.TotalCO2) AS TotalCO2
FROM FactCO2Energy f
JOIN DimCountry c ON f.CountryKey = c.CountryKey
WHERE f.TimeKey IN (SELECT TimeKey FROM DimTime WHERE Year = 2020)
GROUP BY c.CountryName
ORDER BY TotalCO2 DESC;

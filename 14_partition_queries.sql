-- =========================
-- PARTITION-AWARE QUERIES
-- =========================

-- Filter by Year (Range)
SELECT *
FROM FactCO2Energy_Partitioned
WHERE Year BETWEEN 2015 AND 2020;

-- Filter by Country (List)
SELECT *
FROM FactCO2_ByCountry_Partitioned
WHERE CountryCode = 'ALB';

-- Analytical Query 1
SELECT c.CountryName, SUM(f.TotalCO2) AS TotalCO2
FROM FactCO2Energy_Partitioned f
JOIN DimCountry c ON f.CountryKey = c.CountryKey
GROUP BY c.CountryName
ORDER BY TotalCO2 DESC;

-- Analytical Query 2
SELECT t.Year, SUM(f.TotalCO2) AS TotalCO2
FROM FactCO2Energy_Partitioned f
JOIN DimTime t ON f.TimeKey = t.TimeKey
GROUP BY t.Year
ORDER BY t.Year;

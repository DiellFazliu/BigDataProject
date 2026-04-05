-- =========================
-- PARTITION-AWARE QUERIES
-- =========================

-- 1. Filter by Year (Range Partition)
SELECT *
FROM FactWDI_Partitioned_Year
WHERE Year BETWEEN 2010 AND 2015;

-- 2. Filter by Country (List-like Partition)
SELECT *
FROM FactWDI_Partitioned_Country
WHERE CountryCode = 'USA';

-- 3. Sum Values per Year (Range Partition)
SELECT Year, SUM(Value) AS TotalValue
FROM FactWDI_Partitioned_Year
GROUP BY Year
ORDER BY Year;

-- 4. Top 5 Countries by Value (List Partition)
SELECT TOP 5 CountryCode, SUM(Value) AS TotalValue
FROM FactWDI_Partitioned_Country
GROUP BY CountryCode
ORDER BY TotalValue DESC;

-- 5. Filter by Year and Country Together
SELECT y.Year, c.CountryCode, y.Value
FROM FactWDI_Partitioned_Year y
JOIN FactWDI_Partitioned_Country c
    ON y.CountryKey = (SELECT CountryKey FROM DimCountry WHERE CountryCode = c.CountryCode)
WHERE y.Year >= 2015 AND c.CountryCode IN ('USA','FRA');

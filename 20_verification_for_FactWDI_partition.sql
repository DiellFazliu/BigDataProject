-- Shiko sa rreshta ka per çdo Year
SELECT Year, COUNT(*) AS NumRows
FROM FactWDI_Partitioned_Year
GROUP BY Year
ORDER BY Year;

-- Shiko 10 rreshta të para për kontroll
SELECT TOP 10 *
FROM FactWDI_Partitioned_Year
ORDER BY Year, FactID;

-- Shiko sa rreshta ka per çdo CountryCode
SELECT CountryCode, COUNT(*) AS NumRows
FROM FactWDI_Partitioned_Country
GROUP BY CountryCode
ORDER BY CountryCode;

-- Shiko 10 rreshta të para për kontroll
SELECT TOP 10 *
FROM FactWDI_Partitioned_Country
ORDER BY CountryCode, FactID;

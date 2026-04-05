-- =========================
-- RANGE PARTITIONING (YEAR)
-- =========================

-- 1. Krijo Partition Function për Year
CREATE PARTITION FUNCTION pfWDI_Year (INT) 
AS RANGE LEFT FOR VALUES (2005, 2010, 2015, 2020);

-- 2. Krijo Partition Scheme mbi Year
CREATE PARTITION SCHEME psWDI_Year
AS PARTITION pfWDI_Year ALL TO ([PRIMARY]);

-- 3. Krijo tabela e partitioned mbi Year
CREATE TABLE FactWDI_Partitioned_Year (
    FactID BIGINT IDENTITY(1,1),
    CountryKey INT,
    TimeKey INT,
    Year INT,
    Value DECIMAL(18,4),
    PRIMARY KEY (FactID, Year)
) ON psWDI_Year(Year);

-- 4. Insert të dhënat në tabelën e partitioned
INSERT INTO FactWDI_Partitioned_Year (CountryKey, TimeKey, Year, Value)
SELECT 
    f.CountryKey,
    f.TimeKey,
    t.Year,
    f.Value
FROM FactWDI f
JOIN DimTime t ON f.TimeKey = t.TimeKey;

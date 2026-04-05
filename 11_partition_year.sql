-- =========================
-- RANGE PARTITIONING (YEAR)
-- =========================

CREATE PARTITION FUNCTION pf_Year (INT) 
AS RANGE LEFT FOR VALUES (2005, 2010, 2015, 2020);

CREATE PARTITION SCHEME ps_Year
AS PARTITION pf_Year ALL TO ([PRIMARY]);

CREATE TABLE FactCO2Energy_Partitioned (
    FactID BIGINT IDENTITY(1,1),
    CountryKey INT,
    TimeKey INT,
    Year INT,
    TotalCO2 DECIMAL(18,4)
) ON ps_Year(Year);

INSERT INTO FactCO2Energy_Partitioned (CountryKey, TimeKey, Year, TotalCO2)
SELECT 
    f.CountryKey,
    f.TimeKey,
    t.Year,
    f.TotalCO2
FROM FactCO2Energy f
JOIN DimTime t ON f.TimeKey = t.TimeKey;

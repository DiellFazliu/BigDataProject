-- =========================
-- LIST-LIKE PARTITIONING (COUNTRY)
-- =========================

CREATE PARTITION FUNCTION pf_Country (NVARCHAR(10))
AS RANGE LEFT FOR VALUES ('DEU', 'FRA', 'USA');

CREATE PARTITION SCHEME ps_Country
AS PARTITION pf_Country ALL TO ([PRIMARY]);

CREATE TABLE FactCO2_ByCountry_Partitioned (
    FactID INT IDENTITY(1,1),
    CountryCode NVARCHAR(10),
    Year INT,
    TotalCO2 DECIMAL(18,4)
) ON ps_Country(CountryCode);

INSERT INTO FactCO2_ByCountry_Partitioned (CountryCode, Year, TotalCO2)
SELECT 
    c.CountryCode,
    t.Year,
    f.TotalCO2
FROM FactCO2Energy f
JOIN DimCountry c ON f.CountryKey = c.CountryKey
JOIN DimTime t ON f.TimeKey = t.TimeKey;

UPDATE FactCO2_ByCountry_Partitioned
SET CountryCode = REPLACE(CountryCode, '"', '');

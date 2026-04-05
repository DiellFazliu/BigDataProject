-- =========================
-- LIST-LIKE PARTITIONING (COUNTRY)
-- =========================

CREATE PARTITION FUNCTION pfWDI_Country (NVARCHAR(50))
AS RANGE LEFT FOR VALUES ('DEU', 'FRA', 'USA', 'Dem. Rep.', 'CHN', 'GBR');

CREATE PARTITION SCHEME psWDI_Country
AS PARTITION pfWDI_Country ALL TO ([PRIMARY]);

CREATE TABLE FactWDI_Partitioned_Country (
    FactID BIGINT IDENTITY(1,1),
    CountryCode NVARCHAR(50),
    Year INT,
    Value DECIMAL(18,4),
    PRIMARY KEY (FactID, CountryCode)
) ON psWDI_Country(CountryCode);

INSERT INTO FactWDI_Partitioned_Country (CountryCode, Year, Value)
SELECT 
    c.CountryCode,
    t.Year,
    f.Value
FROM FactWDI f
JOIN DimCountry c ON f.CountryKey = c.CountryKey
JOIN DimTime t ON f.TimeKey = t.TimeKey;

UPDATE FactWDI_Partitioned_Country
SET CountryCode = REPLACE(CountryCode, '"', '');

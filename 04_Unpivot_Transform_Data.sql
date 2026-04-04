-- Transformon të dhënat me UNPIVOT nga kolona vitesh në rreshta (Year, Value).

INSERT INTO dbo.WorldBankNormalized (CountryName, CountryCode, SeriesName, SeriesCode, Year, Value)
SELECT 
    CountryName,
    CountryCode,
    SeriesName,
    SeriesCode,
    CAST(YearCol AS INT) AS Year,
    TRY_CAST(Value AS DECIMAL(20,4)) AS Value
FROM (
    SELECT 
        CountryName,
        CountryCode,
        SeriesName,
        SeriesCode,
        [2000], [2001], [2002], [2003], [2004],
        [2005], [2006], [2007], [2008],
        [2017], [2018], [2019], [2020], [2021],
        [2022], [2023], [2024], [2025]
    FROM dbo.WorldBankStaging
) AS src
UNPIVOT (
    Value FOR YearCol IN (
        [2000], [2001], [2002], [2003], [2004],
        [2005], [2006], [2007], [2008],
        [2017], [2018], [2019], [2020], [2021],
        [2022], [2023], [2024], [2025]
    )
) AS unpvt
WHERE Value IS NOT NULL;
GO

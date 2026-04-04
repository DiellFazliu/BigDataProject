USE BigDataProject;
GO

INSERT INTO dbo.FactCO2Energy (
    CountryKey,
    TimeKey,
    TotalCO2,
    CoalCO2,
    OilCO2,
    GasCO2,
    Population
)
SELECT
    dc.CountryKey,
    dt.TimeKey,
    m.TotalCO2,
    m.CoalCO2,
    m.OilCO2,
    m.GasCO2,
    m.Population
FROM dbo.MasterNormalized m
JOIN dbo.DimCountry dc
    ON dc.CountryName = m.Country
   AND dc.CountryCode = m.ISOCode
JOIN dbo.DimTime dt
    ON dt.[Year] = m.[Year]
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.FactCO2Energy f
    WHERE f.CountryKey = dc.CountryKey
      AND f.TimeKey = dt.TimeKey
);
GO
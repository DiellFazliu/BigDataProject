USE BigDataProject;
GO

INSERT INTO dbo.DimCountry (CountryName, CountryCode)
SELECT DISTINCT
    m.Country,
    m.ISOCode
FROM dbo.MasterNormalized m
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.DimCountry dc
    WHERE dc.CountryName = m.Country
      AND dc.CountryCode = m.ISOCode
);
GO

INSERT INTO dbo.DimTime ([Year])
SELECT DISTINCT
    m.[Year]
FROM dbo.MasterNormalized m
WHERE NOT EXISTS (
    SELECT 1
    FROM dbo.DimTime dt
    WHERE dt.[Year] = m.[Year]
);
GO
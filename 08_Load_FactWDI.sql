USE BigDataProject;
GO

INSERT INTO dbo.FactWDI (CountryKey, TimeKey, SeriesKey, Value)
SELECT
    dc.CountryKey,
    dt.TimeKey,
    ds.SeriesKey,
    w.Value
FROM dbo.WorldBankNormalized w
JOIN dbo.DimCountry dc
    ON dc.CountryName = w.CountryName
   AND dc.CountryCode = w.CountryCode
JOIN dbo.DimTime dt
    ON dt.[Year] = w.[Year]
JOIN dbo.DimSeries ds
    ON ds.SeriesName = w.SeriesName
   AND ds.SeriesCode = w.SeriesCode;
GO
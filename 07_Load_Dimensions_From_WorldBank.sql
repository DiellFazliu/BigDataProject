USE BigDataProject;
GO

INSERT INTO dbo.DimCountry (CountryName, CountryCode)
SELECT DISTINCT CountryName, CountryCode
FROM dbo.WorldBankNormalized;
GO

INSERT INTO dbo.DimTime ([Year])
SELECT DISTINCT [Year]
FROM dbo.WorldBankNormalized;
GO

INSERT INTO dbo.DimSeries (SeriesName, SeriesCode)
SELECT DISTINCT SeriesName, SeriesCode
FROM dbo.WorldBankNormalized;
GO
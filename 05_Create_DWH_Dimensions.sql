USE BigDataProject;
GO

CREATE TABLE dbo.DimCountry (
    CountryKey INT IDENTITY(1,1) PRIMARY KEY,
    CountryName NVARCHAR(200) NOT NULL,
    CountryCode NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE dbo.DimTime (
    TimeKey INT IDENTITY(1,1) PRIMARY KEY,
    [Year] INT NOT NULL UNIQUE
);
GO

CREATE TABLE dbo.DimSeries (
    SeriesKey INT IDENTITY(1,1) PRIMARY KEY,
    SeriesName NVARCHAR(300) NOT NULL,
    SeriesCode NVARCHAR(100) NOT NULL
);
GO
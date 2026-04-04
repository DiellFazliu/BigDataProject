-- Krijon tabelë të normalizuar për analizë (strukturë long format).

USE BigDataProject;
GO

IF OBJECT_ID('dbo.WorldBankNormalized', 'U') IS NOT NULL
    DROP TABLE dbo.WorldBankNormalized;
GO

CREATE TABLE dbo.WorldBankNormalized (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    CountryName NVARCHAR(500),    
    CountryCode NVARCHAR(50),      
    SeriesName NVARCHAR(500),      
    SeriesCode NVARCHAR(100),      
    Year INT,
    Value DECIMAL(20,4)
);
GO
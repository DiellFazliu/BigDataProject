-- Krijon tabelë staging dhe importon të dhënat nga CSV me BULK INSERT.

IF OBJECT_ID('dbo.WorldBankStaging', 'U') IS NOT NULL
    DROP TABLE dbo.WorldBankStaging;
GO

CREATE TABLE dbo.WorldBankStaging (
    CountryName NVARCHAR(MAX),
    CountryCode NVARCHAR(MAX),
    SeriesName NVARCHAR(MAX),
    SeriesCode NVARCHAR(MAX),
    [2000] NVARCHAR(MAX),
    [2001] NVARCHAR(MAX),
    [2002] NVARCHAR(MAX),
    [2003] NVARCHAR(MAX),
    [2004] NVARCHAR(MAX),
    [2005] NVARCHAR(MAX),
    [2006] NVARCHAR(MAX),
    [2007] NVARCHAR(MAX),
    [2008] NVARCHAR(MAX),
    [2017] NVARCHAR(MAX),
    [2018] NVARCHAR(MAX),
    [2019] NVARCHAR(MAX),
    [2020] NVARCHAR(MAX),
    [2021] NVARCHAR(MAX),
    [2022] NVARCHAR(MAX),
    [2023] NVARCHAR(MAX),
    [2024] NVARCHAR(MAX),
    [2025] NVARCHAR(MAX)

);
GO

-- BULK INSERT 
BULK INSERT dbo.WorldBankStaging
FROM 'C:\Users\DELL\Downloads\dataset_Worldbank.csv'  
WITH (
    FIRSTROW = 2,          
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a', 
    KEEPNULLS,
    CODEPAGE = '65001'      
);
GO

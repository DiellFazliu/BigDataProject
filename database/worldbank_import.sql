USE BigDataProject;
GO

DROP TABLE IF EXISTS WorldBankData;
GO

CREATE TABLE WorldBankData (
    CountryName NVARCHAR(100),
    CountryCode NVARCHAR(20),
    SeriesName NVARCHAR(200),
    SeriesCode NVARCHAR(100),
    Year NVARCHAR(50),
    Value NVARCHAR(100)
);
GO

BULK INSERT WorldBankData
FROM 'C:\Users\Admin\Downloads\dataset_Worldbank (2).csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    KEEPNULLS
);
GO

DROP TABLE IF EXISTS WorldBankData_Clean;
GO

SELECT
    CountryName,
    CountryCode,
    SeriesName,
    SeriesCode,
    TRY_CAST(LTRIM(RTRIM(Year)) AS INT) AS Year,
    TRY_CAST(NULLIF(LTRIM(RTRIM(Value)), '') AS FLOAT) AS Value
INTO WorldBankData_Clean
FROM WorldBankData;
GO
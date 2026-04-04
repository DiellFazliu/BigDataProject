USE BigDataProject;
GO

DROP TABLE IF EXISTS CO2_Data;
GO

CREATE TABLE CO2_Data (
    ID NVARCHAR(50),
    Country NVARCHAR(200),
    PerCapita NVARCHAR(50),
    WorldPercent NVARCHAR(50),
    ChangeValue NVARCHAR(50),
    Year NVARCHAR(50),
    Value NVARCHAR(50)
);
GO

BULK INSERT CO2_Data
FROM 'C:\Users\Admin\Downloads\Copy of countries by carbon dioxide emissions (1).csv'
WITH (
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);
GO

DROP TABLE IF EXISTS CO2_Data_Clean;
GO

SELECT
    TRY_CAST(ID AS INT) AS ID,
    Country,
    TRY_CAST(PerCapita AS FLOAT) AS PerCapita,
    TRY_CAST(WorldPercent AS FLOAT) AS WorldPercent,
    TRY_CAST(ChangeValue AS FLOAT) AS ChangeValue,
    TRY_CAST(Year AS INT) AS Year,
    TRY_CAST(Value AS FLOAT) AS Value
INTO CO2_Data_Clean
FROM CO2_Data;
GO
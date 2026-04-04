--Krijo tabelën staging për MASTER.csv dhe importon të dhënat 
-- nga skedari CSV në SQL Server duke përdorur BULK INSERT

USE BigDataProject;
GO

IF OBJECT_ID('dbo.MasterStaging', 'U') IS NOT NULL
    DROP TABLE dbo.MasterStaging;
GO

CREATE TABLE dbo.MasterStaging (
    RowNumber NVARCHAR(50),
    Year NVARCHAR(50),
    Country NVARCHAR(200),
    ISOCode NVARCHAR(10),
    TotalCO2 NVARCHAR(100),
    CoalCO2 NVARCHAR(100),
    OilCO2 NVARCHAR(100),
    GasCO2 NVARCHAR(100),
    CementCO2 NVARCHAR(100),
    FlaringCO2 NVARCHAR(100),
    OtherCO2 NVARCHAR(100),
    PerCapitaCO2 NVARCHAR(100),
    TotalEnergyProduction NVARCHAR(100),
    CoalEnergy NVARCHAR(100),
    GasEnergy NVARCHAR(100),
    PetroleumEnergy NVARCHAR(100),
    NuclearEnergy NVARCHAR(100),
    RenewablesEnergy NVARCHAR(100),
    CH4 NVARCHAR(100),
    Population NVARCHAR(100),
    TempChange NVARCHAR(100)  -- E mbajmë për import, por nuk e përdorim më vonë
);
GO

-- Importo të dhënat nga CSV

BULK INSERT dbo.MasterStaging
FROM 'C:\Users\DELL\Downloads\MASTER.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    KEEPNULLS,
    CODEPAGE = '65001'
);
GO
IF OBJECT_ID('dbo.MasterNormalized', 'U') IS NOT NULL
    DROP TABLE dbo.MasterNormalized;
GO

-- Krijo tabelën finale të normalizuar me tipet e duhura të 
-- të dhënave (INT, DECIMAL, BIGINT)

CREATE TABLE dbo.MasterNormalized (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Year INT,
    Country NVARCHAR(100),
    ISOCode NVARCHAR(10),
    TotalCO2 DECIMAL(20,6),
    CoalCO2 DECIMAL(20,6),
    OilCO2 DECIMAL(20,6),
    GasCO2 DECIMAL(20,6),
    CementCO2 DECIMAL(20,6),
    FlaringCO2 DECIMAL(20,6),
    OtherCO2 DECIMAL(20,6),
    PerCapitaCO2 DECIMAL(20,6),
    TotalEnergyProduction DECIMAL(20,6),
    CoalEnergy DECIMAL(20,6),
    GasEnergy DECIMAL(20,6),
    PetroleumEnergy DECIMAL(20,6),
    NuclearEnergy DECIMAL(20,6),
    RenewablesEnergy DECIMAL(20,6),
    CH4 DECIMAL(20,6),
    Population BIGINT
);
GO
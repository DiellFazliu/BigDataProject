-- Konverto dhe inserto të dhënat nga staging në tabelën finale

INSERT INTO dbo.MasterNormalized (
    Year, Country, ISOCode,
    TotalCO2, CoalCO2, OilCO2, GasCO2, CementCO2, FlaringCO2, OtherCO2,
    PerCapitaCO2, TotalEnergyProduction, CoalEnergy, GasEnergy,
    PetroleumEnergy, NuclearEnergy, RenewablesEnergy,
    CH4, Population
)
SELECT 
    TRY_CAST(Year AS INT) AS Year,
    Country,
    ISOCode,
    TRY_CAST(TotalCO2 AS DECIMAL(20,6)),
    TRY_CAST(CoalCO2 AS DECIMAL(20,6)),
    TRY_CAST(OilCO2 AS DECIMAL(20,6)),
    TRY_CAST(GasCO2 AS DECIMAL(20,6)),
    TRY_CAST(CementCO2 AS DECIMAL(20,6)),
    TRY_CAST(FlaringCO2 AS DECIMAL(20,6)),
    TRY_CAST(OtherCO2 AS DECIMAL(20,6)),
    TRY_CAST(PerCapitaCO2 AS DECIMAL(20,6)),
    TRY_CAST(TotalEnergyProduction AS DECIMAL(20,6)),
    TRY_CAST(CoalEnergy AS DECIMAL(20,6)),
    TRY_CAST(GasEnergy AS DECIMAL(20,6)),
    TRY_CAST(PetroleumEnergy AS DECIMAL(20,6)),
    TRY_CAST(NuclearEnergy AS DECIMAL(20,6)),
    TRY_CAST(RenewablesEnergy AS DECIMAL(20,6)),
    TRY_CAST(CH4 AS DECIMAL(20,6)),
    TRY_CAST(Population AS BIGINT)  -- Kjo tani duhet të funksionojë
FROM dbo.MasterStaging
WHERE TRY_CAST(Year AS INT) IS NOT NULL
  AND Country IS NOT NULL;
GO
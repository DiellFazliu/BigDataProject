-- Zëvendëson të gjitha vlerat NULL në kolonat numerike me 0.
USE BigDataProject;
GO

UPDATE dbo.MasterNormalized
SET 
    TotalCO2 = ISNULL(TotalCO2, 0),
    CoalCO2 = ISNULL(CoalCO2, 0),
    OilCO2 = ISNULL(OilCO2, 0),
    GasCO2 = ISNULL(GasCO2, 0),
    CementCO2 = ISNULL(CementCO2, 0),
    FlaringCO2 = ISNULL(FlaringCO2, 0),
    OtherCO2 = ISNULL(OtherCO2, 0),
    PerCapitaCO2 = ISNULL(PerCapitaCO2, 0),
    TotalEnergyProduction = ISNULL(TotalEnergyProduction, 0),
    CoalEnergy = ISNULL(CoalEnergy, 0),
    GasEnergy = ISNULL(GasEnergy, 0),
    PetroleumEnergy = ISNULL(PetroleumEnergy, 0),
    NuclearEnergy = ISNULL(NuclearEnergy, 0),
    RenewablesEnergy = ISNULL(RenewablesEnergy, 0),
    CH4 = ISNULL(CH4, 0),
    Population = ISNULL(Population, 0);
GO
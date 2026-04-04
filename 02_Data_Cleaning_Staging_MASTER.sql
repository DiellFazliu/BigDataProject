-- Fshi rreshtat e pavlefshëm
DELETE FROM dbo.MasterStaging
WHERE Country IS NULL OR Country = '' OR Year IS NULL OR Year = '';
GO

-- Pastro thonjëzat
UPDATE dbo.MasterStaging
SET Country = REPLACE(REPLACE(Country, '"', ''), '"', '');
GO

-- Konverto vlerat boshe ('') në NULL për të gjitha kolonat numerike
UPDATE dbo.MasterStaging SET TotalCO2 = NULLIF(TotalCO2, '');
UPDATE dbo.MasterStaging SET CoalCO2 = NULLIF(CoalCO2, '');
UPDATE dbo.MasterStaging SET OilCO2 = NULLIF(OilCO2, '');
UPDATE dbo.MasterStaging SET GasCO2 = NULLIF(GasCO2, '');
UPDATE dbo.MasterStaging SET CementCO2 = NULLIF(CementCO2, '');
UPDATE dbo.MasterStaging SET FlaringCO2 = NULLIF(FlaringCO2, '');
UPDATE dbo.MasterStaging SET OtherCO2 = NULLIF(OtherCO2, '');
UPDATE dbo.MasterStaging SET PerCapitaCO2 = NULLIF(PerCapitaCO2, '');
UPDATE dbo.MasterStaging SET TotalEnergyProduction = NULLIF(TotalEnergyProduction, '');
UPDATE dbo.MasterStaging SET CoalEnergy = NULLIF(CoalEnergy, '');
UPDATE dbo.MasterStaging SET GasEnergy = NULLIF(GasEnergy, '');
UPDATE dbo.MasterStaging SET PetroleumEnergy = NULLIF(PetroleumEnergy, '');
UPDATE dbo.MasterStaging SET NuclearEnergy = NULLIF(NuclearEnergy, '');
UPDATE dbo.MasterStaging SET RenewablesEnergy = NULLIF(RenewablesEnergy, '');
UPDATE dbo.MasterStaging SET CH4 = NULLIF(CH4, '');
UPDATE dbo.MasterStaging SET Population = NULLIF(Population, '');
UPDATE dbo.MasterStaging SET TempChange = NULLIF(TempChange, '');
GO
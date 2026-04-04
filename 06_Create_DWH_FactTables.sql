USE BigDataProject;
GO

CREATE TABLE dbo.FactWDI (
    FactWDIKey BIGINT IDENTITY(1,1) PRIMARY KEY,
    CountryKey INT NOT NULL,
    TimeKey INT NOT NULL,
    SeriesKey INT NOT NULL,
    Value DECIMAL(18,4) NULL,
    FOREIGN KEY (CountryKey) REFERENCES dbo.DimCountry(CountryKey),
    FOREIGN KEY (TimeKey) REFERENCES dbo.DimTime(TimeKey),
    FOREIGN KEY (SeriesKey) REFERENCES dbo.DimSeries(SeriesKey)
);
GO

CREATE TABLE dbo.FactCO2Energy (
    FactCO2EnergyKey BIGINT IDENTITY(1,1) PRIMARY KEY,
    CountryKey INT NOT NULL,
    TimeKey INT NOT NULL,
    TotalCO2 DECIMAL(18,4) NULL,
    CoalCO2 DECIMAL(18,4) NULL,
    OilCO2 DECIMAL(18,4) NULL,
    GasCO2 DECIMAL(18,4) NULL,
    Population DECIMAL(18,4) NULL,
    FOREIGN KEY (CountryKey) REFERENCES dbo.DimCountry(CountryKey),
    FOREIGN KEY (TimeKey) REFERENCES dbo.DimTime(TimeKey)
);
GO
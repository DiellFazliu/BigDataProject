-- stored procedure 1
CREATE PROCEDURE sp_TotalCO2ByCountry
    @CountryName NVARCHAR(100)
AS
BEGIN
    SELECT t.Year, SUM(f.TotalCO2) AS TotalCO2
    FROM FactCO2Energy f
    JOIN DimCountry c ON f.CountryKey = c.CountryKey
    JOIN DimTime t ON f.TimeKey = t.TimeKey
    WHERE c.CountryName = @CountryName
    GROUP BY t.Year
    ORDER BY t.Year;
END;

-- stored procedure 2
CREATE PROCEDURE sp_ComparePerCapita
    @Country1 NVARCHAR(100),
    @Country2 NVARCHAR(100)
AS
BEGIN
    SELECT c.CountryName, SUM(f.TotalCO2)/SUM(f.Population) AS CO2_PerCapita
    FROM FactCO2Energy f
    JOIN DimCountry c ON f.CountryKey = c.CountryKey
    WHERE c.CountryName IN (@Country1, @Country2)
    GROUP BY c.CountryName;
END;

-- stored procedure 3
CREATE PROCEDURE sp_TopNCountriesByYear
    @Year INT,
    @TopN INT
AS
BEGIN
    SELECT TOP(@TopN) c.CountryName, SUM(f.TotalCO2) AS TotalCO2
    FROM FactCO2Energy f
    JOIN DimCountry c ON f.CountryKey = c.CountryKey
    JOIN DimTime t ON f.TimeKey = t.TimeKey
    WHERE t.Year = @Year
    GROUP BY c.CountryName
    ORDER BY TotalCO2 DESC;
END;

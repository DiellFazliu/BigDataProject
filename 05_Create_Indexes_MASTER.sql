-- Krijo indekset për tabelën MasterNormalized për të 
-- përshpejtuar kërkimin dhe filtrimin e të dhënave.

CREATE INDEX IX_MasterNormalized_Year ON dbo.MasterNormalized(Year);
CREATE INDEX IX_MasterNormalized_Country ON dbo.MasterNormalized(Country);
CREATE INDEX IX_MasterNormalized_ISOCode ON dbo.MasterNormalized(ISOCode);
CREATE INDEX IX_MasterNormalized_Year_Country ON dbo.MasterNormalized(Year, Country);
GO
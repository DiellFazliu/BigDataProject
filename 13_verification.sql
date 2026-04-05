-- =========================
-- VERIFY PARTITIONING
-- =========================

-- Year partitions
SELECT 
    $PARTITION.pf_Year(Year) AS PartitionNumber,
    COUNT(*) AS RowsCount
FROM FactCO2Energy_Partitioned
GROUP BY $PARTITION.pf_Year(Year);

-- Country partitions
SELECT 
    $PARTITION.pf_Country(CountryCode) AS PartitionNumber,
    COUNT(*) AS RowsCount
FROM FactCO2_ByCountry_Partitioned
GROUP BY $PARTITION.pf_Country(CountryCode);

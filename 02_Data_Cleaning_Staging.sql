-- Pastron të dhënat: heq rreshtat e panevojshëm dhe zëvendëson ".." me NULL.

USE BigDataProject;
GO

-- 1. Fshi rreshtat e fundit pa të dhëna (header-at që mund të jenë si të dhëna)
DELETE FROM dbo.WorldBankStaging
WHERE CountryName = 'Country Name' OR CountryName IS NULL OR CountryName = '';
GO

-- 2. Fshi rreshtat e fundit (Data from database, Last Updated)
DELETE FROM dbo.WorldBankStaging
WHERE CountryName LIKE 'Data from database%' OR CountryName LIKE 'Last Updated%';
GO

-- 3. Pastro thonjëzat nga emrat e vendeve
UPDATE dbo.WorldBankStaging
SET CountryName = REPLACE(REPLACE(CountryName, '"', ''), '"', '');
GO

-- 4. Zëvendëso ".." me NULL - KETU KLLAPAT KATRORE JANE KYCE!
UPDATE dbo.WorldBankStaging
SET 
    [2000] = NULLIF([2000], '..'),
    [2001] = NULLIF([2001], '..'),
    [2002] = NULLIF([2002], '..'),
    [2003] = NULLIF([2003], '..'),
    [2004] = NULLIF([2004], '..'),
    [2005] = NULLIF([2005], '..'),
    [2006] = NULLIF([2006], '..'),
    [2007] = NULLIF([2007], '..'),
    [2008] = NULLIF([2008], '..'),
    [2017] = NULLIF([2017], '..'),
    [2018] = NULLIF([2018], '..'),
    [2019] = NULLIF([2019], '..'),
    [2020] = NULLIF([2020], '..'),
    [2021] = NULLIF([2021], '..'),
    [2022] = NULLIF([2022], '..'),
    [2023] = NULLIF([2022], '..'),
    [2024] = NULLIF([2022], '..'),
    [2025] = NULLIF([2022], '..');
GO
(: 3. XQUERY: Listë vendeve :)
for $c in //CountryRecord
return concat($c/@Country, ": ", $c/TotalCO2)
(: 4. XQUERY: Top 3 për vitin 2020 :)
(for $c in //CountryRecord[@Year="2020"]
 order by xs:double($c/TotalCO2) descending
 return <Rank country="{$c/@Country}" totalCO2="{$c/TotalCO2}"/>)[position() le 3]
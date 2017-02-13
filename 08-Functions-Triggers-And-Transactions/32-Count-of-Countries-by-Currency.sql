SELECT ccy.CurrencyCode, ccy.Description AS Currency, 
  COUNT(c.CountryCode) AS NumberOfCountries
FROM Currencies AS ccy
LEFT JOIN Countries AS c ON c.CurrencyCode = ccy.CurrencyCode
GROUP BY ccy.CurrencyCode, ccy.Description
ORDER BY NumberOfCountries DESC, Currency
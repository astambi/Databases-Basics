SELECT Content, SentOn
FROM Messages
WHERE SentOn > '2014/05/12' AND CHARINDEX('just', Content) > 0
ORDER BY Id DESC
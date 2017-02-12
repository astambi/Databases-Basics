SELECT i.Name AS Item, i.Price, i.MinLevel, gt.Name AS [Forbidden Game Type]
FROM Items AS i -- all items
  LEFT JOIN GameTypeForbiddenItems AS fi ON fi.ItemId = i.Id
  LEFT JOIN GameTypes AS gt ON fi.GameTypeId = gt.Id
ORDER BY [Forbidden Game Type] DESC, Item
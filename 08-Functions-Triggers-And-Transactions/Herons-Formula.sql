CREATE FUNCTION ufn_HeronsFormula(@a float, @b float, @c float)
RETURNS float
AS
BEGIN
  DECLARE @s float = (@a + @b + @c) / 2;
  RETURN sqrt(@s*(@s-@a)*(@s-@b)*(@s-@c));
END;
GO

SELECT Id, A, B, C, 
  dbo.ufn_HeronsFormula(A, B, C) AS Area
FROM Triangles